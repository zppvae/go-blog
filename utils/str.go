package utils

import (
	"regexp"
	"time"
	"crypto/md5"
	"fmt"
	"math/rand"
)

/*
   @Time : 2018/9/10 10:32 
   @Author : ff
*/


var emailPattern = regexp.MustCompile("[\\w!#$%&'*+/=?^_`{|}~-]+(?:\\.[\\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\\w](?:[\\w-]*[\\w])?\\.)+[a-zA-Z0-9](?:[\\w-]*[\\w])?")


func IsEmail(b []byte) bool {
	return emailPattern.Match(b)
}

func MD5(buf [] byte) string {
	hash := md5.New()
	hash.Write(buf)
	return fmt.Sprintf("%x", hash.Sum(nil))
}

//生成随机字符串
func GetRandomString(lens int) string {
	str := "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
	bytes := []byte(str)
	result := []byte{}
	r := rand.New(rand.NewSource(time.Now().UnixNano()))
	for i := 0; i < lens; i++ {
		result = append(result, bytes[r.Intn(len(bytes))])
	}
	return string(result)
}

func SetPassword(len int, password string) (pwd string, salt string) {
	salt = GetRandomString(4)
	pwd = MD5([]byte(password + salt))
	return pwd, salt
}