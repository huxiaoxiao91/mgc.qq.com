/**
 * Created by user on 2015/10/8.
 */
/**
 * Todo:1.完善登录时各错误码处理
 *       2.flash缓存的缓存时机由页面决定。（因为只有页面才知道完整的登录状态，而flash是不知道的。需要配合逻辑flash更改）
 */
requirejs.config({
    shim: {
        login_manager: {
            deps: [],
            exports: 'LoginManager'
        },
        eas: {
            exports: 'eas'
        },
        tgadshow: {
            exports: 'tgadshow'
        },
        mgc_ad: {
            deps: [],
            exports: 'mgc_ad'
        }
    },
    paths: {
        login_manager: 'http://ossweb-img.qq.com/images/js/login/loginmanagerv3',
        eas: 'http://ossweb-img.qq.com/images/js/eas/eas',
        tgadshow: 'http://ossweb-img.qq.com/images/js/comm/tgadshow.min',
        mgc_ad: 'http://mgc.qq.com/upload/x5/x5mgc/ad'
    }
});
define(['mgc_callcenter', 'mgc_comm_view', 'mgc_tool', 'mgc_consts', 'mgc_comm', 'mgc_dialog', 'mgc_popmanager'], function(callcenter, comm_view, tool, consts, mgc_comm, mgc_dialog, mgc_popmanager) {
    var ui_login_callback = null;//回调监听
    var ui_login_get_homepage = false;//是否拉取homepage
    var is_need_check_first_login = false;//标识是否检测首登
    /**
     * 带QQ登录态登录视频
     */
    var loginWithQQ = function() {
        callcenter.query_has_cookie(qqaccount.has_cookie_callback);
    };

    //检测用户名是否重复
    callcenter.addRespListener(291, function(resp, params) {
        switch (resp.status) {
            case 0:
                //ChangeName.show(true);
                is_need_check_first_login = true;
                break;

            case 1:
                ChangeName.show(true);
                break;

            case 2:
                logout();
                var myTime = new Date();
                var filename = window.location.href;
                tool.cookie("mgc_logError_login__callcenter_addRespListener__logout__checkNameIsRepetition", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "___reason___logout__checkNameIsRepetition___web--callcenter_addRespListener__logout___filename" + filename, {
                    path: '/',
                    domain: '.qq.com'
                });
                break;

            case 3:
                //ChangeName.show(true);
                break;
        }

    });

    //检测异常信息
    callcenter.addRespListener(318, function(resp, params) {
        switch (resp.res) {
            case -12:
                var NoteObj = {
                    "Note": "服务器异常，请重新加载"
                };
                tool.commonDialog(NoteObj, function() {
                    location.reload();
                });
                break;

            case 1:
                var NoteObj = {
                    "Note": "请刷新界面后重试"
                };
                tool.commonDialog(NoteObj, function() {
                    location.reload();
                });
                break;
            case -14:
                var NoteObj = {
                    "Note": "很抱歉房间火热，登陆后可以更快进入房间哟~"
                };
                tool.commonDialog(NoteObj, function() {
                    window.mgc.account.checkLoginStatus();
                });

                LoginManager.closeLogin(function(){
                    window.location.href = window.mgc.tools.changeUrlToLivearea(consts.url.HOME);
                    return true;
                });
                break;
        }

    });

    var ChangeName = {

        nick_pool: -1,

        nick_record_id: -1,
        firstCheckLogin: true,

        show: function(b) {
            if (b) {
                //确定按钮
                $("#pop_changeName .pop_enter").click(this, this.onEnter);
                //色子注册
                $("#pop_changeName .color_words").click(this, this.onRandom);
                //检查重名
                $("#pop_changeName .checkDup").click(this, this.onCheckDup);
                //关闭按钮
                $("#pop_changeName .pop_close").click(this, this.onClose);

                // 动态绑定动作
                $('#pop_changeName .pop_sr').focus(function() {
                    var v = $.trim($(this).val());
                    $(this).css({
                        "color": "#1c1c1c"
                    });
                    if (v == '输入QQ昵称') {
                        $(this).val("");
                    }
                    if (tool.Strlen(v) > 12) {
                        $("#pop_changeName .pop_nick_info").html('昵称长度限制12个字符').css('color', 'red');
                        $(this).val(tool.Strcut(v, 12));
                    } else {
                        $("#pop_changeName .pop_nick_info").html('点击可修改昵称，最多12位字符').css({
                            "color": "#545454"
                        });
                    }
                }).blur(function() {
                    var v = $.trim($(this).val());
                    if (v == '') {
                        $(this).val('输入QQ昵称').css({
                            "color": "#bcbcbc"
                        });
                    }
                }).keyup(function() {
                    var v = $.trim($(this).val());
                    if (tool.Strlen(v) > 12) {
                        $(this).val(tool.Strcut(v, 12));
                    }
                }).keydown(function() {
                    var v = $(this).val();
                    if (tool.Strlen(v) >= 12) {
                        event.returnValue = false;
                    }
                    if (event.keyCode == 8) {
                        event.returnValue = true;;
                    }
                });

                window.mgc.popmanager.layerControlShow($("#pop_changeName"), 4, 1);
            }
            else {

                //确定按钮
                $("#pop_changeName .pop_enter").off();
                //色子注册
                $("#pop_changeName .color_words").off();
                //检查重名
                $("#pop_changeName .checkDup").off();
                //关闭按钮
                $("#pop_changeName .pop_close").off();

                $('#pop_changeName .pop_sr').off();

                window.mgc.popmanager.layerControlHide($("#pop_changeName"), 4, 1);
            }
        },


        onEnter: function(e) {
            _this = e.data;

            var _userNick = $.trim($("#pop_changeName .pop_sr").val());
            var msg = '';
            if (_userNick.length == 0 || _userNick == '输入QQ昵称') {
                msg = '请输入昵称！';
            }
            else if (_userNick.length > 12) {
                msg = '昵称长度限制12个字符';
            }
            else if (_userNick.replace(/&nbsp;/g, "").length == 0 || _userNick.replace(/&nbsp/g, "").length == 0 || $.trim(_userNick).length == 0) {
                msg = '该昵称不可使用，请您重新输入';
            }
            if (msg != '') {
                $("#pop_changeName .pop_nick_info").html(msg).css('color', 'red');
                return false;
            }
            tool.EAS([{ 'e_c': 'mgc.regist', 'c_t': 4 }]);
            /*
            var params = {};
            params.caller = _this;
            params.nick = _userNick;
            params.gender = this.getGender();
            params.nick_pool = _this.nick_pool;
            params.nick_record_id = _this.nick_record_id;
            if (this.register_callback) {
            this.register_callback(params);
            }
            */

            var reqParams = {
                "nick": _userNick,
                "source_type": 7,
                "rand_nick_pool": _this.nick_pool,
                "nick_record_id": _this.nick_record_id
            };
            callcenter.callbackStr_req("EDIT_USERNICK", _this.onEnterCallBack, "_this.onEnterCallBack", reqParams);
        },

        onRandom: function(e) {
            _this = e.data;

            //随机获取昵称
            //var _userGender = parseInt(this.$("#userGender").val());
            var params = {};
            params.caller = _this;
            callcenter.query_rand_nick(_this.nick_pool, 1, _this.get_rand_nick_callback, params);
        },

        onCheckDup: function(e) {
            _this = e.data;

            var v = $.trim($("#pop_changeName .pop_sr").val());
            var reg = new RegExp(/[　]{1,12}/);
            if (v == '' || v == '输入QQ昵称' || v == undefined || reg.test(v)) {
                $("#pop_changeName .pop_nick_info").html('请输入昵称！').css('color', 'red');
            } else {
                var params = {};
                params.caller = _this;
                callcenter.check_dupnick(v, _this.check_dupnick_callback, params);
            }
        },

        onClose: function(e) {
            _this = e.data;
            //_this.show(false);

            tool.commonDialog({
                "Title": "提示信息",
                "Note": "如果不修改昵称将无法继续登录梦工厂，改名的提示会在您下次进入梦工厂时继续弹出",
                "BtnName": "确定",
                "BtnName2": "取消",
                "BtnNum": 2
            }, function() {
                logout();
                var myTime = new Date();
                var filename = window.location.href;
                tool.cookie("mgc_logError_login__ChangeName___onClose__logout", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "___reason___ChangeName___onClose__logout__web--ChangeName___onClose___filename" + filename, {
                    path: '/',
                    domain: '.qq.com'
                });
            });
        },

        onEnterCallBack: function(responseStr) {
            var obj = typeof responseStr == 'object' ? responseStr : mgc_tool.strToJson(responseStr);
            if (obj.res == 0) {
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '修改成功';
                mgc_dialog.simpleDialog(5, dialog, function() {
                    //$('#i_nick_name').html($.trim($('#i_edit_nick').val()));
                    mgc_popmanager.layerControlHide($("#pop_changeName"), 4, 1);
                    if (is_need_check_first_login) {
                        if ((tool.cookie("mgc_login_succeed_uin") != null) && (tool.cookie("mgc_login_first_login_uin") == null)) {
                            callcenter.check_is_first_login(window.mgc.common_contral.LoginGiftsResp.checkIsFirstLoginCallBack, false);//检查是否首登
                            tool.cookie("mgc_login_first_login_uin", new Date().format("yyyy-MM-dd"), {
                                path: '/',
                                domain: '.qq.com'
                            });
                        }//检查是否首登
                    } else {
                        is_need_check_first_login = true;
                    }
                    
                });
            }
            else if (obj.res == 2) {
                $("#pop_changeName .pop_nick_info").html('该昵称不可使用，请您重新输入！').css('color', 'red');
            }
            else if (obj.res == 3) {
                $("#pop_changeName .pop_nick_info").html('该昵称已被使用，请您重新输入！').css('color', 'red');
            }
        },

        get_rand_nick_callback: function(resp, params) {
            this.randomUserName = resp.nick;
            this.nick_pool = resp.nick_pool;
            this.nick_record_id = resp.nick_record_id;

            if (this.randomUserName && this.randomUserName.length > 0) {
                $("#pop_changeName .pop_sr").css("color", "#000000").val(this.randomUserName);
                $("#pop_changeName .pop_nick_info").children().remove();
            }
            else {
                $("#pop_changeName .pop_nick_info").html('获取昵称失败！').css('color', 'red');
            }

        },

        check_dupnick_callback: function(resp, params) {
            var msg = '';
            var color = 'red';
            switch (parseInt(resp.res)) {
                case 0:
                    msg = '该昵称可用！';
                    color = 'green';
                    break;
                case 1:
                    msg = '请输入昵称！';
                    break;
                case 2:
                    msg = '该昵称不可使用，请您重新输入！';
                    break;
                case 3:
                    msg = '该昵称已被使用，请您重新输入！';
                    break;
                default:
                    msg = '该昵称不可使用，请您重新输入！';
                    break;
            }
            $("#pop_changeName .pop_nick_info").html(msg).css('color', color);
        }
    }

    var common = {};
    common.isAutoRegister = false;//是否自动注册标示
    /**
     * 登录视频服务器,登录流程完成，成功登录某大区、登录失败、或者用户取消登录时回调
     * @param callback
     * @param use_guest 没有登录态时是否使用游客登陆
     */
    common.doLoginVideo = function(callback, use_guest) {
        ui_login_callback = callback;
        mgc.account.checkLogin(function() {
            loginWithQQ();
        }, function() {
            if (use_guest) {
                loginWithGuest();
            } else {
                loginWithoutQQ();
            }
        }, true);
    };
    //用账号成功连接的zoneid。
    var account_connected_zoneid = 0;
    /**
     * 成功获取个人信息后才算登录成功，
     * @param resp
     * @param params
     */
    var getPlayerInfoCallback = function(resp, params) {
        if (resp.res) {
            trigger_login_callback(mgc.consts.ui.RES_ERROR, resp, params);
        }
        else {
            //存cookie
            if (account_connected_zoneid != 0) {
                console.log("account_connected_zoneid:" + account_connected_zoneid);
                callcenter.query_set_cookie(mgc.account.getUin(), account_connected_zoneid);
                //初始化当前玩家信息
                mgc.consts.MGCData.myPlayerId = resp.playerinfo.pstid;
                mgc.consts.MGCData.myVipLevel = resp.playerinfo.vip_level;
                mgc.consts.MGCData.invisible = resp.playerinfo.invisible;
                //【新贵族】初始化当前玩家贵族信息
                if (resp.playerinfo.vip_level > 0) {
                    mgc.common_contral.CommOpenVip.attached_anchor_id = resp.playerinfo.vip_anchor_id;
                    mgc.common_contral.CommOpenVip.attached_anchor_name = resp.playerinfo.vip_anchor_name;
                }
                resp.playerinfo.player_url = mgc.consts.MGCData.player_url;
                //初始化顶条组件
                mgc.comm_model.getLoginBarModel.toggle(true);
                mgc.comm_coll.getPlayerInfoColl.reset_playerinfo(resp.playerinfo);
            }
            trigger_login_callback(mgc.consts.ui.RES_NORMAL, resp, params);
            //只拉取一次homepage
            if (!ui_login_get_homepage) {
                //通过147回调、检测首登签到状态
                getPlayerInfoForSignCallback(resp, params);
                //礼物区147验证 老代码
                MGC_SWFINIT.playerInfo = resp;
                mgc.gift_response(resp);
                mgc.eventgift_response(resp);
            }
            ui_login_get_homepage = true;
        }
    };
    var getWeekStarUrlCallback = function(resp){
        consts.MGCData.player_url = resp.player_url;
    }
    common.getPlayerInfo = function() {
        callcenter.query_weekstar_url_config(getWeekStarUrlCallback);
        callcenter.query_player_info(0, getPlayerInfoCallback);
    }
    /*
    *通过147回调、检测首登签到状态 回调
    * @param resp
    * @param params
    */
    var getPlayerInfoForSignCallback = function(resp, params) {
        if (tool.cookie('IsIndexNewPlay') == (new Date().format("yyyy-MM-dd"))) {
            if (tool.is_home_page()) {
                var myTimeNew = new Date();
                var myHourNew = myTimeNew.getHours();
                var myMinuteNew = myTimeNew.getMinutes();
                var mySectionNew = myTimeNew.getSeconds();
                var poor = '';
                var poorHour = '';
                var poorMinute = '';
                var poorSection = '';
                var setTimeNew = null;
                var clearSetTimeNew = null;

                var strMyTime = tool.cookie('strMyTimeArr')
                var strMyTimeArr = [];
                if (tool.cookie('strMyTimeArr') != null) {
                    strMyTimeArr = strMyTime.split(',');
                    if (parseInt(strMyTimeArr[1]) <= myMinuteNew) {
                        checkIndeGuide();
                    } else {

                        if (parseInt(strMyTimeArr[0]) < myHourNew) {
                            checkIndeGuide();
                        } else {
                            poorHour = parseInt(strMyTimeArr[0]) - myHourNew;
                            poorMinute = parseInt(strMyTimeArr[1]) - myMinuteNew;
                            poorSection = parseInt(strMyTimeArr[2]) - mySectionNew;
                            clearTimeout(clearSetTimeNew);
                            if (poorMinute > 0 && poorHour == 0) {
                                setTimeNew = (poorMinute * 60 + poorSection) * 1000;
                                clearSetTimeNew = setTimeout(checkIndeGuide, setTimeNew);
                            } else if (poorMinute > 0 && poorHour > 0) {
                                setTimeNew = (poorHour * 60 * 60 + poorMinute * 60 + poorSection) * 1000;
                                clearSetTimeNew = setTimeout(checkIndeGuide, setTimeNew);
                            }

                        }
                    }
                }
            }
        }
        console.log("getPlayerInfoForSignCallback：检测签到");
        if (resp.res == 0) {
            if (is_need_check_first_login) {
                if ((tool.cookie("mgc_login_succeed_uin") != null) && (tool.cookie("mgc_login_first_login_uin") == null)) {
                    callcenter.check_is_first_login(window.mgc.common_contral.LoginGiftsResp.checkIsFirstLoginCallBack, false);//检查是否首登
                    tool.cookie("mgc_login_first_login_uin", new Date().format("yyyy-MM-dd"), {
                        path: '/',
                        domain: '.qq.com'
                    });
                }//检查是否首登
            } else {
                is_need_check_first_login = true;
            }
            //如果是首页 首登、签到自动弹出
            if (tool.is_home_page() || tool.is_in_room_page() || tool.is_ranklist_page() || tool.is_show_page() || tool.need_login_page() || tool.is_playback_page()) {
                console.log("getPlayerInfoForSignCallback:1");
                if (tool.cookie("mgc_login_succeed_uin") != null) {
                    console.log("getPlayerInfoForSignCallback:2");
                    callcenter.check_goodFriendPay(mgc_comm.GoodFriendPay.goodFriendPayCallBack);//登录成功-请求好友充值消息                   
                }

                //今日是否已经自动弹出首登界面
                if (tool.cookie("mgc_logingifts_" + mgc.account.getUin() + "_" + tool.cookie("mgc_zoneid")) != new Date().format("yyyy-MM-dd")) {
                    console.log("getPlayerInfoForSignCallback:3");
                    if (tool.cookie("mgc_login_succeed_uin") != null) {
                        callcenter.check_sign(mgc_comm.SignResp.checkSignCallBack, { isAuto: false, isStop: true });
                    }
                    //null
                }
                    //如果首登未通过的情况下，执行签到
                else {
                    console.log("getPlayerInfoForSignCallback:4");
                    //进行首登引导时
                    if ((tool.cookie("LoginGiftsResp_IsToken")) == 'false') {
                        //不弹签到
                        callcenter.check_sign(mgc_comm.SignResp.checkSignCallBack, { isAuto: false, isStop: true });
                    } else {

                        //今日是否已经自动弹出签到界面
                        if (tool.cookie("mgc_sign_" + mgc.account.getUin() + "_" + tool.cookie("mgc_zoneid")) != new Date().format("yyyy-MM-dd")) {

                            //非首登状态下 - 立即判断签到状态 isAuto:是否自动弹出 ; isStop:是否阻止弹出
                            callcenter.check_sign(mgc_comm.SignResp.checkSignCallBack, { isAuto: true, isStop: false });
                        } else {
                            callcenter.check_sign(mgc_comm.SignResp.checkSignCallBack, { isAuto: false, isStop: true });
                        }
                    }
                }



            } else {
                console.log("getPlayerInfoForSignCallback:5");
               // callcenter.check_is_first_login(mgc_comm.LoginGiftsResp.checkIsFirstLoginCallBack, false);//检查是否首登  此处用于服务端做统计
                callcenter.check_sign(mgc_comm.SignResp.checkSignCallBack, { isAuto: false, isStop: true });
            }
        }
    }
    /*首页检查是否去其他页，除房间首页引导弹窗*/
    var checkIndeGuide = function() {
        if (tool.cookie('cookieGuideRoom') == null && (tool.cookie('cookieGuideRoom_flag') == '1024')) {
            return;
        } else {
            var indexHref = null;
            indexHref = $("#index_newPlayer_enter").attr('href');
            if (indexHref != 'javascript:showDialog.hide();') {
                $("#pop_newPlayer").fadeIn();
            }
        }
        $('#pop_newPlayer .pop_close,#index_newPlayer_enter').unbind('click').bind('click', function() {
            $("#pop_newPlayer").fadeOut();
        })
        tool.cookie('strMyTimeArr', null, {
            path: '/',
            domain: '.qq.com'
        });
    }
    /**
     * 触发UI回调
     * @param res_type  ui回调结果类型
     * @param resp      消息
     * @param params    附加参数
     */
    var trigger_login_callback = function(res_type, resp, params) {
        if (ui_login_callback) {
            isDoLogin = true;
            ui_login_callback(res_type, resp, params);
            ui_login_callback = '';
        }
    };
    var checkSkeyCallback = function() {
        if (MgcAPI.SNSBrowser.IsQQGame()) {
            tool.commonDialog({ "Note": "对不起，由于您的登录状态已过期，请重新登录梦工厂。" }, function() {
                GameAPI.SNSBrowser.Close();
            }, function() {
                GameAPI.SNSBrowser.Close();
            });
        } else {
            //检测登录异常时，清除缓存
            mgc.account.hasSkey = false;
            mgc.account.logout();
            mgc.account.clear_cookie();
            mgc.comm_model.getLoginBarModel.toggle(false);
            callcenter.query_clear_login_cookie(function () {
                console.log("cookie cleared!");
                var myTime = new Date();
                var filename = window.location.href;
                tool.cookie("mgc_logError_login_checkSkeyCallback", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "___reason___Test-the-login-state-expired___web--login_checkSkeyCallback___filename" + filename, {
                    path: '/',
                    domain: '.qq.com'
                });
            });
            tool.commonDialog({ "Note": "对不起，由于您的登录状态已过期，请重新登录梦工厂。" }, function() {
                tool.hideDialog();
                $("#login-bar-btn").click();
            }, function() {
                tool.hideDialog();
                $("#login-bar-btn").click();
            });
        }
        return false;
    }
    /**
     * 选择角色步骤回调
     * @param resp
     * @param params
     * @param is_false:是否为伪造的大区角色操作
     */
    var select_role_callback = function(resp, params, is_false) {
        //若为伪造的大区角色（888大区开放后，常驻在角色选择列表，但实为未注册）
        if (is_false) {
            param = {};
            param.result = mgc.consts.callcenter.E_LOGIN_NO_CHARA;
            loginCallback(null, param);
            return;
        }
        if (resp.res == 0) {
            console.log("logined with role select"+JSON.stringify(resp));
            window.mgc.config.channel = resp.channel;

            //检测首登改名
            callcenter.callbackStr_req("GET_CHANGE_NAME");

            account_connected_zoneid = resp.zoneid;
            tool.cookie("mgc_zoneid", account_connected_zoneid, { path: '/', domain: '.qq.com' });
            tool.cookie("mgc_login_succeed_uin", new Date().format("yyyy-MM-dd"), {
                path: '/',
                domain: '.qq.com'
            });
            //显示隐藏的tab按钮
            var dis_none;
            if (tool.is_show_room()) {
                dis_none = $("#header .dis-none:lt(3)");//演唱会不显示后援团
            } else {
                if(tool.is_live_room()){
                    dis_none = $("#header .dis-none:lt(4)");
                } else{
                    dis_none = $("#header .dis-none");
                }
                
            }
            dis_none.removeClass().addClass("dis-block");
            var dis_block = $('.dis-block');
            if (tool.is_in_room_page()) {
                dis_block.find("strong").removeClass("background-none");
                dis_block.eq(dis_block.length - 1).find("strong").addClass("background-none");
            } else {
                dis_block.removeClass("background-none");
                dis_block.eq(dis_block.length - 1).addClass("background-none");
            }
            //登录成功以后，清除首页引导弹窗
            if (tool.is_home_page()) {
                window.mgc.popmanager.layerControlHide($('#pop_guide'), 4, 1);
            }
            //当前任务数
            comm_view.getDoneActCount();
            //正常登录后，获取玩家信息  ： 只拉取一次homepage , 其余两次合并到回调中
            callcenter.query_weekstar_url_config(getWeekStarUrlCallback);
            callcenter.query_player_info(0, getPlayerInfoCallback);
            //火箭宝箱的点劵数量在新角色下不显示
            if (typeof (DreamBox) != "undefined") {
                DreamBox.setRole(mgc.tools.isNewRole());
            }
            //红包是否是当前角色
            if ($('.red_con').length != 0) {
                $(".red_con .red_packet").each(function(i, n) {

                    if ($m.cookie('mgc_zoneid') > 40000 && !MGC_Comm.CheckGuestStatus(true)) {
                        $(this).children()[0].className = 'rp_red_x52';
                        tool.cookie("mgc_redpack", 'has', {
                            path: '/',
                            domain: '.qq.com'
                        });
                    } else {
                        $(this).children()[0].className = 'rp_red';
                        tool.cookie("mgc_redpack", 'has', {
                            path: '/',
                            domain: '.qq.com'
                        });
                    }


                });
            }
        } else if (resp.res == -11) {
            return checkSkeyCallback();
        } else if (resp.res == 2) {
            tool.EAS([{ 'e_c': 'mgc.regist.error.7', 'c_t': 4 }]);
        } else {
            tool.EAS([{ 'e_c': 'mgc.regist.error.8', 'c_t': 4 }]);
        }
    };
    /**
     * 创建角色步骤回调
     * @param resp
     * @param params
     */
    var create_role_callback = function(resp, params) {
        console.log("logined with role create:" + JSON.stringify(resp));
        if (resp.res) {
            trigger_login_callback(mgc.consts.ui.RES_ERROR, resp, params);
        }
        else {
            if (resp.res == 0) {
                account_connected_zoneid = resp.zoneid;
            }
            callcenter.query_weekstar_url_config(getWeekStarUrlCallback);
            callcenter.query_player_info(0, getPlayerInfoCallback);
        }
    };

    var logout = function(affirmative) {
        tool.EAS([{ 'e_c': 'mgc.logout', 'c_t': 4 }]);
        var _uin = mgc.account.getUin();
        var cookie_key = "mgc_logingifts_" + mgc.account.getUin() + "_" + tool.cookie("mgc_zoneid");
        //任务引导气泡清cookie
        tool.cookie("mgc_login_succeed_uin", null, {
            path: '/',
            domain: '.qq.com'
        });
        tool.cookie(cookie_key, null, {
            path: '/',
            domain: '.qq.com'
        });
        tool.cookie('taskCount', null, {
            path: '/',
            domain: '.qq.com'
        })
        tool.cookie('cookieGuideRoom_flag', null, {
            path: '/',
            domain: '.qq.com'
        });
        tool.cookie("timerNend_index", null, {
            path: '/',
            domain: '.qq.com'
        });
        tool.cookie('enterRoom_tips', null, {
            path: '/',
            domain: '.qq.com'
        });
        tool.cookie("mgc_redpack", null, {
            path: '/',
            domain: '.qq.com'
        });
        tool.cookie("mgc_login_first_login_uin",null, {
            path: '/',
            domain: '.qq.com'
        });
        //弹首登礼包，清弹首登礼包cookie
        tool.cookie("LoginGiftsResp_IsToken", null, {
            path: '/',
            domain: '.qq.com'
        });
        //退出登录后弹窗隐藏
        $("#pop_newPlayer").fadeOut();
        $("#reminder").fadeOut();
        if (tool.is_in_room_page() && affirmative) {
            var NoteObj = {
                "Note": "退出登录后会退出当前视频房间并且回到首页，您确认要更换登录状态吗？",
                "BtnNum": 2
            };
            tool.commonDialog(NoteObj, function() {
                mgc.account.logout(function() {
                    //请求退出操作,清缓存，发171，回首页
                    callcenter.query_logout();
                    var myTime = new Date();
                    var filename = window.location.href;
                    tool.cookie("mgc_logError_login_logout__mgc_account_logout_is_in_room_pageANDaffirmative", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "___reason___Do_Logout___web--login_logout__mgc_account_logout__is_in_room_pageANDaffirmative___filename" + filename, {
                        path: '/',
                        domain: '.qq.com'
                    });
                    mgc.account.clear_cookie();
                    mgc.account.checkLogin(function() { }, function() { window.location.href = window.mgc.tools.changeUrlToLivearea(consts.url.HOME); }, true);
                });
            });
            //避免退出登录弹窗中取消按钮显示错误
            $("#CancelBtn").css("display", "inline-block");
        } else if (tool.is_in_room_page()) {
            mgc.account.logout(function() {
                //请求退出操作,清缓存，发171，回首页
                callcenter.query_logout();
                var myTime = new Date();
                var filename = window.location.href;
                tool.cookie("mgc_logError_login_logout__mgc_account_logout_is_in_room_page", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "___reason___Do_Logout__is_in_room_page___web--login_logout__mgc_account_logout__is_in_room_page___filename" + filename, {
                    path: '/',
                    domain: '.qq.com'
                });
                mgc.account.clear_cookie();
                mgc.account.checkLogin(function() { }, function() { window.location.href = window.mgc.tools.changeUrlToLivearea(consts.url.HOME); }, true);
            });
        } else if (tool.need_login_page()) {
            //无论是否是因为权限退登的，都会回到首页
            mgc.account.logout(function() {
                //请求退出操作,清缓存，发171，回首页
                callcenter.query_logout();
                var myTime = new Date();
                var filename = window.location.href;
                tool.cookie("mgc_logError_login_logout__mgc_account_logout_need_login_page", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "___reason___Do_Logout__need_login_page___web--login_logout__mgc_account_logout__need_login_page___filename" + filename, {
                    path: '/',
                    domain: '.qq.com'
                });
                mgc.account.clear_cookie();
                mgc.account.checkLogin(function() { }, function() { window.location.href = window.mgc.tools.changeUrlToLivearea(consts.url.HOME); }, true);
            });
        } else if (tool.is_ticket_page()) {
            mgc.account.logout(function() {
                //请求退出操作,清缓存，发171
                callcenter.query_logout();
                var myTime = new Date();
                var filename = window.location.href;
                tool.cookie("mgc_logError_login_logout__mgc_account_logout_is_ticket_page", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "___reason___Do_Logout__is_ticket_page___web--login_logout__mgc_account_logout__is_ticket_page___filename" + filename, {
                    path: '/',
                    domain: '.qq.com'
                });
                mgc.account.clear_cookie();
                mgc.account.checkLogin(function() { }, function() { window.location.reload(); }, true);
            });
        } else {
            mgc.account.logout(function() {
                //请求退出操作,清缓存，发171
                callcenter.query_logout();
                var myTime = new Date();                
                var filename = window.location.href;
                tool.cookie("mgc_logError_login_logout__mgc_account_logout_another_logout", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() +'-'+ myTime.getSeconds() + "_____reason___Do_Logout__another_logout___web--login_logout__mgc_account_logout__another_logout___filename" + filename, {
                    path: '/',
                    domain: '.qq.com'
                });
                mgc.account.clear_cookie();
                mgc.account.checkLogin(function() { }, function() { window.location.reload(); }, true);
            });
        };
    };
    common.logout = logout;
    var isDoLogin = false;
    var cancel_login_callback = function(res_type) {
        console.log("user cancel:" + res_type);
        logout();
        var myTime = new Date();
        var filename = window.location.href;
        tool.cookie("mgc_logError_login___cancel_login_callback", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "___reason___video_sel_role_view___cancel_login_callback___filename" + filename, {
            path: '/',
            domain: '.qq.com'
        });
    }
    //选择角色模型
    var video_sel_role_model = mgc.comm_coll.getCollSelRole;
    var video_sel_role_view = new comm_view.getViewSelRole(select_role_callback, cancel_login_callback);
    /**
     * 登录回调
     * @param resp
     * @param params
     */
    var loginCallback = function(resp, params) {
        switch (params.result) {
            case mgc.consts.callcenter.E_LOGIN_FAILED:
                console.log("login failed");
                trigger_login_callback(mgc.consts.ui.RES_ERROR, resp, params);
                break;
            case mgc.consts.callcenter.E_LOGINED_ANONYMOUS:
                console.log("anonymous logined");
                trigger_login_callback(mgc.consts.ui.RES_NORMAL, resp, params);
                break;
            case mgc.consts.callcenter.E_LOGINED_GUEST:
                console.log("guest logined");
                mgc.account.is_guest = true;
                //存cookie
                callcenter.query_set_cookie(mgc.account.getUin(), mgc.consts.pageSourceConfig.mgc.zoneid);
                trigger_login_callback(mgc.consts.ui.RES_NORMAL, resp, params);
                break;
            case mgc.consts.callcenter.E_LOGIN_CHARA_LIST:
                console.log("need to select one player,select first");
                video_sel_role_model.reset_zone_list(resp.old_player_zone_list, resp.mgc_player, resp.old_two_player_zone_list, resp.lastAccount);
                tool.EAS([{ 'e_c': 'mgc.poparea', 'c_t': 4 }]);
                break;
            case mgc.consts.callcenter.E_LOGIN_NO_CHARA:
                console.log("need to create chara");
                console.log("自动注册");
                //自动注册流程
                common.isAutoRegister = true;
                qqaccount.start_auto_register();
                tool.EAS([{ 'e_c': 'mgc.poparea', 'c_t': 4 }]);
                break;
            case mgc.consts.callcenter.E_LOGIN_SUCCESS:
                console.log("login success");
                if (tool.is_home_page() || tool.is_show_page() || tool.is_playback_page()) {
                    trigger_login_callback(mgc.consts.ui.RES_NORMAL, resp, params);
                }
                select_role_callback(resp);
                break;
            default:
                console.log("default login failed");
                trigger_login_callback(mgc.consts.ui.RES_ERROR, resp, params);
                break;
        }
    };
    /**
     * QQ登录模块
     */
    var qqaccount = {};
    /**
     * 有QQ账号缓存回调
     * @param resp
     * @param param
     */
    qqaccount.has_cookie_callback = function(resp) {
        console.log("qqaccount.has_cookie_callback called:" + JSON.stringify(resp));
        if (resp.hasCookie && resp.sameQQ) {
            if ((MgcAPI.SNSBrowser.IsQQGame() && resp.zoneid != consts.pageSourceConfig.QGame.zoneid) || (MgcAPI.SNSBrowser.IsX52() && resp.zoneid != parseInt(tool.cookie("mgc_zoneid")))) {
                //先清除逻辑的缓存
                callcenter.query_clear_login_cookie(function () {
                    console.log("cookie cleared!");
                    var myTime = new Date();
                    var filename = window.location.href;
                    tool.cookie("mgc_logError_login_qqaccount_has_cookie_callback_QgameAndXw2", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "___reason___Cache_inconsistency___QgameAndXw2--qqaccount_has_cookie_callback_QgameAndXw2-hasCookie And sameQQ___filename" + filename, {
                        path: '/',
                        domain: '.qq.com'
                    });
                });
                //清除189发送缓存--清空 可触发189发送
                tool.cookie("mgc_login_first_login_uin", null, {
                    path: '/',
                    domain: '.qq.com'
                });
                //清进房首登第一次进房，登录异常清缓存
                tool.cookie('enterRoom_tips', null, {
                    path: '/',
                    domain: '.qq.com'
                });
                //清登录首登领取成功以后的cookie--几种弹任务tips标识
                tool.cookie("timerNend_index", null, {
                    path: '/',
                    domain: '.qq.com'
                });
                //弹首登礼包，清弹首登礼包cookie
                tool.cookie("LoginGiftsResp_IsToken", null, {
                    path: '/',
                    domain: '.qq.com'
                });
                callcenter.query_player_zone_list(qqaccount.version_callback);
            } else {
                var params = { result: mgc.consts.callcenter.E_LOGIN_SUCCESS };
                resp.zoneid = resp.zoneid || tool.cookie("mgc_zoneid");
                if (resp.zoneid == consts.pageSourceConfig.QGame.zoneid && resp.channel == null) {
                    resp.channel = consts.pageSourceConfig.QGame.channel;
                }

                if (resp.zoneid > 40000) {
                    resp.channel = consts.pageSourceConfig.X52.channel;
                }
                callcenter.query_login_zone(resp.zoneid, resp.channel, qqaccount.selectrole_callback, params);
            }
        }
        else {
            if (resp.hasCookie) {
                //先清除逻辑的缓存
                callcenter.query_clear_login_cookie(function () {
                    console.log("cookie cleared!");
                    var myTime = new Date();
                    var filename = window.location.href;
                    tool.cookie("mgc_logError_login_qqaccount_has_cookie_callback_web", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "___reason___Cache_inconsistency___web--qqaccount_has_cookie_callback_web-hasCookie___filename" + filename, {
                        path: '/',
                        domain: '.qq.com'
                    });
                });
            }
            //清除189发送缓存--清空 可触发189发送
            tool.cookie("mgc_login_first_login_uin", null, {
                path: '/',
                domain: '.qq.com'
            });
            callcenter.query_player_zone_list(qqaccount.version_callback);
        }
    };
    /*
    *开启自动注册流程
    */
    qqaccount.start_auto_register = function() {
        var params = {};
        params.nick_pool = -1;
        params.nick_record_id = -1;
        params.isRegister = true;
        params.zoneid = tool.pageSource().zoneid;
        if (MgcAPI.SNSBrowser.IsQQGame()) {
            params.zoneid = consts.pageSourceConfig.QGame.zoneid;
        } else if (MgcAPI.SNSBrowser.IsX52()) {
            params.zoneid = parseInt(tool.cookie("mgc_zoneid"));
        }
        params.is_auto_create = common.isAutoRegister;
        //炫舞2平台 昵称和性别
        var nickXW2 = '';
        nickXW2 = tool.cookie("XW2_IED_LOG_INFO2");
        if (MgcAPI.SNSBrowser.IsX52()) {
            console.log("nickname:" + nickXW2);
            params.nick = tool.substring(nickXW2, 6);//昵称字符长度限制
            console.log("nickname:" + params.nick);
            qqaccount.start_auto_register2(params);
        } else {
            //获取昵称
            LoginManager.getNickName(function(loginInfo) {
                if (loginInfo.isLogin && loginInfo.nickName && loginInfo.nickName.length > 0) {
                    console.log("nickname:" + loginInfo.nickName);
                    params.nick = tool.substring(loginInfo.nickName, 6);//昵称字符长度限制
                    console.log("nickname:" + params.nick);
                    qqaccount.start_auto_register2(params);
                }
                else {
                    //获取昵称失败处理
                    params.nick = "";
                    qqaccount.start_auto_register2(params);
                }
            });
        }

    }
    qqaccount.start_auto_register2 = function(params) {

        //炫舞2平台 昵称和性别
        var genderXW2 = '';
        genderXW2 = parseInt(tool.cookie("XW2_IED_LOG_INFO2_GENDER"));
        if (MgcAPI.SNSBrowser.IsX52()) {
            if (genderXW2 == 1) {
                params.gender = 1;
            } else if (genderXW2 == 0) {
                params.gender = 0;
            } else {
                //获取失败 默认女
                params.gender = 0;
            }
            callcenter.query_login_zone(params.zoneid, consts.pageSourceConfig.X52.channel, qqaccount.start_register_callback, params);

        } else {
            //获取性别
            var _url = "http://apps.game.qq.com/mgc/index.php?m=GetUserGender&t=" + (new Date()).getTime();
            $.ajax({
                type: 'get', url: _url, dataType: 'jsonp', jsonp: 'jsoncallback',
                success: function(obj) {
                    if (parseInt(obj.ret_code) == 0) {
                        if (obj.data.UserGender == "男") {
                            params.gender = 1;
                        }
                        else {
                            params.gender = 0;
                        }
                    }
                    else {
                        //获取失败 默认女
                        params.gender = 0;
                    }
                    callcenter.query_login_zone(params.zoneid, tool.pageSource().channel, qqaccount.start_register_callback, params);
                },
                error: function() {
                    alert('抱歉，网络繁忙，请稍候再试！');
                }
            });
        }

    }
    /*
    *开始注册模式 发-2 链接大区
    */
    qqaccount.start_register = function(params) {
        var zoneid = null;
        if (MgcAPI.SNSBrowser.IsX52()) {
            zoneid = parseInt(tool.cookie("XW2_IED_LOG_INFO2_ZONEID"));
        } else {
            zoneid = tool.pageSource().zoneid;
        }
        params.isRegister = true;
        params.zoneid = zoneid;
        params.is_auto_create = common.isAutoRegister;
        callcenter.query_login_zone(zoneid, 0, qqaccount.start_register_callback, params);
    };
    /*
    *开始注册回调 -2  链接大区回调
    */
    qqaccount.start_register_callback = function(resp, params) {
        console.log("start register callback:" + JSON.stringify(resp));
        if (resp.res == -11) {
            return checkSkeyCallback();
        }
        mgc.account.checkLogin(function() {
            if (resp.res == consts.ui.RES_NORMAL) {
                if (params.isRegister) {
                    callcenter.query_create_role(params.nick, params.gender, params.zoneid, params.nick_pool, params.nick_record_id, qqaccount.do_create_role_callback, params);
                }
            }
        }, function() {
            create_role_callback(resp);
        }, true);
    }
    /*
    *创建角色回调
    */
    qqaccount.do_create_role_callback = function(resp, params) {
        console.log("do register callback:" + JSON.stringify(resp));
        var msg = '';
        switch (resp.res) {
            case 0:
                // 关闭注册模式
                tool.EAS([{ 'e_c': 'mgc.regist.succ', 'c_t': 4 }]);
                params.isRegister = false;
                if (common.isAutoRegister) {
                    //自动注册 todo
                    common.isAutoRegister = false;
                } else {
                    $('#popSr').val('输入QQ昵称').css({ "color": "#bcbcbc" });
                    window.mgc.popmanager.layerControlHide($("#pop_player_create"), 4, 1);
                    //tool.commonDialog({ "Title": "提示", "Note": "创建角色成功。" }, function() { });
                    if (tool.is_transfer_page()) {
                        window.location.reload();
                    }
                }
                // 然后继续链接大区
                callcenter.query_login_zone(params.zoneid, 0, qqaccount.selectrole_callback, params);
                return;
                break;
            case 1:
                tool.EAS([{ 'e_c': 'mgc.regist.error.1', 'c_t': 4 }]);
                msg = '请输入昵称！';
                break;
            case 2:
                tool.EAS([{ 'e_c': 'mgc.regist.error.2', 'c_t': 4 }]);
                msg = '该昵称不可使用，请您重新输入！';
                break;
            case 3:
                tool.EAS([{ 'e_c': 'mgc.regist.error.3', 'c_t': 4 }]);
                msg = '该昵称已被使用，请您重新输入！';
                break;
            case 4:
                tool.EAS([{ 'e_c': 'mgc.regist.error.4', 'c_t': 4 }]);
                msg = '角色已存在，请您重新输入！';
                break;
            default:
                tool.EAS([{ 'e_c': 'mgc.regist.error.5', 'c_t': 4 }]);
                msg = '该昵称不可使用，请您重新输入！';
                break;
        }
        if (common.isAutoRegister) {
            common.isAutoRegister = false;
            var view = comm_view.getViewCreateRole(mgc.comm_model.getCreateRoleModel, qqaccount.start_register, cancel_login_callback);
            view.render();
        }
        if (msg != '') {
            $('.pop_nick_info').html(msg).css('color', 'red');
        }
        return;
    }
    /**
     * QQ账号选择角色回调
     * @param resp
     * @param param
     */
    qqaccount.selectrole_callback = function(resp, param) {
        console.log("qqaccount.selectrole_callback called");
        if (resp.res == -11) {
            return checkSkeyCallback();
        }
        if (loginCallback) {
            param.result = mgc.consts.callcenter.E_LOGIN_SUCCESS;
            loginCallback(resp, param);
        }
    };

    qqaccount.version_callback = function(resp, param) {
        console.log("qqaccount.version_callback called");
        //签名验证失败
        if (resp.err_code == 3 || resp.err_code == 1) {
            return checkSkeyCallback();
        }
        if (resp.account_infos.length > 0) {
            //有角色
            var PlayerZoneList = getPlayerZoneList(resp.account_infos, resp.room_proxy_infos);
            resp.old_two_player_zone_list = PlayerZoneList[2];
            resp.old_player_zone_list = PlayerZoneList[1];
            resp.mgc_player = PlayerZoneList[0];
            param.result = mgc.consts.callcenter.E_LOGIN_CHARA_LIST;
            //炫舞2大区列表----是否有和地址里传过来的zoneid不一致情况（有：快速注册，无：走有角色选大区）
            if (MgcAPI.SNSBrowser.IsX52()) {
                console.log('炫舞2大区进入1');
                if (getXW2ZoneIdNotSame(resp.old_two_player_zone_list)) {
                    console.log('炫舞2大区进入判断炫舞大区id是否相同方法----返回最后的xw2ZoneFlag 5 开始快速注册');
                    //登录大区列表中的zoneid和缓存的zoneid不一样--去快速注册
                    //callcenter.query_login_zone(parseInt(tool.cookie("mgc_zoneid")), tool.pageSource().channel, qqaccount.room_proxy_callback_no_role);
                    common.isAutoRegister = true;
                    console.log('炫舞2大区进入判断炫舞大区id是否相同方法----返回最后的xw2ZoneFlag 6 开始快速注册');
                    qqaccount.start_auto_register();
                    console.log('炫舞2大区进入判断炫舞大区id是否相同方法----返回最后的xw2ZoneFlag 7 开始快速注册结束');
                } else {
                    //qgame大厅环境下  跳过选择角色  直接登录
                    callcenter.query_login_zone(mgc.tools.pageSource().zoneid, 4, select_role_callback);
                }
            } else {
                if (MgcAPI.SNSBrowser.IsQQGame() || (resp.old_player_zone_list.length == 0 && resp.old_two_player_zone_list.length == 0 && resp.mgc_player.length == 1)) {
                    //qgame大厅环境下 或者 只有888大区  跳过选择角色  直接登录
                    callcenter.query_login_zone(tool.pageSource().zoneid, tool.pageSource().channel, select_role_callback);
                } else {
                    loginCallback(resp, param);
                }
            }

        }
        else {
            //炫舞2 
            if (MgcAPI.SNSBrowser.IsX52()) {
                //从缓存里读取zoneid ---修改：tool.pageSource().zoneid
                callcenter.query_login_zone(mgc.tools.pageSource().zoneid, tool.pageSource().channel, qqaccount.room_proxy_callback_no_role);
            } else {
                //无角色
                callcenter.query_login_zone(tool.pageSource().zoneid, tool.pageSource().channel, qqaccount.room_proxy_callback_no_role);
            }
        }
    };
    qqaccount.room_proxy_callback_no_role = function(resp, param) {
        console.log("qqaccount.room_proxy_callback_no_role called");
        if (resp.res == -11) {
            return checkSkeyCallback();
        }
        if (loginCallback) {
            param.result = mgc.consts.callcenter.E_LOGIN_NO_CHARA;
            loginCallback(resp, param);
        }
    };
    qqaccount.room_proxy_callback = function(resp, param) {
        console.log("qqaccount.room_proxy_callback called");
        if (loginCallback) {
            param.result = mgc.consts.callcenter.E_LOGIN_CHARA_LIST;
            loginCallback(resp, param);
        }
    };
    var getPlayerZoneList = function(account_infos, room_proxy_infos) {
        var mgcPlayer = [];
        var oldPlayer = [];
        var oldTwoPlayer = [];
        var is_exist_mgc;
        for (var m = 0, n = account_infos.length; m < n; m++) {
            var zoneid = parseInt(account_infos[m]["zoneid"], 10);
            for (var k = 0, t = room_proxy_infos.length; k < t; k++) {
                var rp_zoneid = parseInt(room_proxy_infos[k]["zoneid"], 10);
                if (zoneid == rp_zoneid) {
                    var rp_zonename = room_proxy_infos[k].name;
                    var channel = account_infos[m].channel;
                    if (zoneid == mgc.consts.pageSourceConfig.mgc.zoneid || zoneid == mgc.consts.pageSourceConfig.QGame.zoneid) {
                        mgcPlayer.push({ zoneid: zoneid, zonename: rp_zonename, channel: channel });
                        if (zoneid == mgc.consts.pageSourceConfig.mgc.zoneid) {
                            is_exist_mgc = true;
                        }
                    } else if (channel == mgc.consts.pageSourceConfig.X52.channel) {
                        oldTwoPlayer.push({ zoneid: zoneid, zonename: rp_zonename, channel: channel });
                    } else {
                        oldPlayer.push({ zoneid: zoneid, zonename: rp_zonename, channel: channel });
                    }
                    break;
                }
            }
        }
        if (!is_exist_mgc) {
            mgcPlayer.splice(0, 0, { zoneid: mgc.consts.pageSourceConfig.mgc.zoneid, zonename: mgc.consts.pageSourceConfig.mgc.zonename, channel: mgc.consts.pageSourceConfig.mgc.channel, is_false: true });
        }
        return [mgcPlayer, oldPlayer, oldTwoPlayer];
    };
    //炫舞2平台-获取的当前zoneid  和 大区列表的的 zoneid 找不相同的
    var getXW2ZoneIdNotSame = function(room_proxy_infos) {
        console.log('炫舞2大区进入判断炫舞大区id是否相同方法2');
        var xw2ZoneFlag = true;
        var xw2Zone = parseInt(tool.cookie("mgc_zoneid"));
        for (var k = 0, t = room_proxy_infos.length; k < t; k++) {
            if (xw2Zone == room_proxy_infos[k].zoneid) {
                xw2ZoneFlag = false;
                console.log('炫舞2大区进入判断炫舞大区id是否相同方法----xw2ZoneFlag：3' + xw2ZoneFlag);
                break;
            }
        }
        console.log('炫舞2大区进入判断炫舞大区id是否相同方法----返回最后的xw2ZoneFlag 4' + xw2ZoneFlag);
        return xw2ZoneFlag;
    };

    /**
     * 匿名登录
     * @param callback
     */
    var loginWithoutQQ = function() {
        callcenter.query_player_zone_list(anonymous.version_callback);
    };

    //匿名登录模块
    var anonymous = {};
    /**
     * 匿名登录拉取角色列表
     * @param resp
     * @param param
     */
    anonymous.version_callback = function(resp, param) {
        console.log("anonymous.version_callback called");
        callcenter.query_login_zone(tool.pageSource().zoneid, tool.pageSource().channel, anonymous.room_proxy_callback);
    };
    /**
     * 匿名登录大区
     * @param resp
     * @param param
     */
    anonymous.room_proxy_callback = function(resp, param) {
        console.log("anonymous.room_proxy_callback called");
        tool.EAS([{ 'e_c': 'mgc.regist.error.6', 'c_t': 4 }]);
        if (loginCallback) {
            param.result = mgc.consts.callcenter.E_LOGINED_ANONYMOUS;
            loginCallback(resp, param);
        }
    };

    qqaccount.createrole_callback = function(resp, param) {
        console.log("callcenter.qqaccount.createrole_callback called");
        if (loginCallback) {
            loginCallback(resp, param);
        }
    };

    /**
     * 游客登陆
     * @param callback
     */
    var loginWithGuest = function() {
        callcenter.query_player_zone_list(guest.version_callback);
    };

    var guest = {};
    /**
     * 请求是否有游客缓存
     * @param resp
     * @param param
     */
    guest.version_callback = function(resp, param) {
        console.log("callcenter.guest.version_callback called");
        callcenter.query_has_guest_account(guest.has_cookie_callback);
    };
    /**
     * 根据游客缓存决定直接连接还是申请游客缓存
     * @param resp
     * @param param
     */
    guest.has_cookie_callback = function(resp, param) {
        console.log("guest.has_cookie_callback called");
        if (resp.hasCookie) {
            //直接用游客账号链接
            callcenter.query_guest_login_zone(resp.id, resp.encrypt_identity, mgc.consts.pageSourceConfig.guest.zoneid, mgc.consts.pageSourceConfig.guest.channel, guest.room_proxy_callback);
        }
        else {
            //用匿名连接
            callcenter.query_login_zone(mgc.consts.pageSourceConfig.mgc.zoneid, mgc.consts.pageSourceConfig.mgc.channel, guest.room_proxy_callback_get_guestid);
        }
    };
    /**
     *匿名连接申请游客账号
     * @param resp
     * @param param
     */
    guest.room_proxy_callback_get_guestid = function(resp, param) {
        console.log("guest.room_proxy_callback_get_guestid called");
        callcenter.query_get_guest_account(guest.get_guestid_callback);
    };
    /**
     * 申请到游客账号后用游客账号进行连接
     * @param resp
     * @param param
     */
    guest.get_guestid_callback = function(resp, param) {
        console.log("guest.get_guestid_callback called");
        callcenter.query_guest_login_zone(resp.id, resp.encrypt_identity, mgc.consts.pageSourceConfig.guest.zoneid, mgc.consts.pageSourceConfig.guest.channel, guest.room_proxy_callback);
    };
    /**
     * 用游客账号登录大区后回调给上层登录成功
     * @param resp
     * @param param
     */
    guest.room_proxy_callback = function(resp, param) {
        console.log("guest.room_proxy_callback called");
        if (loginCallback) {
            param.result = mgc.consts.callcenter.E_LOGINED_GUEST;
            loginCallback(resp, param);
        }
    };

    /*
     *检测到用户名异常
     */
    common.CheckNameError = function(type) {
        var NoteObj = {
            "Note": "检测到用户名异常，将为您登出"
        };
        tool.commonDialog(NoteObj, function() {
            logout();
            var myTime = new Date();
            var filename = window.location.href;
            tool.cookie("mgc_logError_login___common_CheckNameError", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "___reason___common_CheckNameError___web--common_CheckNameError___filename" + filename, {
                path: '/',
                domain: '.qq.com'
            });
        });
    };

    if (!window.mgc) {
        window.mgc = {};
    }
    window.mgc.common_logic = common;
    return common;
});