/**
 * @Description:   梦工厂web-控制-个人直播间
 *
 * @author         Xu XiaoJing
 * @version        V1.0
 * @Date           2015/12/02
 * @Company        horizon3d
 */
define(['mgc_callcenter', 'mgc_consts', 'jqtmpl', 'mgc_tool', 'mgc_tips', 'mgc_popmanager', 'mgc_skin'], function(callcenter, consts, jqtmpl, mgc_tool, mgc_tips, mgc_popmanager, mgc_skin) {
    var control = {};

    control.Request = {

    };
    control.Response = {
        /*
         * 解锁皮肤成功信息
         */
        unlockNewSkinCallback: function(resp, param) {
            //@ todo
        },
        /*
         * 通知房间皮肤升级
         */
        informRoomSkinUpCallback: function(resp, param) {
            console.log('"op_type":308  informRoomSkinUpCallback');
            var levelUp_level = resp.info.skin_level;
            var levelUp_id = resp.info.skin_id;
            window.mgc.nest_control.initFlashLevelUp(levelUp_id, levelUp_level);

            //人数增加特效
            AddNumEffect.show(resp.info.room_size);
            //皮肤重置
            mgc_skin.resetskin(levelUp_level);
        }
    };
    control.skinLevelUpTimer = null;
    control.initFlashLevelUp = function(id, level) {
        var swfVersionStr = "11.1.0";
        var xiSwfUrlStr = "playerProductInstall.swf?v=3_8_8_2016_15_4_final_3";
        var flashvars = {};
        var strTheme = '';
        //flashvars.m_level = data.giftData.m_level;
        flashvars.skin_id = id;
        flashvars.skin_level = level;
        var params = {};
        params.quality = "high";
        params.bgcolor = "#000";
        params.allowscriptaccess = "always";
        params.allowfullscreen = "true";
        params.allowFullScreenInteractive = "true";
        params.wmode = "transparent";
        var attributes = {};
        attributes.id = "skinLevelUp";
        attributes.name = "skinLevelUp";
        attributes.align = "middle";

        var swfurl = "assets/skinLevelUp.swf?v=3_7_4_2015_34_3_" + (new Date()).getTime();

        if (navigator.userAgent.toLowerCase().indexOf("qqbrowser") > 0)
            swfurl += "&r=" + new Date();
        swfobject.embedSWF(swfurl, "skinLevelUp", "100%", "100%",
        swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
        window.mgc.popmanager.layerControlShow($m('.skinLevelUp'), 2, 1, null, { saveFocus: true });
        $('.skinLevelUp_bg').show();

        if (id == 1) {
            strTheme = mgc.config.SKIN_CONFIG[1].name;
        } else if (id == 2) {
            strTheme = mgc.config.SKIN_CONFIG[2].name;
        } else {
            strTheme = mgc.config.SKIN_CONFIG[3].name;
        }
        $('#skinDes').html(strTheme + '皮肤已升至' + level + '级，感谢您的参与！');
        $(window).resize(this.onResize);
        clearTimeout(window.mgc.nest_control.skinLevelUpTimer);
        window.mgc.nest_control.skinLevelUpTimer = setTimeout(window.mgc.nest_control.hideFlashLevelUp, 5000);
    }
    //隐藏特效
    control.hideFlashLevelUp = function() {
        window.mgc.popmanager.layerControlHide($('.skinLevelUp'), 2, 1);
        $('.skinLevelUp').remove();
        $('.skinLevelUp_bg').hide();
        $('body').append('<div class="pop skinLevelUp" style="display: none;"></div>');
        $('.skinLevelUp').append("<p id='skinLevelUp'></p>");
        $('.skinLevelUp').append("<p id='skinDes'></p>");        
    }

    //主动下发下消息监听
    callcenter.addRespListener(callcenter.OP_TYPE.UNLOCK_NEW_SKIN, control.Response.unlockNewSkinCallback);
    callcenter.addRespListener(callcenter.OP_TYPE.INFORM_ROOM_SKIN_UP, control.Response.informRoomSkinUpCallback);
    window.mgc.nest_control = control;
    return control;
});

