<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">

    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>{{.siteName}}</title>
    <link rel="stylesheet" href="/static/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="/static/css/login.css?t=1504439386550" media="all">
</head>
<body>
<div class="layui-carousel video_mask bg-img" id="login_carousel" >

    <div class="login layui-anim layui-anim-up">
        <h1>blog管理后台</h1></p>
        <form class="layui-form" action="/login" method="post">
            <div class="layui-form-item">
                <input type="text" name="username" lay-verify="required" placeholder="请输入账号" autocomplete="off"  value="{{.username}}" class="layui-input">
            </div>
            <div class="layui-form-item">
                <input type="password" name="password" lay-verify="required" placeholder="请输入密码" autocomplete="off" value="" class="layui-input">
            </div>
            <a href="/login"><button class="layui-btn login_btn" lay-submit="" lay-filter="login">登录</button></a>
        </form>
    </div>
</div>
<script src="/static/layui/layui.js?t=1504439386550" charset="utf-8"></script>
<!-- <script src="https://cdn.bootcss.com/jquery/1.8.3/jquery.js"></script>-->
<script type="text/javascript">
    layui.use(['layer'], function(){
        var layer = layui.layer; //弹层
        var error_info = "{{.flash.error}}";
        if(error_info){
            layer.msg(error_info,{time:2000,offset: '100px'});
        }

    })
</script>
</body>
</html>



