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
<script src="/static/layui/layui.js?s=36"></script>
<script type="text/javascript">
    var $;
    layui.config({
        base : "js/"
    }).use(['table','element','layer','jquery'], function(){
        var table = layui.table;
        var element = layui.element;
        $ = layui.jquery

        //监听工具条
        table.on('tool(demo)', function(obj){
            var data = obj.data;
            if(obj.event === 'detail'){
                //layer.msg('ID：'+ data.id + ' 的查看操作');
            } else if(obj.event === 'del'){
                layer.confirm('真的删除【'+data.title+'】么', function(index){
                    var jsData = {'id':data.id}
                    $.post('{{urlfor "NewsController.AjaxDel"}}', jsData, function (out) {
                        if (out.status == 0) {
                            layer.alert('删除成功了', {icon: 1},function(index){
                                layer.close(index);
                                window.location.reload();
                            });
                        } else {
                            layer.msg(out.message)
                        }
                    }, "json");
                    // obj.del();
                    layer.close(index);
                });
            } else if(obj.event === 'edit'){
                window.location.href="/news/edit?id="+data.id
            }
        });
    });
</script>

