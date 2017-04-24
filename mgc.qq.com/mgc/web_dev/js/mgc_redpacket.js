/**
 * @Description:   梦工厂web-红包功能
 *
 * @author         Xu XiaoJing
 * @version        V1.0
 * @Date           2015/10/29
 * @Company        horizon3d
 */
//建立闭包
$m(function($) {
    //可显示的大小红包数量,从页面上直接读取可现实区域数量
    var bigCount = $(".red_packet").size();
    var bigInitCount = bigCount;
    var smallCount = $(".red_small").size();
    var smallInitCount = smallCount;
    //复制html，页面上只第一个红包加入红包显示内容其它的用js复制注入
    var rpHtml = $(".red_packet").eq(0).html();
    for (var i = 1; i < bigCount; i++) {
        $(".red_packet").eq(i).html(rpHtml);
    }
    var smallHtml = $(".red_small").eq(0).html();
    for (var i = 1; i < smallCount; i++) {
        $(".red_small").eq(i).html(smallHtml);
    }

    if ($m.cookie('mgc_zoneid') > 40000) {
        $("#rp_container .red_packet").each(function (i, n) {
            $(this).children().eq(0).attr('class', 'rp_red_x52');
        });       
    } else {
        $("#rp_container .red_packet").each(function (i, n) {
            $(this).children().eq(0).attr('class', 'rp_red');
        });
    }
    $(".red_con").prepend($("#rp_container").html());
    $("#rp_container").children().remove();
    //排队等待显示的红包,小红包
    var bigWaitArray = new Array();
    var smallWaitArray = new Array();
    //可用位置，如果已经在该位置显示了就变false
    var bigDispArray = [true, true, true, true, true, true, true, true];
    var smallDispArray = [true, true, true];
    //记录显示红包的信息
    var map = new HashMap();
    //发送请求
    var MGC_RedRequest = {
        //抢红包
        grabRedPacket: function(rpId) {
            var param = {
                op_type: OpType.GrabRedPacketOpType,
                red_id: rpId
            };
            MGC_Comm.sendMsg(param, "MGC_CommResponse.grabRedPacketCallBack");
        },
        //红包信息
        showRedPacket: function(rpId) {
            var param = {
                op_type: OpType.ShowRedPacketOpType,
                red_id: rpId
            };
            MGC_Comm.sendMsg(param, "MGC_CommResponse.showRedPacketCallBack");
        }
    };

    //测试用计数器
    var countNum = 0;
    //服务器端回调
    var MGC_RedResponse = {
        redPacketCallBack: function(obj) {
            console.log('服务器下发红包' + JSON.stringify(obj));
            //计算失效时间
            obj.zone = $.mZone(obj.zone);
            var bigTime = new Date().getTime() + obj.red_envelope_duration * 1000;
            //建立红包
            var redPacket = {
                id: obj.red_id,
                name: obj.nick,
                sum: obj.total_money,
                count: obj.divide_count,
                bigTime: bigTime,
                smallTime: obj.small_red_envelope_duration
            };
            console.log('bigCount' + bigCount);
            //是否有空位
            if (bigCount > 0) {
                //显示红包
                showRed(redPacket);
            } else {
                //放入红包数组
                bigWaitArray.push(redPacket);
                console.log('bigWaitArray size' + bigWaitArray.length);
            }

            obj = null;
        },
        showOldRedPacket: function(info) {
            var rpArray = info.m_redenvelopes;
            var bigTime = new Date().getTime() + info.red_envelope_duration * 1000;
            console.log('服务器进入房间时候下发红包' + JSON.stringify(rpArray));
            $m.each(rpArray, function(k, v) {
                v.m_zone = $.mZone(v.m_zone);
                //建立红包
                var redPacket = {
                    id: v.m_red_id,
                    name: v.m_nick,
                    sum: v.m_total_money,
                    count: v.m_divide_count,
                    bigTime: bigTime,
                    smallTime: info.small_red_envelope_duration
                };
                //是否有空位
                if (bigCount > 0) {
                    //显示红包
                    showRed(redPacket);
                } else {
                    //放入红包数组
                    bigWaitArray.push(redPacket);
                }
            });
        },
        grabRedPacketCallBack: function(obj) {
            console.log('抢红包callback' + JSON.stringify(obj));
            var result = obj.res;
            var rpId = obj.red_id;
            var dianquan = obj.grab_count;
            var mengbi = obj.grab_count_value;
            var dialogStr = {};
            dialogStr.Title = '提&nbsp;&nbsp;&nbsp;示';
            var redPacket = map.get(rpId);
            var removeBig = false;
            var zoneId = obj.zone_id;
            switch (result) {
                case 0:
                    //抢红包成功
                    dialogStr.BtnName = '查看记录';
                    dialogStr.BtnName2 = '关闭';
                    dialogStr.BtnNum = 2;
                    dialogStr.Note = '您成功抢到了' + '<span style="color:#ee5f38">点券' + dianquan + '</span>';
                    if (window.mgc.tools.isNewRole()) {
                        dialogStr.Note = '';
                        dialogStr.Note += '您成功抢到了<span style="color:#ee5f38">梦幻币' + mengbi + '个</span>';
                    } else {
                        if(window.mgc.config.channel == 0){
                            dialogStr.Note += '已发到您的<span style="color:#ee5f38">游戏账户</span>内';
                        } else{
                            dialogStr.Note += '已发到您的<span style="color:#ee5f38">游戏账户</span>内，';
                            dialogStr.Note += '<br>可通过游戏内邮件来进行收取';
                        }
                    }
                    
                    //避免弹窗中取消按钮显示错误
                    $("#CancelBtn").css("display", "inline-block");

                    MGC_Comm.CommonDialog(dialogStr);
                    $m('#CommonDialog').css("top", "310px");
                    $m('#CommonDialog').find("#NoteP").css("textAlign", "left");
                    $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);MGC_CommRequest.showRedPacket(" + rpId + ");");
                    //如果还能取到信息
                    if (redPacket != null) {
                        showSmallRed(redPacket);
                    }
                    removeBig = true;
                    break;
                case 2:
                    //紅包失效了
                    dialogStr.Note = '信息失效了哦，无法进行查看';
                    MGC_Comm.CommonDialog(dialogStr);
                    $m('#CommonDialog').css("top", "310px");
                    $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                    removeBig = true;
                    break;
                case 3:
                    //已经抢过了
                    dialogStr.BtnName = '查看记录';
                    dialogStr.BtnName2 = '关闭';
                    dialogStr.BtnNum = 2;
                    dialogStr.Note = '您已经抢过这个红包了';
                    MGC_Comm.CommonDialog(dialogStr);
                    $m('#CommonDialog').css("top", "310px");
                    $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);MGC_CommRequest.showRedPacket(" + rpId + ");");
                    removeBig = true;
                    break;
                case 4:
                    //cd时间
                    dialogStr.Note = '您抢的太频繁了，请稍后再试';
                    MGC_Comm.CommonDialog(dialogStr);
                    $m('#CommonDialog').css("top", "310px");
                    $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                    break;
                case 5:
                    //被屏蔽了
                    dialogStr.BtnName = '查看记录';
                    dialogStr.BtnName2 = '关闭';
                    dialogStr.BtnNum = 2;
                    dialogStr.Note = '对不起，您已被对方屏蔽，无法参与抢夺TA发的红包';
                    MGC_Comm.CommonDialog(dialogStr);
                    $m('#CommonDialog').css("top", "310px");
                    $m('#CommonDialog').find("#NoteP").css("textAlign", "left");
                    $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);MGC_CommRequest.showRedPacket(" + rpId + ");");
                    break;
                default:
                    //抢红包失败
                    dialogStr.BtnName = '查看记录';
                    dialogStr.BtnName2 = '关闭';
                    dialogStr.BtnNum = 2;
                    dialogStr.Note = '您来晚了，红包已经被抢光了';
                    MGC_Comm.CommonDialog(dialogStr);
                    $m('#CommonDialog').css("top", "310px");
                    $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);MGC_CommRequest.showRedPacket(" + rpId + ");");
                    removeBig = true;
            }
            /*移除掉（触发关闭弹窗时） 在通用弹窗上-增加红包查看记录消息事件*/
            $m('#CommonDialog #CloseBtn,#CommonDialog #CancelBtn').unbind('click').bind('click', function () {
                $m('#ConfirmBtn').removeAttr('href');
            });
            /*结束*/
            if (removeBig) {
                var pos = redPacket.pos;
                $(".red_packet").eq(pos).css("visibility", "hidden");
                bigDispArray[pos] = true;
                bigCount++;
                map.remove(redPacket.id);
                getStorePacket();
            }
        },
        showRedPacketCallBack: function (obj) {
            /*移除掉 在通用弹窗上-增加红包查看记录消息事件*/
            $m('#ConfirmBtn').removeAttr('href');
            /*结束*/
            var rpId = obj.red_id;
            var nick = obj.nick;
            var sum = obj.total_money;
            var count = obj.divide_count;
            var grabbers = obj.grabbers;
            if (obj.res == 2) {
                var dialogStr = {};
                dialogStr.Title = '提&nbsp;&nbsp;&nbsp;示';
                dialogStr.Note = '信息失效了哦，无法进行查看';
                MGC_Comm.CommonDialog(dialogStr);
                $m('#CommonDialog').css("top", "310px");
                $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
            } else {
                $m.each(grabbers, function(k, v) {
                    v.zone = $.mZone(v.zone);
                });
                var red_record_tmpl = $('#red_record_tmpl').tmpl(obj);
                $('#rp_record_container').html(red_record_tmpl);
                //$('#rp_record_list').prepend($('#red_one_record_tmpl').tmpl(grabbers));
                var red_one_record_tmpl = $('#red_one_record_tmpl').tmpl(grabbers);
                $('#rp_record_list').html(red_one_record_tmpl);
                //红包记录区域滚动
                $m('#rp_record_list').jScrollPane({
                    autoReinitialise: true,
                    animateScroll: true
                });
                //取红包详细信息
                window.mgc.popmanager.layerControlShow($m("#pop_red_packet"), 4, 1);
                $m('#pop_red_packet').centerDisp();
                $m('#pop_red_packet').find(".pop_close,.rp_close_btn").off('click').on('click', function() {
                    window.mgc.popmanager.layerControlHide($m("#pop_red_packet"), 4, 1);
                });
                //重绘滚动条 
                var scrollAPI_rprecordlist = $m('#rp_record_list').data('jsp');
                if(scrollAPI_rprecordlist){   
                    scrollAPI_rprecordlist.initScroll();
                }
                red_record_tmpl = null;
                red_one_record_tmpl = null;
            }
        },
    };

    //取出数组中红包进行显示
    function getStorePacket(isSmall) {
        if (isSmall) {
            if (smallWaitArray.length > 0) {
                setTimeout(function() {
                    showSmallRed(smallWaitArray.shift());
                }, 500);
            }
        } else {
            if (bigWaitArray.length > 0) {
                setTimeout(function() {
                    showRed(bigWaitArray.shift());
                }, 500);
            }
        }
    };

    //展示小红包
    function showSmallRed(redPacket) {
        var rpId = redPacket.id;
        var name = redPacket.name;
        var sum = redPacket.sum;
        var count = redPacket.count;
        var smallTime = redPacket.smallTime * 1000;
        //if (smallCount != smallInitCount) {
        //右移
        for (var i = smallInitCount - 1; i > 0; i--) {
            $(".red_small").eq(i).html($(".red_small").eq(i - 1).html());
            $(".red_small").eq(i).css("visibility", $(".red_small").eq(i - 1).css("visibility"));
        }
        //}
        //$(".red_small").eq(0).find("a").attr("onmouseover", "MGC.susTipsHtml(event,1,'" + name + "的红包<br>红包总额：" + sum + "点券<br>红包数量：" + count + "个');");
        var element = $(".red_small").eq(0).find("a");

        element.attr("data-mgc-redid", rpId);
        element.attr("data-mgc-redname", name);
        element.attr("data-mgc-redsum", sum);
        element.attr("data-mgc-redcount", count);
        $(".red_small").eq(0).css("visibility", "visible");

        for (var i = 2; i >= 0; i--) {
            if ($(".red_small").eq(i).css("visibility") == "visible") {
                var smallObj = $(".red_small").eq(i).find("a");
                var tName = smallObj.attr("data-mgc-redname");
                var tSum = smallObj.attr("data-mgc-redsum");
                var tCount = smallObj.attr("data-mgc-redcount");

                //判断是否是梦工厂大区、Qgame大区(新角色)
                var tStrong = '';
                if (window.mgc.tools.isNewRole()) {
                    tStrong = tName + "的红包<br>红包数量：" + tCount + "个";
                } else {                    
                    tStrong = tName + "的红包<br>红包总额：" + tSum + "点券<br>红包数量：" + tCount + "个";
                }
                MGC.newTips(tStrong, smallObj);
            }
        }

        //smallCount--;
        setTimeout(function() {
            for (var i = 2; i >= 0; i--) {
                var smallObj = $(".red_small").eq(i).find("a");
                if (smallObj.attr("data-mgc-redid") == redPacket.id) {
                    $(".red_small").eq(i).css("visibility", "hidden");
                }
            }

            redPacket = null;
        }, smallTime);
    }
    //展示红包
    function showRed(redPacket) {
        //安排到第几空位*(0-bigInitCount)
        var position = 0;
        //随机安排到第几空位
        var posCount = Math.ceil(Math.random() * bigCount);
        for (var i = 0; i < bigInitCount; i++) {
            if (bigDispArray[i]) {
                posCount--;
                if (posCount == 0) {
                    //累计找到空位
                    position = i;
                    break;
                }
            }
        }
        //展示时间
        var showTime = redPacket.bigTime - new Date().getTime();
        if (showTime > 0) {
            //空位占用
            bigDispArray[position] = false;
            //计数减少
            bigCount--;
            //灌入数据
            var redPackObj = $(".red_packet").eq(position);
            redPackObj.find(".rp_sum").html(redPacket.sum);
            redPackObj.find(".rp_name").html("<span class='rp-name-l'>" + redPacket.name + "</span><span class='rp-name-r'>的红包</span>");
            redPackObj.attr("data-mgc-redid", redPacket.id);
            if ($m.cookie('mgc_zoneid') > 40000 && !MGC_Comm.CheckGuestStatus(true)) {
                redPackObj.children()[0].className = 'rp_red_x52';
            } else {
                redPackObj.children()[0].className = 'rp_red';
            }
            redPackObj.css("visibility", "visible");
            redPacket.pos = position;
            map.put(redPacket.id, redPacket);
            setTimeout(function() {
            	var redPacketFromMap = map.get(redPacket.id);
            	if(redPacketFromMap)
            	{
            		if(redPackObj.css("visibility")=="visible")
            		{
            			redPackObj.css("visibility", "hidden");
            			bigCount++;
            		}
                    bigDispArray[position] = true;
                    map.remove(redPacket.id);
                    getStorePacket();
            	}
                redPacket = null;
            }, showTime);
        }

    };

    $('.red_packet').off('click').on('click', function() {
        if (!MGC_Comm.CheckGuestStatus(false)) {
            var rpId = $(this).attr("data-mgc-redid");
            MGC_CommRequest.grabRedPacket(rpId);
        }
    });

    $('.red_small').off('click').on('click', function() {
        if (!MGC_Comm.CheckGuestStatus(false)) {
            var rpId = $(this).find("a").attr("data-mgc-redid");
            MGC_CommRequest.showRedPacket(rpId);
        }
    });

    $.extend(MGC_CommRequest, MGC_RedRequest);
    $.extend(MGC_CommResponse, MGC_RedResponse);

    function HashMap() {
        var length = 0;
        var obj = new Object();
        this.containsKey = function(key) {
            return ( key in obj);
        };
        this.isEmpty = function() {
            return length == 0;
        };
        this.put = function(key, value) {
            if (!this.containsKey(key)) {
                length++;
            }
            obj[key] = value;
        };
        this.get = function(key) {
            return this.containsKey(key) ? obj[key] : null;
        };
        this.remove = function(key) {
            if (this.containsKey(key) && (
            delete obj[key])) {
                length--;
            }
        };
        this.size = function() {
            return length;
        };
        this.clear = function() {
            length = 0;
            obj = new Object();
        };
    }
});
