<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <span>文章管理</span>
            </div>
            <div class="panel-body">
                <div class="layui-btn-group demoTable">
                    <a href="/article/add" class="layui-btn" style="text-decoration: none">新增</a>
                </div>
                <table class="layui-table" lay-data="{width: 1006, height:500, url:'/article/table', page:true, id:'idTest'}" lay-filter="demo">
                    <thead>
                        <tr>
                            <th lay-data="{type:'checkbox', fixed: 'left'}"></th>
                            <th lay-data="{field:'id', width:80,fixed: true}">ID</th>
                            <th lay-data="{field:'thumbnailHtml', width:100}">预览图</th>
                            <th lay-data="{field:'title', width:240}">标题</th>
                            <th lay-data="{field:'username', width:100}">作者</th>
                            <th lay-data="{field:'created', width:120}">发表日期</th>
                            <th lay-data="{field:'views', width:100}">访问数</th>
                            <th lay-data="{field:'statusHtml', width:90}">状态</th>

                            <th lay-data="{field:'handleHtml', width:130}">操作</th>
                        </tr>
                    </thead>
                </table>

            </div>
        </div>
    </div>
</div>
<script src="/static/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
    var $;
    layui.use(['table','element','layer','jquery'], function(){
        var table = layui.table;
        $ = layui.jquery

        //监听工具条
        table.on('tool(demo)', function(obj){
            var data = obj.data;
            //推荐
            if(obj.event === 'featured'){
                layer.confirm('确定推荐【'+data.title+'】?', function(index){
                    var jsData = {'id':data.id,'featured':1}
                    $.post('{{urlfor "ArticleController.AjaxFeatured"}}', jsData, function (out) {
                        if (out.code == 0) {
                            layer.msg("推荐成功", {icon: 1,time:2000},function(index){
                                layer.close(index);
                                window.location.reload();
                            });
                        } else {
                            layer.msg(out.msg)
                        }
                    }, "json");
                    layer.close(index);
                });
            }
            //取消推荐
            if(obj.event === 'unfeatured'){
                layer.confirm('确定取消推荐【'+data.title+'】?', function(index){
                    var jsData = {'id':data.id,'featured':0}
                    $.post('{{urlfor "ArticleController.AjaxFeatured"}}', jsData, function (out) {
                        if (out.code == 0) {
                            layer.msg("取消推荐成功", {icon: 1,time:2000},function(index){
                                layer.close(index);
                                window.location.reload();
                            });
                        } else {
                            layer.msg(out.msg)
                        }
                    }, "json");
                    layer.close(index);
                });
            }
            //置顶
            if(obj.event === 'weight'){
                layer.confirm('确定置顶【'+data.title+'】?', function(index){
                    var jsData = {'id':data.id,'weight':1}
                    $.post('{{urlfor "ArticleController.AjaxWeight"}}', jsData, function (out) {
                        if (out.code == 0) {
                            layer.msg("置顶成功", {icon: 1,time:2000},function(index){
                                layer.close(index);
                                window.location.reload();
                            });
                        } else {
                            layer.msg(out.msg)
                        }
                    }, "json");
                    layer.close(index);
                });
            }
            //取消置顶
            if(obj.event === 'unweight'){
                layer.confirm('确定取消置顶【'+data.title+'】?', function(index){
                    var jsData = {'id':data.id,'weight':0}
                    $.post('{{urlfor "ArticleController.AjaxWeight"}}', jsData, function (out) {
                        if (out.code == 0) {
                            layer.msg("取消置顶成功", {icon: 1,time:2000},function(index){
                                layer.close(index);
                                window.location.reload();
                            });
                        } else {
                            layer.msg(out.msg)
                        }
                    }, "json");
                    layer.close(index);
                });
            }
            if(obj.event === 'del'){
                layer.confirm('确定删除【'+data.title+'】?', function(index){
                    var jsData = {'id':data.id}
                    $.post('{{urlfor "ArticleController.AjaxDel"}}', jsData, function (out) {
                        if (out.code == 0) {
                            layer.msg("删除成功", {icon: 1,time:2000},function(index){
                                layer.close(index);
                                window.location.reload();
                            });
                        } else {
                            layer.msg(out.msg)
                        }
                    }, "json");
                    layer.close(index);
                });
            }
            if(obj.event === 'edit'){
                window.location.href="/article/edit?id="+data.id
            }
        });
    });

    $(function() {
        layui.use(['layer'], function () {
            var layer = layui.layer; //弹层
            var notice = "{{.notice}}";
            if (notice) {
                layer.msg(notice, {time: 2000});
            }
        })
    });
</script>

