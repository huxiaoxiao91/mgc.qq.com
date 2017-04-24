 /**
 * Created by Jason on 2015/10/8.
 */
define(['jquery','mgc_callcenter','mgc_group_model','mgc_group_view'], function ($,callcenter,Model,View) {
    var Control = {};

    /**
     * 加载相应页面
     * id 页面id url 页面地址
     */
    Control.loadPage = function(data){
        $(".groupContent").children().remove();
        $(".groupContent").load(data.url,loadPageComplete);

        /**
         * 加载相应页面完成事件
         */
        function loadPageComplete(response, status, xhr){
            if(status != "success")return;

            switch(data.id){
                case 3:
                    Model.isChief;
                    View.myGroupView.init();

                    break;
            }

        }
    };

    return Control;
});