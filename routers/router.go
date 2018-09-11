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

	beego.Router("/article/list", &controllers.ArticleController{},"*:List")
	beego.Router("/article/add", &controllers.ArticleController{},"*:Add")
	beego.Router("/article/upload", &controllers.ArticleController{},"*:Upload")
	beego.Router("/article/save", &controllers.ArticleController{},"*:Save")
	beego.Router("/article/update", &controllers.ArticleController{},"*:Post")
}
