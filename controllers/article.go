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
	"strings"
	"github.com/astaxie/beego/logs"
)

/*
   @Time : 2018/9/11 16:41 
   @Author : ff
   文章管理
*/

var (
	THUMBNAIL_PERFIX = "/static/upload/"

	THUMBNAIL_IMG = "<img src='{}' style='width: 80px;'>"
	//推荐
	FEATURED_STATUS = [2]string{"","<span class='label label-danger'>荐</span>"}
	//置顶
	WEIGHT_STATUS = [2]string{"","<span class='label label-warning'>顶</span>"}


	//推荐/取消  操作
	FEATURED_HANDLE_STATUS = [2]string{"<a class='btn btn-xs btn-default' lay-event='featured' title='推荐'>" +
											"<i class='fa fa-sun-o'></i>"+
										"</a>",
										"<a class='btn btn-xs btn-danger' lay-event='unfeatured' title='取消推荐'>"+
											"<i class='fa fa-circle-thin'></i>"+
										"</a>"}
	//置顶/取消
	WEIGHT_HANDLE_STATUS = [2]string{"<a class='btn btn-xs btn-default' lay-event='weight' title='置顶'>"+
									 	"<i class='fa fa-angle-double-up'></i>"+
									 "</a>",
									 "<a class='btn btn-xs btn-warning' lay-event='unweight' title='取消置顶'>"+
									 	"<i class='fa fa-angle-double-down'></i>"+
									 "</a>"}

	EDIT_AND_DEL_HANDLE_STATUS = "<a class='btn btn-xs btn-info' lay-event='edit'><i class='fa fa-edit'></i></a><a class='btn btn-xs btn-primary' lay-event='del'><i class='fa fa-trash-o'></i></a>"
)

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

//通过channel查询文章
func (this *ArticleController) ListByChannel()  {
	this.noLayout = true
	channelIdStr := this.Input().Get("channelId")
	channelId,_ := strconv.Atoi(channelIdStr)

	if channelId <=0 {
		logs.Error("channelId is error!")
	}
	list := make([]map[string]interface{},1)
	this.Data["articles"] = list
	this.TplName = "admin/article/channel/list.tpl"
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



	for k, v := range result {
		row := make(map[string]interface{})
		var handleHtml = ""
		row["id"] = v.Id
		row["title"] = v.Title
		row["userId"] = v.UserId
		row["views"] = v.Views
		row["statusHtml"] = WEIGHT_STATUS[v.Weight] + FEATURED_STATUS[v.Featured]

		row["thumbnailHtml"] = strings.Replace(THUMBNAIL_IMG,"{}",THUMBNAIL_PERFIX + v.Thumbnail,-1)
		row["created"] = beego.Date(v.Created, "Y-m-d")

		if v.Featured == 1{
			handleHtml += FEATURED_HANDLE_STATUS[1]
		} else {
			handleHtml += FEATURED_HANDLE_STATUS[0]
		}

		if v.Weight == 1{
			handleHtml += WEIGHT_HANDLE_STATUS[1]
		} else {
			handleHtml += WEIGHT_HANDLE_STATUS[0]
		}
		row["handleHtml"] = handleHtml + EDIT_AND_DEL_HANDLE_STATUS
		list[k] = row
	}
	this.ajaxLayuiTable(utils.CODE_OK, utils.MSG_SUCCESS, count, list)
}

func (this *ArticleController) Add()  {
	this.TplName = "admin/article/add.tpl"
}

func (this *ArticleController) Edit()  {
	idstr := this.Input().Get("id")
	id,_ := strconv.Atoi(idstr)
	article,_ := models.ArticleGetById(id)

	row := make(map[string]interface{})
	row["id"] = article.Id
	row["title"] = article.Title
	row["content"] = article.Content
	row["channelId"] = article.ChannelId
	row["tags"] = article.Tags
	this.Data["article"] = row
	this.TplName = "admin/article/edit.tpl"
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

func (this *ArticleController) Update(){
	if !CheckAccount(this.Ctx) {
		this.redirect(beego.URLFor("LoginController.Login"))
	}
	idstr := this.Input().Get("id")
	title := this.Input().Get("title")
	content := this.Input().Get("content")
	chanId := this.Input().Get("channelId")
	tags := this.Input().Get("tags")

	channelId, _ := strconv.ParseInt(chanId, 10,64)
	id, _ := strconv.Atoi(idstr)
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
	article,err := models.ArticleGetById(id)
	article.Title = title
	article.Content = content
	article.ChannelId = channelId
	article.Tags = tags
	article.Thumbnail = attachment

	flash := beego.NewFlash()
	if err := article.Update();err != nil {
		flash.Error( "修改文章错误")
		flash.Store(&this.Controller)
		this.redirect(beego.URLFor("ArticleController.Edit"))
		return
	}
	flash.Notice("修改成功")
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

/**
  推荐/取消推荐
 */
func (this *ArticleController) AjaxFeatured() {

	id, _ := this.GetInt("id")
	featured, _ := this.GetInt("featured")
	article, _ := models.ArticleGetById(id)

	if article == nil {
		this.ajaxMsg(utils.CODE_ERROR,utils.MSG_ERROR)
	}
	article.Id = id
	article.Featured = featured

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