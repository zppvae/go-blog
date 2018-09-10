package controllers

/*
   @Time : 2018/9/10 11:27 
   @Author : ff
*/

type HomeController struct {
	BaseController
}

func (this *HomeController) Index()  {
	this.Data["title"] = "首页"
	this.TplName = "admin/index.tpl"
}