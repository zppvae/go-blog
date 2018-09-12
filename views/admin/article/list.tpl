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
                <div class="table-responsive">
                    <table id="dataGrid" class="table table-striped table-bordered">
                        <thead>
                        <tr>
                            <th width="30"><input type="checkbox" class="checkall"></th>
                            <th width="80">#</th>
                            <th>文章标题</th>
                            <th width="120">作者</th>
                            <th width="100">发表日期</th>
                            <th width="60">访问数</th>
                            <th width="80">状态</th>
                            <th width="140"></th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>
                                <input type="checkbox" name="id" value="1">
                            </td>
                            <td>
                                <img src="/store/thumbs/2018/0911/11151749cxpt.jpg" style="width: 80px;">
                            </td>
                            <td>
                                <a href="/view/1" target="_blank">xmpp节点详解</a>
                            </td>
                            <td>admin</td>
                            <td>2018-09-11</td>
                            <td>3</td>
                            <td>
                            </td>
                            <td class="text-center" align="left">
                                <a href="javascript:void(0);" class="btn btn-xs btn-default" data-id="1" rel="featured"
                                   data-toggle="tooltip" title="推荐">
                                    <i class="fa fa-sun-o"></i>
                                </a>

                                <a href="javascript:void(0);" class="btn btn-xs btn-default" data-id="1" rel="weight"
                                   data-toggle="tooltip" title="置顶">
                                    <i class="fa fa-angle-double-up"></i>
                                </a>

                                <a href="/admin/post/view?id=1" class="btn btn-xs btn-info">
                                    <i class="fa fa-edit"></i>
                                </a>
                                <a href="javascript:void(0);" class="btn btn-xs btn-primary" data-id="1" rel="delete">
                                    <i class="fa fa-trash-o"></i>
                                </a>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="panel-footer">

                <ul class="pagination">

                    <li class="active"><a href="javascript:void(0);"><span>1</span></a></li>

                </ul>
            </div>
        </div>
    </div>
</div>
<script src="/static/layui/layui.js?t=1504439386550" charset="utf-8"></script>
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
        layui.use(['layer'], function(){
            var layer = layui.layer; //弹层
            var notice = "{{.notice}}";
            if(notice){
                layer.msg(notice,{time:2000});
            }
        })

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

