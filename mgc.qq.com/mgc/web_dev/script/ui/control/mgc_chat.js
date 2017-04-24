/**
 * Created by 77 on 2016/10/8.
 * 聊天区逻辑
 */
define(['mgc_consts', 'mgc_callcenter', 'mgc_tool', 'jquery', 'jqtmpl', 'js_scrollpane', 'mgc_tips', 'mgc_popmanager', 'mgc_account', 'mgc_comm'/*, 'mgc_bubble', 'mgc_getmember_info'*/], function (consts, callcenter, mgc_tool, $c, jqtmpl, jScrollPane, mgc_tips, mgc_popmanager, mgc_account, comm/*, bubble, memberInfo*/) {
    var filename = STATIC_RESOURCE.filename(window.location.href);
    var talkInfo = {};
    var MGCData = comm.mgcData;
    var MGC_Comm = comm.mgc_comm;
    var OpType = callcenter.OP_TYPE;
    var presentList = ['所有人', '私聊', '', '', '后援团'];
    var channelMsg;
    var systemInfo = false;
    var g_isSelf = false;

    var MGC_Response = function (callback_obj) {
        var _op_type = callback_obj.op_type;
        switch (parseInt(_op_type)) {
            case -100:
                $chat_response.initFinashedBoxCallback(callback_obj);
                break;
            case 224: //查询惊喜宝箱奖励
                $chat_response.getBoxGiftCallBack(callback_obj, true);
                break;
            case 225: //打开惊喜宝箱返回
                $chat_response.openBoxCallback(callback_obj);
                break;

            default:
                break;
        }
        callback_obj = null;
    };

    var $chat = {
        isChatLoadFinashed: false,
        isSupport: false,
        userSc: true,
        faceSc: true,
        wheelStop: true, //标识滚动条是否可移动
        /*聊天计数*/
        MsgChatNum: 0,
        def: true,

        refreshNotice: function (callback_obj) {
            var $notice = $c(".sr_chat .notice span");
            if ($notice.length > 0) {
                $notice.children().removeAll();
                $notice.html(callback_obj.data.intro);
            }
        },

        talkCallBack: function (callback_obj) {
            if (!$chat.isSupport && callback_obj.msg.channel == 4 && filename != "showroom.shtml") {
                $chat.ChatInit(true);
            }
            //主播经验效果
            if (callback_obj.msg.add_anchor_exp > 0) {
                MGC_Comm.addExpEffect(callback_obj.msg.add_anchor_exp);
            }
            $chat.PushTalk(callback_obj);
        },
        /**
        * 插入表情
        * @param {} id 输入框ID
        * @param {} txt 文本
        */
        isertFace: function (id, txt) {
            var input = document.getElementById(id);
            input.focus();
            $chat.onFouse(id);
            if (document.all) {
                var r = document.selection.createRange();
                document.selection.empty();
                r.text = txt;
                r.collapse();
                r.select();
            } else {
                var newstart = input.selectionStart + txt.length;
                input.value = input.value.substr(0, input.selectionStart) + txt + input.value.substr(input.selectionEnd);
                input.selectionStart = newstart;
                input.selectionEnd = newstart;
            }
        },
        /*
        * @function 初始化表情
        * @using 聊天区
        * @return void
        */
        facePackage: function () {
            var page = 0,
                ePage = 0,
                vip1Page = 0,
                vip2Page = 0,
                sendMsg = "",
                sc = true,
                sfAct = $c("#sc_face_act"),
                sfTab = $c("#sc_face_tab"),
                sc_face_vip1 = $c("#sc_face_vip1"),
                sc_face_vip2 = $c("#sc_face_vip2"),
                vip1Ban = sc_face_vip1.find(".sc_face_ban"),
                vip2Ban = sc_face_vip2.find(".sc_face_ban"),
                vip1Pre = sc_face_vip1.find(".sc_face_pre"),
                vip2Pre = sc_face_vip2.find(".sc_face_pre"),
                vip1Next = sc_face_vip1.find(".sc_face_next"),
                vip2Next = sc_face_vip2.find(".sc_face_next"),
                s_vip1_len = sc_face_vip1.find("ul").length,
                s_vip2_len = sc_face_vip2.find("ul").length,
                sfBan = sfAct.find(".sc_face_ban"),
                s_act_len = sfAct.find("ul").length,
                sfPre = sfAct.find(".sc_face_pre"),
                sfNext = sfAct.find(".sc_face_next"),
                sfExclusive = $c("#sc_face_exclusive"),
                seBan = sfExclusive.find(".sc_face_ban"),
                s_exc_len = sfExclusive.find("ul").length,
                sePre = sfExclusive.find(".sc_face_pre"),
                seNext = sfExclusive.find(".sc_face_next"),
                scBox = $c(".sc_box_btn"),
                scFace = $c(".sc_face"),
                scRole = $c(".sc_role"),
                scR = $c(".scr_r"),
                scrC = $c(".scr_c"),
                scRoleUl = $c(".sc_role_ul"),
                scRoleArr = scRoleUl.find("li"),
                SendMsgChatBox = $c("#SendMsgChatBox");
            sfAct.find("b").html(s_act_len);
            sfExclusive.find("b").html(s_exc_len);
            sc_face_vip1.find("b").html(s_vip1_len);
            sc_face_vip2.find("b").html(s_vip2_len);
            var picUrl = "http://ossweb-img.qq.com/images/mgc/css_img/chat/chat_",
            activeArrFace = ["f00.gif", "f01.gif", "f02.gif", "f03.gif", "f04.gif", "f05.gif", "f06.gif", "f07.gif", "f08.gif", "f09.gif", "f10.gif", "f11.gif", "f12.gif", "f13.gif", "f14.gif",
                             "f15.gif", "f16.gif", "f17.gif", "f18.gif", "f19.gif", "f20.gif", "f21.gif", "f22.gif", "f23.gif", "f24.gif", "f25.gif", "f26.gif", "f27.gif", "f28.gif", "f29.gif",
                             "f30.gif", "f31.gif", "f32.gif", "f33.gif", "f34.gif", "f35.gif", "f36.gif", "f37.gif", "f38.gif", "f39.gif", "f40.gif", "f41.gif", "f42.gif", "f43.gif", "f44.gif",
                             "f45.gif", "f46.gif", "f47.gif", "f48.gif", "f49.gif", "f50.gif", "f51.gif", "f52.gif", "f53.gif", "f54.gif", "f55.gif", "f56.gif", "f57.gif", "f58.gif", "f59.gif",
                             "f60.gif", "f61.gif", "f62.gif", "f63.gif", "f64.gif", "f65.gif", "f66.gif", "f67.gif", "f68.gif", "f69.gif", "f70.gif", "f71.gif", "f72.gif", "f73.gif", "f74.gif",
                             "f75.gif", "f76.gif", "f77.gif", "f78.gif", "f79.gif", "f80.gif", "f81.gif", "f82.gif", "f83.gif", "f84.gif", "f85.gif", "f86.gif", "f87.gif", "f88.gif", "f89.gif",
                             "f90.gif", "f91.gif", "f92.gif", "f93.gif", "f94.gif", "f95.gif", "f96.gif", "f97.gif", "f98.gif", "f99.gif", "g00.gif", "g01.gif", "g02.gif", "g03.gif", "g04.gif",
                             "g05.gif", "g06.gif", "g07.gif", "g08.gif", "g09.gif", "g10.gif", "g11.gif", "g12.gif", "g13.gif", "g14.gif", "g15.gif", "g16.gif", "g17.gif", "g18.gif", "g19.gif",
                             "g20.gif", "g21.gif", "g22.gif", "g23.gif", "g24.gif", "g25.gif", "g26.gif", "g27.gif", "g28.gif", "g29.gif", "g30.gif", "g31.gif", "g32.gif", "g33.gif", "g34.gif",
                             "g86.gif", "g87.gif", "g88.gif", "g89.gif", "g90.gif", "g91.gif", "g92.gif", "g93.gif", "g94.gif", "g95.gif", "g96.gif", "g97.gif", "g98.gif", "g99.gif", "h00.gif",
                             "h01.gif", "h02.gif", "h03.gif", "h04.gif", "h05.gif", "h06.gif"],
            guardArrFace = ["g76.gif", "g77.gif", "g78.gif", "g79.gif", "g80.gif", "g81.gif", "g82.gif", "g83.gif", "g84.gif", "g85.gif"];
            vipArrFace1 = ["h07.png?v=3_8_8_2016_15_4_final_3", "h08.png?v=3_8_8_2016_15_4_final_3", "h09.png?v=3_8_8_2016_15_4_final_3", "h10.png?v=3_8_8_2016_15_4_final_3", "h11.png?v=3_8_8_2016_15_4_final_3", "h12.png?v=3_8_8_2016_15_4_final_3", "h13.png?v=3_8_8_2016_15_4_final_3", "h14.png?v=3_8_8_2016_15_4_final_3", "h15.png?v=3_8_8_2016_15_4_final_3", "h16.png?v=3_8_8_2016_15_4_final_3"];
            vipArrFace2 = ["h17.png?v=3_8_8_2016_15_4_final_3", "h18.png?v=3_8_8_2016_15_4_final_3", "h19.png?v=3_8_8_2016_15_4_final_3", "h20.png?v=3_8_8_2016_15_4_final_3", "h21.png?v=3_8_8_2016_15_4_final_3", "h22.png?v=3_8_8_2016_15_4_final_3", "h23.png?v=3_8_8_2016_15_4_final_3", "h24.png?v=3_8_8_2016_15_4_final_3", "h25.png?v=3_8_8_2016_15_4_final_3", "h26.png?v=3_8_8_2016_15_4_final_3"];
            scBox.unbind("mouseover,mouseout").hover(function () {
                $c(this).addClass("btn-hover");
            }, function () {
                $c(this).removeClass("btn-hover btn-click");
            }).trigger("mouseout");
            //表情打开时，加载表情及事件
            scBox.click(function () {
                if ($c(this).hasClass("stopClick")) {
                    return;
                }
                if (sc == true) {
                    sc = false;
                    if (sfBan.find("li img").length == 0) {
                        setTimeout(function () {
                            sfBan.find("ul:eq(0) li").each(function (index) {
                                $c(this).html('<img src="' + picUrl + activeArrFace[index] + '" width="24" height="24" style="background:url(' + picUrl + activeArrFace[index] + ') no-repeat scroll center center">');
                            });
                        }, 1);
                    }
                }
                if ($chat.faceSc == true) {
                    faceShow();
                } else {
                    faceHide();
                }
            });
            SendMsgChatBox.bind('input propertychange', function () {
                sendMsg = SendMsgChatBox.val();
            });
            $c(".sc_face_ban").find("li").click(function () {
                faceHide();
                var faceCode = "/mgcchat_" + $c(this).attr("class");
                $chat.isertFace("SendMsgChatBox", faceCode);
            });
            scRoleArr.each(function () {
                $c(this).click(function () {
                    if ($chat.def == true) {
                        $chat.def = false;
                    } else {
                        $chat.def = true;
                    }
                    var thishtml = $c(this).html();
                    scrC.html(thishtml);
                });
            });
            //点击所有人按钮
            //MGC.faceSc容器关闭的时候其值必定是false,打开的时候必定是true
            scR.unbind("click").bind("click", function () {
                if ($chat.userSc == true) {
                    scShow();
                } else {
                    scHide();
                }
            });
            //点击所有人列表节点
            $c("#sc_role_out").delegate("li", "click", function () {
                scHide();
            });
            //区域判断
            var area = {
                addEvent: function (k, v) {
                    var me = this;
                    if (me.addEventListener)
                        me.addEventListener(k, v, false);
                    else if (me.attachEvent)
                        me.attachEvent("on" + k, v);
                    else
                        me["on" + k] = v;
                },
                removeEvent: function (k, v) {
                    var me = this;
                    if (me.removeEventListener)
                        me.removeEventListener(k, v, false);
                    else if (me.detachEvent)
                        me.detachEvent("on" + k, v);
                    else
                        me["on" + k] = null;
                },
                face: function (evt) {
                    evt = evt || window.event;
                    evt.stopPropagation ? evt.stopPropagation() : evt.cancelBubble = true;
                },
                role: function (evt1) {
                    evt1 = evt1 || window.event;
                    evt1.stopPropagation ? evt1.stopPropagation() : evt1.cancelBubble = true;
                }
            };
            document.getElementById('sc_role_out').onclick = area.role;
            document.getElementById("sc_face").onclick = area.face;
            function scShow() {//用户列表打开
                mgc_tool.controlCon('sc_role_out', true);
                $chat.userSc = false;
                try {
                    area.removeEvent.call(document, 'click', scHide);
                }
                catch (err) {

                }
                setTimeout(function () { area.addEvent.call(document, 'click', scHide); }, 1);
                $chat.GetPrivateMsgChatList();
            }
            function scHide() {//用户列表关闭
                mgc_tool.controlCon('sc_role_out', false);
                area.removeEvent.call(document, 'click', scHide);
                $chat.userSc = true;
                // $c('#GetPrivateMsgChatListBtn').attr("onclick", "$chat.GetPrivateMsgChatList();");
                $c('#GetPrivateMsgChatListBtn').attr("isClick", "false");
            }
            function faceShow() {//表情包打开
                mgc_tool.controlCon('sc_face', true);
                $chat.faceSc = false;
                try {
                    area.removeEvent.call(document, 'click', faceHide);
                }
                catch (err) {

                }
                setTimeout(function () { area.addEvent.call(document, 'click', faceHide); }, 1);
            }
            function faceHide() {//表情包关闭
                mgc_tool.controlCon('sc_face', false);
                $chat.faceSc = true;
                area.removeEvent.call(document, 'click', faceHide);
            }
            if (filename != "caveolaeroom.shtml" && filename != "nest.shtml") {
                sfTab.find(".face_3,.face_4").remove();
            }
            if (filename == "showroom.shtml") {
                sfTab.find(".face_2").remove();
            }
            //表情标签切换
            sfTab.find("a").each(function (index) {
                $c(this).click(function () {
                    sfTab.find("a").removeClass().eq(index).addClass("current");
                    $c(".sc_face_con").hide().eq(index).show();
                    var _ban_obj = $c(".sc_face_con").eq(index).find("ul").eq(0);
                    var arrFace = index == 0 ? activeArrFace : index == 1 ? guardArrFace : index == 2 ? vipArrFace1 : vipArrFace2;
                    if (_ban_obj.find("li img").length == 0) {
                        _ban_obj.find("li").each(function (index) {
                            $c(this).html('<img src="' + picUrl + arrFace[index] + '" width="24" height="24" style="background:url(' + picUrl + arrFace[index] + ') no-repeat scroll center center">');
                        });
                    }
                });
            });
            //表情翻页
            faceCon(sfPre, sfNext, page, sfBan, sfAct, s_act_len, activeArrFace);
            faceCon(sePre, seNext, ePage, seBan, sfExclusive, s_exc_len, guardArrFace);
            faceCon(vip1Pre, vip1Next, vip1Page, vip1Ban, sc_face_vip1, s_vip1_len, vipArrFace1);
            faceCon(vip2Pre, vip2Next, vip2Page, vip2Ban, sc_face_vip2, s_vip2_len, vipArrFace2);
            function faceCon(pre, next, page, ban, actItem, len, arrFace) {
                if (page == 0) {
                    pre.attr('class', 'sc_face_pre_end');
                }
                if (len == 1) {
                    next.attr('class', 'sc_face_next_end');
                }
                pre.click(function () {
                    pre.attr('class', 'sc_face_pre');
                    page--;
                    if (page >= 0) {
                        next.attr('class', 'sc_face_next');
                        ban.animate({ "left": -285 * page });
                        actItem.find("span").html(page + 1);
                        if (page == 0) {
                            pre.attr('class', 'sc_face_pre_end');
                        }
                    } else {
                        page = 0;
                        pre.attr('class', 'sc_face_pre_end');
                    }
                });
                next.click(function () {
                    next.attr('class', 'sc_face_next');
                    page++;
                    if (page < len) {
                        pre.attr('class', 'sc_face_pre');
                        ban.animate({ "left": -285 * page });
                        actItem.find("span").html(page + 1);
                        if (page == len - 1) {
                            next.attr('class', 'sc_face_next_end');
                        }
                        if (ban.find("ul").eq(page).find("li img").length == 0) {
                            var _sum = ban.find("ul").eq(0).find("li").length * page;
                            ban.find("ul").eq(page).find("li").each(function (index) {
                                $c(this).html('<img src="' + picUrl + arrFace[_sum + index] + '" width="24" height="24" style="background:url(' + picUrl + arrFace[_sum + index] + ') no-repeat scroll center center">');
                            });
                        }
                    } else {
                        page = len - 1;
                        next.attr('class', 'sc_face_next_end');
                    }
                });
            }
            (function ($) {//获取光标
                $.fn.extend({
                    getInputInfo: function (element) {
                        var win = window
                          , doc = win.document
                          , res = {
                              text: "",
                              start: 0,
                              end: 0
                          }
                          , element = $(element).get(0);
                        if (!element.value)
                            return res;
                        try {
                            if (win.getSelection)
                                res.start = element.selectionStart,
                                res.end = element.selectionEnd,
                                res.text = element.value.slice(res.start, res.end);
                            else if (doc.selection) {
                                element.focus();
                                var range = doc.selection.createRange(), range2 = doc.body.createTextRange(), tmpLength;
                                res.text = range.text;
                                try {
                                    range2.moveToElementText(element),
                                    range2.setEndPoint("StartToStart", range)
                                } catch (e) {
                                    range2 = element.createTextRange(),
                                    range2.setEndPoint("StartToStart", range)
                                }
                                res.start = element.value.length - range2.text.length,
                                res.end = res.start + range.text.length
                            }
                        } catch (e) { }
                        return res
                    },
                    insertEmoticon: function (tag, callback) {
                        var me = this
                            , inputBox = this;
                        inputBox.triggerHandler("focus");
                        var val = inputBox.val()
                          , inputInfo = me.getInputInfo(inputBox)
                          , end = inputInfo.start + tag.length;
                        console.log(inputBox + ":" + tag + ":" + val.substr(0, inputInfo.start) + ":" + val.substr(inputInfo.end));
                        inputBox.val(val.substr(0, inputInfo.start) + tag + val.substr(inputInfo.end));
                        try {
                            if (inputBox[0].createTextRange) {
                                var range = inputBox[0].createTextRange();
                                range.collapse(!0),
                                range.moveStart("character", end),
                                range.select()
                            } else
                                inputBox[0].setSelectionRange && (typeof this.options.isInputFocus == "undefined" || this.options.isInputFocus) && (inputBox[0].setSelectionRange(end, end),
                                inputBox[0].focus())
                        } catch (e) { }
                        $.isFunction(callback) && callback(tag)
                    }
                });
            })($c);
        },
        onFouse: function (id) {
            var thisItem = $c("#" + id), thistxt = thisItem.val();
            thisItem.css("background-position", "-200px 2px");
        },
        onblur: function (id) {
            var thisItem = $c("#" + id), thistxt = thisItem.val();
            if (thisItem.val() == "") {
                thisItem.css("background-position", "0 2px");
            }
        },
        /*
        * @function 初始化发言按钮
        * @using 聊天区
        * @return void
        */

        SendMsgChatInit: function () {
            isChatLoadFinashed = true;
            _sendTime = true;
            _MsgChannel = 0;
            _receiverId = 0;
            _receiverName = "";
            _receiverZoneName = "";

            // 所有人选框移入效果
            $c(".sc_role").unbind("mouseover,mouseout").hover(function () {
                $c(this).addClass("hover-btn");
            }, function () {
                $c(this).removeClass("hover-btn");
            }).trigger("mouseout");

            //最近私聊列表按钮点击
            $c("#GetPrivateMsgChatListBtn").unbind("click").bind("click", function (e) {
                if ($c(this).attr("clicked") == "true") {
                    $chat.ClosePrivateMsgList();
                } else {
                    $chat.GetPrivateMsgChatList();
                }

            });
            var val = "点击发弹幕"; //当前为聊天模式

            var xpos;

            // 聊天区回车发送消息
            $c('#SendMsgChatBox').unbind("keydown").bind("keydown", function (event) {
                if (event.keyCode == 13) {
                    //兼容qgame大厅下，部分按键个keydown事件会执行多次
                    if (_sendTime) {
                        _sendTime = false;
                        setTimeout(function () { _sendTime = true; }, 1);
                    } else {
                        return;
                    }
                    if (_MsgChannel == 0) {
                        mgc_tool.tabCut('sc_tab', 'sc_con', 0);
                    } else if (_MsgChannel == 1) {
                        if ($chat.$o.PrivateMsgChatContainer.css("display") == "block") {
                            $chat.isPaneFixed[1] = false;
                            systemInfo = false;
                        }
                    } else if (_MsgChannel == 4) {
                        if ($chat.$o.FansGuildMsgChatContainer.css("display") == "block") {
                            $chat.isPaneFixed[2] = false;
                            systemInfo = false;
                        }
                    }
                    if ($chat.$o.AllMsgChatContainer.css("display") == "block") {
                        $chat.isPaneFixed[0] = false;
                        systemInfo = false;
                    }
                    $chat.SendMsgChat(false);
                }
            });
            // 聊天框和发言按钮事件绑定
            $c('#SendMsgChatBtn').unbind("click").click(function () {
                if (_MsgChannel == 0) {
                    mgc_tool.tabCut('sc_tab', 'sc_con', 0);
                } else if (_MsgChannel == 1) {
                    if ($chat.$o.PrivateMsgChatContainer.css("display") == "block") {
                        $chat.isPaneFixed[1] = false;
                        systemInfo = false;
                    }
                } else if (_MsgChannel == 4) {
                    if ($chat.$o.FansGuildMsgChatContainer.css("display") == "block") {
                        $chat.isPaneFixed[2] = false;
                        systemInfo = false;
                    }
                }
                if ($chat.$o.AllMsgChatContainer.css("display") == "block") {
                    $chat.isPaneFixed[0] = false;
                    systemInfo = false;
                }
                $chat.SendMsgChat(true);
            });
            $c('#SendMsgChatBtn').unbind("mouseover,mouseout").hover(function () {
                $c(this).addClass("btn-hover");
            }, function () {
                $c(this).removeClass("btn-hover btn-click");
            }).trigger("mouseout");

            $c('#SendMsgChatBox').off('focus').on('focus', function (e) {
                $chat.onFouse('SendMsgChatBox');
            });
            $c('#SendMsgChatBox').off('blur').on('blur', function (e) {
                $chat.onblur('SendMsgChatBox');
            });
            //聊天框的弹出框
            $c('#AllMsgChatContainer,#PrivateMsgChatContainer,#FansGuildMsgChatContainer').off('click').on('click', '.talkPlayer', function () {
                inv_from = 2;
                card_source = 6;
                var _name = $c(this).attr('data-name');
                var _area = $c(this).attr('data-area');
                //请求玩家信息，此处调用成员操作列表
                MGC_CommRequest.getPlayerInfo(_name, _area);
                //注：  此处event为引类型，在传递过程中event改变,赋值变量随即改变，因此此处要复制一个event对象指向不同的地址。 兼容ie
                mgc.common_contral.mgc_comm.eventInfo = mgc_tool.offsetEvent.getEvent();
            });
            MGC_Response({ op_type: -100 });
            if (window.location.href.indexOf("nest.shtml") >= 0) {
                //鼠标滑过显示公告
                var hasLeave = true;
                $c(".sr_chat .noticeHot,.sr_chat .notice").hover(function () {
                    $chat.showNotice(true, false);
                    hasLeave = false;
                }, function () {
                    $chat.showNotice(false, false);
                    hasLeave = true;
                });
                //公告tip
                $c(".sr_chat .notice .btnTip").off().mouseover(function () {
                    $c(".sr_chat .notice .tipsShow").show();
                }).mouseout(function () {
                    $c(".sr_chat .notice .tipsShow").hide();
                });
                //显示公告
                this.showNotice(true);
            }
        },
        /**
        * 后援团初始化回调
        */
        FansGuildInit: function (obj) {
            console.log("获取玩家是否是后援团：" + JSON.stringify(obj));
            //getPlayerInfoCallBack 会用到该变量
            canInvite = obj.canInvite;
            //后援团初始化
            if (obj.vgid != 0) {
                $chat.ChatInit(true);
            }
        },
        /*
        *初始化聊天组件
        */
        ChatInit: function (isSupport) {
            this.isSupport = isSupport;
            if (MGC_Comm.CheckGuestStatus(true) || filename == "showroom.shtml" || !isSupport) {
                //如果是游客 or 演唱会房间 or 当前玩家没有后援团  不显示后援团聊天功能
                //未判断当前玩家是否有后援团  @todo 
                if (filename == "nest.shtml") {
                    $c("#sc_tab").find("li").css({ "width": "160px" });
                    $c("#sc_tab #AllMsgChatBtn").removeClass().addClass("bigTab current");
                    $c("#sc_tab #PrivateMsgChatBtn").removeClass().addClass("bigTab");
                    $c("#sc_tab #FansGuildMsgChatBtn").removeClass().addClass("bigTab");
                } else {
                    $c("#sc_tab").find("li").css({ "width": "160px", "margin-right": "1px" }).find("a").css("background-position-x", "-261px");
                    $c("#sc_tab").find("li").eq(0).css({ "width": "160px" });
                    $c("#sc_tab").find("li").eq(1).css({ "margin-right": "0" });
                    if ($c("#sc_tab").find(".current").html() == "后援团") {
                        mgc_tool.tabCut('sc_tab', 'sc_con', 0);
                    }
                }
                $c("#FansGuildMsgChatBtn").parent().hide();
                $c(".sc_role_ul").height("auto").find("li").eq(0).hide();
            } else {
                if (filename == "nest.shtml") {
                    $c("#sc_tab").find("li").css({ "width": "105px", "margin-right": "1px" });
                    $c("#sc_tab #AllMsgChatBtn").removeClass().addClass("smallTab current");
                    $c("#sc_tab #PrivateMsgChatBtn").removeClass().addClass("smallTab");
                    $c("#sc_tab #FansGuildMsgChatBtn").removeClass().addClass("smallTab");
                    $c("#sc_tab").find("li").eq(2).css({ "margin-right": "0" });
                    $c("#sc_tab").find("li").eq(0).css({ "width": "106px" });
                } else {
                    $c("#sc_tab").find("li").css({ "width": "106px", "margin-right": "1px" }).find("a").css("background-position-x", "-295px");
                    $c("#sc_tab").find("li").eq(2).css({ "margin-right": "0" });
                    $c("#sc_tab").find("li").eq(0).css({ "width": "107px" });
                }
                $c("#FansGuildMsgChatBtn").parent().show();
                $c(".sc_role_ul").height("auto").find("li").eq(0).show();
            }
        },
        isNotice: false,
        timeid: 0,
        /*
        * 是否显示公告
        * b true 显示
        * auto true 自动消失
        */
        showNotice: function (b, auto) {
            this.isNotice = b;

            //默认自动
            if (auto == null) {
                auto = true;
            };

            var $notice = $c(".sr_chat .notice");

            if (b) {
                clearTimeout($chat.timeid);
                if (auto) {
                    if (mgc.tools.checkH5()) {
                        $notice.stop().fadeIn(500, function () {
                            $chat.timeid = setTimeout("$chat.showNotice(false)", 3000);
                        });
                    } else {
                        $notice.show();
                        $chat.timeid = setTimeout("$chat.showNotice(false)", 3000);
                    }
                }
                else {
                    if (mgc.tools.checkH5()) {
                        $notice.stop().fadeIn(500);
                    } else {
                        $notice.show();
                    }
                }

            }
            else {
                //$chat.timeid = setTimeout(function() {
                if (mgc.tools.checkH5()) {
                    $notice.stop().fadeOut(500);
                } else {
                    $notice.hide();
                }
                //}, 100);
            }

        },
        /*
        * @function 最近私聊列表
        * @using 聊天区
        * @return void
        */
        GetPrivateMsgChatList: function () {
            callcenter.getPrivateMsgChatList($chat.GetPrivateMsgChatListCallBack);
            // $c('#GetPrivateMsgChatListBtn').attr("onclick", "$chat.ClosePrivateMsgList();");
            $c('#GetPrivateMsgChatListBtn').attr("clicked", "true");
            mgc_tool.controlCon('sc_role_out', true);
        },
        /*
        * @function 关闭聊天选择框
        * @using 聊天区
        * @return void
        */
        ClosePrivateMsgList: function () {
            mgc_tool.controlCon('sc_role_out', false);
            // $c('#GetPrivateMsgChatListBtn').attr("onclick", "$chat.GetPrivateMsgChatList();");
            $c('#GetPrivateMsgChatListBtn').attr("clicked", "false");
        },
        /*
        * @function 获取最近私聊列表回调
        * @using 聊天区
        * @return void
        */
        GetPrivateMsgChatListCallBack: function (obj) {
            obj = MGC_Comm.strToJson(obj);
            console.log(obj);
            PrivateMsgChatList = obj.data;
            var MsgChatObjectCon = $c('#MsgChatObjectTmpl');
            var MsgChatObjectTmpl;
            var MsgChatObjectContainer = $c('#MsgChatObjectContainer').find('.jspPane');
            MsgChatObjectTmpl = MsgChatObjectCon.render(PrivateMsgChatList);
            MsgChatObjectContainer.html(MsgChatObjectTmpl);
            MsgChatObjectContainer.find("li").unbind("click").bind("click", function () {
                $chat.PreSendMsgChat(1, this);
            });
            if (obj.data.length > 3) {
                $c(".sc_role_out .jspContainer").css("cssText", "position:relative !important");
                //重绘滚动条 
                var scrollAPI_privatemsgchatlist = $c('#MsgChatObjectContainer').data('jsp');
                scrollAPI_privatemsgchatlist.initScroll(true);
            }
            MsgChatObjectTmpl = null;
            MsgChatObjectCon = null;
        },
        /*
        * @function 聊天、飞屏
        * @using 聊天区
        * @return void
        */
        SendMsgChat: function (isClick) {
            if (MGC_Comm.CheckGuestStatus()) {
                console.log("屏蔽游客操作：聊天、飞屏");
                return false; //游客身份下，屏蔽此操作
            }
            var MsgChat = $c('#SendMsgChatBox').val();
            var CheckFlag = $chat.ChenckMsgChat(MsgChat);
            if (CheckFlag) {
                if (MsgChat == "") {
                    MsgChat = consts.secretOrderInfo;
                }
                callcenter.sendChatMsg(_MsgChannel, _receiverId, _receiverName, _receiverZoneName, MsgChat, $chat.SendMsgChatCallBack);
                //清空聊天框
                $c('#defaultDes').val($c('#defaultDes').data("value") || "");
                $c('#SendMsgChatBox').val("");
                if (isClick) {
                    $c('#SendMsgChatBox').blur();
                }
            };
        },
        // 聊天信息转换
        MsgToStr: function (chatnods, channel) {
            var MsgStr = "";
            var suffix = "";
            $c.each(chatnods, function (k, v) {
                if (v.content.indexOf('[后援]') == 0) {
                    var backStr = v.content.substr(4);
                    if (backStr.indexOf('[梦工厂]') < 0) {
                        var insertPos = backStr.indexOf('[');
                        if (insertPos >= 0) {
                            v.content = '[后援]' + backStr.substr(0, insertPos + 1) + '炫舞-' + backStr.substr(insertPos + 1);
                        }
                    }
                }
                if (v.nodeType == 0) {
                    MsgStr += v.content;
                } else if (v.nodeType == 1) {
                    var _count = parseInt(v.content.substring(1), 10);
                    suffix = (v.content.indexOf('h') == 0 && _count >= 7 && _count <= 26) ? ".png" : ".gif";
                    if (channel == 2) {
                        v.content = mgc_tool.MsgImgPath + "chat_" + v.content + suffix;
                    } else {
                        MsgStr += "<img src='" + mgc_tool.MsgImgPath + "chat_" + v.content + suffix + "' width='20' height='20' alt='' >";
                    }
                }
            });
            chatnods = null;
            return MsgStr;
        },
        // 聊天、飞屏、用户输入请求
        ChenckMsgChat: function (Str) {
            if (!Str) {
                alert("请输入聊天内容!");
                return false;
            };
            return true;
        },
        // 选择聊天对象
        PreSendMsgChat: function (MsgChannel, obj, IsFirst) {
            _MsgChannel = MsgChannel;
            if (obj) {
                if ($c("#cardTipContainer").css('display') == 'none') {
                    _receiverName = $c.trim($c(obj).attr("receivername"));
                } else {
                    _receiverName = $c.trim($c("#cardTipContainer .name_info .ni_nick").html());
                }
                _receiverId = $c(obj).attr("receiverId") || "";
                _receiverZoneName = $c(obj).attr("receiverZoneName") || "";
                _receiverPlayerType = $c(obj).attr("receiverPlayerType") || "";
            } else {
                _receiverId = 0;
                _receiverName = "";
                _receiverZoneName = "";
                _receiverPlayerType = "";
            }
            //选择的时候 更新当前的选择
            if (_receiverName == "") {
                _receiverName = presentList[MsgChannel];
            }
            $c('#SendMsgChatObject').html(_receiverName);
            if (IsFirst) {
                var MsgChatObject = {};
                MsgChatObject.name = _receiverName;
                MsgChatObject.receiverId = _receiverId;
                MsgChatObject.zonename = _receiverZoneName;
                MsgChatObject.receiverPlayerType = _receiverPlayerType;
                var MsgChatObjectCon = $c('#MsgChatObjectTmpl');
                var MsgChatObjectTmpl;
                var MsgChatObjectContainer = $c('#MsgChatObjectContainer').find('.jspPane');
                MsgChatObjectTmpl = MsgChatObjectCon.tmpl(MsgChatObject);
                MsgChatObjectContainer.append(MsgChatObjectTmpl);
                MsgChatObjectContainer.find("li").unbind("click").bind("click", function () {
                    $chat.PreSendMsgChat(1, this);
                });
                MsgChatObjectTmpl = null;
                MsgChatObjectCon = null;
            };
            $chat.ClosePrivateMsgList();
        },
        SendMsgChatCallBack: function (obj) {
            obj = MGC_Comm.strToJson(obj);
            var SendResult = parseInt(obj.result.result, 10);
            if (SendResult > 0 && SendResult <= 17) {
                var ErrCode = ['禁止公众频道聊天', '聊天cd中', '私聊找不到目标玩家', '直播中才可以发飞屏', '单房间阈值达到，悄悄地丢弃', '禁言状态不能使用飞屏', '免费飞屏已经用尽', '不在比赛中，不能发送免费飞屏，主播端使用', '失败', '被禁言', '永久禁言', '没有炫贝', '公屏聊天cd时间未到', '禁言状态不能使用超新星喇叭', '被腾讯的消息过滤系统禁止', '被全房间禁言'];
                //alert(ErrCode[parseInt(SendResult - 1, 10)]);
            };
        },
        clearChatInfo: function () {
            if ($chat.$o.AllMsgChatContainer.css("display") == "block") {
                $chat.isPause = true;
                $chat.newMsg = 0;
            } else if ($chat.$o.PrivateMsgChatContainer.css("display") == "block") {
                $chat.privateIsPause = true;
                $chat.privateNewMsg = 0;
            } else if ($chat.$o.FansGuildMsgChatContainer.css("display") == "block") {
                $chat.helpIsPause = true;
                $chat.helpNewMsg = 0;
            }
            $chat.isScrollBtmFlag = false;
            $chat.isScrollBtm();
        },
        // 判断滚动条是否置底了
        isScrollBtmFlag: false, //标识是否已经执行过一次置底操作了，若执行过一次，则不再执行；若滚动条悬停后，再重置
        scrollIsBottom: function () {
            var gl = $c('.sc_con .jspDrag');
            var glh = $c('.sc_con .jspTrack');
            if (gl.length > 0) {
                if (parseInt(gl.css("height")) + parseInt(gl.css("top")) == parseInt(glh.css("height"))) {
                    return true;
                }
            }
            return false;
        },
        isScrollBtm: function () {
            if ($chat.scrollIsBottom()) {
                if (!$chat.isScrollBtmFlag) {
                    $chat.isScrollBtmFlag = true;
                    var allMsg = $chat.$o.AllMsgChatContainer.find("li");
                    var privateMsg = $chat.$o.PrivateMsgChatContainer.find("li");
                    var helpMsg = $chat.$o.FansGuildMsgChatContainer.find("li");
                    var allMsgNum = allMsg.size();
                    var privateMsgNum = privateMsg.size();
                    var helpMsgNum = helpMsg.size();
                    if ($chat.$o.AllMsgChatContainer.css("display") == "block") {
                        if (channelMsg != 3) {
                            $chat.isPause = false;
                        }
                        $chat.newMsg = 0;
                        $chat.$o.AllMsgChatContainer.append($chat.newMsgArr.join(''));
                        $chat.newMsgArr = [];
                        allMsg = $chat.$o.AllMsgChatContainer.find("li");
                        allMsgNum = allMsg.size();
                        // 只要消息超出50条，就清除
                        $chat.removeMessage(allMsg, allMsgNum - $chat.msgnum);
                    } else if ($chat.$o.PrivateMsgChatContainer.css("display") == "block") {
                        $chat.privateIsPause = false;
                        $chat.privateNewMsg = 0;
                        $chat.$o.PrivateMsgChatContainer.append($chat.privateNewMsgArr.join(''));
                        $chat.privateNewMsgArr = [];
                        privateMsg = $chat.$o.PrivateMsgChatContainer.find("li");
                        privateMsgNum = privateMsg.size();
                        $chat.removeMessage(privateMsgNum, privateMsgNum - $chat.msgnum);
                    } else if ($chat.$o.FansGuildMsgChatContainer.css("display") == "block") {
                        $chat.helpIsPause = false;
                        $chat.helpNewMsg = 0;
                        $chat.$o.FansGuildMsgChatContainer.append($chat.helpNewMsgArr.join(''));
                        $chat.helpNewMsgArr = [];
                        helpMsg = $chat.$o.FansGuildMsgChatContainer.find("li");
                        helpMsgNum = helpMsg.size();
                        $chat.removeMessage(helpMsg, helpMsgNum - $chat.msgnum);
                    }
                }
            } else {
                $chat.isScrollBtmFlag = false;
            }
        },

        /**
        * 滚动条置底
        * isTabClick [Bool] 传递值为 true, 标识切换标签，此时滚动条的重绘取决于 jspVerticalBar
        * 不传递值或者传递值为其他，标识滚动条置底
        */
        chatMessage: function (isTabClick) {
            //初始化滚动条
            if (!mgc.consts.API.scroll.chat)
                mgc.consts.API.scroll.chat = $c('.sc_con').data('jsp');
            //重绘滚动条
            // if (isTabClick && $c('.sc_con').find(".jspVerticalBar").length != 0){//如果是切换标签，滚动条不需要初始化

            // } else{
            mgc.consts.API.scroll.chat.initScroll(true);
            // }
            //滚动条置底
            var tabIndex = $c("#sc_tab").find("a.current").parent().index();
            if (!systemInfo && (!$chat.isPause || !$chat.privateIsPause || !$chat.helpIsPause)) {
                setTimeout(function () {
                    mgc.consts.API.scroll.chat.scrollBy(0, Number.POSITIVE_INFINITY);
                    $c("#sc_con .jspDrag").show();
                }, 1);
            }
        },
        chatMessageTimer: null,
        msgnum: 50,
        isPause: false, //公聊是否悬停
        privateIsPause: false, // 私聊是否悬停
        helpIsPause: false, // 后援团是否悬停
        newMsg: 0,  //公聊新进消息数量
        privateNewMsg: 0, //私聊新进消息数量
        helpNewMsg: 0, //后援团新进消息数量
        newMsgArr: [],
        privateNewMsgArr: [],
        helpNewMsgArr: [],
        testIsTrue: 0, //测试标示
        isPaneFixed: [false, false, false], //当前聊天层是否固定
        oneMsgHeight: 25, //一条单行系统消息的高度
        /*
        * DOM常量
        */
        $o: {
            AllMsgChatContainer: $c('#AllMsgChatContainer'),
            PrivateMsgChatContainer: $c('#PrivateMsgChatContainer'),
            FansGuildMsgChatContainer: $c('#FansGuildMsgChatContainer'),
            MsgChatCon: $c('#MsgChatTmpl'),
            GiftMessageCon: $c('#GiftMessageTmpl')
        },
        /*
        * 聊天消息队列
        */
        ChatMsgHtml: ["", "", ""],
        //聊天
        PushTalk: function (obj) {
            var MsgStrObj = {},
                MsgChannel = obj.msg.channel; //0：公屏 1：发给我的 2：我给别人的 4:后援团
            if ((mgc_tool.is_show_room() || !$chat.isSupport) && MsgChannel == 4) {
                return; //演唱会不接受后援团的消息
            }
            MsgStrObj.MsgStr = $chat.MsgToStr(obj.chatnodes, MsgChannel);
            MsgStrObj.senderName = obj.msg.senderName;
            MsgStrObj.senderZoneName = obj.msg.senderZoneName;
            MsgStrObj.receiverName = obj.msg.receiverName;
            MsgStrObj.receiverZoneName = obj.msg.receiverZoneName;
            MsgStrObj.viplevel = obj.msg.viplevel;
            MsgStrObj.senderPlayerType = obj.msg.m_senderPlayerType;
            MsgStrObj.receiverPlayerType = obj.msg.receiverPlayerType;
            MsgStrObj.senderdefend = obj.msg.sender_defend;
            MsgStrObj.guardName = consts.guardLevelTab[obj.msg.sender_defend];
            MsgStrObj.channel = obj.msg.channel;
            MsgStrObj.systemType = obj.msg.systemType;
            MsgStrObj.vipCardPattern = obj.msg.vipCardPattern;
            MsgStrObj.flag = obj.msg.flag;
            MsgStrObj.sender_jacket = obj.msg.sender_jacket;
            MsgStrObj.targetGuardLevel = obj.msg.targetGuardLevel;
            MsgStrObj.wealth_level = obj.msg.wealth_level;
            MsgStrObj.anchor_level = 0;
            MsgStrObj.is_vip_with_anchor = obj.msg.is_vip_with_anchor;
            MsgStrObj.senderPlayerID = obj.msg.senderPlayerID;
            MsgStrObj.receiverPlayerID = obj.msg.receiverPlayerID;
            // // 系统消息 3 个标识:禁言 2 个标识，入房提醒 1 个标识
            // if(MsgStrObj.channel == 3){
            //     if(MsgStrObj.systemType == 1){
            //         // 是否是移动端管理员,需要换成服务器字段  obj.msg.sender_is_mobile_manager
            //         MsgStrObj.senderIsMobileManager = true;
            //         // 被禁言/取消禁言者 是否是移动端管理员,需要换成服务器字段  obj.msg.receiver_is_mobile_manager
            //         MsgStrObj.receiverIsMobileManager = true;
            //     } else if(MsgStrObj.systemType == 2){
            //         MsgStrObj.isMobileManager = true;
            //     }
            // } else{
            //     // 非系统消息 一个标识即可
            //     MsgStrObj.isMobileManager = true;
            // }

            // if(MsgStrObj.receiverIsMobileManager && window.forbidden) return;
            // 禁言/取消禁言的系统消息提示
            if (MsgStrObj.channel == 3) {
                if (MsgStrObj.systemType == 1) {
                    MsgStrObj.senderIsMobileManager = mgc_tool.judgeIfUserAdmin(allUserAdmins, MsgStrObj.senderPlayerID);
                }
            }
            MsgStrObj.isMobileManager = mgc_tool.judgeIfUserAdmin(allUserAdmins, MsgStrObj.senderPlayerID);

            if (obj.msg.systemType == 1) {
                MsgStrObj.systemType = obj.msg.systemType;
                MsgStrObj.targetVipLevel = obj.msg.targetVipLevel;
                MsgStrObj.targetGuardIcon = obj.msg.targetGuardLevel;
                var jy = "",
                    adminStr = "";
                if (obj.msg.perpetual) {
                    jy = "永久";
                };
                if (MsgStrObj.senderPlayerType == 1) {
                    adminStr = "被房间管理员";
                };
                if (obj.msg.ban) {
                    MsgStrObj.jy = adminStr + jy + "禁言";
                } else {
                    MsgStrObj.jy = "的" + jy + "禁言" + adminStr + "解除";
                };
            }
            if (obj.msg.senderPlayerID != "-1") {
                g_isSelf = obj.isSelf;
                channelMsg = MsgChannel;
                if (channelMsg == 3) {
                    systemInfo = true;
                } else {
                    systemInfo = false;
                }
            }
            $chat.isScrollBtm();
            if (MsgChannel != 2 && obj.msg.senderPlayerID != "-1") {
                $chat.MsgChatNum++;
                MsgStrObj.MsgChatNum = $chat.MsgChatNum;
            }
            MsgStrObj.isSelf = obj.msg.isSelf;
            if (obj.isSelf) {
                MsgStrObj.NickColor = "#a94c01";
            } else {
                MsgStrObj.NickColor = obj.msg.NickColor;
            }
            MsgStrObj.TextColor = obj.msg.TextColor;
            var date = new Date();
            var time = date.getTime();
            MsgStrObj.nowtime = MGC_Comm.DateToUnix(time);
            if (MsgStrObj.senderPlayerType == 0 || MsgStrObj.receiverPlayerType == 0) {
                MsgStrObj.anchor_level = MsgStrObj.wealth_level == 0 ? 0 : Math.floor(MsgStrObj.wealth_level / 10) + 1;
            }
            var isSelf = obj.isSelf;
            //包括送花全部聊天最多只保留50条聊天信息
            var allMsg = $chat.$o.AllMsgChatContainer.find("li");
            var privateMsg = $chat.$o.PrivateMsgChatContainer.find("li");
            var helpMsg = $chat.$o.FansGuildMsgChatContainer.find("li");
            allMsgNum = allMsg.size();
            privateMsgNum = privateMsg.size();
            helpMsgNum = helpMsg.size();

            // var MsgChatTmpl = ($chat.$o.MsgChatCon.tmpl(MsgStrObj))[0].outerHTML;
            var MsgChatTmpl = $chat.$o.MsgChatCon.render(MsgStrObj);

            // 飞屏不发送消息,除了飞屏以外的消息都要放到全部聊天框中
            if (obj.msg.senderPlayerID != "-1") {
                if (MsgChannel != 2) {
                    if ($chat.isPause) {
                        // 信息悬停,新进消息增加
                        $chat.newMsg++;
                        //悬停状态，超出50条的新消息存储在 newMsgArr
                        if (allMsgNum >= $chat.msgnum) {
                            $chat.newMsgArr.push(MsgChatTmpl);
                        } else {
                            $chat.ChatMsgHtml[0] += MsgChatTmpl;
                        }
                    } else {
                        $chat.ChatMsgHtml[0] += MsgChatTmpl;
                    }
                }
                if (MsgChannel == 1) {
                    if (MsgStrObj.isSelf != 2 && !$c("#PrivateMsgChatBtn").hasClass("current")) {
                        $c("#PrivateMsgChatBtn").next(".chatMsgTips").show();
                    }
                    if ($chat.privateIsPause) {
                        // 信息悬停,新进消息增加
                        $chat.privateNewMsg++;
                        if (privateMsgNum >= $chat.msgnum) {//悬停状态，超出50条的新消息存储在 privateNewMsg
                            $chat.privateNewMsgArr.push(MsgChatTmpl);
                        } else {
                            $chat.ChatMsgHtml[1] += MsgChatTmpl;

                        }
                    } else {
                        $chat.ChatMsgHtml[1] += MsgChatTmpl;
                    }
                } else if (MsgChannel == 2) {
                    FlyScreen = true;
                    MsgStrObj.isTakeVip = obj.msg.isTakeVip;
                    MsgStrObj.chatnodes = obj.chatnodes;
                    window.MGC_Comm.addFlyScreenMsg(MsgStrObj, true);
                } else if (MsgChannel == 3) {
                    if (MsgStrObj.systemType == 3) {
                        $chat.ChatMsgHtml[1] += MsgChatTmpl;
                    };
                } else if (MsgChannel == 4) {
                    if (!$c("#FansGuildMsgChatBtn").hasClass("current") && !obj.isSelf) {
                        $c("#FansGuildMsgChatBtn").next(".chatMsgTips").show();
                    }
                    if ($chat.helpIsPause) {
                        // 信息悬停,新进消息增加
                        $chat.helpNewMsg++;
                        if (helpMsgNum >= $chat.msgnum) { //悬停状态，超出50条的新消息存储在 helpNewMsgArr
                            $chat.helpNewMsgArr.push(MsgChatTmpl);
                        } else {
                            $chat.ChatMsgHtml[2] += MsgChatTmpl;
                        }
                    } else {

                        $chat.ChatMsgHtml[2] += MsgChatTmpl;
                    }
                }
                obj = null;
                MsgStrObj = null;
                return;
            } else {
                if ($chat.ChatMsgHtml[0] != "") {
                    $chat.$o.AllMsgChatContainer.append($chat.ChatMsgHtml[0]);
                    $chat.ChatMsgHtml[0] = "";
                }
                if ($chat.ChatMsgHtml[1] != "") {
                    $chat.$o.PrivateMsgChatContainer.append($chat.ChatMsgHtml[1]);
                    $chat.ChatMsgHtml[1] = "";
                }
                if ($chat.ChatMsgHtml[2] != "") {
                    $chat.$o.FansGuildMsgChatContainer.append($chat.ChatMsgHtml[2]);
                    $chat.ChatMsgHtml[2] = "";
                }
            }
            // 信息悬停
            // 新进消息超过50条 或 本用户发送消息,新进信息放入对应的容器中,信息不悬停
            if ($chat.newMsgArr.length > 0 && ($chat.newMsg >= $chat.msgnum)) {
                $chat.isPause = false;
                $chat.$o.AllMsgChatContainer.append($chat.newMsgArr.join(''));
                $chat.newMsgArr = [];
            }
            if ($chat.privateNewMsgArr.length > 0 && ($chat.privateNewMsg >= $chat.msgnum)) {
                $chat.privateIsPause = false;
                $chat.$o.PrivateMsgChatContainer.append($chat.privateNewMsgArr.join(''));
                $chat.privateNewMsgArr = [];
            }
            if ($chat.helpNewMsgArr.length > 0 && ($chat.helpNewMsg >= $chat.msgnum)) {
                $chat.helpIsPause = false;
                $chat.$o.FansGuildMsgChatContainer.append($chat.helpNewMsgArr.join(''));
                $chat.helpNewMsgArr = [];
            }
            allMsg = $chat.$o.AllMsgChatContainer.find("li");
            privateMsg = $chat.$o.PrivateMsgChatContainer.find("li");
            helpMsg = $chat.$o.FansGuildMsgChatContainer.find("li");
            allMsgNum = allMsg.size();
            privateMsgNum = privateMsg.size();
            helpMsgNum = helpMsg.size();
            //这里是清除逻辑
            if ($chat.wheelStop && !$chat.isPause || g_isSelf) {
                if ($chat.$o.AllMsgChatContainer.css("display") == "block") {
                    $chat.chatMessage();
                    $chat.newMsg = 0;
                }
                $chat.removeMessage(allMsg, allMsgNum - $chat.msgnum);
            }
            if ($chat.wheelStop && !$chat.privateIsPause || g_isSelf) {
                if ($chat.$o.PrivateMsgChatContainer.css("display") == "block") {
                    $chat.chatMessage();
                    $chat.privateNewMsg = 0;
                }
                $chat.removeMessage(privateMsg, privateMsgNum - $chat.msgnum);
            }
            if ($chat.wheelStop && !$chat.helpIsPause || g_isSelf) {
                if ($chat.$o.FansGuildMsgChatContainer.css("display") == "block") {
                    $chat.chatMessage();
                    $chat.helpNewMsg = 0;
                }
                $chat.removeMessage(helpMsg, helpMsgNum - $chat.msgnum);
            }
            //聊天滚动层固定逻辑
            var tabIndex = $c("#sc_tab").find("a.current").parent().index();
            if (!$chat.isPaneFixed[tabIndex]) {
                var num = tabIndex == 0 ? allMsgNum : tabIndex == 1 ? privateMsgNum : helpMsgNum;
                if ((num - $chat.msgnum) >= 0) {
                    $c("#sc_con").find(".jspPane").removeClass("height-auto").height($chat.msgnum * $chat.oneMsgHeight);
                    $c("#sc_con").find(".jspPane ul").eq(tabIndex).css({ 'position': 'absolute', 'bottom': '0px' });
                    $chat.isPaneFixed[tabIndex] = true;
                    //首次固定滚动层高度时，重绘一次滚动条
                    mgc.consts.API.scroll.chat.initScroll(true);
                }
            }
            //重绘滚动条
            if (!mgc.consts.API.scroll.chat)
                mgc.consts.API.scroll.chat = $c('.sc_con').data('jsp');
            if (!$chat.isPaneFixed[tabIndex]) {
                mgc.consts.API.scroll.chat.initScroll(true);
            }
            allMsg = null;
            privateMsg = null;
            helpMsg = null;
            obj = null;
            MsgStrObj = null;
            MsgChatTmpl = null;
        },
        // 判断是否是禁言消息 输入超过上限的消息
        checkIsBubble: function (channel, msg) {
            if (channel == 3) {
                if (msg == "对不起，您输入的字符超过限制!您最多只能一次输入31个中文或63个英文字符") {
                    return true;
                } else if (msg == "对不起，您暂时被管理员禁止发言") {
                    return true;
                }
            }
            return false;
        },
        hideChatMsgTips: function (id) {
            $c("#" + id).next(".chatMsgTips").hide();
        },
        //屏蔽免费礼物
        maskGifts: function () {
            var mask_gifts = $c(".mask-gifts");
            var mask_gifts_tips = $c(".mask-gifts-tips");
            var checked = 0;
            mask_gifts.unbind("click").click(function () {
                if (!isChatLoadFinashed) {
                    return false;
                }
                if (MGC_Comm.CheckGuestStatus()) {
                    console.log("屏蔽游客操作：聊天、飞屏");
                    return false; //游客身份下，屏蔽此操作
                }
                checked = 1 - parseInt($c(this).data("checked"), 10);
                if (checked) {
                    mask_gifts_tips.html("取消勾选显示免费礼物信息");
                } else {
                    mask_gifts_tips.html("勾选后屏蔽免费礼物信息");
                }
                $c(this).data("checked", checked.toString()).find("span").removeClass().addClass("icon-checkbox-" + checked);
                var isIgnore = !!checked;
                callcenter.ignoreFreeGiftInfo(isIgnore, $chat.hideFreeGiftCallBack);
            }).off("mouseover,mouseout").on("mouseover", function () {
                if (parseInt($c(this).data("checked"), 10)) {
                    mask_gifts_tips.html("取消勾选显示免费礼物信息");
                } else {
                    mask_gifts_tips.html("勾选后屏蔽免费礼物信息");
                }
                mask_gifts_tips.show();
            }).on("mouseout", function () {
                mask_gifts_tips.hide();
            }).removeClass('mask-gifts-un');
        },
        unMaskGifts: function () {
            var mask_gifts = $c(".mask-gifts");
            mask_gifts.unbind("click").unbind("mouseenter").unbind("mouseleave").addClass('mask-gifts-un');
        },
        hideFreeGiftCallBack: function (obj) {
            if (obj.ret == 1) {
                MGC_Comm.CommonDialog({ "Title": "提示", "Note": "抱歉，网络繁忙，请稍候再试。" });
            }
            else if (obj.is_ignore) {
                var mask_gifts = $c(".mask-gifts");
                var mask_gifts_tips = $c(".mask-gifts-tips");
                if (parseInt($c(this).data("checked"), 10) != 1) {
                    mask_gifts_tips.html("取消勾选显示免费礼物信息");
                    mask_gifts.data("checked", "1").find("span").removeClass().addClass("icon-checkbox-1");
                }
            }
        },

        /**
        * 移除DOM数组index前的所有元素
        */
        removeMessage: function ($elements, index) {
            if (index <= 0) return;
            var $prevAll = $c($elements.get(index)).prevAll();
            $prevAll.children().each(function () {
                $c(this).off();
            });
            $prevAll.remove();
        },
        /**
        * 切换页签时，消息处理
        * @return {[type]} [description]
        */
        tabCutCallback: function (id, con, i) {
            systemInfo = false;
            if (typeof ($chat) != 'undefined') {
                if (($chat.isPause == true) && (i == 0)) {
                    $chat.privateIsPause = false;
                    $chat.helpIsPause = false;
                } else if (($chat.privateIsPause == true) && (i == 1)) {
                    $chat.isPause = false;
                    $chat.helpIsPause = false;
                } else if (($chat.helpIsPause == true) && (i == 2)) {
                    $chat.isPause = false;
                    $chat.privateIsPause = false;
                } else {
                    $chat.isPause = false;
                    $chat.privateIsPause = false;
                    $chat.helpIsPause = false;
                }
            }

            var AllMsgChatContainer = $c('#AllMsgChatContainer');
            var PrivateMsgChatContainer = $c('#PrivateMsgChatContainer');
            var FansGuildMsgChatContainer = $c('#FansGuildMsgChatContainer');
            var allMsg = $c("#AllMsgChatContainer").find("li");
            var privateMsg = $c("#PrivateMsgChatContainer").find("li");
            var helpMsg = $c("#FansGuildMsgChatContainer").find("li");
            var allMsgNum = allMsg.size();
            var privateMsgNum = privateMsg.size();
            var helpMsgNum = helpMsg.size();


            if (typeof ($chat) != 'undefined') {
                if ($c("#AllMsgChatContainer").css("display") == "block") {
                    $chat.newMsg = 0;
                    AllMsgChatContainer.append($chat.newMsgArr.join(''));
                    $chat.newMsgArr = [];
                    allMsg = $c("#AllMsgChatContainer").find("li");
                    allMsgNum = allMsg.size();
                    // 只要消息超出50条，就清除
                    if ((allMsgNum - $chat.msgnum) >= 0) {
                        $c(allMsg.get(allMsgNum - $chat.msgnum)).prevAll().remove();
                    }

                } else if ($c("#PrivateMsgChatContainer").css("display") == "block") {
                    $chat.privateNewMsg = 0;
                    PrivateMsgChatContainer.append($chat.privateNewMsgArr.join(''));
                    $chat.privateNewMsgArr = [];
                    privateMsg = $c("#PrivateMsgChatContainer").find("li");
                    privateMsgNum = privateMsg.size();
                    if ((privateMsgNum - $chat.msgnum) >= 0) {
                        $c(privateMsg.get(privateMsgNum - $chat.msgnum)).prevAll().remove();
                    }

                } else if ($c("#FansGuildMsgChatContainer").css("display") == "block") {
                    $chat.helpNewMsg = 0;
                    FansGuildMsgChatContainer.append($chat.helpNewMsgArr.join(''));
                    $chat.helpNewMsgArr = [];
                    helpMsg = $c("#FansGuildMsgChatContainer").find("li");
                    helpMsgNum = helpMsg.size();
                    if ((helpMsgNum - $chat.msgnum) >= 0) {
                        $c(helpMsg.get(helpMsgNum - $chat.msgnum)).prevAll().remove();
                    }
                }
            }
            var num = i == 0 ? allMsgNum : i == 1 ? privateMsgNum : helpMsgNum;
            if ((num - $chat.msgnum) >= 0) {
                $c("#sc_con").find(".jspPane").removeClass("height-auto").height($chat.msgnum * $chat.oneMsgHeight);
                $c("#sc_con").find(".jspPane ul").eq(i).css({ 'position': 'absolute', 'bottom': '0px' });
                $chat.isPaneFixed[i] = true;
            } else {
                $c("#sc_con").find(".jspPane").addClass("height-auto").css("top", "0");
                $c("#sc_con").find(".jspPane ul").eq(i).css({ 'position': 'static' });
                $chat.isPaneFixed[i] = false;
            }
            // 只有聊天区域切换滚动条才会置底
            if (id == "sc_tab") {
                var chatH = $c("#sc_con").height();
                var allMsgH = $c("#AllMsgChatContainer").height();
                var privateMsgH = $c("#PrivateMsgChatContainer").height();
                var fansMsgH = $c("#FansGuildMsgChatContainer").height();
                if (($chat.isPause == true) && ($c("#AllMsgChatContainer").css("display") == "block") || ($chat.privateIsPause == true) && ($c("#PrivateMsgChatContainer").css("display") == "block") || ($chat.helpIsPause == true) && ($c("#FansGuildMsgChatContainer").css("display") == "block")) {

                } else {
                    // 切换 tab 时，出现滚动条才会置底
                    if ((i == 0) && (allMsgH > chatH) || (i == 1) && (privateMsgH > chatH) || (i == 2) && (fansMsgH > chatH)) {
                        mgc.consts.API.scroll.chat.scrollBy(0, Number.POSITIVE_INFINITY);
                        $chat.chatMessage(true);
                    }
                }
            }
        },
        pushRoomBanNoticeCallBack: function (obj) {
            console.log("房间禁言：" + JSON.stringify(obj));
            consts.MGCData.userBanned = obj.m_banned;
        }
    };
    //惊喜宝箱状态设置
    var $chat_surpruse = {
        info: null,
        /*
        *初始化惊喜宝箱
        */
        surpruseSwfInit: function () {
            var surpruseBox = $(".surprise-box");

            if ($("#SurpriseTreasureSwf")) {
                $("#SurpriseTreasureSwf").remove();
            }
            if ($("#surprise-box-swf").length == 0) {
                $("<div id='surprise-box-swf'></div>").appendTo(surpruseBox);
            }
            var swfVersionStr1 = "11.1.0";
            var xiSwfUrlStr = "playerProductInstall.swf?v=3_8_8_2016_15_4_final_3";
            var flashvars = {};
            var params = {};
            params.quality = "high";
            params.bgcolor = "#000";
            params.allowscriptaccess = "always";
            params.allowfullscreen = "true";
            params.allowFullScreenInteractive = "true";
            params.wmode = "transparent";
            var attributes = {};
            attributes.id = "SurpriseTreasureSwf";
            attributes.name = "SurpriseTreasureSwf";
            attributes.align = "middle";
            var swfurl = "/assets/SurpriseTreasureSwf.swf?v=3_8_8_2016_15_4_final_3" + "&r=" + Math.random();
            //if (navigator.userAgent.toLowerCase().indexOf("qqbrowser") > 0)
            //   swfurl += "&r=" + new Date();
            swfobject.embedSWF(swfurl, "surprise-box-swf", "100%", "100%", swfVersionStr1, xiSwfUrlStr, flashvars, params, attributes);
        },
        //显示、隐藏惊喜宝箱tips
        showSurpriseTips: function (flower_count, time_down, times, progress) {
            if (progress == 100 && time_down == 0) {
                $c('.surprise-open-tips').show();
            } else {
                $c('.surprise-flower-count').html(flower_count);
                $chat_surpruse.time_down_fun(time_down);
                $c('.surprise-times').html(times);
                $c('.surprise-tips').show();
            }
        },
        hideSurpriseTips: function () {
            $c('.surprise-tips,.surprise-open-tips').hide();
        },
        _setInterval: null,
        //倒计时
        time_down_fun: function (time_down) {
            if ($chat_surpruse._setInterval) {
                clearInterval($chat_surpruse._setInterval);
            }
            $c('.surprise-time-down').html($chat_surpruse.fillZero(Math.floor(time_down / 60), 2) + ":" + $chat_surpruse.fillZero(time_down % 60, 2));
            time_down--;
            $chat_surpruse._setInterval = setInterval(function () {
                if (time_down < 0) {
                    clearInterval($chat_surpruse._setInterval);
                    return;
                }
                $c('.surprise-time-down').html($chat_surpruse.fillZero(Math.floor(time_down / 60), 2) + ":" + $chat_surpruse.fillZero(time_down % 60, 2));
                time_down--;
            }, 1000);
        },
        //左补齐
        fillZero: function (number, digits) {
            number = String(number);
            var length = number.length;
            if (number.length < digits) {
                for (var i = 0; i < digits - length; i++) {
                    number = "0" + number;
                }
            }
            return number;
        }
    };
    var $chat_request = {
        /*
        * 查询惊喜宝箱奖励
        */
        querySurpriseBoxReward: function (activity_id) {
            var _reqStr = { "op_type": 224, "box_id": 11, "activity_id": activity_id };
            MGC_Comm.sendMsg(_reqStr, "MGC_Response");
        },
        /*
        * 开启惊喜宝箱
        */
        openSurpriseBox: function () {
            var _reqStr = { "op_type": 225 };
            MGC_Comm.sendMsg(_reqStr, "MGC_Response");
        },
        /*
        * 领取
        */
        getSurpriseBoxReward: function () {

        }
    };
    var $chat_response = {
        /**
        * 224 查询惊喜宝箱奖励
        */
        //查询宝箱数据
        getBoxGiftCallBack: function (obj, isSurpriseTreasure) {
            console.log("获取宝箱数据：" + obj);
            //obj = MGC_Comm.strToJson(obj);
            if (obj.reward) {
                $m.each(obj.reward, function (k, v) {
                    var url = v.channel == 0 ? v.url : v.channel == 3 ? v.url : v.channel == 4 ? v.url : v.channel == 2 ? ("http://ossweb-img.qq.com/images/mgc/css_img" + v.url + "?v=3_8_8_2016_15_4_final_3") : ("http://ossweb-img.qq.com/images/mgc/css_img" + v.url + "?v=3_8_8_2016_15_4_final_3");
                    v.url = url;
                    v.Qgame = false;
                    if (v.channel == 3) {
                        if (v.url == '') {
                            v.url = "http://ossweb-img.qq.com/images/mgc/css_img/common/game_default.png?v=3_8_8_2016_15_4_final_3";
                        }
                        Qgame = true;
                        v.Qgame = true;
                    }
                    v.anchor_level = MGCData.anchor_level;
                    v.buff_percent = obj.buff_percent;
                });
                if (MgcAPI.SNSBrowser.IsQQGame()) {
                    Qgame = true;
                }
                obj.showTips = "";
                obj.showTips_game = "";
                if (isSurpriseTreasure) {
                    obj.showTips = "激活的惊喜宝箱打开后，你将获得如下奖励中的一个";
                } else if (Qgame == true) {
                    obj.showTips = "达到房间热度后，由主播开启宝箱，可能获取其中一种奖励，每期奖励数量有限先到先得哦~";
                    obj.showTips_game = "";
                } else {
                    obj.showTips = "房间热度达到一定的值，你将获得如下奖励中的一个";
                    if (obj.hasgame == true) {
                        if(window.mgc.config.channel == 0){
                            obj.showTips_game = "（获得的游戏道具会直接进入游戏背包）";
                        }else{
                            obj.showTips_game = "（获得的游戏道具以邮件发放到电脑端）";
                        }
                    } else {
                        obj.showTips_game = "：";
                    }
                }
                var boxGiftCon = $m('#boxGiftTmpl');
                var boxGiftTmpl;
                var boxGiftContainer = $m('#boxGiftContainer');
                boxGiftContainer.children().remove();
                boxGiftTmpl = boxGiftCon.tmpl(obj);
                boxGiftTmpl.appendTo(boxGiftContainer);
                MGC.flipOver("#boxGiftContainer");
                boxGiftContainer.find("span").off("mouseover,mouseout").on("mouseover", function (e) {
                    var giftName = $(this).attr("mgc_giftname");
                    var giftTips = $(this).attr("mgc_gifttips");
                    if (giftName) {
                        MGC.suswTips2(e, 1, giftName, giftTips);
                    }
                }).on("mouseout", function () {
                    MGC.suswTips2(event, 0);
                });
                boxGiftContainer.find("i").off("mouseover,mouseout").on("mouseover", function (e) {
                    var giftBuff = $(this).attr("mgc_buff");
                    if (giftBuff) {
                        MGC.suswTips5(e, 1, giftBuff, "");
                    }
                }).on("mouseout", function () {
                    MGC.suswTips5(event, 0);
                });

                window.mgc.popmanager.layerControlShow($m('#boxGiftContainer'), 5, 1);
                $m('#boxGiftContainer').find(".btn_open,.pop_close").off('click').on('click', function () {
                    window.mgc.popmanager.layerControlHide($m('#boxGiftContainer'), 5, 1);
                });
                boxGiftTmpl = null;
                boxGiftCon = null;
            }
        },
        /**
        * 225 打开惊喜宝箱返回
        */
        openBoxCallback: function (resp) {
            switch (resp.result) {
                case 0:
                    var swfobj = mgc_tool.getSWF('SurpriseTreasureSwf');
                    if (swfobj) {
                        swfobj.request_as(resp);
                    }
                    $chat_surpruse.hideSurpriseTips(); //隐藏tips
                    break;
                case 1:
                    MGC_Comm.CommonDialog({ "Title": "提示", "Note": "系统错误！" });
                    break;
                case 2:
                    MGC_Comm.CommonDialog({ "Title": "提示", "Note": "未知错误！" });
                    break;
                case 3:
                    MGC_Comm.CommonDialog({ "Title": "提示", "Note": "宝箱未激活！" });
                    break;
                case 4:
                    MGC_Comm.CommonDialog({ "Title": "提示", "Note": "服务器繁忙！" });
                    break;
                case 5:
                    MGC_Comm.CommonDialog({ "Title": "提示", "Note": "系统错误：没有配置奖励！" });
                    break;
                case 6:
                    MGC_Comm.CommonDialog({ "Title": "提示", "Note": "Game服务器超时！" });
                    break;
                case 7:
                    MGC_Comm.CommonDialog({ "Title": "提示", "Note": "不在视频房间内！" });
                    break;
                case 8:
                    MGC_Comm.CommonDialog({ "Title": "提示", "Note": "视频不在直播中！" });
                    break;
                case 9:
                    MGC_Comm.CommonDialog({ "Title": "提示", "Note": "不在活动中或者活动已结束！" });
                    break;
                case 10:
                    MGC_Comm.CommonDialog({ "Title": "提示", "Note": "系统错误，GameServer找不到RoomServer！" });
                    break;
                case 11:
                    MGC_Comm.CommonDialog({ "Title": "提示", "Note": "主播端不能开宝箱！" });
                    break;
            }
        },
        /*
        * 226 更新惊喜宝箱
        */
        updateSurpriseBoxCallback: function (resp) {
            $chat_surpruse.info = resp;
            var swfobj = mgc_tool.getSWF('SurpriseTreasureSwf');
            if (swfobj) {
                swfobj.request_as($chat_surpruse.info);
            }
        },
        initFinashedBoxCallback: function (resp) {
            //惊喜宝箱初始化完成
            try {
                var swfobj = mgc_tool.getSWF('SurpriseTreasureSwf');
                if (swfobj) {
                    var _reqStr;
                    if (filename == "nest.shtml") {
                        _reqStr = { "op_type": 280, "isCaveolaeBo": true, "isConcert": false, "isVisitor": MGC_Comm.CheckGuestStatus(true), "skinId": SKIN.id, "skinLevel": SKIN.level };
                    } else {
                        _reqStr = { "op_type": 280, "isCaveolaeBo": filename == "caveolaeroom.shtml", "isConcert": false, "isVisitor": MGC_Comm.CheckGuestStatus(true) };
                    }
                    console.log("惊喜宝箱：" + JSON.stringify(_reqStr));
                    swfobj.request_as(_reqStr);
                    if ($chat_surpruse.info) {
                        console.log("惊喜宝箱：" + JSON.stringify($chat_surpruse.info));
                        swfobj.request_as($chat_surpruse.info);
                    }
                }
            } catch (e) { }
        },

        /*
        * 227 获得惊喜宝箱数据
        */
        getSurpriseTreasureCallBack: function (obj) {
            console.log("获取惊喜宝箱数据Action：" + JSON.stringify(obj));
            //obj = MGC_Comm.strToJson(obj);
            $m.each(obj.reward, function (k, v) {
                var url = v.channel == 0 ? v.url : v.channel == 3 ? v.url : v.channel == 4 ? v.url : v.channel == 2 ? ("http://ossweb-img.qq.com/images/mgc/css_img" + v.url + "?v=3_8_8_2016_15_4_final_3") : ("http://ossweb-img.qq.com/images/mgc/css_img" + v.url + "?v=3_8_8_2016_15_4_final_3");
                v.url = url;
                v.Qgame = false;
                if (v.channel == 3) {
                    if (v.url == '') {
                        v.url = "http://ossweb-img.qq.com/images/mgc/css_img/common/game_default.png?v=3_8_8_2016_15_4_final_3";
                    }
                    Qgame = true;
                    v.Qgame = true;
                }
                v.anchor_level = MGCData.anchor_level;
                v.buff_percent = obj.buff_percent;

            });
            if (MgcAPI.SNSBrowser.IsQQGame()) {
                Qgame = true;
            }
            obj.showTips = "惊喜宝箱奖励";
            if (Qgame) {
                if (obj.is_reissue) {
                    obj.showTips = "很遗憾，本期惊喜宝箱奖励已经发完，您获得了安慰奖励：";
                } else {
                    obj.showTips = "惊喜宝箱奖励：（如获得游戏道具，会自动放入您的QQ游戏大厅背包中）";
                }
            } else {
                if (obj.hasgame) {
                    if(window.mgc.config.channel == 0){
                        obj.showTips_game = "（获得的游戏道具会直接进入游戏背包）";
                    }else{
                        obj.showTips_game = "（获得的游戏道具以邮件发放到电脑端）";
                    }
                } else {
                    obj.showTips_game = '：';
                }
            }
            var boxGiftCon = $m('#boxGiftTmpl');
            var boxGiftTmpl;
            var boxGiftContainer = $m('#boxGiftContainer');
            boxGiftContainer.children().remove();
            boxGiftTmpl = boxGiftCon.tmpl(obj);
            boxGiftTmpl.appendTo(boxGiftContainer);
            MGC.flipOver("#boxGiftContainer");
            boxGiftContainer.find("span").off("mouseover,mouseout").on("mouseover", function (e) {
                var giftName = $(this).attr("mgc_giftname");
                var giftTips = $(this).attr("mgc_gifttips");
                if (giftName) {
                    MGC.suswTips2(e, 1, giftName, giftTips);
                }
            }).on("mouseout", function () {
                MGC.suswTips2(event, 0);
            });

            boxGiftContainer.find("i").off("mouseover,mouseout").on("mouseover", function (e) {
                var giftBuff = $(this).attr("mgc_buff");
                if (giftBuff) {
                    MGC.suswTips5(e, 1, giftBuff, "");
                }
            }).on("mouseout", function () {
                MGC.suswTips5(event, 0);
            });

            window.mgc.popmanager.layerControlShow($m('#boxGiftContainer'), 5, 1);
            $m('#boxGiftContainer').find(".btn_open,.pop_close").off('click').on('click', function () {
                window.mgc.popmanager.layerControlHide($m('#boxGiftContainer'), 5, 1);
            });
            boxGiftTmpl = null;
            boxGiftCon = null;
        },
        /**
        * 142 获得宝箱数据的提示
        */
        getBoxGiftActionCallBack: function (obj) {
            if (MGC_Comm.CheckGuestStatus(true)) {
                console.log("屏蔽游客操作：获得宝箱数据动画");
                return false; //游客身份下，屏蔽此操作
            }
            console.log("获取宝箱数据Action：" + JSON.stringify(obj));
            obj = MGC_Comm.strToJson(obj);

            //宝箱开启提示
            if (obj.res == 0 || obj.res == 8) {
                mgc.openTipModel.set("boxid", obj.boxid);
            }

            if ((obj.online && obj.res == 0) || (obj.online && obj.res == 9)) {
                var popInfo = {};
                //popInfo.showTips = "房间热度奖励";
                popInfo.reward = {};
                popInfo.reward.count_desc = obj.truelyReward[0].count_desc;
                popInfo.reward.name = obj.truelyReward[0].name;
                popInfo.reward.tips = obj.truelyReward[0].tips;
                popInfo.reward.url = obj.truelyReward[0].channel == 0 ? obj.truelyReward[0].url : obj.truelyReward[0].channel == 3 ? obj.truelyReward[0].url : obj.truelyReward[0].channel == 4 ? obj.truelyReward[0].url : obj.truelyReward[0].channel == 2 ? ("http://ossweb-img.qq.com/images/mgc/css_img" + obj.truelyReward[0].url + "?v=3_8_8_2016_15_4_final_3") : ("http://ossweb-img.qq.com/images/mgc/css_img" + obj.truelyReward[0].url + "?v=3_8_8_2016_15_4_final_3");

                if (obj.truelyReward[0].channel == 3) {
                    if (obj.truelyReward[0].url == '') {
                        obj.truelyReward[0].url = "http://ossweb-img.qq.com/images/mgc/css_img/common/game_default.png?v=3_8_8_2016_15_4_final_3";
                    }
                    Qgame = true;
                }
                if (MgcAPI.SNSBrowser.IsQQGame()) {
                    Qgame = true;
                }
                popInfo.reward.anchor_level = MGCData.anchor_level;
                if (popInfo.reward.name == "梦幻币" || popInfo.reward.name == "经验") {
                    popInfo.reward.buff_percent = "(+" + obj.buff_percent + "%)";
                }
                else {
                    popInfo.reward.buff_percent = "";
                }

                if (obj.res == 0) {
                    popInfo.showTips = "热度宝箱已开启！恭喜您获得：";
                }
                else if (obj.res == 9) {
                    popInfo.showTips = "补发热度宝箱奖励：";
                }

                if (Qgame) {
                    if (obj.is_reissue) {
                        popInfo.showTips = "本期热度宝箱奖励已发完，您获得安慰奖：";
                    } else {
                        //popInfo.showTips = "获得房间热度奖励~（如获得游戏道具，会自动放入您的QQ游戏大厅背包中）";
                        //popInfo.showTips = "热度宝箱已开启！恭喜您获得：";
                    }
                    popInfo.showTips_game = "";
                } else {
                    if (obj.hasgame) {
                        if(window.mgc.config.channel == 0){
                            popInfo.showTips_game = "（获得的游戏道具会直接进入游戏背包）";
                        }else{
                            popInfo.showTips_game = "（获得的游戏道具以邮件发送至电脑端）";
                        }
                        //popInfo.showTips = "热度宝箱已开启！恭喜您获得：";
                    } else {
                        popInfo.showTips_game = "";
                        //popInfo.showTips = "热度宝箱已开启！恭喜您获得：";
                    }
                }

                var tipObj = {};
                tipObj.showTips = popInfo.showTips;
                tipObj.name = popInfo.reward.name;
                tipObj.count_desc = popInfo.reward.count_desc;
                tipObj.buff_percent = popInfo.reward.buff_percent;
                tipObj.showTips_game = popInfo.showTips_game;
                if (obj.last_hit_player_name.length > 0) {
                    if(obj.last_hit_player_invisible && obj.last_hit_player_id != MGCData.myPlayerId){
                        tipObj.lastHitPlayerName = "神秘土豪";
                    } else{
                        tipObj.lastHitPlayerName = obj.last_hit_player_name[0];
                    }
                    tipObj.isLastking = true;
                } else {
                    tipObj.isLastking = false;
                }
                //var rewardTip = "<span>" + popInfo.showTips + popInfo.reward.name + " x" + popInfo.reward.count_desc + popInfo.reward.buff_percent + popInfo.showTips_game + "</span>";
                mgc.rewardTipModel.addTip(tipObj);

                //获得遗失在房间里的热度宝箱奖励(主播下线未开的宝箱奖励)
            } else if ((!obj.online && obj.res == 0) || (!obj.online && obj.res == 9)) {

                console.log("获取宝箱数据Action处理后：" + JSON.stringify(obj));
                $m('.video_title').hide();
                var popInfo = {};
                //popInfo.lostReward = "这是你在房间遗失的奖励~请查收~";
                popInfo.showTips = "补发热度宝箱奖励：";
                popInfo.showTips_game = "";
                popInfo.reward = obj.truelyReward;

                $m.each(popInfo.reward, function (k, v) {
                    var url = v.channel == 0 ? v.url : v.channel == 3 ? v.url : v.channel == 4 ? v.url : v.channel == 2 ? ("http://ossweb-img.qq.com/images/mgc/css_img" + v.url + "?v=3_8_8_2016_15_4_final_3") : ("http://ossweb-img.qq.com/images/mgc/css_img" + v.url + "?v=3_8_8_2016_15_4_final_3");
                    v.url = url;
                    v.Qgame = false;
                    if (v.channel == 3) {
                        if (v.url == '') {
                            v.url = "http://ossweb-img.qq.com/images/mgc/css_img/common/game_default.png?v=3_8_8_2016_15_4_final_3";
                        }
                        v.Qgame = true;
                    }
                    v.anchor_level = obj.anchor_level;
                    //v.buff_percent = obj.buff_percent;
                    if (v.name == "梦幻币" || v.name == "经验") {
                        v.buff_percent = "(+" + obj.buff_percent + "%)";
                    }
                    else {
                        v.buff_percent = "";
                    }

                    if (MgcAPI.SNSBrowser.IsQQGame()) {
                        Qgame = true;
                    }
                    indexNum = 1;
                    if (Qgame) {
                        if (obj.is_reissue) {
                            //popInfo.showTips = "很遗憾，本期热度宝箱奖励已经发完，您获得了安慰奖励：";
                            //popInfo.showTips = "本期热度宝箱奖励已发完，您获得安慰奖：";
                        } else {
                            //popInfo.showTips = "获得房间热度奖励~（如获得游戏道具，会自动放入您的QQ游戏大厅背包中）";
                            //popInfo.showTips = "热度宝箱已开启！恭喜您获得：";
                        }
                        popInfo.showTips_game = "";
                    } else {
                        if (obj.hasgame == true) {
                            if(window.mgc.config.channel == 0){
                                popInfo.showTips_game = "（获得的游戏道具会直接进入游戏背包）";
                            }else{
                                popInfo.showTips_game = "（获得的游戏道具以邮件发放到电脑端）";
                            }
                            //popInfo.showTips = "热度宝箱已开启！恭喜您获得：";
                        } else {
                            //popInfo.showTips_game = "：";
                            //popInfo.showTips = "热度宝箱已开启！恭喜您获得：";
                        }
                    }

                    //var rewardTip = "<span>" + popInfo.showTips + v.name + " x" + v.count_desc + v.buff_percent + popInfo.showTips_game + "</span>"
                    var tipObj = {};
                    tipObj.showTips = popInfo.showTips;
                    tipObj.name = v.name;
                    tipObj.count_desc = v.count_desc;
                    tipObj.buff_percent = v.buff_percent;
                    tipObj.showTips_game = popInfo.showTips_game;
                    if (obj.last_hit_player_name.length > 0) {
                        if(obj.last_hit_player_invisible[k] && obj.last_hit_player_id[k] != MGCData.myPlayerId){
                            tipObj.lastHitPlayerName = "神秘土豪";
                        } else{
                            tipObj.lastHitPlayerName = obj.last_hit_player_name[k];
                        }
                        tipObj.isLastking = true;
                    } else {
                        tipObj.isLastking = false;
                    }
                    mgc.rewardTipModel.addTip(tipObj);
                });

            } else if (obj.res == 8 && tmpBx == 0 && obj.online) {
                // tmpBx = 1;
                // //冷却--公用弹出框
                // MGC_Comm.CommonDialog({
                //     "Title": "提示",
                //     "Note": "您进入房间的时间太短，还没有融入房间的热度中。主播开启热度宝箱的奖励，将会在您融入房间的热度后再发放给您。"
                // });
            } else if (obj.res == 8 && tmpBx == 0 && !obj.online) {
                // tmpBx = 1;
                // //冷却--公用弹出框
                // MGC_Comm.CommonDialog({
                //     "Title": "提示",
                //     "Note": "您进入房间的时间太短，还没有融入房间的热度中。主播开启热度宝箱的奖励帮您存起来了，在您融入房间热度后再发放给您。"
                // });
            }
        }
    };
    var FreeGift = {
        enabled: true,
        nowtime: null, //标识当前时间
        freeGiftArray: [{ id: 1, desc: "", num: 0, lefttime: 600 }, { id: 36, desc: "超级期待~再来一首！", num: 0, lefttime: 120}],
        freeGiftArrayForShowroom: [{ id: 1, desc: "【杰伦小公举】财富值+1，亲密度+1，主播经验+1", num: 0, lefttime: 120},
                                   { id: 2, desc: "【小鸡小鸡】财富值+1，亲密度+1，主播经验+1", num: 0, lefttime: 120}],
        showRoomsessionNo: 0,//演唱会场次
        giftLefttime: 0,
        giftNum: 0,
        getShowNo: false,
        // currentSessionGiftId: 0,//记录当前场次的礼物 id
        sessionConfig: {"1": 1, "2": 2, "3": 3},//根据演唱会场次存储礼物id:场次：礼物id
        //送礼
        sendGift: function (gift_id, gift_cnt) {
            callcenter.sendGift(gift_id, gift_cnt, FreeGift.sendGiftCallBack);
        },
        //送礼回调
        sendGiftCallBack: function (resp, params) {
            console.log("送礼回调：" + JSON.stringify(resp));
            //送礼物时，只需要改变全部聊天的滚动条悬停状态，私聊和后援团不需要修改悬停状态
            if (_MsgChannel == 0) {
                $chat.isPause = false;
            }

            $chat.isScrollBtm();

        },
        //免费礼物数量回调
        responseFreeGift: function (resp, params) {
            console.log("免费礼物数量回调：" + JSON.stringify(resp));
            if(filename != "showroom.shtml"){
                FreeGift.setLefttime(1, resp.leftTime);
                FreeGift.setNum(1, resp.giftNum);
                //更新tip
                if (GiftTip.getId() == 1) {
                    GiftTip.showGiftTip(1);
                }
            }
            
            resp = null;
        },
        //其他免费礼物回调
        responseOtherFreeGift: function (resp, params) {
            console.log("免费礼物1数量回调：" + JSON.stringify(resp));
            var array = resp.giftinfo;
            for (var i = 0; i < array.length; i++) {
                var giftinfo = array[i];
                if(giftinfo.giftid == 36){
                    FreeGift.giftLefttime = giftinfo.leftTime;
                    FreeGift.giftNum = giftinfo.giftcnt;
                }
                FreeGift.setLefttime(giftinfo.giftid, giftinfo.leftTime);
                FreeGift.setNum(giftinfo.giftid, giftinfo.giftcnt);
                //更新tip
                if (GiftTip.getId() == giftinfo.giftid) {
                    GiftTip.showGiftTip(giftinfo.giftid);
                }
            }
        },
        //初始化免费礼物 只有演唱会会主动下发
        isFreeGiftInit: false,
        responseInitFreeGift: function (resp, params) {
            console.log("初始化免费礼物回调：" + JSON.stringify(resp));
            if (filename == "showroom.shtml") { 
                if(!this.getShowNo){
                    return;
                } 
            } else{
                if(this.isFreeGiftInit) return;
            }
            // FreeGift.showRoomsessionNo = resp.session;
            this.isFreeGiftInit = true;
            var array = resp.giftIdArray;
            var arr = [];
            for (var i = 0; i < array.length; i++) {
                var id = array[i];
                for (var j = 0; j < FreeGift.freeGiftArray.length; j++) {
                    var o = FreeGift.freeGiftArray[j];
                    var id1 = o.id;
                    if (id == id1) {
                        arr.push(o);
                    }
                }
            }
            FreeGift.init(arr);
        },
        //礼物消息广播
        responseGiftMessage: function (obj) {
            //只显示免费礼物
            if (obj.gift.giftItemID != 1 && obj.gift.giftItemID != 35 && obj.gift.giftItemID != 36) {
                $c("#default_gift_bg").hide();
                return;
            }

            // 自己送花，滚动条不悬停，置底
            if (obj.isSelf && $c("#AllMsgChatContainer").css("display") == "block") {
                systemInfo = false;
                $chat.isPause = false;
                $chat.chatMessage();
            }
            // 显示所有的送礼信息
            var data = {};
            data.senderName = obj.gift.senderName;
            data.senderZoneName = obj.gift.zoneName;
            data.count = obj.gift.count;
            data.vipIcon = obj.gift.vipIcon.replace("vip_lv", "");
            data.guardIcon = obj.gift.guardIcon.replace("guard_lv", "");
            data.giftItemID = obj.gift.giftItemID;
            data.wealth_level = obj.gift.wealth_level;
            data.source = obj.gift.source;
            // 是否是移动端管理员,需要换成服务器字段  obj.gift.?
            data.senderPlayerID = obj.gift.senderPlayerID;
            data.isMobileManager = mgc_tool.judgeIfUserAdmin(allUserAdmins, data.senderPlayerID);
            //增加一个标识，区分是单送还是连送
            data.continuous_send_gift_times = obj.gift.continuous_send_gift_times;
            if(filename == "showroom.shtml"){
                data.giftItemID = $c('.freeGift li').eq(0).attr('data-id');
                data.isShowRoomConfig = true;
            } else{
                data.isShowRoomConfig = false;
            }
            // var GiftMessageTmpl = ($chat.$o.GiftMessageCon.tmpl(data))[0].outerHTML;
            var GiftMessageTmpl = $chat.$o.GiftMessageCon.render(data);
            //包括送花全部聊天最多只保留50条聊天信息
            var allMsg = $chat.$o.AllMsgChatContainer.find("li");
            var allMsgNum = allMsg.size();
            if (obj.isSelf) {
                $chat.isPause = false;
            }
            if ($chat.isPause) {
                // 信息悬停,新进消息增加
                $chat.newMsg++;
                //悬停状态，超出50条的新消息存储在 newMsgArr
                if (allMsgNum >= $chat.msgnum) {
                    $chat.newMsgArr.push(GiftMessageTmpl);
                    obj = null;
                    data = null;
                    return;
                }
            }
            $chat.ChatMsgHtml[0] += GiftMessageTmpl;
            obj = null;
            data = null;
        },
        //更新礼物
        update: function () {
            $c('.freeGift li').each(function () {
                var num = $c(this).data("num");
                var id = $c(this).data("id");
                if (FreeGift.enabled && num != 0) {
                    $c(this).find('a').removeClass('gift_' + id + "_Disable");
                    $c(this).find('.num').show();
                    $c(this).find('.num').html(num);
                    if(id != 36 && filename == "showroom.shtml"){
                        $c(".freeGiftTip").css("background", "url(http://ossweb-img.qq.com/images/mgc/css_img/flash/gift/freegift/gift_" +id + "_tips.png) no-repeat center center");
                        $c(".freeGiftTip").css("background-size", "cover");
                        $c(".freeGiftTip .leftTime").css("top", "50px");
                        $c(this).find('a').css("background", "url(http://ossweb-img.qq.com/images/mgc/css_img/flash/gift/freegift/gift_" +id + ".png) no-repeat center center");
                        $c(this).find('a').css("background-size", "cover");
                    }
                }
                else {
                    $c(this).find('a').addClass('gift_' + id + "_Disable");
                    $c(this).find('.num').hide();
                    $c(this).removeClass("hover");
                    if(id != 36 && filename == "showroom.shtml"){
                        $c(".freeGiftTip").css("background", "url(http://ossweb-img.qq.com/images/mgc/css_img/flash/gift/freegift/gift_" +id + "_tips.png) no-repeat center center");
                        $c(".freeGiftTip").css("background-size", "cover");
                        $c(".freeGiftTip .leftTime").css("top", "50px");
                        $c(this).find('a').css("background", "url(http://ossweb-img.qq.com/images/mgc/css_img/flash/gift/freegift/gift_" +id + "_Disable.png) no-repeat center center");
                        $c(this).find('a').css("background-size", "cover");
                    }
                }
            });
        },
        //是否启用
        setEnabled: function (b) {
            FreeGift.enabled = b;
            FreeGift.update();
        },
        //更新某个礼物的数量
        setNum: function (id, num) {
            var $li = $c('.freeGift li[data-id=' + id + ']');
            if(id == 36 && filename == "showroom.shtml"){
                 $li = $c('.freeGift li').eq(0);
            }
            if ($li) {
                $li.data("num", num);
                FreeGift.update();
            }
        },
        //更新某个礼物的剩余时间
        setLefttime: function (id, lefttime) {
            var $li = $c('.freeGift li[data-id=' + id + ']');
            if(id == 36 && filename == "showroom.shtml"){
                 $li = $c('.freeGift li').eq(0);
            }
            if ($li) {
                $li.data("lefttime", lefttime);
            }
        },
        //初始化 {id: 2, num: 99, lefttime: 600}
        init: function (data) {
            $c('.sc_role_list').jScrollPane({ autoReinitialise: true, animateScroll: true, autoReinitialiseDelay: 100 });
            $c('.sc_con').jScrollPane({ autoReinitialise: true, stickToBottom: true, autoReinitialiseDelay: 100, verticalDragMinHeight: 44, mousemoveCallback: $chat.clearChatInfo });
            // $c('.cb_fy').bind('click', function() { $chat.chatMessage(); });
            $chat.facePackage();
            $chat.maskGifts();
            $("#SendMsgChatBox").val("");
            if (filename == "showroom.shtml") {
                $c(".surprise-box").hide();
                $c(".freeGift").width(155).find("ul").children().remove();
                $c("#sc_con ul").children().remove();
            } else {
                $c(".surprise-box").show();
                $chat_surpruse.surpruseSwfInit(true);
            }

            /**
            * 页签切换
            */
            $c("#AllMsgChatBtn").unbind("click").bind("click", function (e) {
                mgc_tool.tabCut('sc_tab', 'sc_con', 0, $chat.tabCutCallback);
            });
            $c("#PrivateMsgChatBtn").unbind("click").bind("click", function (e) {
                mgc_tool.tabCut('sc_tab', 'sc_con', 1, $chat.tabCutCallback);
                $chat.hideChatMsgTips('PrivateMsgChatBtn');
            });
            $c("#FansGuildMsgChatBtn").unbind("click").bind("click", function (e) {
                mgc_tool.tabCut('sc_tab', 'sc_con', 2, $chat.tabCutCallback);
                $chat.hideChatMsgTips('FansGuildMsgChatBtn');
            });
            /**
            * 所有人选框
            */
            $c("#sc_role_out .sc_role_ul li").unbind("click").bind("click", function (e) {
                var index = parseInt($(this).attr("index"));
                $chat.PreSendMsgChat(index);
            });

            var giftCellCon = $c('#GiftCellTmpl');
            var giftCellTmpl;
            var freeGiftContainer = $c('.freeGift ul');
            freeGiftContainer.children().remove();
            //if(data.length && data.length == 2){
            //    data = data.reverse();
            //}
            if(filename == "showroom.shtml"){
                
                if(FreeGift.sessionConfig[FreeGift.showRoomsessionNo] != undefined){
                    var giftId = FreeGift.sessionConfig[FreeGift.showRoomsessionNo];
                    var data = [];
                    for(var j=0, m=FreeGift.freeGiftArrayForShowroom.length; j<m; j++){
                        if(FreeGift.freeGiftArrayForShowroom[j].id == giftId){
                            data[0] = {};
                            data[0].id = giftId;
                            data[0].desc = FreeGift.freeGiftArrayForShowroom[j].desc;
                            data[0].isShowroom = true;
                            if(MGC_Comm.CheckGuestStatus(true)){
                                data[0].lefttime = FreeGift.freeGiftArrayForShowroom[j].lefttime;
                            } else{
                                data[0].lefttime = FreeGift.giftLefttime;
                            }
                            
                            data[0].num = FreeGift.giftNum;
                            break;
                        }
                    }
                }
                if(data.length == 0){
                    data.push(FreeGift.freeGiftArray[1]);
                }
            }
            
            giftCellTmpl = giftCellCon.render(data);
            freeGiftContainer.append(giftCellTmpl);
            if (filename == "showroom.shtml") {
                freeGiftContainer.find("li:eq(0)").css("margin", "0 8px 0 15px");
            }
            freeGiftContainer.find("li").click(function (e) {
                if (MGC_Comm.CheckGuestStatus()) {
                    console.log("屏蔽游客操作：游客状态下停止免费花赠送");
                    return false;
                }
                var $li = $c(e.currentTarget);
                var id = $li.data("id");
                if(filename == "showroom.shtml"){
                    id = 36;
                }
                var num = $li.data("num");
                console.log("sendgift id = " + id);
                if (FreeGift.enabled && num != 0) {
                    FreeGift.sendGift(id, num);
                }
            });
            freeGiftContainer.find("li").mouseover(function (e) {
                var $li = $c(e.currentTarget);
                var id = $li.data("id");
                GiftTip.showGiftTip(id, true);
                $li.addClass("hover");
            });
            freeGiftContainer.find("li").mouseout(function (e) {
                var $li = $c(e.currentTarget);
                var id = $li.data("id");
                GiftTip.showGiftTip(id, false);

                if ($li.hasClass("hover")) {
                    $li.removeClass("hover");
                }
            });
            FreeGift.update();
            if (MGC_Comm.CheckGuestStatus(true)) {
                console.log("屏蔽游客操作：游客状态下停止免费花增长");
            } else {
                //计时器
                clearInterval(giftInterval);
                FreeGift.nowtime = new Date().getTime();
                FreeGift.nowtime1 = null;
                var alltime = 0;
                var cutnum = 0;

                giftInterval = setInterval(function () {
                    FreeGift.nowtime1 = new Date().getTime();
                    //cutnum = Math.ceil((FreeGift.nowtime1 - FreeGift.nowtime) / 1000);
                    $c('.freeGift li').each(function () {
                        var lefttime = $c(this).data("lefttime");
                        //alltime = alltime > 0 ? alltime : (lefttime != undefined ? lefttime : 0);
                        var num = $c(this).data("num");
                        if (lefttime > 0) {
                            //if (cutnum > alltime - lefttime) {
                            //lefttime = alltime - cutnum;
                            //} else {
                            lefttime--;
                            //}
                        }
                        if (lefttime <= 0) {
                            //FreeGift.nowtime = FreeGift.nowtime1;
                            lefttime = 0;
                            $(".freeGiftTip").hide();
                        }
                        if (num == 20) {
                            lefttime = 600;
                        }
                        $c(this).data("lefttime", lefttime);
                    });

                    var lefttime = GiftTip.getlefttime();
                    var num = GiftTip.getNum();
                    if (lefttime > 0) {
                        // if (cutnum > alltime - lefttime) {
                        //     lefttime = alltime - cutnum;
                        // } else {
                        lefttime--;
                        //}
                    }
                    if (lefttime <= 0) {
                        //FreeGift.nowtime = FreeGift.nowtime1;
                        lefttime = 0;
                    }
                    if (num == 20) {
                        lefttime = 600;
                    }
                    GiftTip.setlefttime(lefttime);
                }, 1000);
            }
            giftCellTmpl = null;
            giftCellCon = null;
        }
    };
    var giftInterval;
    var GiftTip = {
        //设置剩余时间
        setlefttime: function (lefttime) {
            var $tip = $c(".freeGiftTip");
            $tip.data("lefttime", lefttime);
            if (filename == "showroom.shtml" && GiftTip.getNum() == 20) {
                $tip.find(".leftTime").html("每120秒获得一个，最多累计20个，每次全部送出。");
            } else {
                if (lefttime < 0) {
                    if (filename != "showroom.shtml") {
                        $tip.find(".leftTime").html("600秒后获得下一个礼物，每次全部送出");
                    }
                    else {
                        $tip.find(".leftTime").html("600秒后获得下一个礼物，每次全部送出");
                    }
                }
                else {
                    if (filename != "showroom.shtml") {
                        $tip.find(".leftTime").html(lefttime + "秒后获得下一个礼物，每次全部送出");
                    }
                    else {
                        $tip.find(".leftTime").html(lefttime + "秒后获得下一个礼物，每次全部送出");
                    }
                }
            }
        },
        //获取剩余时间
        getlefttime: function () {
            return $c(".freeGiftTip").data("lefttime");
        },
        //设置数量
        setNum: function (num) {
            var $tip = $c(".freeGiftTip");
            //var lefttime =  $tip.data("lefttime");
            $tip.data("num", num);
        },
        //获取数量
        getNum: function () {
            return $c(".freeGiftTip").data("num");
        },
        //设置描述
        setDesc: function (desc) {
            var $tip = $c(".freeGiftTip");
            //var lefttime =  $tip.data("lefttime");
            $tip.data("desc", desc);
            $tip.find(".desc").html(desc);
        },
        //设置礼物id
        setId: function (id) {
            var $tip = $c(".freeGiftTip");
            $tip.data("id", id);
        },
        //获取礼物id
        getId: function () {
            return $c(".freeGiftTip").data("id");
        },
        //显示某个礼物的tip
        showGiftTip: function (id, visible) {
            var $tip = $c(".freeGiftTip");
            var $li = $c('.freeGift li[data-id=' + id + ']');

            $tip.removeClass();
            $tip.addClass("freeGiftTip freeGiftTip_" + id);

            GiftTip.setNum($li.data("num"));
            GiftTip.setlefttime($li.data("lefttime"));
            if (filename == "showroom.shtml") {
                GiftTip.setDesc($li.data("desc"));
            }
            GiftTip.setId($li.data("id"));

            if (visible) {
                //$tip.show();
                window.mgc.popmanager.layerControlShow($tip, 1, 3);
            }
            else {
                //$tip.hide();
                window.mgc.popmanager.layerControlHide($tip, 1, 3);
            }
        }
    };
    /**
    * 弹幕模式回调处理
    */
    var barragePattern = {
        //弹幕接口
        barrageCallBack: function (resp, params) {
            //炫豆不够，需要充值
            if (resp.notEnoughMoney) {
                //需要加充值回调和算了回调
                // bubble.show({ Note: "亲，您的炫豆不够了，快去充值吧!", Position: { x: 100, y: 200 }, BtnName: ["充值", "算了"], Callbacks: { 0: function() { alert("ok"); }, 1: function() { alert("cancel"); } } });
            }
        },
        // 设置输入框里默认内容
        barrageDefaultValue: function (resp, req) {
            // 拥有免费弹幕时，默认提示语为：您还有n条免费弹幕
            if (resp.freeBarrageNo > 0) {
                $c("#defaultDes").html("您还有" + resp.freeBarrageNo + "条免费弹幕");
                $c("#defaultDes").data("value", "您还有" + resp.freeBarrageNo + "条免费弹幕");
            } else {
                $c("#defaultDes").html("每条弹幕将花费" + resp.xuandou + "炫豆");
                $c("#defaultDes").data("value", "每条弹幕将花费" + resp.xuandou + "炫豆");
            }
        }
    };

    if (MgcAPI.SNSBrowser.IsQQGame()) {
        $chat.msgnum = 30;
    }
    var MsgNULL = { "isSelf": true, "msg": { "senderDeviceType": 2, "m_in_vip_seat": false, "m_is_free_whistle": false, "m_is_purple": false, "invisible": false, "m_senderPlayerType": 2, "msg": "", "forbid_talk_all_room": false, "isOnLive": false, "nest_assistant": false, "senderIcon": "", "NickColor": "#232323", "channel": 0, "TextColor": "#232323", "senderPlayerID": "-1", "isSelf": 0, "senderPlayerZoneID": 0, "systemType": 0, "targetVipLevel": 0, "senderName": "", "targetGuardLevel": 0, "receiverName": "", "ban": false, "senderZoneName": "梦工厂", "perpetual": false, "receiverZoneName": "", "wealth_level": 0, "sender_jacket": 0, "add_anchor_exp": 0, "sender_defend": 0, "isTakeVip": false, "viplevel": 0, "vipCardPattern": null, "judge_type": -1, "video_guild_id": "", "receiverPlayerID": "", "receiverPlayerType": 0, "flag": 0 }, "chatnodes": [{ "nodeType": 0, "content": ""}], "op_type": 46 };
    setInterval(function () {
        if ($chat.ChatMsgHtml[0] != "" ||
            $chat.ChatMsgHtml[1] != "" ||
            $chat.ChatMsgHtml[2] != "" ||
            $chat.newMsg >= $chat.msgnum ||
            $chat.privateNewMsg >= $chat.msgnum ||
            $chat.helpNewMsg >= $chat.msgnum) {
            $chat.PushTalk(MsgNULL);
        }
    }, 1000);
    //飞屏测试代码
    //setInterval(function() { $chat.PushTalk({ "op_type": 46, "msg": { "invisible": false, "m_senderPlayerType": 2, "forbid_talk_all_room": false, "isOnLive": false, "nest_assistant": false, "senderIcon": "", "NickColor": "", "channel": 2, "msg": "$t$测试$z$if14$18$18$", "TextColor": "", "senderPlayerID": "7810934898688666", "isSelf": 0, "senderPlayerZoneID": 0, "systemType": 0, "targetVipLevel": 0, "senderName": "WWWWWWW", "targetGuardLevel": 0, "receiverName": "", "ban": false, "senderZoneName": "梦工厂", "perpetual": false, "receiverZoneName": "", "wealth_level": 9, "sender_jacket": 0, "add_anchor_exp": 0, "sender_defend": 100, "isTakeVip": false, "viplevel": 5, "vipCardPattern": "Znewui_sphuangdmpback", "judge_type": -1, "video_guild_id": "", "receiverPlayerID": "", "receiverPlayerType": 0, "flag": 0, "senderDeviceType": 2, "m_in_vip_seat": false, "m_is_free_whistle": false, "m_is_purple": false }, "chatnodes": [{ "nodeType": 0, "content": "测试" }, { "nodeType": 1, "content": "f14" }], "isSelf": true }); }, 5000);



    talkInfo.chat = $chat;
    talkInfo.chat_request = $chat_request;
    talkInfo.chat_response = $chat_response;
    talkInfo.chat_surpruse = $chat_surpruse;
    talkInfo.FreeGift = FreeGift;
    talkInfo.GiftTip = GiftTip;
    talkInfo.barragePattern = barragePattern;
    // callcenter.request_room_status(OpType.RECEIVE_ROOM_STATUS);

    // // //主动下发下消息监听 46 聊天区消息广播
    // callcenter.addRespListener(OpType.RECEIVE_CHAT_INFO, talkInfo.chat.talkCallBack);
    // //205 是否有后援团以及权限，当前直播的主播是否是后援团所支持的主播
    // callcenter.addRespListener(OpType.RECEIVE_GROUP_AUTH, talkInfo.chat.FansGuildInit);
    // //226 是否有后援团以及权限，当前直播的主播是否是后援团所支持的主播
    // callcenter.addRespListener(OpType.RECEIVE_GROUP_AUTH, talkInfo.chat.FansGuildInit);
    // 35 刷新房间状态
    // callcenter.addRespListener(callcenter.OP_TYPE.RECEIVE_ROOM_STATUS, FreeGift.responseGiftMessage);
    // 36 礼物消息广播
    // callcenter.addRespListener(callcenter.OP_TYPE.GIFT_INFO_BROADCAST, FreeGift.responseGiftMessage);
    // 38 免费礼物更新的通知
    callcenter.addRespListener(callcenter.OP_TYPE.FREE_GIFT_UPDATE, FreeGift.responseFreeGift);
    // 46 聊天消息广播
    callcenter.addRespListener(callcenter.OP_TYPE.RECEIVE_CHAT_INFO, $chat.talkCallBack);
    // 忽略免费礼物消息接口 292
    callcenter.addRespListener(callcenter.OP_TYPE.IGNORE_FREE_GIFT_INFO, $chat.hideFreeGiftCallBack);
    callcenter.addRespListener(callcenter.OP_TYPE.PUSH_ROOM_BAN_NOTICE, $chat.pushRoomBanNoticeCallBack);
    // 惊喜宝箱
    // -100 
    // callcenter.addRespListener(callcenter.OP_TYPE.INIT_FINISHED_BOX, $chat_response.initFinashedBoxCallback);
    // 224 查询惊喜宝箱奖励
    // callcenter.addRespListener(callcenter.OP_TYPE.QUERY_SUPRISE_REWARDS,function(resp,params){
    //     $chat_response.getBoxGiftCallBack(resp,true);
    // });
    // // 225 打开惊喜宝箱返回
    // callcenter.addRespListener(callcenter.OP_TYPE.OPEN_SUPRISE_BOX_RETURN, $chat_response.openBoxCallback);
    // // 226 更新惊喜宝箱
    // callcenter.addRespListener(callcenter.OP_TYPE.UPDATE_SUPRISE_BOX, $chat_response.updateSurpriseBoxCallback);
    // // 227 获得惊喜宝箱数据
    // callcenter.addRespListener(callcenter.OP_TYPE.GET_SUPRISE_REWARDS, $chat_response.getSurpriseTreasureCallBack);
    // // 142 获得宝箱数据的提示
    // callcenter.addRespListener(callcenter.OP_TYPE.GET_SUPRISE_BOX, $chat_response.getBoxGiftActionCallBack);

    window.$chat = $chat;
    window.$chat_response = $chat_response;
    window.$chat_surpruse = $chat_surpruse;
    window.FreeGift = FreeGift;
    window.GiftTip = GiftTip;
    return talkInfo;
});

