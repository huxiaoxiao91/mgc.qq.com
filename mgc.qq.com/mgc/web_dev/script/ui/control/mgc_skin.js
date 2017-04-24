/**
 * Created by shixinqi on 2015/9/28.
 * 房间成长【换肤】
 */
define(['jquery', 'mgc_consts', 'mgc_config', 'mgc_tool'], function(jquery, consts, config, tool) {
    var skincontrol = {};

    //检测当前皮肤状态及等级，如果与当前拿到的数据不符，则直接踢回相应房间
    skincontrol.checkSkin = function(skin_id, skin_level) {
        var _url;
        if (SKIN.id == skin_id && SKIN.level == skin_level) { //当url地址中的皮肤类型、等级 与进房后拿到的数据相同时
            if (skin_level > 0 && !tool.is_nest_room()) {
                //皮肤等级大于零 && 非新皮肤小窝   踢回正确页面
                _url = window.location.href.replace(consts.url.CAVEOLAE_ROOM, consts.url.NEST_ROOM);
            } else if (skin_level <= 0 && !tool.is_caveolae_room()) {
                //皮肤等级小于等于零 && 非普通小窝   踢回正确页面
                _url = window.location.href.replace(consts.url.NEST_ROOM, consts.url.CAVEOLAE_ROOM);
            }
        } else {                                              //当url地址中的皮肤类型、等级 与进房后拿到的数据不同时
            if (skin_level > 0) {
                if (tool.is_nest_room() && SKIN.id == skin_id) {
                    //页面 、 皮肤类型 相同，皮肤等级不同的情况下 直接动态处理成正确皮肤
                    SKIN.level = skin_level;
                    skincontrol.resetskin(skin_level);
                } else {
                    _url = window.location.href.replace(consts.url.CAVEOLAE_ROOM, consts.url.NEST_ROOM).replace("skin_id=" + SKIN.id, "skin_id=" + skin_id).replace("skin_level=" + SKIN.level, "skin_level=" + skin_level);
                }
            } else {
                if (tool.is_caveolae_room()) {
                    SKIN.id = skin_id;
                    SKIN.level = skin_level;
                } else {
                    _url = window.location.href.replace(consts.url.NEST_ROOM, consts.url.CAVEOLAE_ROOM).replace("skin_id=" + SKIN.id, "skin_id=" + skin_id).replace("skin_level=" + SKIN.level, "skin_level=" + skin_level);
                }
            }
        }
        if (_url) {
            if (_url.indexOf("&skin_id=") < 0) {
                _url += "&skin_id=" + skin_id;
            }
            if (_url.indexOf("&skin_level=") < 0) {
                _url += "&skin_level=" + skin_level;
            }
            window.location.href = window.mgc.tools.changeUrlToLivearea(_url);
            return false;
        }
        return true;
    };
    //各模块换肤,每个不同的模块换肤代码，自定义一个函数进行封装
    skincontrol.dorest = {
        initSkin: function() {
            if (SKIN.level > 0) {
                //礼物区默认背景
                $("#default_gift_bg img").attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin" + SKIN.id + "/default_gift_bg.png?v=3_8_8_2016_15_4_final_3");
                //守护抢座默认头像
                $(".seatlist li img").attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/headicon/default_head_null_skin" + SKIN.id + ".png?v=3_8_8_2016_15_4_final_3");
            }
        }
    };

    //视频换肤
    skincontrol.videoSkin = {

        //皮肤等级
        level: 1,

        //皮肤类别
        skinType: 1,

        setSkin: function(skinType, level) {
            this.skinType = skinType;
            this.level = level;

            //清除所有挂件
            $(".video_con>img").each(function(index) {
                if (index != 0) {
                    $(this).remove();
                }
            });

            if (skinType == 1) {
                //inmusic
                //$(".video_con").append("<img class='logo' src='http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin1/logo.png'>");
                $(".video_con_bg").attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin" + skinType + "/video_con_1.png?v=3_8_8_2016_15_4_final_3");
                $(".video_play_bg").attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin" + skinType + "/video_play_1.png?v=3_8_8_2016_15_4_final_3");
                switch (level) {
                    case 1:
                        //$(".video_con_bg").attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin" + skinType + "/video_con_1.png?v=3_8_8_2016_15_4_final_3");
                        //$(".video_play_bg").attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin" + skinType + "/video_play_1.png?v=3_8_8_2016_15_4_final_3");
                        break;

                    case 2:
                        //$(".video_con_bg").attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin" + skinType + "/video_con_2.png?v=3_8_8_2016_15_4_final_3");
                        //$(".video_play_bg").attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin" + skinType + "/video_play_1.png?v=3_8_8_2016_15_4_final_3");
                        break;

                    case 3:
                        //$(".video_con_bg").attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin" + skinType + "/video_con_3.png?v=3_8_8_2016_15_4_final_3");
                        //$(".video_play_bg").attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin" + skinType + "/video_play_1.png?v=3_8_8_2016_15_4_final_3");
                        break;

                    default:
                        break;
                }
            }
            else if (skinType == 2) {
                $(".video_con_bg").attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin" + skinType + "/video_con_1.png?v=3_8_8_2016_15_4_final_3");
                $(".video_play_bg").attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin" + skinType + "/video_play_1.png?v=3_8_8_2016_15_4_final_3");
                switch (level) {
                    case 1:
                        //$(".video_con_bg").attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin" + skinType + "/video_con_1.png?v=3_8_8_2016_15_4_final_3");
                        //$(".video_play_bg").attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin" + skinType + "/video_play_1.png?v=3_8_8_2016_15_4_final_3");
                        break;

                    case 2:
                        $(".video_con").append("<img class='item_1' src='http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin2/video_item_1.png'>");
                        $(".video_con").append("<img class='item_2' src='http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin2/video_item_2.png'>");
                        //$(".video_con_bg").attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin" + skinType + "/video_con_2.png?v=3_8_8_2016_15_4_final_3");
                        //$(".video_play_bg").attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin" + skinType + "/video_play_1.png?v=3_8_8_2016_15_4_final_3");
                        break;

                    case 3:
                        $(".video_con").append("<img class='item_1' src='http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin2/video_item_1.png'>");
                        $(".video_con").append("<img class='item_2' src='http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin2/video_item_2.png'>");
                        //$(".video_con_bg").attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin" + skinType + "/video_con_3.png?v=3_8_8_2016_15_4_final_3");
                        //$(".video_play_bg").attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin" + skinType + "/video_play_1.png?v=3_8_8_2016_15_4_final_3");
                        break;

                    default:
                        break;
                }
            }
            else if (skinType == 3) {
                $(".video_con_bg").attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin" + skinType + "/video_con_1.png?v=3_8_8_2016_15_4_final_3");
                $(".video_play_bg").attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin" + skinType + "/video_play_1.png?v=3_8_8_2016_15_4_final_3");
                switch (level) {
                    case 1:
                        //$(".video_con_bg").attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin" + skinType + "/video_con_1.png?v=3_8_8_2016_15_4_final_3");
                        //$(".video_play_bg").attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin" + skinType + "/video_play_1.png?v=3_8_8_2016_15_4_final_3");
                        break;

                    case 2:
                        //$(".video_con_bg").attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin" + skinType + "/video_con_2.png?v=3_8_8_2016_15_4_final_3");
                        //$(".video_play_bg").attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin" + skinType + "/video_play_1.png?v=3_8_8_2016_15_4_final_3");
                        break;

                    case 3:
                        //$(".video_con_bg").attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin" + skinType + "/video_con_3.png?v=3_8_8_2016_15_4_final_3");
                        //$(".video_play_bg").attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin" + skinType + "/video_play_1.png?v=3_8_8_2016_15_4_final_3");
                        break;

                    default:
                        break;
                }
            }

        }

    };

    //背景换肤
    skincontrol.bgSkin = {
        setSkin: function(skinType, level) {
            var _url = "http://ossweb-img.qq.com/images/mgc/css_img/video_room/skin" + skinType + "/bg_" + level + ".png?v=3_8_8_2016_15_4_final_3";
            //$("body").css("background", "url(" + _url + ")");
            $("#load-bg-body").css("backgroundImage", "url(" + _url + ")");
        }
    };

    /*
     * @重置皮肤
     * @param _skin_level:int 当前皮肤等级
     */
    skincontrol.resetskin = function(_skin_level) {
        SKIN.level = _skin_level;
        //to do 切换等级
        switch (SKIN.id) {
            case 1:
                if (SKIN.level == 0) {
                    $('.layer-anchor-new #anchorImg').attr('class', '');
                    $('.auto_seatVip').css('display', 'none');
                    $('.layer-vipSeat').css('display', 'block');
                    $("#layer-plat").attr("class", "plat0");
                } else if (SKIN.level > 0 && SKIN.level <= 3) {
                    $('.layer-anchor-new #anchorImg').attr('class', '');
                    $('.layer-vipSeat').css('display', 'none');
                    if ($('.auto_seatVip').width() > 700) {
                        $('.auto_seatVip').css({ 'display': 'block', 'width': mgc.config.SKIN_CONFIG[SKIN.id][SKIN.level].ui_grab.width });
                    } else {
                        $('.auto_seatVip').css({ 'display': 'block' });
                    }
                    $('.auto_seatVip').attr('class', 'auto_seatVip auto_seatVip_one');
                    skincontrol.videoSkin.setSkin(SKIN.id, 1);
                    skincontrol.bgSkin.setSkin(SKIN.id, 1);
                    $("#layer-plat").attr("class", "plat1");
                } else if (SKIN.level > 3 && SKIN.level <= 6) {
                    skincontrol.videoSkin.setSkin(SKIN.id, 2);
                    skincontrol.bgSkin.setSkin(SKIN.id, 2);
                    $('.layer-anchor-new #anchorImg').attr('class', '');
                    $('.layer-vipSeat').css('display', 'none');
                    if ($('.auto_seatVip').width() > 700) {
                        $('.auto_seatVip').css({ 'display': 'block', 'width': mgc.config.SKIN_CONFIG[SKIN.id][SKIN.level].ui_grab.width });
                    } else {
                        $('.auto_seatVip').css({ 'display': 'block' });
                    }
                    $('.auto_seatVip').attr('class', 'auto_seatVip auto_seatVip_two');
                    $("#layer-plat").attr("class", "plat2");
                } else if (SKIN.level > 6 && SKIN.level <= 9) {
                    skincontrol.videoSkin.setSkin(SKIN.id, 3);
                    skincontrol.bgSkin.setSkin(SKIN.id, 3);
                    $('.layer-anchor-new #anchorImg').attr('class', 'skin');
                    $('.layer-vipSeat').css('display', 'none');
                    if ($('.auto_seatVip').width() > 700) {
                        $('.auto_seatVip').css({ 'display': 'block', 'width': mgc.config.SKIN_CONFIG[SKIN.id][SKIN.level].ui_grab.width });
                    } else {
                        $('.auto_seatVip').css({ 'display': 'block' });
                    }
                    $('.auto_seatVip').attr('class', 'auto_seatVip auto_seatVip_three');
                    $('.level_img_star').css('display', 'block');
                    $('.level_img_play').css('display', 'block');
                    $("#layer-plat").attr("class", "plat3");
                }
                break;
            case 2:
                if (SKIN.level == 0) {
                    skincontrol.videoSkin.setSkin(SKIN.id, 1);
                    skincontrol.bgSkin.setSkin(SKIN.id, 1);
                    $('.layer-anchor-new #anchorImg').attr('class', '');
                    $('.auto_seatVip').css('display', 'none');
                    $('.layer-vipSeat').css('display', 'block');
                    $("#layer-plat").attr("class", "plat0");
                } else if (SKIN.level > 0 && SKIN.level <= 3) {
                    skincontrol.videoSkin.setSkin(SKIN.id, 1);
                    skincontrol.bgSkin.setSkin(SKIN.id, 1);
                    $('.layer-anchor-new #anchorImg').attr('class', '');
                    $('.layer-vipSeat').css('display', 'none');
                    if ($('.auto_seatVip').width() > 700) {
                        $('.auto_seatVip').css({ 'display': 'block', 'width': mgc.config.SKIN_CONFIG[SKIN.id][SKIN.level].ui_grab.width });
                    } else {
                        $('.auto_seatVip').css({ 'display': 'block' });
                    }
                    $('.auto_seatVip').attr('class', 'auto_seatVip auto_seatVip_one');
                } else if (SKIN.level > 3 && SKIN.level <= 6) {
                    skincontrol.videoSkin.setSkin(SKIN.id, 2);
                    skincontrol.bgSkin.setSkin(SKIN.id, 2);
                    $('.layer-anchor-new #anchorImg').attr('class', 'skin');
                    $('.layer-vipSeat').css('display', 'none');
                    if ($('.auto_seatVip').width() > 700) {
                        $('.auto_seatVip').css({ 'display': 'block', 'width': mgc.config.SKIN_CONFIG[SKIN.id][SKIN.level].ui_grab.width });
                    } else {
                        $('.auto_seatVip').css({ 'display': 'block' });
                    }
                    $('#seaWorld_anchor .part1,#seaWorld_anchor .part2,#seaWorld_anchor .part4,#guardIcon').css('display', 'block');
                    $('.auto_seatVip').attr('class', 'auto_seatVip auto_seatVip_two');
                    $('.level_img_pao1').css('display', 'block');
                    $('.level_img_pao2').css('display', 'block');
                } else if (SKIN.level > 6 && SKIN.level <= 9) {
                    skincontrol.videoSkin.setSkin(SKIN.id, 3);
                    skincontrol.bgSkin.setSkin(SKIN.id, 3);
                    $('.layer-anchor-new #anchorImg').attr('class', 'skin');
                    $('.layer-vipSeat').css('display', 'none');
                    if ($('.auto_seatVip').width() > 700) {
                        $('.auto_seatVip').css({ 'display': 'block', 'width': mgc.config.SKIN_CONFIG[SKIN.id][SKIN.level].ui_grab.width });
                    } else {
                        $('.auto_seatVip').css({ 'display': 'block' });
                    }
                    $('#seaWorld_anchor .part1,#seaWorld_anchor .part2,#seaWorld_anchor .part3,#seaWorld_anchor .part4,#guardIcon').css('display', 'block');
                    $('.auto_seatVip').attr('class', 'auto_seatVip auto_seatVip_three');
                    $('.level_img_pao1').css('display', 'block');
                    $('.level_img_pao2').css('display', 'block');
                    $('.level_img_zhe1').css('display', 'block');
                    $('.level_img_zhe2').css('display', 'block');
                }
                break;
            case 3:
                if (SKIN.level == 0) {
                    skincontrol.videoSkin.setSkin(SKIN.id, 1);
                    skincontrol.bgSkin.setSkin(SKIN.id, 1);
                    $('.layer-anchor-new #anchorImg').attr('class', '');
                    $('.auto_seatVip').css('display', 'none');
                    $('.layer-vipSeat').css('display', 'block');
                } else if (SKIN.level > 0 && SKIN.level <= 3) {
                    skincontrol.videoSkin.setSkin(SKIN.id, 1);
                    skincontrol.bgSkin.setSkin(SKIN.id, 1);
                    $('.layer-anchor-new #anchorImg').attr('class', '');
                    $('.layer-vipSeat').css('display', 'none');
                    if ($('.auto_seatVip').width() > 700) {
                        $('.auto_seatVip').css({ 'display': 'block', 'width': mgc.config.SKIN_CONFIG[SKIN.id][SKIN.level].ui_grab.width });
                    } else {
                        $('.auto_seatVip').css({ 'display': 'block' });
                    }
                    $('.auto_seatVip').attr('class', 'auto_seatVip auto_seatVip_one');
                } else if (SKIN.level > 3 && SKIN.level <= 6) {
                    skincontrol.videoSkin.setSkin(SKIN.id, 2);
                    skincontrol.bgSkin.setSkin(SKIN.id, 2);
                    $('.layer-anchor-new #anchorImg').attr('class', '');
                    $('.layer-vipSeat').css('display', 'none');
                    if ($('.auto_seatVip').width() > 700) {
                        $('.auto_seatVip').css({ 'display': 'block', 'width': mgc.config.SKIN_CONFIG[SKIN.id][SKIN.level].ui_grab.width });
                    } else {
                        $('.auto_seatVip').css({ 'display': 'block' });
                    }
                    $('.layer-anchor-new .seaWorld_anchor .part1').css('display', 'block');
                    $('.auto_seatVip').attr('class', 'auto_seatVip auto_seatVip_two');
                } else if (SKIN.level > 6 && SKIN.level <= 9) {
                    skincontrol.videoSkin.setSkin(SKIN.id, 3);
                    skincontrol.bgSkin.setSkin(SKIN.id, 3);
                    $('.layer-anchor-new #anchorImg').attr('class', '');
                    $('.layer-vipSeat').css('display', 'none');
                    if ($('.auto_seatVip').width() > 700) {
                        $('.auto_seatVip').css({ 'display': 'block', 'width': mgc.config.SKIN_CONFIG[SKIN.id][SKIN.level].ui_grab.width });
                    } else {
                        $('.auto_seatVip').css({ 'display': 'block' });
                    }
                    $('.layer-anchor-new .seaWorld_anchor .part2,.layer-anchor-new .seaWorld_anchor .part3').css('display', 'block');
                    $('.auto_seatVip').attr('class', 'auto_seatVip auto_seatVip_three');
                    $('.level_img_star').css('display', 'block');
                    $('.level_img_play').css('display', 'block');
                }
                break;
            default:

        }
    };

    if (!window.mgc) {
        window.mgc = {};
    }
    window.mgc.skincontrol = skincontrol;
    return skincontrol;
});