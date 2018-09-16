package controllers

import (
	"github.com/astaxie/beego"
	"strings"
	"path"
	"go-blog/utils"
)



type BaseController struct {
	beego.Controller

	controllerName string
	actionName     string
	userId         int
	username       string
	pageSize       int64
	allowUrl       string
	noLayout	   bool
}


func (self *BaseController) Prepare() {
	self.pageSize = 20
	controllerName, actionName := self.GetControllerAndAction()
	self.controllerName = strings.ToLower(controllerName[0 : len(controllerName)-10])
	self.actionName = strings.ToLower(actionName)

	self.Data["version"] = beego.AppConfig.String("version")
	self.Data["siteName"] = beego.AppConfig.String("site.name")
	self.Data["curController"] = self.controllerName
	self.Data["curAction"] = self.actionName

	self.Data["loginUserId"] = self.userId
	self.Data["loginUsername"] = self.Ctx.GetCookie("uname")

	if self.noLayout {
		self.Layout = "admin/index.tpl"
	}
}

func (this *BaseController) useLayout(tpl string) {
	this.Layout = "admin/index.tpl"
	this.TplName = tpl
}

func (this *BaseController) redirect(url string) {
	this.Redirect(url, 302)
	this.StopRun()
}

func (this *BaseController) isPost() bool {
	return this.Ctx.Request.Method == "POST"
}

func (this *BaseController) isGet() bool {
	return this.Ctx.Request.Method == "GET"
}


func (this *BaseController) ajaxMsg(code int,msg string) {
	out := make(map[string]interface{})
	out["code"] = code
	out["msg"] = msg
	this.Data["json"] = out
	this.ServeJSON()
	this.StopRun()
}

func (this *BaseController) ajaxData(code int,msg string,data interface{}) {
	out := make(map[string]interface{})
	out["code"] = code
	out["msg"] = msg
	out["data"] = data
	this.Data["json"] = out
	this.ServeJSON()
	this.StopRun()
}

func (this *BaseController) ajaxLayuiTable(code int,msg string,count int64,data interface{}) {
	out := make(map[string]interface{})
	out["code"] = code
	out["msg"] = msg
	out["count"] = count
	out["data"] = data
	this.Data["json"] = out
	this.ServeJSON()
	this.StopRun()
}

func (this *BaseController) UploadFile(filename string, filepath string) {
	f, h, err := this.GetFile(filename)

	out := make(map[string]interface{})
	out["code"] = utils.CODE_ERROR
	if err != nil {
		out["msg"] = "文件读取错误"
	}
	var fileSuffix, newFile string
	fileSuffix = path.Ext(h.Filename) //获取文件后缀
	newFile = utils.GetRandomString(8) + fileSuffix
	err = this.SaveToFile("upfile", filepath+newFile)
	if err != nil {
		out["msg"] = "文件保存错误"
	}
	defer f.Close()
	out["url"] = filepath + newFile
	out["title"] = newFile
	out["original"] = h.Filename
	out["size"] = 1000
	out["code"] = utils.CODE_OK
	out["msg"] = utils.MSG_SUCCESS
	this.Data["data"] = out
	this.ServeJSON()
	this.StopRun()
}