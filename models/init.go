package models

import (
	"github.com/astaxie/beego/orm"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/context"
)

/*
   @Time : 2018/9/11 17:16 
   @Author : ff
*/

/**
   注册db
 */
func RegisterDB() {
	username := beego.AppConfig.String("db.username")
	pwd := beego.AppConfig.String("db.password")
	dbhost := beego.AppConfig.String("db.host")
	dbname := beego.AppConfig.String("db.dbname")

	dbstr := username +":"+pwd + "@tcp("+dbhost+":3306)/"+dbname
	// set default database
	orm.RegisterDataBase("default", "mysql", dbstr+"?charset=utf8", 30)

	// register model
	orm.RegisterModelWithPrefix("t_", new(User),new(Article))

}

func Filters()  {
	var FilterUser = func(ctx *context.Context) {
		cookie,err := ctx.Request.Cookie("userId")
		if err != nil {
			ctx.Redirect(302, beego.URLFor("LoginController.Login"))
		}
		if cookie.Value == "" && ctx.Request.RequestURI != "/login" {
			ctx.Redirect(302, beego.URLFor("LoginController.Login"))
		}
	}

	beego.InsertFilter("/admin/*",beego.BeforeRouter,FilterUser)
}