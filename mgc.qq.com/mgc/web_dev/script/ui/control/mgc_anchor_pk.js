/**
 * Created by 77 on 2015/10/8.
 */
/**
 * Todo:1.主播PK
 */
define(['mgc_callcenter', 'mgc_tool', 'mgc_consts'], function(callcenter, tool, consts) {
    var control = {};
    var currentObj = {
        $pk_con: $("#pk-con"),//PK信息条
        $pk_rocket: $("#pk-rocket"),//火箭buff
        $pk_start: $("#pk-start"),//PK倒计时
        $pk_rocket_count_down: $("#pk-rocket .pk-rocket-count-down"),//火箭buff倒计时元素
        $pk_count_down: $("#pk-count-down"),//PK比赛倒计时
        $pk_start_count_down: $("#pk-start-count-down"),//PK比赛开启倒计时
        $pk_anchor_img_current: $("#pk-anchor-img-current"),//第一个主播头像
        $pk_anchor_img_other: $("#pk-anchor-img-other"),//第二个主播头像
        $pk_anchor_name_current: $("#pk-anchor-name-current span"),//第一个主播昵称
        $pk_anchor_name_other: $("#pk-anchor-name-other span"),//第二个主播昵称
        $pk_progress: $("#pk-progress"),//PK条
        $pk_progress_left: $("#pk-progress .pk-progress-left"),//第一个主播进度条
        $pk_progress_right: $("#pk-progress .pk-progress-right"),//第二个主播进度条
        $pk_progress_exp_left: $("#pk-progress .pk-progress-exp-left"),//第一个主播PK值
        $pk_progress_exp_right: $("#pk-progress .pk-progress-exp-right"),//第二个主播PK值
        $pk_end_effect: $(".pk-end-effect"),//GO特效、PK结果特效     
        $pk_go_effect: $(".pk-go-effect"),//GO特效、PK结果特效     
        $btn_pk_rank: $(".btn-pk"),//pk排行榜按钮
        $panl_pk_rank: $(".pk-rank"),//pk排行榜层
        progress_total: 460,//PK条总长度
        progress_left: 230,//PK条左边长度
        progress_right: 230,//PK条右边长度
        progress_animate_percent: 5,//最小移动距离
        pk_go_end: false,//pk开始倒计时播放完毕或者不需要播
        //PK信息
        pk_data: { m_pk_status: 0, m_pk_count_down: 0, m_first_anchor_id: 0, m_first_anchor_url: "", m_first_anchor_name: "", m_first_pk_value: 0, m_second_anchor_id: 0, m_second_anchor_url: "", m_second_anchor_name: "", m_second_pk_value: 0, m_left_time: 0 },
        /*
        *重置PK信息
        */
        reset_view: function() {
            this.pk_data = { m_pk_status: 0, m_pk_count_down: 0, m_first_anchor_id: 0, m_first_anchor_url: "", m_first_anchor_name: "", m_first_pk_value: 0, m_second_anchor_id: 0, m_second_anchor_url: "", m_second_anchor_name: "", m_second_pk_value: 0, m_left_time: 0 };
            currentObj.$pk_anchor_img_current.attr({ 'anchor_id': '', 'src': consts.filePath.DEFAULT_FEMALE });
            currentObj.$pk_anchor_img_other.attr({ 'anchor_id': '', 'src': consts.filePath.DEFAULT_FEMALE });
            currentObj.$pk_anchor_name_current.html("");
            currentObj.$pk_anchor_name_other.html("");
            currentObj.$pk_anchor_name_current.parent().hide();
            currentObj.$pk_anchor_name_other.parent().hide();
            currentObj.$pk_count_down.hide();
            currentObj.$pk_rocket.hide();
            currentObj.$pk_count_down.removeAttr('second');
            currentObj.$pk_progress_exp_left.html("");
            currentObj.$pk_progress_exp_right.html("");
            currentObj.$pk_progress_left.width(230);
            currentObj.$pk_progress_right.width(230);
        },
        /*
        * 刷新PK信息
        * d:数据
        * t:是否只刷新进度条
        */
        refresh_pk_view: function(d, t) {
            if (d.m_pk_status < 2)
                return;
            if (!t && currentObj.pk_go_end) {
                d.m_first_anchor_url = d.m_first_anchor_url == "" ? consts.filePath.DEFAULT_FEMALE : d.m_first_anchor_url;
                d.m_second_anchor_url = d.m_second_anchor_url == "" ? consts.filePath.DEFAULT_FEMALE : d.m_second_anchor_url;
                currentObj.$pk_anchor_img_current.attr({ 'anchor_id': d.m_first_anchor_id, 'src': d.m_first_anchor_url });
                currentObj.$pk_anchor_img_other.attr({ 'anchor_id': d.m_second_anchor_id, 'src': d.m_second_anchor_url });
                currentObj.$pk_anchor_name_current.html(d.m_first_anchor_name);
                currentObj.$pk_anchor_name_other.html(d.m_second_anchor_name);
                //PK倒计时
                if (d.m_pk_status == 2 && currentObj.$pk_count_down.attr('second') == undefined) {
                    currentObj.$pk_anchor_name_current.parent().show();
                    currentObj.$pk_anchor_name_other.parent().show();
                    currentObj.$pk_count_down.show();
                    currentObj.$pk_rocket.show();
                    callcenter.get_system_time(function(resp, param) {
                        var now_time = resp.server_time;
                        var end_time = param.m_end_time;
                        var count_down = end_time - now_time;
                        //倒计时校准
                        count_down = count_down > param.m_left_time ? param.m_left_time : count_down;
                        tool.progressCountDown(currentObj.$pk_count_down, count_down, 0, {
                            10: function() {
                                //倒计时剩余10s时红色字体闪烁
                                var i = 0, _iTimer = setInterval(function() {
                                    if (i % 2 == 0) {
                                        currentObj.$pk_count_down.css('color', '#fff');
                                    } else {
                                        currentObj.$pk_count_down.css('color', '#ff8b2e');
                                    }
                                    if (currentObj.$pk_count_down.attr('second') == '0') {
                                        clearInterval(_iTimer);
                                        currentObj.$pk_count_down.css('color', '#fff');
                                    }
                                    i++;
                                }, 400);
                            }
                        });
                    }, d);
                }
            }
            currentObj.$pk_progress_exp_left.html(d.m_first_pk_value);
            currentObj.$pk_progress_exp_right.html(d.m_second_pk_value);
            //PK条左边长度
            var _progress_left = Math.round(currentObj.progress_total * ((d.m_first_pk_value + 1000) / (d.m_first_pk_value + d.m_second_pk_value + 1000 + 1000)));
            //PK条左边移动刻度
            var _progress_animate_percent = Math.abs(currentObj.progress_left - _progress_left);
            //是否满足最小移动刻度
            if (_progress_animate_percent >= currentObj.progress_animate_percent) {
                currentObj.progress_left = _progress_left;
                currentObj.progress_right = currentObj.progress_total - _progress_left;
                currentObj.$pk_progress_left.stop().animate({ width: currentObj.progress_left }, 200);
                currentObj.$pk_progress_right.stop().animate({ width: currentObj.progress_right }, 200);
            }
        },
        /*
        * tips定位
        */
        comm_tips_position: function(obj) {
            var mouseXY = tool.offsetEvent.mouseXY();
            var clientXY = tool.offsetEvent.clientXY();
            var scrollXY = tool.offsetEvent.scrollXY();
            var _w = obj.width();
            var _x = mouseXY.X;
            var _y = mouseXY.Y + 20;
            if (document.all)
                _x += scrollXY.X, _y += scrollXY.Y;
            obj.css({ "top": _y, "left": _x });
        },
        //PK tips dom
        PK_TIPS_DOM_HTML: '<div id="pk-progress-tips">送出免费鲜花、炫豆礼物及使用幸运转盘功能都可为当前直播间内主播增加PK值哦~</div>',
        /*
        * 初始化
        */
        initProgress: function(is_pk) {
            if (is_pk || tool.getUrlParam('is_pk') == "true") {
                currentObj.$pk_con.show();
                currentObj.$btn_pk_rank.show();
            }
            $("body").append(currentObj.PK_TIPS_DOM_HTML),
            //绑定主播名片事件
            currentObj.$pk_anchor_img_current.click(function(e) {
                var anchor_id = currentObj.$pk_anchor_img_current.attr('anchor_id');
                if (anchor_id != "")
                    MGC_CommRequest.getAnchorCard(anchor_id);
            }),
            currentObj.$pk_anchor_img_other.click(function(e) {
                var anchor_id = currentObj.$pk_anchor_img_other.attr('anchor_id');
                if (anchor_id != "")
                    MGC_CommRequest.getAnchorCard(anchor_id);
            }),
            //绑定PK条tips
            currentObj.$pk_progress.hover(function(e) {
                susTips = $('#pk-progress-tips');
                currentObj.comm_tips_position(susTips);
                mgc.popmanager.layerControlShow(susTips, 3, 3);
            }, function(e) {
                susTips = $('#pk-progress-tips');
                mgc.popmanager.layerControlHide(susTips, 3, 3);
            });
        }
    }
    //初始化
    currentObj.initProgress();
    /*
    * flash特效回调函数
    */
    window.UI_PK_close_flash_callback = function(t) {
        if (t != 0) {
            currentObj.$pk_end_effect.hide().html('<p id="pk-end-effect-con"></p>');
            currentObj.$pk_con.hide();
            currentObj.$btn_pk_rank.hide();
            currentObj.$panl_pk_rank.hide();
            $(".pk-rank").hide();
            //重置PK信息
            currentObj.reset_view();
        } else {
            currentObj.$pk_go_effect.hide().html('<p id="pk-go-effect-con"></p>');
        }
    }
    control.Req = {
        //.todo
    }
    control.Resp = {
        /*
        * 刷新火箭buffer信息
        */
        pk_refresh_rocket_buffer_resp: function(resp, param) {
            //剩余time
            callcenter.get_system_time(function(resp, param) {
                var second = param.buff_end_time - resp.server_time;
                //倒计时校准
                second = second > param.buff_left_time ? param.buff_left_time : second;
                if (param && second > 0) {
                    //高亮
                    if (document.getElementById("pk-rocket-swf").tagName == "OBJECT")
                        $("#pk-rocket-swf").show();
                    else
                        tool.initSwf('pk-rocket-swf', 'pk-rocket-swf', 'assets/pk_rocket.swf');
                    currentObj.$pk_rocket_count_down.show();
                    tool.progressCountDown(currentObj.$pk_rocket_count_down, second, 1, {
                        0: function() {
                            //置灰
                            $("#pk-rocket-swf").hide();
                            currentObj.$pk_rocket_count_down.hide();
                        }
                    });
                } else {
                    //置灰
                    $("#pk-rocket-swf").hide();
                    currentObj.$pk_rocket_count_down.hide();
                }
            }, resp);
        },
        /*
        * 刷新PK进度信息
        */
        pk_refresh_progress_info_resp: function(resp, param) {
            if (resp) {
                //判断是否当前主播，将当前主播的数据存储于 _first_ 标示中
                if (MGCData.anchorID == resp.m_first_anchor_id) {
                    currentObj.pk_data.m_first_anchor_id = resp.m_first_anchor_id;
                    currentObj.pk_data.m_second_anchor_id = resp.m_second_anchor_id;
                    currentObj.pk_data.m_first_anchor_name = resp.m_first_anchor_name;
                    currentObj.pk_data.m_second_anchor_name = resp.m_second_anchor_name;
                    currentObj.pk_data.m_first_anchor_url = resp.m_first_anchor_url;
                    currentObj.pk_data.m_second_anchor_url = resp.m_second_anchor_url;
                    currentObj.pk_data.m_first_pk_value = Math.round(resp.m_first_anchor_pk_value / 1000);
                    currentObj.pk_data.m_second_pk_value = Math.round(resp.m_second_anchor_pk_value / 1000);
                } else {
                    currentObj.pk_data.m_first_anchor_id = resp.m_second_anchor_id;
                    currentObj.pk_data.m_second_anchor_id = resp.m_first_anchor_id;
                    currentObj.pk_data.m_first_anchor_name = resp.m_second_anchor_name;
                    currentObj.pk_data.m_second_anchor_name = resp.m_first_anchor_name;
                    currentObj.pk_data.m_first_anchor_url = resp.m_second_anchor_url;
                    currentObj.pk_data.m_second_anchor_url = resp.m_first_anchor_url;
                    currentObj.pk_data.m_first_pk_value = Math.round(resp.m_second_anchor_pk_value / 1000);
                    currentObj.pk_data.m_second_pk_value = Math.round(resp.m_first_anchor_pk_value / 1000);
                }
                currentObj.refresh_pk_view(currentObj.pk_data, false);
            }
        },
        /*
        * 刷新PK比赛信息
        */
        pk_refresh_game_info_resp: function(resp, param) {
            if (resp) {
                isPkRoom = true;
                if (resp.m_pk_status == 1) {
                    //倒计时中
                    callcenter.get_system_time(function(resp, param) {
                        var now_time = resp.server_time;
                        var begin_time = param.m_begin_time;
                        var count_down = begin_time - now_time;
                        //倒计时校准
                        count_down = count_down > param.m_left_time ? param.m_left_time : count_down;
                        if (count_down > 0) {
                            currentObj.pk_data.m_pk_status = 1;
                            currentObj.$pk_start.show();
                            //todo  倒计时
                            tool.progressCountDown(currentObj.$pk_start_count_down, count_down, 2, {
                                0: function() {
                                    //GO  >  show progress
                                    currentObj.pk_go_end = true;
                                    currentObj.$pk_start.hide();
                                    currentObj.$pk_go_effect.css({ "top": $(".layer-video").height() / 2, "margin-top": -230 }).show();
                                    currentObj.$pk_con.show();
                                    currentObj.$btn_pk_rank.show();
                                    //清除榜单数据
                                    mgc.rankPaneModel.set("anchorList", []);
                                    mgc.rankPaneModel.set("fansList", []);
                                    tool.initSwf('pk-go-effect-con', 'pk-go-effect-con', 'assets/pk_go.swf');
                                    if (currentObj.pk_data.m_pk_status == 2) {
                                        currentObj.refresh_pk_view(currentObj.pk_data, false);
                                    }
                                }
                            });
                        } else {
                            //PK进行中
                            currentObj.pk_go_end = true;
                            param.m_pk_status = 2;
                            control.Resp.pk_refresh_game_info_resp(param);
                        }
                    }, resp);
                    return;
                } else if (resp.m_pk_status == 2) {
                    //PK进行中     
                    if (currentObj.pk_data.m_pk_status != 1) {
                        currentObj.pk_go_end = true;
                        currentObj.$pk_con.show();
                        currentObj.$pk_rocket.show();
                        currentObj.$btn_pk_rank.show();
                        //清除榜单数据
                        mgc.rankPaneModel.set("anchorList", []);
                        mgc.rankPaneModel.set("fansList", []);
                    }
                } else if (resp.m_pk_status == 3) {
                    //PK结束
                    //停止倒计时
                    tool.progressCountDown(currentObj.$pk_count_down, 0, 0, null);
                    tool.progressCountDown(currentObj.$pk_rocket_count_down, 0, 1, null);
                    $("#pk-rocket-swf").hide();
                    currentObj.$pk_count_down.css('color', '#fff');
                    currentObj.$pk_rocket_count_down.hide();
                    currentObj.$pk_end_effect.show();
                    //比赛结果展示
                    var swfName = "";
                    var m_first_pk_value = Math.round(resp.m_first_pk_value / 1000);
                    var m_second_pk_value = Math.round(resp.m_second_pk_value / 1000);
                    if ((MGCData.anchorID == resp.m_first_anchor_id && parseInt(m_first_pk_value) > parseInt(m_second_pk_value)) || (MGCData.anchorID == resp.m_second_anchor_id && parseInt(m_first_pk_value) < parseInt(m_second_pk_value))) {
                        //win
                        swfName = "pk_win.swf";
                    } else if ((MGCData.anchorID == resp.m_first_anchor_id && parseInt(m_first_pk_value) < parseInt(m_second_pk_value)) || (MGCData.anchorID == resp.m_second_anchor_id && parseInt(m_first_pk_value) > parseInt(m_second_pk_value))) {
                        //lose
                        swfName = "pk_lose.swf";
                    } else {
                        //tie
                        swfName = "pk_tie.swf";
                    }
                    tool.initSwf('pk-end-effect-con', 'pk-end-effect-con', 'assets/' + swfName);
                } else if (resp.m_pk_status == 4) {
                    //PK比赛异常处理
                    window.UI_PK_close_flash_callback(1);
                    return;
                }
                //重绘PK进度                
                currentObj.pk_data.m_begin_time = resp.m_begin_time;
                currentObj.pk_data.m_end_time = resp.m_end_time;
                currentObj.pk_data.m_left_time = resp.m_left_time;
                //判断是否当前主播，将当前主播的数据存储于 _first_ 标示中
                if (MGCData.anchorID == resp.m_first_anchor_id) {
                    currentObj.pk_data.m_first_anchor_id = resp.m_first_anchor_id;
                    currentObj.pk_data.m_second_anchor_id = resp.m_second_anchor_id;
                    currentObj.pk_data.m_first_pk_value = Math.round(resp.m_first_pk_value / 1000);
                    currentObj.pk_data.m_second_pk_value = Math.round(resp.m_second_pk_value / 1000);
                } else {
                    currentObj.pk_data.m_first_anchor_id = resp.m_second_anchor_id;
                    currentObj.pk_data.m_second_anchor_id = resp.m_first_anchor_id;
                    currentObj.pk_data.m_first_pk_value = Math.round(resp.m_second_pk_value / 1000);
                    currentObj.pk_data.m_second_pk_value = Math.round(resp.m_first_pk_value / 1000);
                }
                if (currentObj.pk_data.m_pk_status == 1) {
                    currentObj.pk_data.m_pk_status = resp.m_pk_status;
                } else {
                    currentObj.pk_data.m_pk_status = resp.m_pk_status;
                    currentObj.refresh_pk_view(currentObj.pk_data, false);
                }
            }
        },
        /*
        * 刷新PK值信息
        */
        pk_refresh_value_resp: function(resp, param) {
            if (resp) {
                //判断是否当前主播，将当前主播的数据存储于 _first_ 标示中
                if (MGCData.anchorID == resp.m_first_anchor_id) {
                    currentObj.pk_data.m_first_pk_value = Math.round(resp.m_first_anchor_pk_value / 1000);
                    currentObj.pk_data.m_second_pk_value = Math.round(resp.m_second_anchor_pk_value / 1000);
                } else {
                    currentObj.pk_data.m_first_pk_value = Math.round(resp.m_second_anchor_pk_value / 1000);
                    currentObj.pk_data.m_second_pk_value = Math.round(resp.m_first_anchor_pk_value / 1000);
                }
                currentObj.refresh_pk_view(currentObj.pk_data, true);
            }
        }
    }
    //主动下发消息监听
    callcenter.addRespListener(callcenter.OP_TYPE.PK_REFRESH_ROCKET_BUFFER, control.Resp.pk_refresh_rocket_buffer_resp);
    callcenter.addRespListener(callcenter.OP_TYPE.PK_REFRESH_PROGRESS_INFO, control.Resp.pk_refresh_progress_info_resp);
    callcenter.addRespListener(callcenter.OP_TYPE.PK_REFRESH_GAME_INFO, control.Resp.pk_refresh_game_info_resp);
    callcenter.addRespListener(callcenter.OP_TYPE.PK_REFRESH_VALUE, control.Resp.pk_refresh_value_resp);
    //测试数据
    //setTimeout(function() {
    //    //PK_REFRESH_ROCKET_BUFFER
    //    //var data1 = { op_type: callcenter.OP_TYPE.PK_REFRESH_ROCKET_BUFFER, room_id: 0, buff_end_time: new Date() };
    //    //setInterval(function() {
    //    //    data1.buff_end_time = new Date(new Date().getTime() + 15000);
    //    //    mgc.network.recvMsg(data1);
    //    //}, 15000);
    //    ////PK_REFRESH_PROGRESS_INFO
    //    //var data2 = { op_type: callcenter.OP_TYPE.PK_REFRESH_PROGRESS_INFO, m_first_anchor_id: "2374324455", m_second_anchor_id: "1045853649", m_first_anchor_name: "第一个主播的名字", m_second_anchor_name: "第二个主播的名字哈", m_first_anchor_url: "http://p.qpic.cn/qdancersec/PiajxSqBRaEIl11X5nrn0u1K8XkywDRpjo982Rt3hmcguo6GiaqAstz8SMGIiaGSLaPhlEujxN38QY/0?v=1472678363", m_second_anchor_url: "", m_first_pk_value: 500, m_second_pk_value: 1000 };
    //    //mgc.network.recvMsg(data2);
    //    ////PK_REFRESH_GAME_INFO
    //    //var data3 = { op_type: callcenter.OP_TYPE.PK_REFRESH_GAME_INFO, m_pk_status: 1, m_begin_time: new Date(new Date().getTime() + 5000), m_end_time: new Date(new Date().getTime() + 70000), m_first_anchor_id: "2374324455", m_second_anchor_id: "1045853649", m_first_pk_value: 100, m_second_pk_value: 200 };
    //    //mgc.network.recvMsg(data3);
    //    //setTimeout(function() {
    //    //    data3.m_pk_status = 2;
    //    //    mgc.network.recvMsg(data3);
    //    //}, 6000);
    //    ////PK_REFRESH_VALUE
    //    //var data4 = { op_type: callcenter.OP_TYPE.PK_REFRESH_VALUE, m_first_anchor_id: "2374324455", m_second_anchor_id: "1045853649", m_first_pk_value: 100, m_second_pk_value: 100 };
    //    ////mgc.network.recvMsg(data4);
    //    //var k = 0;
    //    //setTimeout(function() {
    //    //    setInterval(function() {
    //    //        if (k % 100000 > 5)
    //    //            data4.m_first_pk_value += 1000;
    //    //        else
    //    //            data4.m_second_pk_value += 1000;
    //    //        mgc.network.recvMsg(data4);
    //    //        k++;
    //    //    }, 2000);
    //    //}, 10000);
    //    //setTimeout(function() {
    //    //    data3.m_pk_status = 3;
    //    //    mgc.network.recvMsg(data3);
    //    //}, 200000);
    //    mgc.network.recvMsg({ "m_pk_status": 1, "m_second_pk_value": "0", "m_begin_time": 1473390600, "m_end_time": 1473392400, "m_first_anchor_id": "40999356", "m_second_anchor_id": "249337659", "op_type": 324, "m_first_pk_value": "0" });
    //    mgc.network.recvMsg({ "m_second_anchor_pk_value": "268010000", "m_first_anchor_id": "40999356", "m_first_anchor_pk_value": "160010000", "m_second_anchor_id": "249337659", "op_type": 325 });
    //}, 5000);
    //mgc.network.recvMsg({ "m_pk_status": 3, "m_second_pk_value": "0", "m_begin_time": 1473304500, "m_end_time": 1473306300, "m_first_anchor_id": "40999356", "m_second_anchor_id": "249337659", "op_type": 324, "m_first_pk_value": "522000" });
    //network---recvMsg:{"m_pk_status":1,"m_second_pk_value":"0","m_begin_time":1473390600,"m_end_time":1473392400,"m_first_anchor_id":"40999356","m_second_anchor_id":"249337659","op_type":324,"m_first_pk_value":"0"}
    //network---recvMsg:{"m_first_anchor_name":"109大","m_first_anchor_pk_value":"0","m_first_anchor_url":"you are lucky/0?v=1438868871","m_second_anchor_url":"","m_first_anchor_id":"40999356","m_second_anchor_name":"rtggdghrt","m_second_anchor_id":"249337659","m_second_anchor_pk_value":"118012000","op_type":323}
    //network---recvMsg:{"buff_end_time":1473390780,"room_id":1170,"op_type":322}
    //network---recvMsg:{"m_second_anchor_pk_value":"168010000","m_first_anchor_id":"40999356","m_first_anchor_pk_value":"0","m_second_anchor_id":"249337659","op_type":325}
    return control;
});