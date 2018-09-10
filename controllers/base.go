package controllers

import (
	"github.com/astaxie/beego"
	"strings"
)

type BaseController struct {
	beego.Controller

	controllerName string
	actionName     string
	userId         int
	username       string
	pageSize       int
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