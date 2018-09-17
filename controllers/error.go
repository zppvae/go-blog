package controllers

import "github.com/astaxie/beego"

/*
   @Time : 2018/9/17 17:50 
   @Author : ff
*/

type ErrorController struct {
	beego.Controller
}

func (c *ErrorController) Error404() {
	c.Data["content"] = "page not found"
	c.TplName = "error/404.tpl"
}

func (c *ErrorController) Error501() {
	c.Data["content"] = "server error"
	c.TplName = "error/501.tpl"
}


func (c *ErrorController) ErrorDb() {
	c.Data["content"] = "database is now down"
	c.TplName = "error/dberror.tpl"
}