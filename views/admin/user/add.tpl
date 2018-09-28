<div class="row">
    <div class="col-md-12">
        <div class="panel panel-default">
            <div class="panel-heading">
                <span>添加用户</span>
            </div>
            <div class="layui-layout layui-layout-admin" style="padding-left: 40px;margin-top: 20px;">

                <form class="layui-form" method="post" action="/user/save">
                    {{ .xsrfdata}}
                    <div class="layui-form-item">
                        <label class="layui-form-label">用户名</label>
                        <div class="layui-input-block " style="width: 400px">
                            <input type="text" name="username" lay-verify="required" autocomplete="off" class="layui-input" value="">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">密码</label>
                        <div class="layui-input-block " style="width: 400px">
                            <input type="password" name="password" lay-verify="required" autocomplete="off" class="layui-input" value="">
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
