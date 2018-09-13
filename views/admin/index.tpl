{{template "inc/header.tpl"}}
<body>
<div id="wrapper">
    {{template "inc/nav.tpl" .}}
    <!-- /. NAV SIDE  -->

    <div id="page-wrapper">
        <div id="page-inner">
            {{.LayoutContent}}
        </div>
    </div>
    <!-- /. PAGE WRAPPER  -->
</div>

<script src="/static/theme/admin/js/jquery.metisMenu.js"></script>
<script src="/static/theme/admin/js/custom-scripts.js"></script>
<script src="/static/theme/admin/js/app.data.js"></script>

</body>
</html>