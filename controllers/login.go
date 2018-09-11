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
	if CheckAccount(this.Ctx) {
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
				maxAge = 1<<5 - 1
			}

			this.Ctx.SetCookie("uname", username, maxAge, "/")
			this.redirect(beego.URLFor("HomeController.Index"))
		}
	}

	this.TplName = "login.tpl"
}

func (this *LoginController) Logout() {
	this.Ctx.SetCookie("uname","")
	this.redirect(beego.URLFor("LoginController.Login"))
}

func CheckAccount(ctx *context.Context) bool {
	uname, err := ctx.Request.Cookie("uname")
	if err != nil {
		return false
	}

	if uname.Value == "" {
		return false
	}
	return true
}