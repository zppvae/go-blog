package controllers

import (
	"github.com/astaxie/beego"
	"time"
	"os"
	"go-blog/utils"
	"path"
	"go-blog/models"
	"strconv"
	"fmt"
)

/*
   @Time : 2018/9/11 16:41 
   @Author : ff
   文章管理
*/

type ArticleController struct {
	BaseController
}

func (this *ArticleController) List()  {
	flash := beego.ReadFromRequest(&this.Controller)
	if error := flash.Data["error"]; error != "" {
		fmt.Println(error)
		this.Data["error"] = error
	}
	if notice := flash.Data["notice"]; notice != "" {
		fmt.Println(notice)
		this.Data["notice"] = notice
	}
	this.TplName = "admin/article/list.tpl"
}

func (this *ArticleController) Table()  {
	//加载列表数据
	page, err := this.GetInt("page")
	if err != nil {
		page = 1
	}
	limit, err := this.GetInt("limit")
	if err != nil {
		limit = 30
	}
	this.pageSize = limit
	result,count := models.ArticleGetList(page,this.pageSize)
	list := make([]map[string]interface{}, len(result))

	thumbnailstr := "/static/upload/"
	for k, v := range result {
		row := make(map[string]interface{})
		row["id"] = v.Id
		row["title"] = v.Title
		row["userId"] = v.UserId
		row["views"] = v.Views
		row["thumbnail"] = thumbnailstr + v.Thumbnail
		row["created"] = beego.Date(v.Created, "Y-m-d")
		list[k] = row
	}
	this.ajaxLayuiTable(utils.CODE_OK, utils.MSG_SUCCESS, count, list)
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
		this.redirect(beego.URLFor("ArticleController.Add"))
		return
	}
	flash.Notice("添加成功")
	flash.Store(&this.Controller)
	this.redirect(beego.URLFor("ArticleController.List"))
}


func (this *ArticleController) AjaxDel() {

	id, _ := this.GetInt("id")
	article, _ := models.ArticleGetById(id)

	if article == nil {
		this.ajaxMsg(utils.CODE_ERROR,utils.MSG_ERROR)
	}
	article.Id = id

	if err := article.Delete(); err != nil {
		this.ajaxMsg(utils.CODE_ERROR,utils.MSG_ERROR)
	}
	this.ajaxMsg(utils.CODE_OK,utils.MSG_SUCCESS)
}

/**
  置顶/取消置顶
 */
func (this *ArticleController) AjaxWeight() {

	id, _ := this.GetInt("id")
	weight, _ := this.GetInt("weight")
	article, _ := models.ArticleGetById(id)

	if article == nil {
		this.ajaxMsg(utils.CODE_ERROR,utils.MSG_ERROR)
	}
	article.Id = id
	article.Weight = weight

	if err := article.Update(); err != nil {
		this.ajaxMsg(utils.CODE_ERROR,utils.MSG_ERROR)
	}
	this.ajaxMsg(utils.CODE_OK,utils.MSG_SUCCESS)
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