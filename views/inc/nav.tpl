<nav class="navbar navbar-default top-navbar" role="navigation">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a href="/index" class="navbar-brand">
            <img src="/static/dist/images/logo/logo.png" style="height: 30px;"/>
        </a>
    </div>

    <ul class="nav navbar-top-links navbar-right">
        <li class="dropdown">
            <a class="dropdown-toggle" data-toggle="dropdown" href="#" aria-expanded="false">
                <img src="/static/dist/images/ava/default.png" style="width: 22px;margin-right: 5px; border-radius: 25px;">{{.loginUsername}}
            </a>
            <ul class="dropdown-menu dropdown-user">
                <li><a href="/logout"><i class="fa fa-sign-out fa-fw"></i>退出</a></li>
            </ul>
            <!-- /.dropdown-user -->
        </li>
        <!-- /.dropdown -->
    </ul>
</nav>
<!--/. NAV TOP  -->
<nav class="navbar-default navbar-side" role="navigation">
    <div class="sidebar-collapse">
        <ul class="nav" id="main-menu">
            <li>
                <a href="/index" nav="/index"><i class="fa fa-dashboard"></i> 首页</a>
            </li>
            <li><a href="/admin/article/list" nav="/admin/article/list"><i class="fa fa-clone icon-xlarge"></i>文章管理</a></li>
            <li><a href="/admin/comment/list" nav="/admin/comment/list"><i class="fa fa-comments-o icon-xlarge"></i>评论管理</a></li>
            <li><a href="/admin/user/list" nav="/admin/user/list"><i class="fa fa-user icon-xlarge"></i>用户管理</a></li>
            <li><a href="/admin/role/list" nav="/admin/role/list"><i class="fa fa fa-registered icon-xlarge"></i>角色管理</a></li>
            <li><a href="/admin/config/main" nav="/admin/config/main"><i class="fa fa-sun-o icon-xlarge"></i>系统配置</a></li>
        </ul>
    </div>
</nav>