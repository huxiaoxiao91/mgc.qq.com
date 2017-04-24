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
            mgc_recommend: 'ui/control/mgc_recommend',
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

require(['main_entry', 'mgc_callcenter', 'mgc_room'], function (entry, callcenter, room) {
    var loginCallback = function (res_type, resp, params) {
        console.log("login callback");
        room.init();
    };
    callcenter.listenToInited(function () {
        entry.onNetworkInited(loginCallback);
    });
});