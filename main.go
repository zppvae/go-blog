package main

import (
	_ "go-blog/routers"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/orm"
	"go-blog/models"
)


func init() {
	models.RegisterDB()
}

func main() {

	// 开启 ORM 调试模式
	orm.Debug = true
	// create table
	orm.RunSyncdb("default", false, true)

	beego.Run()
}

