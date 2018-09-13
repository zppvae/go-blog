<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <span>文章管理</span>
                <ul class="nav nav-pills navbar-right panel-toolbox">
                    <li><a href="/article/add">新建</a></li>
                    <li><a href="javascrit:void(0);" data-action="batch_del">批量删除</a></li>
                </ul>
            </div>
            <div class="panel-body">
                <form id="qForm" class="form-inline panel-form">
                    <input type="hidden" name="pn" value="" />
                    <div class="form-group">
                        <input type="text" name="title" class="form-control" value="" placeholder="请输入标题关键字">
                    </div>
                    <button type="submit" class="btn btn-default">查询</button>
                </form>
                <table class="layui-table" lay-data="{width: 'full-10', height: 'full-105', url:'/article/list', page:true, id:'idTest'}" lay-filter="demo">
                    <thead>
                    <tr>
                        <th lay-data="{field:'id', width:80, fixed: true}">ID</th>
                        <th lay-data="{field:'title', width:200}">标题</th>
                        <th lay-data="{field:'author', width:100}">作者</th>
                        <th lay-data="{field:'created', width:100}">发表日期</th>
                        <th lay-data="{field:'views', width:100}">访问数</th>
                        <th lay-data="{fixed: 'right', width:150, align:'center', toolbar: '#barDemo'}">操作</th>
                    </tr>
                    </thead>
                </table>

                <script type="text/html" id="barDemo">
                    <a class="btn btn-xs btn-default" lay-event="featured" title="推荐">
                        <i class="fa fa-sun-o"></i>
                    </a>
                    <a class="btn btn-xs btn-default" lay-event="weight" title="置顶">
                        <i class="fa fa-angle-double-up"></i>
                    </a>
                    <a class="btn btn-xs btn-info" lay-event="edit">
                        <i class="fa fa-edit"></i>
                    </a>
                    <a class="btn btn-xs btn-primary" lay-event="delete">
                        <i class="fa fa-trash-o"></i>
                    </a>
                </script>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var J = jQuery;

    function ajaxReload(json){
        if(json.code >= 0){
            if(json.message != null && json.message != ''){
                layer.msg(json.message, {icon: 1});
            }
            $('#qForm').submit();
        }else{
            layer.msg(json.message, {icon: 2});
        }
    }

    function doDelete(ids) {
        J.getJSON('/admin/post/delete', J.param({'id': ids}, true), ajaxReload);
    }

    function doUpdateFeatured(id, featured) {
        J.getJSON('/admin/post/featured', J.param({'id': id, 'featured': featured}, true), ajaxReload);
    }

    function doUpdateWeight(id, weight) {
        J.getJSON('/admin/post/weight', J.param({'id': id, 'weight': weight}, true), ajaxReload);
    }

    $(function() {
        // 删除
        $('#dataGrid a[rel="delete"]').bind('click', function(){
            var that = $(this);
            layer.confirm('确定删除此项吗?', {
                btn: ['确定','取消'], //按钮
                shade: false //不显示遮罩
            }, function(){
                doDelete(that.attr('data-id'));
            }, function(){
            });
            return false;
        });

        // 推荐/加精
        $('#dataGrid a[rel="featured"]').bind('click', function(){
            var that = $(this);
            layer.confirm('确定推荐吗?', {
                btn: ['确定','取消'], //按钮
                shade: false //不显示遮罩
            }, function(){
                doUpdateFeatured(that.attr('data-id'), 1);
            }, function(){
            });
            return false;
        });

        // 撤销
        $('#dataGrid a[rel="unfeatured"]').bind('click', function(){
            var that = $(this);
            layer.confirm('确定撤销吗?', {
                btn: ['确定','取消'], //按钮
                shade: false //不显示遮罩
            }, function(){
                doUpdateFeatured(that.attr('data-id'), 0);
            }, function(){
            });
            return false;
        });

        // 推荐/加精
        $('#dataGrid a[rel="weight"]').bind('click', function(){
            var that = $(this);
            layer.confirm('确定推荐吗?推荐后将显示在Banner位上', {
                btn: ['确定','取消'], //按钮
                shade: false //不显示遮罩
            }, function(){
                doUpdateWeight(that.attr('data-id'), 1);
            }, function(){
            });
            return false;
        });

        // 撤销
        $('#dataGrid a[rel="unweight"]').bind('click', function(){
            var that = $(this);
            layer.confirm('确定撤销吗?', {
                btn: ['确定','取消'], //按钮
                shade: false //不显示遮罩
            }, function(){
                doUpdateWeight(that.attr('data-id'), 0);
            }, function(){
            });
            return false;
        });

        $('a[data-action="batch_del"]').click(function () {
            var check_length=$("input[type=checkbox][name=id]:checked").length;

            if (check_length == 0) {
                layer.msg("请至少选择一项", {icon: 2});
                return false;
            }

            var ids = [];
            $("input[type=checkbox][name=id]:checked").each(function(){
                ids.push($(this).val());
            });

            layer.confirm('确定删除此项吗?', {
                btn: ['确定','取消'], //按钮
                shade: false //不显示遮罩
            }, function(){
                doDelete(ids);
            }, function(){
            });
        });
    })
</script>

