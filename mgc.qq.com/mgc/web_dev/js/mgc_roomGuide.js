/*
 * VERSION: 1.0 LAST UPDATE: 16.01.07
 */
var $r = jQuery.noConflict();
var _interval;
//首登response
var MGC_roomGuideResp = {
    gift_flag : null,
    arrRoomOn: [],
    arrRoom: [],
    cookieRoomValue: '2048',
    //*检查是否房间内首登-回调
    checkIsRoomGuideCallBack: function (obj)
    
    {
                
        if (typeof (obj) == 'undefined')
        {
            if (filename.indexOf("nest.shtml") == 0 && ($m.cookie("mgc_roomGuide_" + obj + "_") != MGC_roomGuideResp.cookieRoomValue)) {
                MGC_roomGuideResp.showPunchCard();
            } else {
                MGC_roomGuideResp.hidePunchCard();
            }
                      
            if (($m.cookie("mgc_roomGuide_" + obj + "_") == MGC_roomGuideResp.cookieRoomValue)) {
                $r('#register_guide').show();
                MGC_roomGuideResp.firstloginCheck();
                return;
            }
                
            if (filename.indexOf("liveroom.shtml") == 0 || filename.indexOf("caveolaeroom.shtml") == 0 || filename.indexOf("nest.shtml") == 0) {
                
                console.log("房间内引导（个人直播间、公会房间）：" + JSON.stringify(obj));
                $r('#register_guide').show();
                $r('.commTips').show();
                if(!$m.cookie("commTips_gift_cookie")){
                    $m.cookie("commTips_gift_cookie", true, {
                        expires: 24 * 60 * 60 * 1000,
                        path: '/',
                        domain: '.qq.com'
                    });
                    if (($m.cookie("commTips_gift_cookie_room") || $m.cookie("commTips_gift_cookie_room")=="true") && ($m.cookie("mgc_roomGuide_undefined_") != MGC_roomGuideResp.cookieRoomValue)) {
                        $m('.commTips_gift').show();
                    }
                }
                MGC_roomGuideResp.firstloginCheck();              
                
                $r(document).click(function (e) {
                    e = e || window.event; 
                    var obj = $r(e.srcElement || e.target);
                    if ($r(obj).is(".commTips") || $r(obj).is(".commTips_punchCard") || $r(obj).is(".commTips_gift")) {
                    } else {
                        if ($r(obj).is(".register_guide")) {
                            
                        } else {
                            $r(".commTips").hide();
                            $r(".commTips_punchCard").hide();
                            $r(".commTips_gift").hide();
                        }
                    }
                });

               

                //只弹出一次  记录cookie
                $m.cookie("mgc_roomGuide_" + obj + "_", MGC_roomGuideResp.cookieRoomValue, {
                    expires: 24 * 60 * 60 * 1000,
                    path: '/',
                    domain: '.qq.com'
                });
            
            }
        }
            
    },    
    firstloginCheck: function () {       
        
            if (MGC_Comm.CheckGuestStatus(true)) {
                MGC_roomGuideResp.registerFirstRoom()
                _interval=setInterval('$r("#register_guide").show()', 300000);
            } else {
                clearInterval(_interval);
                $r('#register_guide,.commTips,.commTips_gift').hide();
                MGC_roomGuideResp.cookieNullGuide();
            }
        
    },
    registerFirstRoom: function() {        ;
        $r('#register_guide .close').off('click').on('click', function() {
            $r('.commTips,.register_guide_bg,.commTips_gift').hide();
            MGC_roomGuideResp.cookieNullGuide();
        });
        $r('#register_guide_btn').off('click').on('click', function () {
            $r('.commTips,.register_guide_bg,.commTips_gift').hide();
            MGC_roomGuideResp.cookieNullGuide();
            MGC_Comm.CheckGuestStatus();
        });
    },
    cookieNullGuide: function () {
        $m.cookie("commTips_gift_cookie", null, {
            expires: 24 * 60 * 60 * 1000,
            path: '/',
            domain: '.qq.com'
        });
        $m.cookie("commTips_gift_cookie_room", null, {
            expires: 24 * 60 * 60 * 1000,
            path: '/',
            domain: '.qq.com'
        });
    },
    roomGiftAuto: function (flag) {        
        MGC_roomGuideResp.gift_flag = flag;
            //差22像素（周星礼物） 68像素（前面和后面的宽度）
            var MiddW = $r('.layer-gifts').width();
            if (flag) {
                if (typeof (SKIN) != 'undefined') {
                    if (SKIN.level < 1) {
                        $r('#gift_guide').width(MiddW - 25);
                        $r('#gift_guide').css('right', '0');
                        $r('#gift_guide_center').width(MiddW - 68);
                        $r('.gift_guide').css('bottom', '38px');
                        //判断关注的位置
                        $r('#attention_guide').css('top', '153px');
                    } else {
                        //判断关注的位置
                        $r('#attention_guide').css('top', '159px');
                        if (SKIN.id == 1) {
                            $r('#gift_guide').width(MiddW - 37 - 12);
                            $r('#gift_guide').css('right', '12px');
                            $r('#gift_guide_center').width(MiddW - 68 - 24);
                            $r('.gift_guide').css('bottom', '46px');
                        } else if (SKIN.id == 2) {
                            $r('#gift_guide').width(MiddW - 30);
                            $r('#gift_guide').css('right', '2px');
                            $r('#gift_guide_center').width(MiddW - 73);
                            $r('.gift_guide').css('bottom', '41px');
                        } else if (SKIN.id == 3) {
                            $r('#gift_guide').width(MiddW - 28);
                            $r('#gift_guide').css('right', '1px');
                            $r('#gift_guide_center').width(MiddW - 71);
                            $r('.gift_guide').css('bottom', '46px');
                        }
                    }
                } else {
                    $r('#gift_guide').width(MiddW - 25);
                    $r('#gift_guide').css('right', '0');
                    $r('#gift_guide_center').width(MiddW - 68);
                    $r('.gift_guide').css('bottom', '38px');                    
                }
                //没有周星礼物按钮的时候
            } else {
                if (typeof (SKIN) != 'undefined') {
                    //没有换肤的个人直播间
                    if (SKIN.level < 1) {  
                        $r('#gift_guide').width(MiddW - 3);
                        $r('#gift_guide').css('right', '0');
                        $r('#gift_guide_center').width(MiddW + 22 - 68);
                        $r('.gift_guide').css('bottom', '38px');
                        //判断关注的位置
                        $r('#attention_guide').css('top', '153px');
                    } else {
                        //判断关注的位置
                        $r('#attention_guide').css('top', '159px');
                        //换肤的个人直播间----SKIN.id==1 
                        if (SKIN.id == 1) {
                            $r('#gift_guide').width(MiddW - 15 - 12);
                            $r('#gift_guide').css('right', '12px');
                            $r('#gift_guide_center').width(MiddW + 22 - 68 - 24);
                            $r('.gift_guide').css('bottom', '46px');
                        } else if (SKIN.id == 2) {
                            $r('#gift_guide').width(MiddW - 4);
                            $r('#gift_guide').css('right', '2px');
                            $r('#gift_guide_center').width(MiddW + 22 - 69);
                            $r('.gift_guide').css('bottom', '41px');
                        } else if (SKIN.id == 3) {
                            $r('#gift_guide').width(MiddW - 2);
                            $r('#gift_guide').css('right', '1px');
                            $r('#gift_guide_center').width(MiddW + 22 - 67);
                            $r('.gift_guide').css('bottom', '46px');
                        }
                        
                    }
                } else {
                    $r('#gift_guide').width(MiddW - 3);
                    $r('#gift_guide').css('right', '0');
                    $r('#gift_guide_center').width(MiddW + 22 - 68);
                    $r('.gift_guide').css('bottom', '38px');                    
                }
            }        
    },
    showPunchCard:function(){
        $r('.layer-mission').css('position', 'relative');
        if (MGC_Comm.CheckGuestStatus(true)) {
            $r('.commTips_punchCard').attr('class', 'commTips_punchCard guide_punchCard');
            $r('.guide_punchCard').css('display', 'block');
        } else {
            $r('.commTips_punchCard').attr('class', 'commTips_punchCard guide_punchCard_login');
            $r('.guide_punchCard_login').css('display', 'block');
        }        
    },
    hidePunchCard: function () {
        $r('.layer-mission').css('position', 'relative');
        if (MGC_Comm.CheckGuestStatus(true)) {
            $r('.commTips_punchCard').attr('class', 'commTips_punchCard guide_punchCard');
            $r('.guide_punchCard').css('display', 'none');
        } else {
            $r('.commTips_punchCard').attr('class', 'commTips_punchCard guide_punchCard_login');
            $r('.guide_punchCard_login').css('display', 'none');
        }
    },
    resize: function () {
        MGC_roomGuideResp.roomGiftAuto(MGC_roomGuideResp.gift_flag);
    }   

};

$r.extend(MGC_CommResponse, MGC_roomGuideResp);
