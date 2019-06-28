package controllers

import (
	"html/template"
	"github.com/zppvae/go-blog/models"
	"github.com/astaxie/beego"
	"github.com/zppvae/go-blog/utils"
	"fmt"
)

/*
   @Time : 2018/9/27 15:56 
   @Author : ff
*/

type UserController struct {
	BaseController
}

func (this *UserController) Add()  {
	this.Data["xsrfdata"] = template.HTML(this.XSRFFormHTML())
	this.useLayout("admin/user/add.tpl")
}

func (this *UserController) List()  {
	flash := beego.ReadFromRequest(&this.Controller)
	if error := flash.Data["error"]; error != "" {
		fmt.Println(error)
		this.Data["error"] = error
	}
	if notice := flash.Data["notice"]; notice != "" {
		fmt.Println(notice)
		this.Data["notice"] = notice
	}

	this.useLayout("admin/user/list.tpl")

}

func (this *UserController) Save(){

	username := this.Input().Get("username")
	password := this.Input().Get("password")

	pwd,salt := utils.SetPassword(password)
	user := new(models.User)
	user.Username = username
	user.Password = pwd
	user.Salt = salt

	flash := beego.NewFlash()
	_,err := models.UserAdd(user)
	if err != nil {
		flash.Error( "添加用户错误")
		flash.Store(&this.Controller)
		this.redirect(beego.URLFor("UserController.Add"))
		return
	}
	flash.Notice("添加成功")
	flash.Store(&this.Controller)
	this.redirect(beego.URLFor("UserController.List"))
}

func (this *UserController) Table()  {
	//加载列表数据
	page, err := this.GetInt64("page")
	if err != nil {
		page = 1
	}
	limit, err := this.GetInt64("limit")
	if err != nil {
		limit = 30
	}
	this.pageSize = limit
	result,count := models.UserGetList(page,this.pageSize)
	list := make([]map[string]interface{}, len(result))

	for k, v := range result {
		row := make(map[string]interface{})
		row["id"] = v.Id
		row["username"] = v.Username
		list[k] = row
	}
	this.ajaxLayuiTable(utils.CODE_OK, utils.MSG_SUCCESS, count, list)
}
