/**
 * @Description:   梦工厂web-控制-抽奖
 *
 * @author         Xu XiaoJing
 * @version        V1.0
 * @Date           2016/03/03
 * @Company        horizon3d
 */
define(['jquery', 'mgc_callcenter','mgc_luckydraw_coll', 'mgc_luckydraw_view', 'mgc_luckydraw_model', 'mgc_tool', 'mgc_consts', 'mgc_popmanager', 'mgc_account', 'mgc_tips', 'mgc_dialog'], function($, callcenter,mgc_luckydraw_coll, mgc_luckydraw_view, mgc_luckydraw_model, tool, consts, mgc_popmanager, mgc_account ,mgc_tips, mgc_dialog) {
    $(function() {
        //抽奖开始时间
        var beginTime = 0;
        //配置更新时间
        var refreshTime = 0;
        //抽奖状态默认为0，可以免费抽，有新配置为1
        var redStat = 0;
        var newStat = 0;
        function drawButtonStat() {
            if (newStat == 1) {
                $("#icon_new").show();
                $("#icon_red").hide();
            } else {
                if (redStat == 1) {
                    $("#icon_new").hide();
                    $("#icon_red").show();
                } else {
                    $("#icon_new").hide();
                    $("#icon_red").hide();
                }
            }
        }
        //新手引导
        function drawPrompt() {
            if (tool.cookie("draw_prompt") != "draw_prompt") {
                $('#draw_prompt').show();
                $('#prompt_close').unbind('click').bind('click', function() {
                    $('#draw_prompt').hide();
                });
                setTimeout("$('#draw_prompt').fadeOut();", 30000);
                tool.cookie("draw_prompt", "draw_prompt", {
                    expires: 365 * 24 * 60
                });
            }
        }
        //抽一次
        $('#button_div').unbind('click').bind('click', function() {
            $('#draw_prompt').hide();
            if (mgc_account.checkGuestStatus(false)) {
                return;
            } else {
                $("#draw_one_con").hide();
                $("#draw_ten_con").hide();
                $("#draw_div").attr("class", "main_back");
                $("#draw_container").show();
                luckydraw_request.getDraw();
            }
        });

        window.mgc.luckyDialog = function() {
            tool.commonDialog({
                "Title": "提示",
                BtnNum: 2,
                BtnName: "是",
                BtnName2: "否",
                "Note": "您的专属礼物不够了！您可以通过幸运转盘有机会获得该礼物，是否开启幸运转盘？"
            }, function() {
                $('#draw_prompt').hide();
                if (mgc_account.checkGuestStatus(false)) {
                    return;
                } else {
                    $("#draw_one_con").hide();
                    $("#draw_ten_con").hide();
                    $("#draw_div").attr("class", "main_back");
                    $("#draw_container").show();
                    luckydraw_request.getDraw();
                }
            });
        };
        /*
        window.mgc.luckyDialog = function() {
            mgc_prompt.show({
                Title: "提示",
                BtnNum: 2,
                BtnName : ['是','否'],
                Note: "您的专属礼物不够了！您可以通过幸运转盘有机会获得该礼物，是否开启幸运转盘？"
            }, function() {
                $('#draw_prompt').hide();
                // if (mgc_account.checkGuestStatus(false)) {
                //     return;
                // } else {
                    $("#draw_one_con").hide();
                    $("#draw_ten_con").hide();
                    $("#draw_div").attr("class", "main_back");
                    $("#draw_container").show();
                    luckydraw_request.getDraw();
                // }
            });
        };*/

        //UI锁
        var uiLock = false;
        $('.draw_close').unbind('click').bind('click', function() {
            if (!uiLock) {
                window.mgc.popmanager.layerControlHide($("#draw_div"), 4, 1);
                luckydraw_request.drawClose();
            }
        });
        //抽十次奖品的位置
        var tenPrizeList = $("#draw_ten_con").find(".prize_ten");
        var tenFlashList = $("#draw_ten_con").find(".flash_ten");
        for (var i = 0; i < tenPrizeList.size() ; i++) {
            var topTen = 68;
            var leftTen = 11;
            if (i > 4) {
                topTen = 194;
                leftTen = leftTen - 535;
            }
            $(tenPrizeList.get(i)).css({
                "top": topTen,
                "left": leftTen + 107 * i
            });
        }

        //温馨提示
        var promptTxt = "1.获得的奖品可以增加主播经验、<br>玩家亲密度、财富值和房间热度等<br>数值哦~<br>";
        promptTxt += "2.获得的视频礼物或主播经验奖品<br>会直接送给麦上主播<br>";
        promptTxt += "3.祝君好运~";
        // var leftx= parseInt($(".content").css("marginLeft"));
        mgc_tips.commonTips(promptTxt, $("#prompt"), 4);
        /*$("#prompt").off('mouseover mouseout').on({
            mouseover: function (e) {
                mgc_tips.show({
                    Type: 0,
                    Note: promptTxt,
                    Position: { w: 180,x:0, y:0},
                    MainType: 4
                });
            },
            mouseout: function () {
                mgc_tips.hide();
            }
        });*/


        //抽一次========================================
        var selectPos = 1;
        var selectMove = false;
        var canStop = false;
        var mustStop = false;
        var stopPos = 1;
        //开始转后多久停
        var waitTime = 2000;
        var timeOutTime = 30000;
        //开始转后10秒钟超时
        var reqTimeout;
        var drawType = "one";
        //转的函数
        function drawFun(type) {
            uiLock = true;
            if (selectMove == false) {
                $('#draw_container').find(".selected").attr("class", "prize");
                drawType = type;
                if ($('#draw_container').css("display") != "none") {
                    try {
                        // window.mgc.LuckEffect.init();
                        window.mgc.LuckEffect.show(true);
                        console.log("2:draw_one click====================");
                        // setTimeout(window.mgc.LuckEffect.start,2000);
                        window.mgc.LuckEffect.start();
                        console.log("3:draw_one click====================");
                    } catch (e) {
                        console.log("draw_onedraw_one:" + e.message);
                    }
                }

                if (type == "one") {
                    luckydraw_request.drawOne();
                } else {
                    luckydraw_request.drawTen();
                }
                reqTimeout = setTimeout(function() {
                    mustStopFlash();
                    uiLock = false;
                    tool.commonDialog({
                        "Title": "提示信息",
                        "Note": "很抱歉，与服务器连接超时。"
                    }, function() {
                        window.location.reload();
                    });
                }, 10000);
            }
        }



        function stopFlash() {
            //可以停了并且移动到位了
            canStop = true;
            window.mgc.LuckEffect.stop(stopPos - 1);
        }
        function mustStopFlash() {
            //可以停了并且移动到位了
            mustStop = true;
            window.mgc.LuckEffect.stop(0);
            window.mgc.LuckEffect.show(false);
        }

        window.mgc.luckyFlashStop = function() {
            if (mustStop == true) {
                mustStop = false;
                canStop = false;
                selectMove = false;
            } else {
                canStop = false;
                selectMove = false;
                if ($("#draw_container").css("display") != "none") {
                    //多等一秒
                    setTimeout(function() {
                        //$('#draw_container').find("#prize" + stopPos).attr("class", "prize selected");
                        if ($('#draw_container').css("display") != "none") {
                            window.mgc.LuckEffect.show(false);
                        }
                        $("#draw_container").fadeOut(1000, function() {
                            showFun(drawType);
                        });
                    }, 1000);
                } else {
                    showFun(drawType);
                }
            }
        };



        //特效函数
        function showFun(type) {
            $("#draw_div").attr("class", "result_back");
            if (type == "one") {
                $("#draw_one_con").show();
                $("#prize_one").show();
                $("#prize_one").attr("class", "star_one");
                flashShow(type);
                showTimeDiv = true;
            } else {
                $("#draw_ten_con").show();
                tenPrizeList.attr("class", "star_ten");
                var tenCard = 0;
                var starInterval = setInterval(function() {
                    $(tenPrizeList.get(tenCard)).show();
                    tenCard++;
                    if (tenCard == 10) {
                        flashShow(type);
                        clearInterval(starInterval);
                    }
                }, 100);
                //tenPrizeList.show();
            }

        }
        //特效函数
        function flashShow(type) {
            var swfVersionStr = "11.1.0";
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
            attributes.id = "drawAnimation";
            attributes.name = "drawAnimation";
            attributes.align = "middle";
            var swfurl = "http://ossweb-img.qq.com/images/mgc/css_img/flash/draw/flash.swf?v=3_7_4_2015_34_3_" + (new Date()).getTime();
            if (type == "one") {
                swfobject.embedSWF(swfurl, "draw_flash_con", "100%", "100%", swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
                $('#flash_one').show();
                setTimeout(function() {
                    $('#flash_one').hide();
                    $("#prize_one").attr("class", "prize");
                    $("#draw_one_rt").show();
                    $("#draw_one_again").show();
                    uiLock = false;
                }, 1000);
            } else {
                swfurl = "http://ossweb-img.qq.com/images/mgc/css_img/flash/draw/flash10.swf?v=3_7_4_2015_34_3_" + (new Date()).getTime();
                swfobject.embedSWF(swfurl, "flash_ten_con", "100%", "100%", swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
                $('.flash_ten').show();
                setTimeout(function() {
                    $('.flash_ten').hide();
                    tenPrizeList.attr("class", "prize_ten");
                    $("#draw_ten_rt").show();
                    $("#draw_ten_again").show();
                    uiLock = false;
                }, 1000);
            }
        }

        $('#draw_one').find(".click_area").unbind('click').bind('click', function() {
            console.log("1:draw_one click====================");
            if (!uiLock) {
                waitTime = 2000;
                drawFun("one");
            }
        });

        //$('body').unbind('mouseup').bind('mouseup', function() {
        //    $(".draw_btn").find("div.click_area_cost2").attr("class", "click_area click_area_cost");
        //    $(".draw_btn").find("div.click_area_free2").attr("class", "click_area click_area_free");
        //    $(".draw_btn").find("div.click_area2").attr("class", "click_area");
        //});

        //$('#draw_one,#draw_one_again').unbind('mousedown').bind('mousedown', "div", function() {
        //    if (!uiLock) {
        //        if ($(this).attr("class") == "click_area click_area_cost") {
        //            $(this).attr("class", "click_area click_area_cost2");
        //        } else {
        //            $(this).attr("class", "click_area click_area_free2");
        //        }
        //    }
        //});

        //抽十次========================================
        $('#draw_ten').unbind('click').bind('click', "div", function() {
            console.log("抽十次========================================");
            if (!uiLock) {
                waitTime = 2000;
                drawFun("ten");
            }
        });
        //$('#draw_ten,#draw_ten_again,#draw_one_rt,#draw_ten_rt').unbind('mousedown').bind('mousedown', "div", function() {
        //    if (!uiLock) {
        //        $(this).attr("class", "click_area2");
        //    }
        //});
        //抽一次返回转盘========================================
        $('#draw_one_rt').find(".click_area").unbind('click').bind('click', function() {
            console.log("返回转盘");
            $('#draw_container').find(".selected").attr("class", "prize");
            $('#draw_container').find("#prize1").attr("class", "prize selected");
            if (!uiLock) {
                $("#draw_one_con").fadeOut(500, function() {
                    $("#draw_div").attr("class", "main_back");
                    $("#draw_container").fadeIn(500);
                });
            }
        });
        //再抽一次========================================
        $('#draw_one_again').find(".click_area").unbind('click').bind('click', function() {
            console.log("再抽一次");
            if (!uiLock) {
                waitTime = 0;
                drawFun("one");
            }
        });
        //抽十次返回转盘========================================
        $('#draw_ten_rt').find(".click_area").unbind('click').bind('click', function() {
            $('#draw_container').find(".selected").attr("class", "prize");
            $('#draw_container').find("#prize1").attr("class", "prize selected");
            if (!uiLock) {
                $("#draw_ten_con").fadeOut(500, function() {
                    $("#draw_div").attr("class", "main_back");
                    $("#draw_container").fadeIn(500);
                });
            }
        });
        //再抽十次========================================
        $('#draw_ten_again').find(".click_area").unbind('click').bind('click', function() {
            if (!uiLock) {
                waitTime = 0;
                drawFun("ten");
            }
        });
        //发送请求========================================
        var luckydraw_request = {
            getDraw: function() {
                var reqParams = {
                    begin_time: 0,
                    config_refresh_time: refreshTime
                };
                callcenter.callbackStr_req("DRAW_GET", luckydraw_callBack.getDrawCallBack, "luckydraw_callBack.getDrawCallBack", reqParams);
            },
            drawClose: function() {
                callcenter.callbackStr_req("DRAW_CLOSE");
            },
            drawOne: function() {
                var isFree = true;
                if (timeGloble > 0) {
                    isFree = false;
                }
                var reqParams = {
                    begin_time: beginTime,
                    is_free: isFree,
                    is_continuous: false,
                    config_refresh_time: refreshTime
                };
                callcenter.callbackStr_req("DRAW_BEGIN", luckydraw_callBack.drawOneCallBack, "luckydraw_callBack.drawOneCallBack", reqParams);
            },
            drawTen: function() {
                var reqParams = {
                    begin_time: beginTime,
                    is_free: false,
                    is_continuous: true
                };
                callcenter.callbackStr_req("DRAW_BEGIN", luckydraw_callBack.drawTenCallBack, "luckydraw_callBack.drawTenCallBack", reqParams);

            }
        };

        //请求回调========================================
        var luckydraw_callBack = {
            getDrawCallBack: function(obj) {
                console.log("幸运转盘"+JSON.stringify(obj.info.sub_rewards_x51));
                console.log("obj.info.star_gifts"+JSON.stringify(obj.info.star_gifts));
                var uid = mgc.account.getUin();
                tool.cookie("draw_refresh_time" + uid, null);
                //位置重置
                // $('#draw_container').find(".selected").attr("class", "prize");
                // $('#draw_container').find("#prize1").attr("class", "prize selected");
                var result = parseInt(obj.res);
                refreshTime = obj.config_refresh_time;
                // result=1;
                if (result == 0 || result == 1) {
                    var isNewUser = tool.isNewRole();
                    var isX52User = tool.isx52Area();
                    var isNest = tool.is_nest_room();
                    //var isNewUser;
                    // var isX52User;
                    // var isNest=1;
                    if (isNewUser) {
                        if (isNest) {
                                prizeArr = obj.info.rewards;
                        } else {
                            prizeArr = obj.info.sub_rewards;
                        }
                    } else if (isX52User) {
                        if (isNest) {
                            prizeArr = obj.info.rewards_x52;
                        } else {
                            prizeArr = obj.info.sub_rewards_x52;
                        }
                    } else {
                        if (isNest) {
                            prizeArr = obj.info.rewards_x51;
                        } else {
                            prizeArr = obj.info.sub_rewards_x51;
                        }
                    }
                    beginTime = obj.info.begin_time;
                    //奖品列表
                    for (var i = 0; i < prizeArr.length; i++) {
                        var numid;
                        var prizeTips;
                        prizeArr[i].numid=i+1;//为了设置奖品的ID

                        //测试数据
                        //prizeArr[i].type = 9;

                        var prizeObj = prizeArr[i];
                        if(($.inArray(prizeObj.id, obj.info.star_gifts)!=-1) && (prizeObj.type != 4)){
                            prizeObj.star_gift = true;
                        }else{
                            prizeObj.star_gift = false;
                        }
                        //图片地址url的转换
                        var _url = dealPicUrl(prizeObj.url);
                        prizeArr[i].url=_url;
                        /**
                         * tips关于mouseover时tips数据的处理
                         */
                        var prizeStr = prizeObj.name;
                        if (prizeObj.channel == 0 || prizeObj.channel == 3 || prizeObj.channel ==4) {
                            if (prizeObj.tips == "") {
                                //prizeStr = "价值<i style='color:yellow'>" + prizeObj.count_desc + "</i>炫豆的" + prizeObj.name;
                                prizeStr = prizeObj.name;
                            } else {
                                prizeStr = prizeObj.name + "<br>" + prizeObj.tips;
                            }
                        } else {
                            if (prizeObj.type == 2) {
                                //梦幻币tips特殊处理
                                prizeStr = "梦幻币<br>" + prizeObj.tips;
                            } else if (prizeObj.type == 3) {
                                prizeStr = "价值<i style='color: yellow;font-style: normal;'>" + prizeObj.price + "</i>梦幻币的" + prizeObj.name;
                            } else if (prizeObj.type == 6) {
                                prizeStr = "价值<i style='color: yellow;font-style: normal;'>" + prizeObj.price + "</i>炫豆的" + prizeObj.name;
                            } else if (prizeObj.type == 4) {
                                prizeStr = prizeObj.name;
                            } else if (prizeObj.type == 7) {
                                prizeStr = "专属礼物可以帮助房间升级！增长魅力值！";
                            } else if(prizeObj.type == 8){ //免费弹幕礼物
                                prizeStr = "弹幕<br>仅能在炫舞梦工厂app中使用";
                            }else {
                                if (prizeObj.tips == "") {
                                    //prizeStr = "价值<i style='color:yellow'>" + prizeObj.count_desc + "</i>炫豆的" + prizeObj.name;
                                    prizeStr = prizeObj.name + prizeObj.count_desc;
                                } else {
                                    //if (prizeObj.name == "主播经验") {
                                    //    prizeStr = prizeObj.tips + "+" + prizeObj.count_desc;
                                    //} else {
                                        prizeStr = prizeObj.tips;
                                    //}
                                }
                            }
                        }
                        if (prizeObj.type == 2) {
                            //梦幻币tips特殊处理
                            prizeArr[i].tipsWidth=180;
                        } else if (prizeObj.channel == 0 || prizeObj.channel == 3 || prizeObj.channel == 4) {
                            //游戏   长tips特殊处理
                            if (prizeObj.tips != "") {
                                prizeArr[i].tipsWidth=180;
                            }else{
                                prizeArr[i].tipsWidth="tips宽度自适应";
                            }
                        }else{
                            prizeArr[i].tipsWidth="tips宽度自适应";
                        }
                        prizeArr[i].prizeTips=prizeStr;  //返回一个新的obj
                        delete prizeArr[i].id;//删除字段id---当礼物id相同时，会报bug
                    }

                    /**
                     * 获取渲染的数据，
                     */
                    var lucky_draw_ItemColl_room = new mgc_luckydraw_coll.luckydrawItemColl();
                    lucky_draw_ItemColl_room.reset_data(prizeArr);

                    $('#draw_container .prize').remove();
                    for (var i = 0; i < prizeArr.length; i++) {
                        var big_luckydraw_view = new mgc_luckydraw_view.luckydrawView({ model: lucky_draw_ItemColl_room.models[i] });
                        big_luckydraw_view.render();
                    }
                    //todo调用新的tips组件
                    var prizeNumCount=12;
                    for (var i = 0; i < prizeNumCount; i++) {
                        var setPos={};
                        //设置图片的属性
                       var url= $("#prize" + (i + 1)).find("img").attr("src");
                        if ((url.indexOf("ktv.x5.qq.com") >= 0) && (url.indexOf("x52itemicon") < 0)) {
                            $("#prize" + (i + 1)).find("img").attr("class", "game-img");
                        } else {
                            $("#prize" + (i + 1)).find("img").attr("class", "");
                        }
                        $("#prize"+(i+1)).off('mouseover').on(
                            'mouseover', function () {
                                //console.log("+++++++++绑定的over事件+++++++++++");
                                var promptTxt=$(this).find("em").html()+"";

                                var tipsWidth=parseInt($(this).attr("tipsWidth"));
                                // console.log("+++++++++++++++++++++++++++"+tipsWidth);
                                if(tipsWidth===180) {
                                    mgc_tips.cssCommonTips(promptTxt, $(this), {
                                        "width": "180px"
                                    }, 4);
                                }else{
                                    mgc_tips.commonTips(promptTxt, $(this), 4);
                                }
                                /*mgc_tips.show({
                                    Type: 0,
                                    Note: promptTxt,
                                    Position: setPos,
                                    MainType: 4
                                });*/
                            });
                    }
                    //初始化特效
                    window.mgc.LuckEffect.init();

                    //抽一次按钮
                    var lastTime = obj.last_free_lucky_draw_time;
                    freeInterval = obj.info.free_lucky_draw_interval;
                    var serverTime = obj.server_time;
                    //showTimeDiv = true;
                    if (serverTime < lastTime) {
                        drawOneBtn(freeInterval);
                    } else {
                        drawOneBtn(lastTime + freeInterval - serverTime);
                    }
                    var oneCost = obj.info.once_draw_price;
                    $("#draw_one,#draw_one_again").find(".btn_cost").html(oneCost);
                    //抽十次按钮
                    var tenCost = oneCost * 10;
                    tenId = obj.info.continuous_draw_reward_id;
                    var tenContent = prizeArr[tenId].name;
                    var tenImgSrc = prizeArr[tenId].url;
                    $("#draw_ten,#draw_ten_again").find(".btn_cost").html(tenCost);
                    $("#draw_ten,#draw_ten_again").find(".btn_text").find("i").html(tenContent);
                    $("#draw_ten,#draw_ten_again").find(".btn_img").attr("src", dealPicUrl(tenImgSrc));
                    if (tenImgSrc.indexOf("ktv.x5.qq.com") >= 0) {
                        $("#draw_ten,#draw_ten_again").find(".btn_img").css("padding", "6px 0 0 6px");
                    } else {
                        $("#draw_ten,#draw_ten_again").find(".btn_img").css("padding", "0");
                    }
                    //显示转盘
                    window.mgc.popmanager.layerControlShow($("#draw_div"), 4, 1);
                    $('#draw_div').centerDisp();
                    //中将记录
                    var notices = obj.notices;
                    if (notices.length > 0) {
                        $('#record_list_con').children().remove();
                        for (var i = 0; i < notices.length; i++) {
                            luckydraw_callBack.drawRecordAll({
                                notice: notices[i]
                            });
                        }
                    }

                    var top = $("#draw_div").offset().top;
                    if (top < 0) {
                        var top2 = $("#draw_div").position().top;
                        $("#draw_div").css("top", top2 - top);
                    }
                    newStat = 0;
                    drawButtonStat();
                } else if (result == 2) {
                    tool.commonDialog({
                        "Title": "提示信息",
                        "Note": "当前没有活动！"
                    }, function() {
                    });
                } else if (result == 3) {
                    tool.commonDialog({
                        "Title": "提示信息",
                        "Note": "主播已下线，换个房间试试吧！"
                    }, function() {
                    });
                } else {
                    tool.commonDialog({
                        "Title": "提示信息",
                        "Note": "操作失败！"
                    }, function() {
                    });
                }
            },
            drawOneCallBack: function(obj) {
                //清除超时计量
                if (reqTimeout)
                    clearTimeout(reqTimeout);
                var lastTime = obj.last_free_lucky_draw_time;
                var serverTime = obj.server_time;
                if (serverTime < lastTime) {
                    drawOneBtn(freeInterval);
                } else {
                    drawOneBtn(lastTime + freeInterval - serverTime);
                }
                switch (parseInt(obj.res)) {
                    case 0:
                        var prizeOne = obj.rewards[0];
                        var oneName = prizeOne.name;
                        var oneCount = prizeOne.count_desc;
                        var needDefalut = true;
                        //检查下抽中了哪个
                        for (var i = 0; i < prizeArr.length; i++) {
                            var prizeObj = prizeArr[i];

                            //测试数据
                            //prizeObj.type =9;

                            var prizeName = prizeObj.name;
                            var prizeCount = prizeObj.count_desc;
                            if($.inArray(prizeOne.id, obj.star_gifts)!=-1){
                                prizeOne.star_gift = true;
                            }else{
                                prizeOne.star_gift = false;
                            }
                            if (prizeName == oneName && oneCount == prizeCount) {
                                needDefalut = false;
                                setTimeout(function() {
                                    stopPos = i + 1;
                                    stopFlash();
                                    $("#draw_one_rt").hide();
                                    $("#draw_one_again").hide();
                                    $("#prize_one").hide();
                                    //更换奖品图片,文字
                                    $("#prize_one").find("img").attr("src", dealPicUrl(prizeOne.url));
                                    //${url.indexOf("x52itemicon") > 0 ? "" : url.indexOf("ktv.x5.qq.com") > 0 ? "game-img" : ""}  炫舞2平台奖励判断
                                    if ((prizeObj.url.indexOf("ktv.x5.qq.com") >= 0) && (prizeObj.url.indexOf("x52itemicon") < 0)) {
                                        $("#prize_one").find("img").attr("class", "game-img");
                                    } else {
                                        $("#prize_one").find("img").attr("class", "");
                                    }
                                    $("#prize_one").find("p").html(oneName);
                                    $("#prize_one").find("span").html(oneCount);
                                    if(prizeOne.rare){
                                        $("#prize_one").append("<span class='video_free_barrage'></span>");
                                    }else{
                                        $('#prize_one .video_free_barrage').remove();
                                    }
                                    if(prizeOne.star_gift){
                                        $("#prize_one").append("<span class='video_star_week'></span>");
                                    }else{
                                        $('#prize_one .video_star_week').remove();
                                    }
                                }, waitTime);
                                break;
                            }
                        }
                        if (needDefalut) {
                            setTimeout(function() {
                                //未升级房间容错
                                stopPos = 1;
                                stopFlash();
                            }, waitTime);
                        }
                        break;
                    case 1:
                        //更新奖品
                        mustStopFlash();
                        uiLock = false;
                        tool.commonDialog({
                            "Title": "提示信息",
                            "Note": "我们刚刚为您更新了奖品，赶快去看看吧！"
                        }, function() {
                            //要换成更新奖品的
                            luckydraw_request.getDraw();
                        });
                        break;
                    case 2:
                        //主播下线
                        mustStopFlash();
                        uiLock = false;
                        tool.commonDialog({
                            "Title": "提示信息",
                            "Note": "主播已下线，换个房间试试吧！"
                        }, function() {
                        });
                        break;
                    case 3:
                        //时间不一致，不能免费抽
                        mustStopFlash();
                        uiLock = false;
                        tool.commonDialog({
                            "Title": "提示信息",
                            "Note": "玩家不在房间内，请重新进入房间重试！"
                        }, function() {
                        });
                        break;
                    case 4:
                        //时间不一致，不能免费抽
                        mustStopFlash();
                        uiLock = false;
                        tool.commonDialog({
                            "Title": "提示信息",
                            "Note": "暂时没有免费机会，请稍后重试！"
                        }, function() {
                        });
                        break;
                    case 5:
                        //需要充值
                        mustStopFlash();
                        uiLock = false;
                        tool.commonDialog({
                            "Title": "提示信息",
                            "Note": "您没有足够的炫豆用于送出该礼物，快去充值吧。",
                            BtnNum: 2,
                            BtnName2: "取消",
                            BtnName: "快捷购买",
                            url: consts.url.IPAY
                        });
                        break;
                    case 6:
                        //时间不一致，可以免费抽
                        mustStopFlash();
                        uiLock = false;
                        tool.commonDialog({
                            "Title": "提示信息",
                            "Note": "您有一次免费机会，是否使用？",
                            BtnNum: 2,
                            BtnName2: "取消",
                            BtnName: "确定"
                        }, function() {
                            //免费抽
                            waitTime = 2000;
                            drawFun("one");
                        });
                        break;
                    default:
                        mustStopFlash();
                        uiLock = false;
                        tool.commonDialog({
                            "Title": "提示信息",
                            "Note": "操作失败！"
                        }, function() {
                        });
                }
            },

            drawTenCallBack: function(obj) {
                console.log("抽十次："+JSON.stringify(obj));

                //清除超时计量
                if (reqTimeout)
                    clearTimeout(reqTimeout);
                switch (parseInt(obj.res)) {
                    case 0:
                        setTimeout(function() {
                            stopPos = tenId + 1;
                            stopFlash();
                            $("#draw_ten_rt").hide();
                            $("#draw_ten_again").hide();
                            tenPrizeList.hide();
                            var prizeTenArr = [];
                            prizeTenArr = obj.rewards;
                            for (var i = 0; i < prizeTenArr.length; i++) {
                                var prizeObj = prizeTenArr[i];
                                if($.inArray(prizeObj.id, obj.star_gifts)!=-1){
                                    prizeObj.star_gift = true;
                                }else{
                                    prizeObj.star_gift = false;
                                }
                                //测试数据
                                //prizeObj.type =9;

                                //图片
                                $(tenPrizeList.get(i)).find("img").attr("src", dealPicUrl(prizeObj.url));
                                //${url.indexOf("x52itemicon") > 0 ? "" : url.indexOf("ktv.x5.qq.com") > 0 ? "game-img" : ""}  炫舞2平台奖励判断
                                if ((prizeObj.url.indexOf("ktv.x5.qq.com") >= 0) && (prizeObj.url.indexOf("x52itemicon") < 0)) {
                                    $(tenPrizeList.get(i)).find("img").attr("class", "game-img");
                                } else {
                                    $(tenPrizeList.get(i)).find("img").attr("class", "");
                                }
                                $(tenPrizeList.get(i)).find("p").html(prizeObj.name);
                                $(tenPrizeList.get(i)).find("span").html(prizeObj.count_desc);
                                if(prizeObj.rare){
                                    $(tenPrizeList.get(i)).append("<span class='video_free_barrage'></span>");
                                }else{
                                    $(tenPrizeList.get(i)).find('.video_free_barrage').remove();
                                }
                                if(prizeObj.star_gift){
                                    $(tenPrizeList.get(i)).append("<span class='video_star_week'></span>");
                                }else{
                                    $(tenPrizeList.get(i)).find('.video_star_week').remove();
                                }
                            }
                        }, waitTime);
                        break;
                    case 1:
                        //更新奖品
                        mustStopFlash();
                        uiLock = false;
                        tool.commonDialog({
                            "Title": "提示信息",
                            "Note": "我们刚刚为您更新了奖品，赶快去看看吧！"
                        }, function() {
                            //要换成更新奖品的
                            luckydraw_request.getDraw();
                        });
                        break;
                    case 2:
                        //主播下线
                        mustStopFlash();
                        uiLock = false;
                        tool.commonDialog({
                            "Title": "提示信息",
                            "Note": "主播已下线，换个房间试试吧！"
                        }, function() {
                        });
                        break;
                    case 3:
                        //主播下线
                        mustStopFlash();
                        uiLock = false;
                        tool.commonDialog({
                            "Title": "提示信息",
                            "Note": "玩家不在房间内，请重新进入房间重试！"
                        }, function() {
                        });
                        break;
                    case 4:
                        //需要充值
                        mustStopFlash();
                        uiLock = false;
                        tool.commonDialog({
                            "Title": "提示信息",
                            "Note": "暂时没有免费机会，请稍后重试！"
                        }, function() {
                        });
                        break;
                    case 5:
                        //需要充值
                        mustStopFlash();
                        uiLock = false;
                        tool.commonDialog({
                            "Title": "提示信息",
                            "Note": "您没有足够的炫豆用于送出该礼物，快去充值吧。",
                            BtnNum: 2,
                            BtnName2: "取消",
                            BtnName: "快捷购买",
                            url: consts.url.IPAY
                        });
                        break;
                    default:
                        mustStopFlash();
                        uiLock = false;
                        tool.commonDialog({
                            "Title": "提示信息",
                            "Note": "操作失败！"
                        }, function() {
                        });
                }
            },
            //中奖列表
            drawRecord: function(obj) {
                var nick = obj.notice.nick;
                var prizeName = obj.notice.reward.name;
                var count_desc = obj.notice.reward.count_desc;
                var luckyNotices = new mgc_luckydraw_coll.luckyNoticesColl();

                if ($("#i_player_name").html() == nick) {
                    recordListSelf.push({
                        "nick": nick,
                        "prize": prizeName + "X" + count_desc
                    });
                } else {
                    recordList.push({
                        "nick": nick,
                        "prize": prizeName + "X" + count_desc
                    });
                }
                recordCount++;
                var speed = 1000;
                speed = Math.floor(1000 / (recordList.length + recordListSelf.length));
                clearInterval(recordInterval);
                recordInterval = setInterval(function() {
                    if ((recordList.length + recordListSelf.length) > 0) {
                        $(".record_default").remove();
                        if (recordListSelf.length > 0) {
                            //取一个
                            // var luckyNotices = new mgc_luckydraw_coll.luckyNoticesColl();
                            luckyNotices.reset(recordListSelf.shift());
                                var luckyNotices_view = new mgc_luckydraw_view.luckyNoticesView({ model: luckyNotices.models[0] });
                                luckyNotices_view.render();
                        } else {
                            if (recordList.length > 0) {
                                //取一个
                                // var luckyNotices = new mgc_luckydraw_coll.luckyNoticesColl();
                                luckyNotices.reset(recordList.shift());
                                    var luckyNotices_view = new mgc_luckydraw_view.luckyNoticesView({ model: luckyNotices.models[0] });
                                    luckyNotices_view.render();
                            }
                        }
                        var records = $('#record_list_con').find(".record");
                        if (records.size() > 4) {
                            $('#record_list_con').animate({
                                "top": -20
                            }, speed / 2, "linear", function() {
                                while ($('#record_list_con').find(".record").size() > 4) {
                                    $($('#record_list_con').find(".record").get(0)).remove();
                                }
                                $('#record_list_con').css("top", 0);
                            });
                        }
                    }
                    draw_record_con = null;
                    draw_record_tmpl = null;
                }, speed);

            },
            drawRecordAll: function(obj) {
                var nick = obj.notice.nick;
                var prizeName = obj.notice.reward.name;
                var count_desc = obj.notice.reward.count_desc;
                var luckyNotices = new mgc_luckydraw_coll.luckyNoticesColl();
                var record = {
                    "nick": nick,
                    "prize": prizeName + "X" + count_desc
                };
                $(".record_default").remove();
                /**
                 * 获取渲染的数据，取一个
                 */
                // var luckyNotices = new mgc_luckydraw_coll.luckyNoticesColl();
                luckyNotices.reset(record);
                var luckyNotices_view = new mgc_luckydraw_view.luckyNoticesView({model:luckyNotices.models[0] });
                luckyNotices_view.render();
            },
            //可以免费抽了294
            drawFree: function(obj) {
                var lastTime = obj.last_free_lucky_draw_time;
                freeInterval = obj.free_lucky_draw_interval;
                beginTime = obj.activity_begin_time;
                var serverTime = obj.server_time;
                if (serverTime < lastTime) {
                    drawOneBtn(freeInterval);
                } else {
                    drawOneBtn(lastTime + freeInterval - serverTime);
                }

                //是否游客
                if (MGC_Comm.CheckGuestStatus(true)){
                    showTimeDiv = true;
                }
            },
            //有新配置
            drawRefresh: function(obj) {
                //refreshTime = obj.config_refresh_time;
                if (beginTime != obj.info.begin_time) {
                    newStat = 1;
                    drawButtonStat();
                    var uid = mgc.account.getUin();
                    if (tool.cookie("draw_refresh_time" + uid) != "draw_refresh_time") {
                        tool.cookie("draw_refresh_time" + uid, "draw_refresh_time", {
                            expires: 365 * 24 * 60
                        });
                    }
                }
            }
        };

        //监听下发========================================
        //中奖列表
        callcenter.addRespListener(callcenter.OP_TYPE.DRAW_RECORD, function(resp, params) {
            luckydraw_callBack.drawRecord(resp);
            console.log("33333333333333333333333333333333333333333333333333333333333333333333333333333333");
        });
        //红点
        callcenter.addRespListener(callcenter.OP_TYPE.DRAW_FREE, function(resp, params) {
            luckydraw_callBack.drawFree(resp);
            console.log("2222222222222222222222222222222");
        });
        //new
        callcenter.addRespListener(callcenter.OP_TYPE.DRAW_REFRESH, function(resp, params) {
            luckydraw_callBack.drawRefresh(resp);
        });

        //奖品列表
        var prizeArr = [];
        //必出奖品位置
        var tenId = 0;
        //免费抽奖时间间隔
        var freeInterval = 0;
        //刷新中奖列表
        var recordCount = 1;
        var recordList = [];
        var recordListSelf = [];
        var recordInterval;
        var startTime;
        var showTimeDiv = false;

        //一次按钮状态
        function drawOneBtn(oneTime) {
            //var now = Math.floor(new Date().getTime() / 1000);
            //var oneTime = lastTime - now;
            if (oneTime > 0) {

                //先做更新时间，隐藏，再显示
                timeGloble = oneTime;
                if (timeRun == false) {
                    startTime = new Date().getTime();
                    setTime();
                }
                redStat = 0;
            } else {
                $("#draw_one,#draw_one_again").find("div").attr("class", "click_area click_area_free");
                $("#draw_one,#draw_one_again").find(".btn_text,.btn_icon,.btn_cost").hide();
                $("#draw_one,#draw_one_again").find(".btn_free").show();
                timeGloble = 0;
                redStat = 1;
                showTimeDiv = false;
            }
            drawButtonStat();
        }
        //递归减1
        var timeGloble = 0;
        var timeRun = false;
        window.setTime = function setTime() {
            var nowTime = new Date().getTime();
            var selTime = freeInterval - Math.floor((nowTime - startTime) / 1000);
            if (selTime < timeGloble) {
                timeGloble = selTime;
            }
            if (selTime <= 0) {
                timeGloble = 0;
            }
            if (timeGloble == 0) {
                $("#draw_one,#draw_one_again").find("div").attr("class", "click_area click_area_free");
                $("#draw_one,#draw_one_again").find(".btn_text,.btn_icon,.btn_cost").hide();
                $("#draw_one,#draw_one_again").find(".btn_free").show();
                timeRun = false;
                redStat = 1;
                drawButtonStat();
                showTimeDiv = false;
            } else {
                if (showTimeDiv) {
                    $("#draw_one,#draw_one_again").find("div").attr("class", "click_area click_area_cost");
                    $("#draw_one,#draw_one_again").find(".btn_free").hide();
                    $("#draw_one,#draw_one_again").find(".btn_text,.btn_icon,.btn_cost").show();
                }
                $("#draw_one,#draw_one_again").find(".btn_text").html(formatTime(timeGloble) + "<i>后免费</i>");
                timeGloble--;
                timeRun = true;
                setTimeout("setTime()", 1000);
            }
        };
        //输出时间格式
        function formatTime(s) {
            if (s == 86400) {
                s = 86399;
            }
            var t = "";
            if (s > 0) {
                var hour = Math.floor(s / 3600);
                var min = Math.floor(s / 60) % 60;
                var sec = s % 60;
                if (hour < 10) {
                    t += "0";
                }
                t += hour + ":";
                if (min < 10) {
                    t += "0";
                }
                t += min + ":";
                if (sec < 10) {
                    t += "0";
                }
                t += sec;
            } else {
                t = "0:00:0x";
            }
            return t;
        }
        function dealPicUrl(picUrl) {
            if (picUrl.indexOf("http") >= 0) {
                return picUrl;
            } else {
                return "http://ossweb-img.qq.com/images/mgc/css_img" + picUrl;
            }
        }
    });

    window.mgc.LuckEffect = {

        init: function() {
            var swfVersionStr = "11.1.0";
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

            attributes.id = "effect_luck";
            attributes.name = "effect_luck";
            attributes.align = "middle";
            var swfurl = "assets/effect_luck.swf?v=3_8_8_2016_15_4_final_3";
            if (tool.checkIsIEloadSwfFailed()) {
                swfurl += "&r=" + Math.random();
            }
            swfobject.embedSWF(swfurl, "effect_luck", "100%", "100%", swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
        },

        start: function() {
            var swfobj = tool.getSWF('effect_luck');
            swfobj.startEffect();
        },

        stop: function(index) {
            var swfobj = tool.getSWF('effect_luck');
            swfobj.stopEffect(index);
        },

        show: function(b) {
            if (b) {
                $("#draw_div .effect_luck").width(546);
            } else {
                $("#draw_div .effect_luck").width(1);
            }
        }

    };

});
