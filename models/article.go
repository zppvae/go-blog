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

type ArticleDTO struct {
	Id         int
	Title      string
	UserId     int
	Username     string
	ChannelId  int64                            //模块ID
	Comments   int                            //评论数
	Created    time.Time
	Favors     int                            //喜欢数
	Featured   int                            //推荐状态
	Views      int                            //阅读数
	Weight     int                            //置顶状态
	Status     int
	Content    string
	Summary    string     						//摘要
	Tags       string
	Thumbnail  string        					//预览图
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

func ArticleGet(id int64) (*ArticleDTO, error) {
	r := new(ArticleDTO)
	err := orm.NewOrm().Raw("select a.*,u.username from t_article a LEFT JOIN t_user u on a.user_id=u.id where a.id=?",id).QueryRow(&r)
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

func ArticleGetList(page,pageSize int64,filters ...interface{}) ([]*ArticleDTO,int64)  {
	offset := (page - 1) * pageSize
	list := make([]*ArticleDTO, 0)
	o := orm.NewOrm()
	total,_ := o.Raw("select a.*,u.username from t_article a LEFT JOIN t_user u on a.user_id=u.id LIMIT ?,?",
		offset,pageSize).QueryRows(&list)

	return list, total
}

//热门文章
func ArticleGetListByHot(page,pageSize int64) ([]*ArticleDTO,int64)  {
	offset := (page - 1) * pageSize
	list := make([]*ArticleDTO, 0)
	o := orm.NewOrm()

	total,_ := o.Raw("select a.*,u.username from t_article a LEFT JOIN t_user u on a.user_id=u.id order by views desc LIMIT ?,?",
		offset,pageSize).QueryRows(&list)

	return list, total
}

//最新发布
func ArticleGetListByCreated(page,pageSize int64) ([]*ArticleDTO,int64)  {
	offset := (page - 1) * pageSize
	list := make([]*ArticleDTO, 0)
	o := orm.NewOrm()

	total,_ := o.Raw("select a.*,u.username from t_article a LEFT JOIN t_user u on a.user_id=u.id order by created desc LIMIT ?,?",
		offset,pageSize).QueryRows(&list)

	return list, total
}

func ArticleGetListByChannelId(channelId int,page,pageSize int64,order string) ([]*ArticleDTO,int64)  {
	offset := (page - 1) * pageSize
	list := make([]*ArticleDTO, 0)
	o := orm.NewOrm()
	total,_ := o.Raw("select a.*,u.username from t_article a LEFT JOIN t_user u on a.user_id=u.id " +
		" where a.channel_id=? order by ? desc LIMIT ?,?", channelId,order,offset,pageSize).QueryRows(&list)

	return list, total
}