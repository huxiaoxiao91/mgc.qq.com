/**
 * @Description:   梦工厂web-控制-个人中心
 *
 * @author         Xu XiaoJing
 * @version        V1.0
 * @Date           2015/11/27
 * @Company        horizon3d
 */
define(['mgc_callcenter', 'eas', 'tgadshow', 'mgc_consts', 'jqtmpl', 'mgc_tool', 'mgc_tips', 'mgc_popmanager', 'mgc_login', 'mgc_dialog', 'mgc_comm'], function (callcenter, eas, tgadshow, consts, jqtmpl, mgc_tool, mgc_tips, mgc_popmanager, mgc_login, mgc_dialog, mgc_comm) {
    var control = {};

    /**
     * 初始化个人中心
     */
    control.init = function() {
        //隐藏img，用户缓冲图片加载
        $("body").append('<img id="hidden_lazyload_img" class="hide" src="" />');
        //加载个人信息
        personal_request.getMyInfo();
        //复选框
        $('.box_check').off('click').on('click', function() {
            $(this).parent().toggleClass('checked');
        });
        //保存个人签名
        $('.btn_save').off('click').on('click', function() {
            var con = $.trim($('#i_signature').val());
            con = con.replace(/[\r\n]/g, "");
            if (con == '请输入文字，上限为32个汉字。') {
                con = '';
            }
            if (mgc_tool.Strlen(con) > 64) {
                con = mgc_tool.Strcut(con, 64);
            }
            personal_request.editSignature(con);
        });
        //文字限制
        $('#i_signature').focus(function() {
            $(this).css('color', '#1c1c1c');
            if ($(this).val() == '请输入文字，上限为32个汉字。') {
                $(this).val("");
            }
        }).blur(function() {
            if ($.trim($(this).val()) == '') {
                $(this).val("请输入文字，上限为32个汉字。").css('color', '#9b9b9b');
            }
        }).keyup(function() {
            var v = $.trim($(this).val());
            if (MGC_Comm.Strlen(v) > 64) {
                $(this).val(MGC_Comm.Strcut(v, 64));
            }
        }).keydown(function() {
            var v = $(this).val();
            if (MGC_Comm.Strlen(v) >= 64) {
                event.returnValue = false;
            }
            if (event.keyCode == 8) {
                event.returnValue = true;
                ;
            }
            if (event.keyCode == 13) {
                event.returnValue = false;
            }
        });
        //修改昵称
        $('.btn_revamp').off('click').on('click', function() {
            $('#i_tips').children().remove();
            mgc_tool.EAS([{ 'e_c': 'mgc.updatenick', 'c_t': 4 }]);
            //if (isOldUser) {
            //    var dialog = {};
            //    dialog.Note = '您是炫舞用户，请您登录炫舞客户端进行改名操作';
            //    mgc_dialog.simpleDialog(5, dialog);
            //    return false;
            //}
            var nowNick = $.trim($('#i_nick_name').text());
            $('#i_edit_nick').val(nowNick).focus(function() {
                $('#i_tips').hide();
            }).blur(function() {
                var v = $.trim($(this).val());
                if (mgc_tool.Strlen(v > 12)) {
                    mgc_tool.Strcut(v, 12);
                }
            });
            $('#i_edit_btn').unbind('click').click(function() {
                $('#i_tips').hide();
                var v = $.trim($('#i_edit_nick').val());
                if (v == '') {
                    $('#i_tips').html('<i class="icon_warn"></i>请输入昵称！').show();
                } else {
                    if (mgc_tool.Strlen(v) > 12) {
                        $('#i_tips').html('<i class="icon_warn"></i>昵称长度限制12个字符！').show();
                        return;
                    }
                    personal_request.checkDupNick(v);
                }
            });
            mgc_popmanager.layerControlShow($("#pop4"), 4, 1);
            $('.pop_close').off('click').on('click', function() {
                mgc_popmanager.layerControlHide($("#pop4"), 4, 1);
            });
            $("#pop4").centerDisp();
        });
        //加载完毕后，释放点击事件
        
        $('.line_bot #mask').hide();
        //初始化上传头像swf
        personal_request.AvatarSwfInit();

        window.saveImage = function(value) {
            if (value.length <= 0)
                return;
            personal_request.uploadAvatar(value);
        };

    };

    //发送请求========================================
    var personal_request = {
        //加载个人信息
        getMyInfo: function() {
            var reqParams = {
                reqtype: 1
            };
            setTimeout(function() {
                callcenter.callbackStr_req("GET_PLAYER_INFO", personal_callBack.UserInfoCallBack, "personal_callBack.UserInfoCallBack", reqParams);
            }, 100);
        },
        //保存个人签名
        editSignature: function(signCon) {
            var reqParams = {
                sign: signCon
            };
            callcenter.callbackStr_req("EDIT_SIGNATURE", personal_callBack.EditSignatureCallBack, "personal_callBack.EditSignatureCallBack", reqParams);
        },
        //禁止所有私聊
        forbidChat: function(type) {
            var reqParams = {
                "forbid": type
            };
            callcenter.callbackStr_req("FORBID_CHAT", personal_callBack.ForbidChatCallBack, "personal_callBack.ForbidChatCallBack", reqParams);
        },
        //保检查昵称是否重复
        checkDupNick: function(nick) {
            var reqParams = {
                "nick": nick
            };
            callcenter.callbackStr_req("CHECK_DUPNICK", personal_callBack.CheckDupNickCallBack, "personal_callBack.CheckDupNickCallBack", reqParams);
        },
        //修改昵称
        editNick: function(nick) {
            var reqParams = {
                "nick": nick,
                "source_type": 0,
                "rand_nick_pool": -1,
                "nick_record_id": -1
            };
            callcenter.callbackStr_req("EDIT_USERNICK", personal_callBack.EditNickCallBack, "personal_callBack.EditNickCallBack", reqParams);
        },
        //取消关注
        cancelAttend: function(anchorID, anchorName) {
            var reqParams = {
                "anchor_id": anchorID,
                "anchor_nick": anchorName
            };
            callcenter.callbackStr_req("CANCEL_FOLLOW_ANCHOR", personal_callBack.CancelAttendCallBack, "personal_callBack.CancelAttendCallBack", reqParams);
        },

        // 初始化上传头像swf
        AvatarSwfInit: function() {
            var swfUrl = "upimage.swf?v=3_8_8_2016_15_4_final_3";
            var swfVersionStr = "11.1.0";
            var xiSwfUrlStr = "playerProductInstall.swf?v=3_8_8_2016_15_4_final_3";
            var flashvars = {};
            var params = {};
            params.quality = "high";
            params.bgcolor = "#000";
            params.allowscriptaccess = "always";
            params.allowfullscreen = "true";
            params.allowFullScreenInteractive = "true";
            params.wmode = "opaque";
            var attributes = {};

            attributes.id = "AvatarSwf";
            attributes.name = "AvatarSwf";
            attributes.align = "middle";
            if (mgc_tool.checkIsIEloadSwfFailed())
                swfUrl += "&r=" + new Date();
            swfobject.embedSWF(swfUrl, "AvatarFlashContent", "100%", "100%", swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
        },

        uploadAvatar: function(content) {
            var reqParams = {
                "content": content
            };
            callcenter.callbackStr_req("UPLOAD_USER_AVATAR", personal_callBack.UploadAvatarCallBack, "personal_callBack.UploadAvatarCallBack", reqParams);
        }
    };

    var isOldUser = false;
    //取消关注的列
    var currentCancel;

    var personal_callBack = {
        UserInfoCallBack2: function(responseStr) {
            console.log("UserInfoCallBack resp:");
        },
        //用户个人信息
        UserInfoCallBack: function(responseStr) {
            try {
                console.log("UserInfoCallBack resp:" + JSON.stringify(responseStr));
                var obj = typeof responseStr == 'object' ? responseStr : mgc_tool.strToJson(responseStr);
                if (obj.res == 0) {
                    //我的信息
                    var _userInfo = obj.playerinfo;
                    var _sex = '女';
                    var _sex_class = 'female';
                    var _vip_level = _userInfo.vip_level;
                    var _honor = consts.vipLevelTab[_vip_level];
                    var _avatar = _userInfo.photo_url;
                    if (_avatar == '') {
                        if (parseInt(_userInfo.sex_male) == 0) {
                            _avatar = 'http://ossweb-img.qq.com/images/mgc/css_img/headicon/default_female.png?v=3_8_8_2016_15_4_final_3';
                        } else {
                            _avatar = 'http://ossweb-img.qq.com/images/mgc/css_img/headicon/default_male.png?v=3_8_8_2016_15_4_final_3';
                        }
                    }

                    if (parseInt(_userInfo.zone_id) != consts.pageSourceConfig.mgc.zoneid && parseInt(_userInfo.zone_id) != consts.pageSourceConfig.QGame.zoneid) {
                        isOldUser = true;
                    }

                    $('#login_qq_face').attr('src', _avatar);
                    //显示头像
                    if (_userInfo.sex_male == true) {
                        _sex = '男';
                        _sex_class = 'male';
                    }
                    var level_exp = '<i>' + _userInfo.video_exp + '/' + _userInfo.video_levelup_exp + '</i>';
                    lvPerc = 0;
                    if (_userInfo.video_levelup_exp > 0) {
                        lvPerc = (_userInfo.video_exp / _userInfo.video_levelup_exp * 100).toFixed(0);
                    } else if (_userInfo.video_levelup_exp == 0) {
                        lvPerc = 100;
                        level_exp = '<i>max</i>';
                        $('#i_level_exp').css('line-height', '23px');
                    }
                    var wealth_exp = '<i>' + _userInfo.wealth_exp + '/' + _userInfo.wealth_levelup_exp + '</i>';
                    wealthPerc = 0;
                    if (_userInfo.wealth_levelup_exp > 0) {
                        wealthPerc = (_userInfo.wealth_exp / _userInfo.wealth_levelup_exp * 100).toFixed(0);
                    } else if (_userInfo.wealth_levelup_exp == 0) {
                        wealthPerc = 100;
                        wealth_exp = '<i>' + _userInfo.video_wealth + '</i>';
                    }
                    $('#i_nick_name').html(_userInfo.nick);
                    $('#i_dream_money').html(_userInfo.video_dream_money);
                    $('#i_balance_money').html(_userInfo.video_money_balance);
                    $('#i_zone_name').html(mgc_tool.myZoneName(_userInfo.zone_name));
                    $('#i_sex').html(_sex).addClass(_sex_class);
                    //$('#i_wealth').html("财富值：" + _userInfo.video_wealth);
                    $('#i_wealth_level').addClass('i_wealth_level_' + _userInfo.wealth_level);
                    $('#i_wealth_level').css({"background": "url(http://ossweb-img.qq.com/images/mgc/css_img/common/wealth_level/" + _userInfo.wealth_level + ".png?v=3_8_8_2016_15_4_final_3) no-repeat"});
                        
                    $('#i_wealth_exp').html(wealth_exp).width(wealthPerc + '%');
                    $('#i_honor').next().html(_honor);
                    $('#i_video_level').html(_userInfo.video_level);
                    $('#i_level_exp').html(level_exp).width(lvPerc + '%');

                    //顶条也有这个类
                    var iconMhb = $(".box_info").find('.icon_mhb');
                    var iconXd = $(".box_info").find('.icon_xd');
                    var cssObj = {
                        "width": "180px"
                    };
                    mgc_tips.cssCommonTips($('.mhb_tips').html(), iconMhb, cssObj);
                    mgc_tips.cssCommonTips($('.xd_tips').html(), iconXd, cssObj);

                    var pos = {
                        y: 20,
                        x: 170
                    };
                    mgc_tips.cssFixPosTips("财富值：" + _userInfo.video_wealth, $('.i_wealth_level_tips'), pos);

                    if (_vip_level > 0) {
                        var _remain_days = personal_callBack.getRemainDate(_userInfo.vip_remaining_time);
                        $('#i_honor').attr('class', 'b_icon_honor b_icon_honor' + _vip_level);
                        $('#i_honor').css({"background": "url(http://ossweb-img.qq.com/images/mgc/css_img/common/nobility/" + _vip_level + ".png?v=3_8_8_2016_15_4_final_3) no-repeat"});
                        $('#i_anchor-name').html(_userInfo.vip_anchor_name);
                        $('#i_expire_time').html('（剩余时间：' + _remain_days + '）');
                    }
                    if (_userInfo.signature.length > 0) {
                        $('#i_signature').val(_userInfo.signature).css('color', '#000000');
                    }
                    //关注的主播
                    var _userAttend = obj.playerinfo.followinfo_vec;
                    var attendCon = $('#i_attend_tmpl');
                    var attendTmpl;
                    var attendContainer = $('#i_attend_list');
                    var _tmplList = new Array();
                    if (_userAttend.length > 0) {
                        for (var i = 0, j = _userAttend.length; i < j; i++) {
                            _userAttend[i].guardLevelStr = consts.guardLevelTab[_userAttend[i].guard_level];
                            _tmplList.push(_userAttend[i]);
                        }
                        $.each(_tmplList, function(k, v) {
                            v.anchor_level_temp = Math.floor(v.anchor_level / 10) + 1;
                            if (v.anchor_level == 0) {
                                v.anchor_level_temp = 0;
                            }
                        });
                        attendContainer.children().remove();
                        attendTmpl = attendCon.tmpl(_tmplList);
                        attendTmpl.appendTo(attendContainer);

                        $('#i_attend_list').find('span[class^="anchor_level_"]').each(function(i) {
                            mgc_tips.commonTips('主播等级：' + $(this).html(), $(this));
                        });

                        var gdPos = {
                            y: -5,
                            x: 30
                        };
                        $('#i_attend_list').find('span[class^=icon_lv]').each(function(i) {
                            mgc_tips.cssFixPosTips($(this).attr("mgc_guard_level"), $(this), gdPos);
                        });

                        $('#i_attend_list').find('a[class=del]').each(function(i) {
                            $(this).off('click').on('click', function() {
                                var dialog = {};
                                dialog.Note = '确认取消关注该主播？';
                                dialog.BtnNum = 2;
                                currentCancel = this;
                                mgc_dialog.simpleDialog(5, dialog, function() {
                                    var m_anchor = $(currentCancel).attr('m_anchor');
                                    var m_anchor_nick = $(currentCancel).attr('m_anchor_nick');
                                    personal_request.cancelAttend(m_anchor, m_anchor_nick);
                                });
                            });
                        });
                        $('#i_attend_list').on('mouseenter', 'a.del', function() {
                            $(this).next().css({
                                "display": "block"
                            });
                        }).on('mouseleave', 'a.del', function() {
                            $(this).next().css({
                                "display": "none"
                            });
                        });
                        attendTmpl = null;
                        attendCon = null;
                    } else {
                        //暂时没有关注的主播 @TODO

                    }
                    //是否屏蔽
                    if (_userInfo.forbidAllPrivate) {
                        $('.box_check').parent().addClass('checked');
                    }
                } else if (obj.res == 3) {
                    //异常
                    mgc_login.logout();

                    var DialogObj = {};
                    DialogObj.Note = "程序大叔手滑没拉取到您的信息~~>_<~~快进入游戏内梦工厂任意房间，再回来看我哟 (づ￣3￣)づ";
                    mgc_dialog.simpleDialog(5, DialogObj);
                    var myTime = new Date();
                    var filename = window.location.href;
                    mgc_tool.cookie("mgc_logError_mgc_personal_networkError_logout__res__3", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "_____reason___mgc_personal_networkError_logout__res__3___web--mgc_personal_networkError_logout___filename" + filename, {
                        path: '/',
                        domain: '.qq.com'
                    });
                } else {
                    //异常
                    mgc_login.logout();
                    var myTime = new Date();
                    var filename = window.location.href;                    
                    mgc_tool.cookie("mgc_logError_mgc_personal_networkError_logout", new Date().format("yyyy-MM-dd") + '-' + myTime.getHours() + '-' + myTime.getMinutes() + '-' + myTime.getSeconds() + "_____reason___mgc_personal_networkError_logout___web--mgc_personal_networkError_logout___filename" + filename, {
                        path: '/',
                        domain: '.qq.com'
                    });
                    alert('抱歉，网络繁忙，请稍候再试。');
                }
                if (window.mgc.tools.cookie('mgc_login_succeed_uin') == null) {
                    callcenter.check_goodFriendPay(mgc_comm.GoodFriendPay.goodFriendPayCallBack);//登录成功-请求好友充值消息         
                }
            } catch (e) {
                console.log(e);
            }
        },
        EditSignatureCallBack: function(responseStr) {
            var obj = typeof responseStr == 'object' ? responseStr : mgc_tool.strToJson(responseStr);
            if (obj.errcode == 0) {
                var _t = $('.box_check').parent().hasClass('checked') ? 0 : 1;
                personal_request.forbidChat(_t);
            } else {
                var dialog = {};
                dialog.Note = '操作失败！';
                mgc_dialog.simpleDialog(5, dialog);
            }
        },
        ForbidChatCallBack: function(responseStr) {
            responseStr = mgc_tool.strToJson(responseStr);
            if (responseStr.res == 0) {
                var dialog = {};
                dialog.Note = '保存成功！';
            } else {
                var dialog = {};
                dialog.Note = '操作失败！';
            }
            mgc_dialog.simpleDialog(5, dialog);
        },
        CheckDupNickCallBack: function(responseStr) {
            responseStr = mgc_tool.strToJson(responseStr);
            var f = true, msg = '';
            switch (parseInt(responseStr.res)) {
                case 0:
                    f = false;
                    var v = $.trim($('#i_edit_nick').val());
                    personal_request.editNick(v);
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
                case 4:
                    msg = '昵称中不能含有空格，请您重新输入！';
                    break;
                case 5:
                    msg = '该昵称含有非法内容，请您重新输入！';
                    break;
                case 6:
                    msg = '由于未知原因，修改失败！';
                    break;
                default:
                    msg = '该昵称不可使用，请您重新输入！';
                    break;
            }
            if (f) {
                $('#i_tips').html('<i class="icon_warn"></i>' + msg).show();
            }
        },
        EditNickCallBack: function(responseStr) {
            var obj = typeof responseStr == 'object' ? responseStr : mgc_tool.strToJson(responseStr);
            if (obj.res == 0) {
                var dialog = {};
                dialog.Note = '昵称更新成功！';
                mgc_dialog.simpleDialog(5, dialog, function() {
                    $('#i_nick_name').html($.trim($('#i_edit_nick').val()));
                    mgc_popmanager.layerControlHide($("#pop4"), 4, 1);
                });
            } else if (obj.res == 7) {
                window.mgc.common_logic.CheckNameError(156);
            }else {
                $('#i_tips').html('<i class="icon_warn"></i>昵称更新失败，请稍后重试！').show();
            }
        },
        CancelAttendCallBack: function(responseStr) {
            console.log("取消关注主播的返回" + responseStr);
            responseStr = mgc_tool.strToJson(responseStr);
            var dialog = {}, _callback;
            if (responseStr.res == 0 || responseStr.res == 4) {
                dialog.Note = '您已经成功取消关注该主播';
                _callback = function() {
                    $(currentCancel).parents('tr').fadeOut('fast', function() {
                        $(this).remove();
                    });
                };
            } else if (responseStr.res == 2) {
                dialog.Note = '取消关注主播失败，未找到该主播';
            } else {
                dialog.Note = '取消关注主播失败。';
            }
            mgc_dialog.simpleDialog(5, dialog, _callback);
        },
        //上传头像
        UploadAvatarCallBack: function(responseStr) {
            var obj = typeof responseStr == 'object' ? responseStr : mgc_tool.strToJson(responseStr);
            if (obj.errcode == 0) {
                if (obj.pUrl) {
                    $("#login_qq_face").attr("src", obj.pUrl + "?r=" + Math.random());
                    personal_callBack.i++;
                }
                var dialog = {};
                dialog.Note = '头像上传成功！';
            } else {
                var dialog = {};
                dialog.Note = '操作失败！';
            }
            mgc_dialog.simpleDialog(5, dialog);
        },
        getRemainDate: function(remainTime) {
            if (remainTime <= 0)
                return false;
            var _myVipDuration;
            _myVipDuration = Math.ceil(remainTime / 86400);
            _myVipDuration = _myVipDuration + '天';
            return _myVipDuration;
        }
    };


    //票务
    var msg = function(type) {
        if (order_list && order_list.result == 0) {
            if (order_list.total <= 0) {
                $('#ticketContent').html('<tr><td>抱歉，未查到订单信息。</td></tr>');
                $('.fanye').hide();
            } else {
                var htmlTemp = "";
                $.each(order_list.data, function(k, v) {
                    htmlTemp += "<tr>";
                    htmlTemp += '<td width="25%" class="row1">';
                    htmlTemp += '<span style="float:left;display:block;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;width:140px;">' + v.dtBuyTime + '</span>';
                    htmlTemp += "</td>";
                    htmlTemp += '<td width="20%">' + mgc_tool.mZone(v.sZoneDesc) + '</td>';
                    htmlTemp += '<td width="15%">' + v.lGetUin + '</td>';
                    htmlTemp += '<td width="15%"><span class="" title="">' + v.sGoodsInfo.list[0].iQuantity + '</span></td>';
                    htmlTemp += '<td width="15%">' + v.sGoodsInfo.list[0].iGoodsPayAmount / 100 + '元</td>';
                    htmlTemp += "</tr>";
                });
                $('#ticketContent').html(htmlTemp);
                if (type == 1) {
                    //计算总页数
                    totalPage = Math.ceil(order_list.total / perNum);
                }
                $('.fanye').show();
            }
        }
    };
    var perNum = 8, page = 1, totalPage = 1;
    var ticketLog = "http://apps.game.qq.com/cgi-bin/daoju/v3/api/order/order_list.cgi?status=100&_biz_code=mgc&_app_id=1004&_output_fmt=2&_cs=1&ps=" + perNum;
    $('#buyTickeTime').change(function() {
        page = 1;
        var buyTicketTime = $(this).val();
        if (buyTicketTime == 0) {//1月内
            ticketLogTemp = ticketLog + "&pn=" + page;
        } else if (buyTicketTime == 1) {//1月前
            ticketLogTemp = ticketLog + "&hist=1&pn=" + page;
        }
        fn.loadjs(ticketLogTemp, function() {
            msg(1);
        }, 'gbk');
    });
    $('#buyTickePre').on('click', function() {
        var buyTicketTime = $('#buyTickeTime').val();
        if (page <= 1) {
            alert("当前已是第一页");
        } else {
            --page;
            if (buyTicketTime == 0) {//1月内
                ticketLogTemp = ticketLog + "&pn=" + page;
            } else if (buyTicketTime == 1) {//1月前
                ticketLogTemp = ticketLog + "&hist=1&pn=" + page;
            }
            fn.loadjs(ticketLogTemp, function() {
                msg();
            }, 'gbk');
        }
    });
    $('#buyTickeNex').on('click', function() {
        var buyTicketTime = $('#buyTickeTime').val();
        if (page >= totalPage) {
            alert("当前已是最后一页");
        } else {
            ++page;
            if (buyTicketTime == 0) {//1月内
                ticketLogTemp = ticketLog + "&pn=" + page;
            } else if (buyTicketTime == 1) {//1月前
                ticketLogTemp = ticketLog + "&hist=1&pn=" + page;
            }
            fn.loadjs(ticketLogTemp, function() {
                msg();
            }, gbk);
        }
    });

    var getTicketInit = function(ticketTimeObj) {
        page = 1;
        var buyTicketTime = $("#buyTickeTime").val();
        if (buyTicketTime == 0) {//1月内
            ticketLogTemp = ticketLog + "&pn=" + page;
        } else if (buyTicketTime == 1) {//1月前
            ticketLogTemp = ticketLog + "&hist=1&pn=" + page;
        }
        fn.loadjs(ticketLogTemp, function() {
            msg(1);
        }, 'gbk');
    };


    var tabNavBind = function(navId, con, tabType) {
        var allTab = $(navId).find(tabType);
        allTab.each(function(i) {
            $(this).off('click').on('click', function() {
                allTab.removeClass().eq(i).addClass("current");
                $(con).hide().eq(i).show();
                var tabTxt = $(this).find("a").html();
                if (tabTxt == "基本资料" || tabTxt == "关注的主播") {
                    personal_request.getMyInfo();
                }
                if (tabTxt == "我的票务") {
                    getTicketInit();
                }
            });
        });
    };

    //tabnav绑定事件
    tabNavBind('#side_nav', '.main', 'dd');

    return control;
});

