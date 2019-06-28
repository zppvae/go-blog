package controllers

import (
	"github.com/astaxie/beego/context"
	"github.com/astaxie/beego"
	"github.com/zppvae/go-blog/models"
	"html/template"
	"github.com/zppvae/go-blog/utils"
	"strconv"
	cache "github.com/patrickmn/go-cache"
	"strings"
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

		user,err := models.GetUser(username)

		flash := beego.NewFlash()
		errorMsg := ""
		if err != nil || user.Password != utils.MD5([] byte(password + user.Salt)) {
			errorMsg = "帐号或密码错误"
			flash.Error(errorMsg)
			flash.Store(&this.Controller)
			this.redirect(beego.URLFor("HomeController.Login"))
		} else {
			utils.Che.Set("uid"+strconv.Itoa(user.Id), user, cache.DefaultExpiration)
			authkey := utils.MD5([]byte(this.getClientIp() + "|" + user.Password + user.Salt))
			this.Ctx.SetCookie("auth", strconv.Itoa(user.Id)+"|"+authkey, 3600)
			this.redirect(beego.URLFor("HomeController.Index"))
		}
	}
	this.Data["xsrfdata"] = template.HTML(this.XSRFFormHTML())
	this.TplName = "login.tpl"
}

func (this *LoginController) Logout() {
	this.Ctx.SetCookie("auth", "")
	this.redirect(beego.URLFor("LoginController.Login"))
}

func CheckAccount(ctx *context.Context) bool {
	arr := strings.Split(ctx.GetCookie("auth"), "|")

	if len(arr) == 2 {
		idstr, _ := arr[0], arr[1]
		userId, _ := strconv.Atoi(idstr)

		if userId > 0{
			return true
		}
	}
	return false
}
