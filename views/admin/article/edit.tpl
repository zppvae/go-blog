<link rel="stylesheet" href="/static/editor.md/css/editormd.min.css" />

<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <span>编辑文章</span>
            </div>
            <div class="layui-layout layui-layout-admin" style="padding-left: 40px;margin-top: 20px;">

                <form class="layui-form" method="post" action="/article/update" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="{{.article.id}}">
                    <div class="layui-form-item">
                        <label class="layui-form-label">标题</label>
                        <div class="layui-input-block " style="width: 400px">
                            <input type="text" name="title" lay-verify="required" autocomplete="off" class="layui-input" value="{{.article.title}}">
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
                                {{$channelId := .article.channelId}}
                                <option value="1" {{if eq 1 $channelId}} selected {{end}}>banner</option>
                                <option value="2" {{if eq 2 $channelId}} selected {{end}}>博客</option>
                                <option value="3" {{if eq 3 $channelId}} selected {{end}}>问答</option>
                                <option value="4" {{if eq 4 $channelId}} selected {{end}}>分享</option>
                            </select>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">内容</label>
                        <div class="layui-input-block">
                            <textarea id="view_content" name="content" rows="5" data-required data-describedby="message" data-description="content">
                            {{.article.content}}
                            </textarea>
                            {{template "inc/ueditor.tpl"}}
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">标签</label>
                        <div class="layui-input-block " style="width: 400px">
                            <input type="text" name="tags" lay-verify="required" autocomplete="off" class="layui-input" value="{{.article.tags}}">
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
