{{define "include"}}
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
    var _base_path = '/static';

    window.app = {
        base: '/static',
        LOGIN_TOKEN: 'zz'
    };

    //window.UEDITOR_HOME_URL = '/static/dist/vendors/ueditor/';
</script>

<script type="text/javascript" src="/static/theme/default/js/sea.js"></script>
<script type="text/javascript" src="/static/theme/default/js/sea.config.js"></script>

<!-- Favicons -->
<link rel="apple-touch-icon-precomposed" href="http://mtons.com/dist/images/logo.png"/>
<link rel="shortcut icon" href="http://mtons.com/dist/images/logo.png"/>
{{end}}