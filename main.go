package main

import (
	_ "go-blog/routers"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"go-blog/models"
	"go-blog/controllers"
	"github.com/patrickmn/go-cache"
	"time"
	"go-blog/utils"
)


func init() {
	models.RegisterDB()
	models.Filters()
}

func main() {

	// 开启 ORM 调试模式
	orm.Debug = true
	// create table
	orm.RunSyncdb("default", false, true)

	beego.ErrorController(&controllers.ErrorController{})

	utils.Che = cache.New(60*time.Minute, 120*time.Minute)
	beego.Run()
}

