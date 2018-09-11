package controllers

import (
	"github.com/astaxie/beego"
	"time"
	"os"
	"go-blog/utils"
	"path"
	"go-blog/models"
	"strconv"
)

/*
   @Time : 2018/9/11 16:41 
   @Author : ff
*/

type ArticleController struct {
	BaseController
}

func (this *ArticleController) List()  {
	this.TplName = "admin/article/list.tpl"
}
func (this *ArticleController) Add()  {
	this.TplName = "admin/article/add.tpl"
}

func (this *ArticleController) Save(){
	if !CheckAccount(this.Ctx) {
		this.redirect(beego.URLFor("LoginController.Login"))
	}
	title := this.Input().Get("title")
	content := this.Input().Get("content")
	chanId := this.Input().Get("channelId")
	tags := this.Input().Get("tags")

	channelId, _ := strconv.ParseInt(chanId, 10,64)

	// 获取附件
	_, fh, err := this.GetFile("file")
	if err != nil {
		beego.Error(err)
	}

	var attachment string
	if fh != nil {
		// 保存附件
		attachment = fh.Filename
		beego.Info(attachment)
		err = this.SaveToFile("file", path.Join("static/upload", attachment))
		if err != nil {
			beego.Error(err)
		}
	}
	article := new(models.Article)
	article.Title = title
	article.Content = content
	article.ChannelId = channelId
	article.Tags = tags
	article.Created = time.Now()
	userId,err := strconv.Atoi(this.Ctx.GetCookie("userId"))
	article.UserId = userId
	article.Thumbnail = attachment

	flash := beego.NewFlash()
	_,err = models.ArticleAdd(article)
	if err != nil {
		flash.Error( "添加文章错误")
		flash.Store(&this.Controller)
		return
	}
	flash.Notice("添加成功")
	this.redirect(beego.URLFor("ArticleController.List"))
}

//上传图片
func (this *ArticleController) Upload() {

	filepath := "static/upload/" + beego.Date(time.Now(), "Y-m-d") + "/"
	_, err := os.Stat(filepath)
	if err != nil {
		err := os.MkdirAll(filepath, 0777)
		if err != nil {
			this.ajaxMsg(utils.CODE_ERROR,"文件上传失败")
		}
	}
	this.UploadFile("upfile", filepath)
}