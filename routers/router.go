package routers

import (
	"go-blog/controllers"
	"github.com/astaxie/beego"
)

func init() {
	beego.Router("/", &controllers.HomeController{},"*:Index")
	beego.Router("/index", &controllers.HomeController{},"*:Index")
	beego.Router("/login", &controllers.LoginController{},"*:Login")
	beego.Router("/logout", &controllers.LoginController{},"*:Logout")
}
