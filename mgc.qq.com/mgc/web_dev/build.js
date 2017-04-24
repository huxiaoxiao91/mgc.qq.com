﻿({
    appDir: './',
    baseUrl: './script',
    dir: './test-build',
    modules: [
        { name: 'main_entry' }, { name: 'main_entry_act' }, { name: 'main_entry_caveolaeroom' }, { name: 'main_entry_demoroom' }, { name: 'main_entry_group' },
        { name: 'main_entry_index' }, { name: 'main_entry_liveroom' }, { name: 'main_entry_personal' }, { name: 'main_entry_playback' }, { name: 'main_entry_ranklist' }, { name: 'main_entry_room' },
        { name: 'main_entry_show' }, { name: 'main_entry_tencenttmpl' }, { name: 'main_entry_transfer' }, { name: 'room_entry' }, { name: 'room_entry_caveolaeroom' },
        { name: 'room_entry_liveroom' }, { name: 'room_entry_nest' }, { name: 'room_entry_showroom' },
    ],
    fileExclusionRegExp: /^(r|build)\.js|.*\.scss$/,		//排除r.js和build.js
    optimize: 'none',                                        //优化js文件
    optimizeCss: 'standard', 								//优化css文件
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
        jsrender: 'lib/utils/jsrender.min',
        login_manager: 'empty:',
        eas: 'empty:',
        tgadshow: 'empty:',
        mgc_ad: 'empty:',
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
        //配置 /config
        mgc_config: 'comm/mgc_config',
        //MVC
        //control
        mgc_act: 'ui/control/mgc_act',
        mgc_anchor_pk: 'ui/control/mgc_anchor_pk',
        mgc_app_extend: 'ui/control/mgc_app_extend',
        mgc_caveolaeroom: 'ui/control/mgc_caveolaeroom',
        mgc_chat: 'ui/control/mgc_chat',
        mgc_comm: 'ui/control/mgc_comm',
        mgc_fansguards: 'ui/control/mgc_fansguards',
        mgc_festival_activity: 'ui/control/mgc_festival_activity',
        mgc_group_control: 'ui/control/mgc_group_control',
        mgc_index: 'ui/control/mgc_index',
        mgc_index_extend: 'ui/control/mgc_index_extend',
        mgc_last_king: 'ui/control/mgc_last_king',
        mgc_liveroom: 'ui/control/mgc_liveroom',
        mgc_luckydraw: 'ui/control/mgc_luckydraw',
        mgc_nest: 'ui/control/mgc_nest',
        mgc_personal: 'ui/control/mgc_personal',
        mgc_playback: 'ui/control/mgc_playback',
        mgc_punch_card: 'ui/control/mgc_punch_card',
        mgc_ranklist: 'ui/control/mgc_ranklist',
        mgc_rankmeili: 'ui/control/mgc_rankmeili',
        mgc_room: 'ui/control/mgc_room',
        mgc_seat: 'ui/control/mgc_seat',
        mgc_secret_order: 'ui/control/mgc_secret_order',
        mgc_show: 'ui/control/mgc_show',
        mgc_skin: 'ui/control/mgc_skin',
        mgc_transfer: 'ui/control/mgc_transfer',
        mgc_vote: 'ui/control/mgc_vote',
        mgc_pkrank: 'ui/control/mgc_pkrank',
        mgc_recommend: 'ui/control/mgc_recommend',
        //model
        mgc_comm_model: 'ui/model/mgc_comm_model',
        mgc_festival_activity_model: 'ui/model/mgc_festival_activity_model',
        mgc_group_model: 'ui/model/mgc_group_model',
        mgc_index_model: 'ui/model/mgc_index_model',
        mgc_luckydraw_model: 'ui/model/mgc_luckydraw_model',
        mgc_ranklist_model: 'ui/model/mgc_ranklist_model',
        mgc_room_model: 'ui/model/mgc_room_model',
        mgc_seat_model: 'ui/model/mgc_seat_model',
        mgc_show_model: 'ui/model/mgc_show_model',
        //collection
        mgc_comm_coll: 'ui/collection/mgc_comm_coll',
        mgc_festival_activity_coll: 'ui/collection/mgc_festival_activity_coll',
        mgc_index_coll: 'ui/collection/mgc_index_coll',
        mgc_luckydraw_coll: 'ui/collection/mgc_luckydraw_coll',
        mgc_ranklist_coll: 'ui/collection/mgc_ranklist_coll',
        mgc_room_coll: 'ui/collection/mgc_room_coll',
        mgc_show_coll: 'ui/collection/mgc_show_coll',
        //view
        mgc_comm_view: 'ui/view/mgc_comm_view',
        mgc_festival_activity_view: 'ui/view/mgc_festival_activity_view',
        mgc_group_view: 'ui/view/mgc_group_view',
        mgc_index_view: 'ui/view/mgc_index_view',
        mgc_liveroom_view: 'ui/view/mgc_liveroom_view',
        mgc_luckydraw_view: 'ui/view/mgc_luckydraw_view',
        mgc_punchcard_view: 'ui/view/mgc_punchcard_view',
        mgc_ranklist_view: 'ui/view/mgc_ranklist_view',
        mgc_room_view: 'ui/view/mgc_room_view',
        mgc_seat_view: 'ui/view/mgc_seat_view',
        mgc_show_view: 'ui/view/mgc_show_view',
        mgc_room_ad: 'ui/view/mgc_ad',
        mgc_hotbox: 'ui/control/mgc_hotbox',
        //template
        mgc_templates: 'ui/template/mgc_templates'
    }
})