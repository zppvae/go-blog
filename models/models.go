package models

import (
	"github.com/astaxie/beego/orm"
	"github.com/astaxie/beego"
	_ "github.com/go-sql-driver/mysql"
)

/*
   @Time : 2018/9/4 10:10 
   @Author : ff
*/

const (
	USER_TABLE = "user"
)

// User Struct
type User struct {
	Id   int
	Username string `orm:"size(50)"`
	Password string `orm:"size(50)"`
}


/**
   注册db
 */
func RegisterDB() {
	// set default database
	orm.RegisterDataBase("default", "mysql", "root:123456@tcp(127.0.0.1:3306)/go-blog?charset=utf8", 30)

	// register model
	orm.RegisterModel(new(User))

}

func GetUser(username,password string) (*User, error) {
	o := orm.NewOrm()

	user := new(User)

	qs := o.QueryTable("topic")
	err := qs.Filter("username", username).One(user)
	if err != nil {
		return nil, err
	}

	if user.Password != password {
		beego.Error("用户密码错误")
	}
	return user, nil
}