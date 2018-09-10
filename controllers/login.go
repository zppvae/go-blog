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
	BaseController
}

func (this *LoginController) Login() {
	if checkAccount(this.Ctx) {
		this.redirect("/index")
	}
	beego.ReadFromRequest(&this.Controller)

	if this.isPost() {
		// 获取表单信息
		username := this.Input().Get("username")
		password := this.Input().Get("password")
		autoLogin := this.Input().Get("autoLogin") == "on"

		user,err := models.GetUser(username,password)

		flash := beego.NewFlash()
		errorMsg := ""
		if err != nil || user.Password != password {
			errorMsg = "帐号或密码错误"
			flash.Error(errorMsg)
			flash.Store(&this.Controller)
			this.redirect(beego.URLFor("LoginController.Login"))
		} else {
			maxAge := 0
			if autoLogin {
				maxAge = 1<<31 - 1
			}

			this.Ctx.SetCookie("uname", username, maxAge, "/")
			this.Ctx.SetCookie("pwd", password, maxAge, "/")

		}
	}

	this.TplName = "login.html"
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