<link rel="stylesheet" href="/static/editor.md/css/editormd.min.css" />

<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <span>添加文章</span>
            </div>
            <div class="layui-layout layui-layout-admin" style="padding-left: 40px;margin-top: 20px;">

                <form class="layui-form" method="post" action="/article/save" enctype="multipart/form-data">
                    {{ .xsrfdata}}
                    <div class="layui-form-item">
                        <label class="layui-form-label">标题</label>
                        <div class="layui-input-block " style="width: 400px">
                            <input type="text" name="title" lay-verify="required" autocomplete="off" class="layui-input" value="">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">预览图</label>
                        <div class="layui-input-block " style="width: 400px">
                            <input type="file" name="file" thumbnail>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">发布到</label>
                        <div class="layui-input-block"  style="width: 400px">
                            <select name="channelId" lay-filter="channelId" lay-verify="required"  lay-search="">
                                <option value="1" >banner</option>
                                <option value="2" >博客</option>
                                <option value="3" >问答</option>
                                <option value="4" >分享</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">内容</label>
                        <div class="layui-input-block" id="article-editormd" style="solid: #e4e4e4">
                            <textarea name="content" style="display:none;"></textarea>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">标签</label>
                        <div class="layui-input-block " style="width: 400px">
                            <input type="text" name="tags" lay-verify="required" autocomplete="off" class="layui-input" value="">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <div class="layui-input-block">
                            <button class="layui-btn" type="submit">保存</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    layui.use(['form','element','table','layer','jquery'],function(){
        var form = layui.form;
        var $ = layui.jquery;
        form.render();
    });
</script>
{{template "inc/editormd.tpl"}}
