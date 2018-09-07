package controllers

import (
	"github.com/astaxie/beego/context"
	"github.com/astaxie/beego"
	"go-blog/models"
)

/*
   @Time : 2018/9/4 10:48 
   @Author : ff
*/
type LoginController struct {
	beego.Controller
}


func (this *LoginController) Get() {
	// 判断是否为退出操作
	if this.Input().Get("exit") == "true" {
		this.Ctx.SetCookie("uname", "", -1, "/")
		this.Ctx.SetCookie("pwd", "", -1, "/")
		this.Redirect("/", 302)
		return
	}

	this.TplName = "login.html"
}

func (this *LoginController) Post() {
	// 获取表单信息
	username := this.Input().Get("username")
	password := this.Input().Get("password")
	autoLogin := this.Input().Get("autoLogin") == "on"

	_,err := models.GetUser(username,password)

	// 验证用户名及密码
	if err != nil{
		beego.Error("用户登录失败")
	}
	maxAge := 0
	if autoLogin {
		maxAge = 1<<31 - 1
	}

	this.Ctx.SetCookie("uname", username, maxAge, "/")
	this.Ctx.SetCookie("pwd", password, maxAge, "/")
	this.Redirect("/", 302)
	return
}

func checkAccount(ctx *context.Context) bool {
	ck, err := ctx.Request.Cookie("uname")
	if err != nil {
		return false
	}

	uname := ck.Value

	ck, err = ctx.Request.Cookie("pwd")
	if err != nil {
		return false
	}

	pwd := ck.Value

	_,err = models.GetUser(uname,pwd)

	// 验证用户名及密码
	if err != nil{
		beego.Error("用户登录失败")
		return false
	}
	return true
}