seajs.config({
    alias: {
        'plugins': 'dist/js/plugins',

            /* modules */
        'main': 'default/js/modules/main',
        'authc': 'default/js/modules/authc',
        'sidebox': 'default/js/modules/sidebox',
        'post': 'default/js/modules/post',
        'comment': 'default/js/modules/comment',
        'phiz': 'default/js/modules/phiz',
        'avatar': 'default/js/modules/avatar',
        'editor': 'default/js/modules/editor',
        'view': 'default/js/modules/view',
        'webuploader': 'default/js/modules/webuploader',

        /* vendors */
        'pace': 'vendors/pace/pace.min',
        'pjax': 'vendors/pjax/jquery.pjax',
        'dmuploader': 'vendors/uploader/dmuploader',
        'webuploader.min': 'vendors/webuploader/webuploader.min',
        'webuploader.css': 'vendors/webuploader/webuploader.css',
        'jcrop': 'vendors/jcrop/jquery.jcrop.min',
        'validate': 'vendors/validate/jquery-validate',
        'lazyload': 'vendors/lazyload/jquery.lazyload',
        'share': 'vendors/share.js/js/social-share.min.js',

        'highlight':'vendors/highlight/highlight.pack',
        "tinymce": "vendors/tinymce/tinymce.min",
        "form": "dist/js/jquery.form.min"
    },

    // 路径配置
    paths: {
        'vendors': '/static/dist/vendors',
        'dist': '/static/dist',
        'default': '/static/theme/default'
    },

    // 变量配置
    vars: {
        'locale': 'zh-cn'
    },

    charset: 'utf-8',

    debug: false
});

// var __SEAJS_FILE_VERSION = '?v=1.3';
//
// seajs.on('fetch', function(data) {
// 	if (!data.uri) {
// 		return ;
// 	}
//
// 	if (data.uri.indexOf(app.mainScript) > 0) {
// 		return ;
// 	}
//
//    if (/\:\/\/.*?\/assets\/libs\/[^(inc)]/.test(data.uri)) {
//        return ;
//    }
//
//    data.requestUri = data.uri + __SEAJS_FILE_VERSION;
//
// });
//
// seajs.on('define', function(data) {
// 	if (data.uri.lastIndexOf(__SEAJS_FILE_VERSION) > 0) {
// 	    data.uri = data.uri.replace(__SEAJS_FILE_VERSION, '');
// 	}
// });