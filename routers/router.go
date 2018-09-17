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

	beego.Router("/admin/article/list", &controllers.ArticleController{},"*:List")
	beego.Router("/admin/article/add", &controllers.ArticleController{},"*:Add")
	beego.Router("/admin/article/upload", &controllers.ArticleController{},"*:Upload")
	beego.Router("/admin/article/save", &controllers.ArticleController{},"*:Save")
	beego.Router("/admin/article/update", &controllers.ArticleController{},"*:Update")
	beego.Router("/channels/:channelId", &controllers.ArticleController{},"*:ListByChannel")
	beego.Router("/article/latests", &controllers.ArticleController{},"*:Latests")
	beego.Router("/article/hots", &controllers.ArticleController{},"*:Hots")

	beego.AutoRouter(&controllers.ArticleController{})
}
