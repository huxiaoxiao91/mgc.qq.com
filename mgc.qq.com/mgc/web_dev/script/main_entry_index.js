/// <reference path="../lib/utils/jquery-lazyload.js" />
/**
 * Created by Shixinqi on 2015/11/11.
 */
//debugger 环境下，开发用的配置
if (STATIC_RESOURCE.debug) {
    requirejs.config({
        baseUrl: '/script',
        shim: {
            jquery: {
                exports: '$'
            },
            underscore: {
                exports: '_'
            },
            backbone: {
                deps: ['underscore', 'jquery'],
                exports: 'Backbone'
            },
            swfobject: {
                exports: 'swfobject'
            },
            login_manager: {
                exports: 'LoginManager'
            },
            eas: {
                exports: 'eas'
            },
            tgadshow: {
                exports: 'tgadshow'
            },
            jqtmpl: {
                deps: ['jquery'],
                exports: 'jqtmpl'
            },
            js_scrollpane: {
                deps: ['jquery'],
                exports: 'js_scrollpane'
            },
            js_mousewheel: {
                deps: ['jquery'],
                exports: 'js_mousewheel'
            },
            jq_dialog: {
                deps: ['jquery'],
                exports: 'jq_dialog'
            }
        },
        paths: {
            //外部库
            jquery: 'lib/utils/jquery-1.11.3.min',
            underscore: 'lib/utils/underscore-1.8.3.min',
            backbone: 'lib/utils/backbone-1.2.3.min',
            jqtmpl: 'lib/utils/jquery.tmpl.min',
            jq_dialog: 'lib/jquery/mgc_dialog.min',
            js_scrollpane: 'lib/jquery/jquery.jscrollpane.min',
            js_mousewheel: 'lib/jquery/jquery.mousewheel',
            swfobject: 'lib/utils/swfobject',
            login_manager: 'http://ossweb-img.qq.com/images/js/login/loginmanagerv3',
            eas: 'http://ossweb-img.qq.com/images/js/eas/eas',
            tgadshow: 'http://ossweb-img.qq.com/images/js/comm/tgadshow.min',
            mgc_ad: 'http://mgc.qq.com/upload/x5/x5mgc/ad',
            //基础库 /base
            mgc_account: 'base/mgc_account',
            mgc_callcenter: 'base/mgc_callcenter',
            mgc_consts: 'base/mgc_consts',
            mgc_dialog: 'base/mgc_dialog',
            mgc_login: 'base/mgc_login',
            mgc_network: 'base/mgc_network',
            mgc_popmanager: 'base/mgc_popmanager',
            mgc_tool: 'base/mgc_tool',
            mgc_tips: 'base/mgc_tips',
            room_entry: 'room_entry',
            main_entry: 'main_entry',
            //配置 /config
            mgc_config: 'comm/mgc_config',
            //MVC
            //control
            mgc_act: 'ui/control/mgc_act',
            mgc_app_extend: 'ui/control/mgc_app_extend',
            mgc_caveolaeroom: 'ui/control/mgc_caveolaeroom',
            mgc_comm: 'ui/control/mgc_comm',
            mgc_fansguards: 'ui/control/mgc_fansguards',
            mgc_group_control: 'ui/control/mgc_group_control',
            mgc_index: 'ui/control/mgc_index',
            mgc_index_extend: 'ui/control/mgc_index_extend',
            mgc_liveroom: 'ui/control/mgc_liveroom',
            mgc_luckydraw: 'ui/control/mgc_luckydraw',
            mgc_nest: 'ui/control/mgc_nest',
            mgc_personal: 'ui/control/mgc_personal',
            mgc_punch_card: 'ui/control/mgc_punch_card',
            mgc_ranklist: 'ui/control/mgc_ranklist',
            mgc_rankmeili: 'ui/control/mgc_rankmeili',
            mgc_room: 'ui/control/mgc_room',
            mgc_seat: 'ui/control/mgc_seat',
            mgc_show: 'ui/control/mgc_show',
            mgc_skin: 'ui/control/mgc_skin',
            mgc_transfer: 'ui/control/mgc_transfer',
            mgc_vote: 'ui/control/mgc_vote',
            //model
            mgc_comm_model: 'ui/model/mgc_comm_model',
            mgc_group_model: 'ui/model/mgc_group_model',
            mgc_index_model: 'ui/model/mgc_index_model',
            mgc_luckydraw_model: 'ui/model/mgc_luckydraw_model',
            mgc_ranklist_model: 'ui/model/mgc_ranklist_model',
            mgc_room_model: 'ui/model/mgc_room_model',
            mgc_seat_model: 'ui/model/mgc_seat_model',
            mgc_show_model: 'ui/model/mgc_show_model',
            //collection
            mgc_comm_coll: 'ui/collection/mgc_comm_coll',
            mgc_index_coll: 'ui/collection/mgc_index_coll',
            mgc_ranklist_coll: 'ui/collection/mgc_ranklist_coll',
            mgc_room_coll: 'ui/collection/mgc_room_coll',
            mgc_show_coll: 'ui/collection/mgc_show_coll',
            //view
            mgc_comm_view: 'ui/view/mgc_comm_view',
            mgc_group_view: 'ui/view/mgc_group_view',
            mgc_index_view: 'ui/view/mgc_index_view',
            mgc_liveroom_view: 'ui/view/mgc_liveroom_view',
            mgc_luckydraw_view: 'ui/view/mgc_luckydraw_view',
            mgc_punchcard_view: 'ui/view/mgc_punchcard_view',
            mgc_ranklist_view: 'ui/view/mgc_ranklist_view',
            mgc_room_view: 'ui/view/mgc_room_view',
            mgc_seat_view: 'ui/view/mgc_seat_view',
            mgc_show_view: 'ui/view/mgc_show_view',
            //template
            mgc_templates: 'ui/template/mgc_templates'
        }
    })
}

require(['jquery', 'mgc_callcenter', 'jqtmpl', 'mgc_comm_view', 'mgc_index', 'mgc_ad', 'main_entry', 'mgc_tool', 'jq_dialog'], function($, callcenter, jqtmpl, comm_view, index, ad, entry, tool, jq_dialog) {
    console.log("body load finash");
    var loginCallback = function(res_type, resp, params) {
        console.log("login callback");
        //load room list
        //用于记录当前热门推荐模块是模块1或是2
        var hotModuleType = 1;//默认1：推荐模块1,2：推荐模块2
        if(tool.cookie("hotModule")==1){
            tool.cookie("hotModule",2);
            hotModuleType = 2;
        }else{
            tool.cookie("hotModule",1);
            hotModuleType = 1;
        }
        window.mgc.hotRoomPage = 0;
        window.mgc.mobilePage = 0;
        window.mgc.popRoomPage = 0;
        window.mgc.newstarRoomPage = 0;
    
        //推荐房间
        callcenter.query_video_room_list(0, 1, 12, "", 0, hotModuleType, 1, index.getHotRoomListCallBack);
        // 手机直播房间 15
        callcenter.query_video_room_list(15, 1, 8, "", 0, 1, 1, index.getMobileLiveList);
        //公会房间
        callcenter.query_video_room_list(10, 1, 8, "", 0, 1, 1, index.getPopRoomListCallBack);
        //新星房间
        callcenter.query_video_room_list(4, 1, 8, "", 0, 1, 1, index.getNewStarRoomListCallBack);
        //娱乐表演
        callcenter.query_custom_tab_list(tool.is_home_page(), index.getCustomTabListCallBack);
        //top10星耀
        index.InitRanks.Init();
        //节日活动
        tool.ACT.DO_ACT();
        if (tool.cookie('mgc_login_succeed_uin') != null) {
            callcenter.check_goodFriendPay(index.goodFriendPayCallBack);
        }
        // 获取演唱会回放房间列表事件 341
        callcenter.concert_playback_room_get_roomlist(0, 1, index.playCallbackFirstImg);
        // test data
        // index.playCallbackFirstImg({rooms:[]});
    };
    //轮播banner广告
    window.adMessageCon = {};
    var BannerAdCallBack = function(){
        var banner_coll = new mgc.comm_coll.BannerColl();
        $.getScript("http://game.qq.com/time/qqadv/Info_new_15558.js",function(){
            window.adMessageCon.TOP = changeAdMessage(oDaTaNew15558);
            banner_coll.reset(window.adMessageCon.TOP);
            var banner_slider_view = new comm_view.BannerSliderView(banner_coll, null);
        });
    };
    //处理官网返回过来的广告数据
    var changeAdMessage = function(data){
        var adMessageArr = [];
        $.each(data,function(k,v){
            var adMessage = {};
            adMessage.iSeqId = k.replace(/[^0-9]/ig,"");//广告id
            adMessage.sDesc = decodeURIComponent(v[0]);//广告名称
            adMessage.sAdUrl = v[1];//广告链接
            adMessage.sImageUrl = 'http://game.gtimg.cn/upload/adw/'+v[2];//广告图片位置
            adMessageArr.push(adMessage);
        });
        return adMessageArr;
    };
    $(function() {
        //load banner
        try {
            BannerAdCallBack();
            $.getScript("http://game.qq.com/time/qqadv/Info_new_15559.js",function(){
                window.adMessageCon.QUICK_IMG = changeAdMessage(oDaTaNew15559);
                $.getScript("http://game.qq.com/time/qqadv/Info_new_15560.js",function(){
                    window.adMessageCon.YULIU = changeAdMessage(oDaTaNew15560);
                    index.quickAdCallBack(window.adMessageCon.QUICK_IMG, window.adMessageCon);
                });
            });
        } catch (e) {
            console.log(e.message);
        }
    });
    callcenter.listenToInited(function() { entry.onNetworkInited(loginCallback) });
    
});