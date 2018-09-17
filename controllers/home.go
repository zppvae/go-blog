package controllers

import "github.com/astaxie/beego"

/*
   @Time : 2018/9/10 11:27 
   @Author : ff
*/

type HomeController struct {
	BaseController
}

func (this *HomeController) Index()  {
	if !CheckAccount(this.Ctx) {
		this.redirect(beego.URLFor("LoginController.Login"))
	}
	this.Data["title"] = "首页"
	this.useLayout("admin/main.tpl")
}