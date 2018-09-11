package models

import "github.com/astaxie/beego/orm"

/*
   @Time : 2018/9/11 17:16 
   @Author : ff
*/

/**
   注册db
 */
func RegisterDB() {
	// set default database
	orm.RegisterDataBase("default", "mysql", "root:root@tcp(127.0.0.1:3306)/go-blog?charset=utf8", 30)

	// register model
	orm.RegisterModelWithPrefix("t_", new(User),new(Article))

}