<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <span>用户管理</span>
            </div>
            <div class="panel-body">
                <div class="layui-btn-group demoTable">
                    <a href="/user/add" class="layui-btn" style="text-decoration: none">新增</a>
                </div>
                <table class="layui-table" lay-data="{width: 310, height:300, url:'/user/table', page:true, id:'idTest'}" lay-filter="demo">
                    <thead>
                        <tr>
                            <th lay-data="{type:'checkbox', fixed: 'left'}"></th>
                            <th lay-data="{field:'id', width:100,fixed: true}">ID</th>
                            <th lay-data="{field:'username', width:200}">用户名</th>
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

