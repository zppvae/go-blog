<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!--[if IE]>
    <meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1'/>
    <![endif]-->
    <title>{{.article.title}}</title>
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
            LOGIN_TOKEN: ''
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

<!-- content -->
<div class="wrap">
    <!-- Main -->
    <div class="container">
        <div class="row main">
            <div class="col-xs-12 col-md-9 side-left topics-show">
                <!-- view show -->
                <div class="topic panel panel-default">
                    <div class="infos panel-heading">
                        <h1 class="panel-title topic-title">{{.article.title}}</h1>
                        <div class="meta inline-block">
                            {{.article.username}}
                            <abbr class="timeago">{{.article.created}}</abbr>
                            ⋅ {{.article.views}} 阅读

                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <div class="content-body entry-content panel-body ">
                        <div class="markdown-body">
                            {{str2html .article.content}}
                        </div>
                    </div>
                    <div class="panel-footer operate">
                        {{range $index,$elem := .tags}}
                            <span>
                                <a class="label label-default" href="/tags/{{$elem}}/">#{{$elem}}</a>
                            </span>
                        {{end}}
                    </div>
                    <div class="panel-footer operate">
                        <div class="hidden-xs">
                            <div class="social-share" data-sites="weibo, wechat, facebook, twitter, google, qzone, qq"></div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>

                <!-- /view show -->
            </div>
            <div class="col-xs-12 col-md-3 side-right hidden-xs hidden-sm">
                <div class="panel panel-default corner-radius panel-hot-topics">
                    <div class="panel-heading">
                        <h3 class="panel-title"><i class="fa fa-area-chart"></i> 热门文章</h3>
                    </div>
                    <div class="panel-body">
                        <ul class="list" id="hots">
                            <img src="/static/dist/images/spinner.gif">
                        </ul>
                    </div>
                </div>

                <div class="panel panel-default corner-radius panel-hot-topics">
                    <div class="panel-heading">
                        <h3 class="panel-title"><i class="fa fa-bars"></i> 最新发布</h3>
                    </div>
                    <div class="panel-body">
                        <ul class="list" id="latests">
                            <img src="/static/dist/images/spinner.gif">
                        </ul>
                    </div>
                </div>
                <script type="text/javascript">
                    var li_template = '<li>{0}. <a href="/view/{1}">{2}</a></li>';

                    var hotUser_li_template = '<li><a href="{1}"><img src="{0}" class="avatar avatar-small"/></a></li>'

                    seajs.use('sidebox', function (sidebox) {
                        sidebox.init({
                            latestUrl : '/article/latests',
                            hotUrl : '/article/hots',
                            //hotTagUrl : '/api/hot_tags',
                            //hotUserUrl:'/api/hotusers',

                            size :10,
                            // callback
                            onLoadHot : function (i, data) {
                                return jQuery.format(li_template, i + 1, data.id, data.title);
                            },
                            onLoadLatest : function (i, data) {
                                return jQuery.format(li_template, i + 1, data.id, data.title);
                            },
                            onLoadHotUser : function (i, data) {
                                var url = '/users/' + data.id;
                                var item = jQuery.format(hotUser_li_template,data.avatar,url,data.name, data.fans);
                                return item;
                            }
                        });
                    });
                </script>
            </div>
        </div>

        <script type="text/plain" id="chat_template">
            <li id="chat{5}">
                <a class="avt fl" target="_blank" href="/users/{0}">
                    <img src="{1}">
                </a>
                <div class="chat_body">
                    <h5>
                        <div class="fl"><a class="chat_name" href="/users/{0}">{2}</a><span>{3}</span></div>
                        <div class="fr reply_this"><a href="javascript:void(0);" onclick="goto('{5}', '{2}')">[回复]</a></div>
                        <div class="clear"></div>
                    </h5>
                    <div class="chat_p">
                        <div class="chat_pct">{4}</div> {6}
                    </div>
                </div>
                <div class="clear"></div>
                <div class="chat_reply"></div>
            </li>
        </script>

        <script type="text/javascript">
            function goto(pid, user) {
                document.getElementById('chat_text').scrollIntoView();
                $('#chat_text').focus();
                $('#chat_text').val('');
                $('#chat_to').text(user);
                $('#chat_pid').val(pid);

                $('#chat_reply').show();
            }
            var container = $("#chat_container");
            var template = $('#chat_template')[0].text;

            seajs.use('comment', function (comment) {
                comment.init({
                    //load_url: '/comment/list/1',
                    post_url: '/comment/submit',
                    toId: '1',
                    onLoad: function (i, data) {

                        var content = ContentRender.wrapItem(data.content);

                        var quoto = '';
                        if (data.pid > 0 && !(data.parent === null)) {
                            var pat = data.parent;
                            var pcontent = ContentRender.wrapItem(pat.content);
                            quoto = '<div class="quote"><a href="/users/' + pat.author.id + '">@' + pat.author.name + '</a>: ' + pcontent + '</div>';
                        }
                        var item = jQuery.format(template,
                                data.author.id,
                                data.author.avatar,
                                data.author.name,
                                data.created,
                                content,
                                data.id, quoto);
                        return item;
                    }
                });
            });

            seajs.use(['phiz', 'view'], function (phiz) {
                $("#c-btn").jphiz({
                    base: '/dist',
                    textId: 'chat_text',
                    lnkBoxId: 'c-lnk',
                    phizBoxId: 'c-phiz'
                });
            });

        </script>
    </div>
</div>
<!-- /content -->

<!-- footer -->
{{template "inc/footer.tpl"}}
</body>
</html>
