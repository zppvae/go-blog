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
	USER_TABLE = "t_user"
)

// User Struct
type User struct {
	Id   int
	Username string `orm:"size(50)"`
	Password string `orm:"size(50)"`
	Salt     string `orm:"size(50)"`
}

func GetUser(username,password string) (*User, error) {
	o := orm.NewOrm()

	user := new(User)

	qs := o.QueryTable(USER_TABLE)
	err := qs.Filter("username", username).One(user)
	if err != nil {
		return nil, err
	}

	if user.Password != password {
		beego.Error("用户密码错误")
	}
	return user, nil
}

func UserAdd(user *User) (int64,error)  {
	return orm.NewOrm().Insert(user)
}

func UserGetList(page,pageSize int64) ([]*ArticleDTO,int64)  {
	offset := (page - 1) * pageSize
	list := make([]*ArticleDTO, 0)
	o := orm.NewOrm()
	total,_ := o.Raw("select id,username from t_user LIMIT ?,?",
		offset,pageSize).QueryRows(&list)

	return list, total
}