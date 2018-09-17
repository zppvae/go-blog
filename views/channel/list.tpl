<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!--[if IE]>
    <meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'/>
    <![endif]-->
    <meta name="baidu-site-verification" content="2nXjznVkpe" />

    <title>博客</title>
    <meta name="keywords" content="mtons, mtons,博客,社区">
    <meta name="description" content="Mtons, 做一个有内涵的技术社区">

    <meta property="mtons:mblog" content="2.2.1">


    <link rel="stylesheet" media='all' href="/static/dist/vendors/bootstrap/css/bootstrap.min.css">
    <link rel='stylesheet' media='all' href="/static/dist/vendors/share.js/css/share.min.css"/>

    <link rel='stylesheet' media='all' href="/static/theme/default/css/style.css"/>
    <link rel='stylesheet' media='all' href="/static/theme/default/css/editor.css"/>
    <link rel='stylesheet' media='all' href="/static/dist/css/plugins.css"/>

    <link rel='stylesheet' media='all' href="/static/dist/vendors/simple-line-icons/css/simple-line-icons.css"/>
    <link rel='stylesheet' media='all' href="/static/dist/vendors/font-awesome/css/font-awesome.min.css"/>
    <link rel='stylesheet' media='all' href="/static/dist/vendors/pace/themes/pace-theme-minimal.css"/>

    <link rel="stylesheet" media="all" href="/static/dist/vendors/highlight/styles/github.css"/>

    <script type="text/javascript" src="/static/dist/js/jquery.min.js"></script>
    <script type="text/javascript" src="/static/dist/js/jquery-migrate-1.2.1.min.js"></script>
    <script type="text/javascript" src="/static/dist/vendors/layer/layer.js"></script>
    <script type="text/javascript" src="/static/dist/vendors/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/static/dist/vendors/validate/jquery-validate.js"></script>

    <script type="text/javascript" src="/static/theme/default/js/utils.js"></script>

    <script src="/static/dist/vendors/pace/pace.min.js"></script>

    <script type="text/javascript">
        var _base_path = '';

        window.app = {
            base: '',
            LOGIN_TOKEN: '1'
        };

        //window.UEDITOR_HOME_URL = '/dist/vendors/ueditor/';
    </script>

    <script type="text/javascript" src="/static/theme/default/js/sea.js"></script>
    <script type="text/javascript" src="/static/theme/default/js/sea.config.js"></script>

    <!-- Favicons -->
    <link rel="apple-touch-icon-precomposed" href="http://mtons.com/dist/images/logo.png"/>
    <link rel="shortcut icon" href="http://mtons.com/dist/images/logo.png"/>
</head>
<body>

<!-- Fixed navbar -->
<header class="site-header headroom">
    <!--[if lt IE 9]>
    <div class="alert alert-danger alert-dismissible fade in" role="alert" style="margin-bottom:0">
        <button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
        <strong>您正在使用低版本浏览器，</strong> 在本页面的显示效果可能有差异。
        建议您升级到
        <a href="http://www.google.cn/intl/zh-CN/chrome/" target="_blank">Chrome</a>
        或以下浏览器：
        <a href="www.mozilla.org/en-US/firefox/‎" target="_blank">Firefox</a> /
        <a href="http://www.apple.com.cn/safari/" target="_blank">Safari</a> /
        <a href="http://www.opera.com/" target="_blank">Opera</a> /
        <a href="http://windows.microsoft.com/en-us/internet-explorer/download-ie" target="_blank">Internet Explorer 9+</a>
    </div>
    <![endif]-->

    <div class="container">
        <nav class="navbar" role="navigation">
            <div class="navbar-header">
                <button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/">
                    <img src="/static/theme/default/images/logo.png"/>
                </a>
            </div>
            <div class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li>
                        <a href="/channels/2?page=1" nav="博客">博客</a>
                    </li>
                    <li>
                        <a href="/channels/3?page=1" nav="问答">问答</a>
                    </li>
                    <li>
                        <a href="/channels/4?page=1" nav="分享">分享</a>
                    </li>
                </ul>
                <ul class="navbar-button list-inline" id="header_user">
                    <li view="search" class="hidden-xs hidden-sm">
                        <form method="GET" action="/search" accept-charset="UTF-8" class="navbar-form navbar-left">
                            <div class="form-group">
                                <input class="form-control search-input mac-style" placeholder="搜索" name="kw" type="text" value="">
                                <button class="search-btn" type="submit"><i class="fa fa-search"></i></button>
                            </div>
                        </form>
                    </li>
                </ul>
            </div>
        </nav>
    </div>
</header>

<script type="text/javascript">
    $(function () {
        $('a[nav]').each(function(){
            $this = $(this);
            if($this[0].href == String(window.location)){
                $this.closest('li').addClass("active");
            }
        });
    });
</script>
<!-- Header END --><!-- /header -->
<style>
    .excerpt-1 {
        border-radius: 4px 4px 0 0;
    }
    .excerpt h2 {
        display: inline;
        font-size: 18px;
        line-height: 1.4;
        margin-top: 0;
        font-weight: bold;
    }
    .excerpt h2 a {
        color: #555;
    }
    .excerpt {
        border: 1px solid #eaeaea;
        padding: 20px 20px 20px 255px;
        overflow: hidden;
        background-color: #fff;
        margin-bottom: -1px;
    }
    .excerpt .focus {
        float: left;
        margin-left: -235px;
        width: 220px;
    }
    .excerpt header {
        margin-bottom: 10px;
    }
    .excerpt .meta {
        color: #999;
        font-size: 12px;
        margin-bottom: 10px;
    }
    .meta {
        font-size: 13px;
        color: #999;
        line-height: 1;
    }
    .excerpt .note {
        font-size: 12px;
        color: #999;
        word-wrap: break-word;
        line-height: 25px;
        margin-bottom: 0;
    }
</style>
<!-- content -->
<div class="wrap">
    <!-- Main -->
    <div class="container">

        <ol class="breadcrumb ">
            <li title="发布时间排序" {{if eq "created" .order}} class="active" {{end}}>
                <a href="?order=created">最近</a>
            </li>
            <li title="浏览次数排序" {{if eq "views" .order}} class="active" {{end}}>
                <a href="?order=views">热门</a>
            </li>
        </ol>

        <div class="row main">
            <div class="col-xs-12 col-md-9 side-left topics-show">
                {{range $index,$elem := .articles}}
                <article class="excerpt excerpt-1">
                    <a target="_blank" class="focus" href="/article/view?id={{$elem.id}}">
                        <img alt="{{$elem.title}}" src="{{$elem.thumbnailHtml}}" class="thumb1" style="display: inline;width: 220px">
                    </a>
                    <header>
                        <h2>
                            <a target="_blank" href="/article/view?id={{$elem.id}}" title="{{$elem.title}}">{{$elem.title}}</a>
                        </h2>
                    </header>
                    <p class="meta">
                        <time>
                            <i class="fa fa-clock-o"></i>{{$elem.created}}
                        </time>
                        <span class="pv">
                            <i class="fa fa-eye"></i>阅读({{$elem.views}})
                        </span>
                    </p>
                    <p class="note">{{str2html $elem.content}}</p>
                </article>
                {{end}}
                {{template "inc/paging.tpl" .}}

            </div>
        </div>
    </div>
</div>
<!-- /content -->

<!-- footer -->
{{template "inc/footer.tpl"}}
</body>
</html>

