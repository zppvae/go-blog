package models

import (
	"time"
	"github.com/astaxie/beego/orm"
)

/*
   @Time : 2018/9/11 17:17 
   @Author : ff
*/

const (
	ARTICLE_TABLE = "t_article"
)

type Article struct {
	Id         int
	Title      string
	UserId     int
	ChannelId  int64                            //模块ID
	Comments   int                            //评论数
	Created    time.Time
	Favors     int                            //喜欢数
	Featured   int                            //推荐状态
	Views      int                            //阅读数
	Weight     int                            //置顶状态
	Status     int        `orm:"size(1)"`
	Content    string     `orm:"size(1000)"`
	Summary    string     `orm:"size(1000)"`  //摘要
	Tags       string     `orm:"size(100)"`
	Thumbnail  string     `orm:"size(200)"`   //预览图
}

func ArticleAdd(artcicle *Article) (int64,error)  {
	return orm.NewOrm().Insert(artcicle)
}

func ArticleGetById(id int) (*Article, error) {
	r := new(Article)
	err := orm.NewOrm().QueryTable(ARTICLE_TABLE).Filter("id", id).One(r)
	if err != nil {
		return nil, err
	}
	return r, nil
}

func (a *Article) Delete(fields ...string) error  {
	if _, err := orm.NewOrm().Delete(a, fields...); err != nil {
		return err
	}
	return nil
}

func (a *Article) Update(fields ...string) error {
	if _, err := orm.NewOrm().Update(a, fields...); err != nil {
		return err
	}
	return nil
}

func ArticleGetList(page,pageSize int,filters ...interface{}) ([]*Article,int64)  {
	offset := (page - 1) * pageSize
	list := make([]*Article, 0)
	query := orm.NewOrm().QueryTable(ARTICLE_TABLE)
	if len(filters) > 0 {
		l := len(filters)

		for k := 0; k < l; k += 2 {
			query = query.Filter(filters[k].(string), filters[k+1])
		}
	}
	total, _ := query.Count()
	query.OrderBy("-created", "-id").Limit(pageSize, offset).All(&list)

	return list, total
}