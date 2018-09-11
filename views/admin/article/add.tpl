<link rel='stylesheet' media='all' href='/static/dist/css/plugins.css'/>
<script type="text/javascript" src="/static/dist/js/plugins.js"></script>

<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <span>添加文章</span>
            </div>
            <div class="panel-body">

                <form id="qForm" class="form-horizontal form-label-left" method="post" action="/article/save" enctype="multipart/form-data">
                    <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right">标题</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="title" value="" maxlength="64" data-required >
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right">预览图</label>
                        <div class="col-sm-10">
                            <input type="file" name="file" thumbnail>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right">发布到</label>
                        <div class="col-sm-3">
                            <select class="form-control" name="channelId">
                                <option value="1" >banner</option>
                                <option value="2" >博客</option>
                                <option value="3" >问答</option>
                                <option value="4" >分享</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="desc" class="col-sm-2 control-label no-padding-right">内容:</label>
                        <div class="col-sm-10">
                            <script type="text/javascript" charset="utf-8" src="/static/dist/js/jquery.form.min.js"></script>
                            <script type="text/javascript" charset="utf-8" src="/static/dist/vendors/tinymce/tinymce.min.js"></script>

                            <textarea id="view_content" name="content" rows="5" data-required data-describedby="message" data-description="content"></textarea>

                            <script type="text/javascript">
                                $(function () {
                                    tinymce.init({
                                        selector: "#view_content",
                                        theme: 'modern',
                                        height: 400,
                                        plugins: [
                                            'advlist autolink autosave lists link image print anchor codesample',
                                            'searchreplace visualblocks code fullscreen textcolor colorpicker textpattern uploadimage',
                                            'contextmenu paste'
                                        ],
                                        toolbar: "undo redo | formatselect bold underline blockquote alignleft aligncenter alignright " +
                                        "forecolor bullist numlist link unlink uploadimage codesample removeformat fullscreen ",
                                        menubar: false,
                                        language: "zh_CN",
                                        statusbar : false,
                                        body_class: 'markdown-body',
                                        codesample_dialog_width: '600',
                                        codesample_dialog_height: '400',
                                        block_formats: 'Paragraph=p;标题1=h4;标题2=h5;标题3=h6;Preformatted=pre',

                                        content_css: [
                                            '/static/dist/vendors/bootstrap/css/bootstrap.min.css',
                                            '/static/theme/default/css/editor.css',
                                        ]
                                        //参考网站 https://www.tinymce.com/
                                    });
                                })
                            </script>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label no-padding-right">标签</label>
                        <div class="col-sm-10">
                            <input type="hidden" name="tags" id="fieldTags" value="">
                            <ul id="tags"></ul>
                            <p class="help-block" style="font-size: 12px;">添加相关标签，用逗号或空格分隔.</p>
                        </div>
                    </div>

                    <div class="ln_solid"></div>
                    <div class="form-group">
                        <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                            <button type="submit" class="btn btn-success">提交</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function() {
        $('#tags').tagit({
            singleField: true,
            singleFieldNode: $('#fieldTags')
        });

        $('form').validate({
            onKeyup : true,
            onChange : true,
            eachValidField : function() {
                $(this).closest('div').removeClass('has-error').addClass('has-success');
            },
            eachInvalidField : function() {
                $(this).closest('div').removeClass('has-success').addClass('has-error');
            },
            conditional : {
                content : function() {
                    return $(this).val().trim().length > 0;
                }
            },
            description : {
                content : {
                    required : '<div class="alert alert-danger"><button type="button" class="close" data-dismiss="alert"><span aria-hidden="true">&times;</span></button>写点内容吧</div>'
                }
            }
        });
    });

    layui.use(['layer','form'], function(){
        var layer = layui.layer; //弹层
        var form = layui.form;
        var error_info = "{{.flash.error}}";
        if(error_info){
            layer.msg(error_info,{time:2000,offset: '100px'});
        }

    })
</script>

