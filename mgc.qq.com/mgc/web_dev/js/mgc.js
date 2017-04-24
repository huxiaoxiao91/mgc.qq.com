var $j = jQuery.noConflict(), def = true, defCard = true;
var tag_id;
var isLoginCallback = true;
var myClickTab1 = function(id, con) {
    var tabArr = $j("#" + id).find("a"), conArr = $j("." + con);
    tabArr.each(function(index) {
        $j(this).unbind("click").click(function() {
            tabArr.removeClass().eq(index).addClass("current");
            //conArr.hide().eq(index).show();
            $j('[id*="StarContainer"]').hide();
            //if(tag_id)
            //{
            //    if ($j('#StarContainer'+ tag_id).length > 0)
            //    {
            //        $j('#StarContainer'+ tag_id).hide();
            //    }
            //}
            tag_id = $j(this).attr("tag_id");

            var ii = 0;
            var len1 = labelListArr.length;
            selectTabIndex = 0;
            for (ii; ii < len1; ii++) {
                if (labelListArr[ii].tag_id == tag_id) {
                    selectTabIndex = ii;
                    break;
                }
            }

            if ($j('#StarContainer' + tag_id).length > 0) {
                $j('#StarContainer' + tag_id).show();
            } else {
                MGCRoomList.requestStarCallBack(tag_id, 0);
            }

            //tabArr.removeClass().eq(index).addClass("current");
            //conArr.hide().eq(index).show();
        });
    });
}
var tmplname = ['★文正太浩★', '主宰、别样苍茫', '蝴蝶为谁开~', '爱情的经纬线', '无缘的缘分', '打开灯光照照暖', '逆倒尘光', '寻找我（你）的天堂', '爱被打了一巴掌', '夺爱水果刀', 'N个网名用不完', '点水玛线', '擦干你那为爱留下的泪', '放下你的手￥', '扯不断的红尘', '找寻你的足迹∞', '想你时的孤独。', '冷月妖娆 ヽ由命', '︶ㄣ那个撕心裂肺的叫声', '我坚信，他们不会走远。', '月光歌夜美人戏赤木花开', '陈年豆蔻，谁许谁地老天荒', '情歌谱成一曲思念', '那抹温柔演绎的酣畅淋漓', '没有温度的路灯提醒着涐', '因为抱的太久反而难以承受', '涐知道涐只是一厢的情愿。', '都说好下个路口就分手。', '美人如此多娇', '沵永远不知涐是多么的爱沵', '若我离去，后会无期。', '我算个 what ︶￣', '爱后殇ㄋ臫巳', '茈籹孓丹 犯贱', '、用烟火驱散一季的阴霾', '我比任何人都爱自己。', '- 扯蛋 丶', '// 沵想过我旳感受没有', '我只跟自己比', '非典式、想你。', '#沵旳高傲刺伤了硪旳灵魂', '゛我要怎么相信你旳谎言', '花落 , 因为花开过', '我的爱、消失不见', '爱到沸腾，痛到冰点。', '泪洒黄河畔，情欲消眉上。', 'Grace Junk', '丿沩凊丶葰涃', '丿为情丶所困', '想太多我会难过', 'ヾ 残花冷月情', '我的改变,拜您所赐。', '时间一直去,回忆真美丽', '其实说好只是玩玩而已旳,', '繁花似锦，只剩青春旳忧伤', '-﹋原来承诺真旳很无力', '?也许是爱旳太大没有把握', '把一切送沵丶 黄昏余涐#', '▽ 总错把期待当成希望', '疼了就再也不碰爱情好了', '人有绝交，才有至交。', '我爱你这件事不需要解释。', '多么希望你，是我独家的记', '对你的爱,泛滥成灾.', '用微笑掩盖了落寞', '醉后知酒浓、爱后知情伤', '下一站，幸福', '下一站，在哪？', '其实、卜过是一场错爱。', '最终、回到了原点。', '叙述、他和她的故事°', '淡ㄋ的情、怎么继续', 'ッ深冬、心已死亡。', '心情因你的离开而不美丽.', '想恨又不能恨~', '向日葵、没有太阳照样耀眼', '爱断了线该如何撕守-', '# 怀念,那只是优柔寡断', '誓言只不过是拆散的谎言。', '重蹈覆辙成了一种瘾', '天空灰的像哭过 擦干了泪', '你拆了城墙 让我去流浪', '一霸道自私的男r3n╮', '你的心角处一丝想念', '_/~↘浅唱、那囙忆', '╭ァ吢死丶情灭。', '☆想要★§留住你☆', '窒息-你的笑~', 'い奈何心善╮', '狠爱狠爱倪', '真的有来生吗', 'Wo丶好期待', '℡往事随风丶', '╰烟消云散、', '你无辜的眼神', 'and you', 'hahaha', 'love you', '呵呵呵呵', '甜甜'];
var tmplhtml = "<li class=\"li_player\"><p class=\"sz_icon\"><i class=\"icon_lv\"></i><i class=\"icon_honor\" style=\"background:url(http://ossweb-img.qq.com/images/mgc/css_img/common/nobility/{icon_honor}.png?v=3_8_8_2016_15_4_final_3)\"></i></p><p class=\"sq\"><span class=\"player\" style=\"color: #f26cff\">{nickName}</span></p><p class=\"sn roleListLv\" style=\"display: block;\">LV{LV}</p></li>"
var MGC = {
    //存储所有页面缩放时需要操作的滚动条对象
    scrollAPIs:[],
    //随机昵称
    randNickNameFun: function() {
        var num = parseInt(100 * Math.random()); 　//输出0～100之间的随机整数
        var _html = "";
        for (var i = 0; i < 4; i++) {
            if (num + i >= 100) {
                num = 0;
            }
            var _lv = parseInt(4 * Math.random()) + 1;
            _html += tmplhtml.replace("{icon_honor}", _lv).replace("{LV}", _lv).replace("{nickName}", tmplname[num + i].substring(0, 6));
        }
        return _html;
    },
    /*浏览器类型及其版本*/
    browser : function() {
        var Sys = {};
        var ua = navigator.userAgent.toLowerCase();
        var s;
            (s = ua.match(/firefox\/([\d.]+)/)) ? Sys.firefox = s[0] :
            (s = ua.match(/chrome\/([\d.]+)/)) ? Sys.chrome = s[0] :
            (s = ua.match(/opera.([\d.]+)/)) ? Sys.opera = s[0] :
            (s = ua.match(/qqbrowser\/([\d.]+)/)) ? Sys.qqbrowser = s[0] :
            (s = ua.match(/msie 6.0/)) ? Sys.ie6 = s[0] :
            (s = ua.match(/msie 7.0/)) ? Sys.ie7 = s[0] :
            (s = ua.match(/msie 8.0/)) ? Sys.ie8 = s[0] :
            (s = ua.match(/msie 9.0/)) ? Sys.ie9 = s[0] :
            (s = ua.match(/msie 10.0/)) ? Sys.ie10 = s[0] :
            (s = ua.match(/rv:11.0/)) ? Sys.ie11 = s[0] :
            //(s = ua.match(/msie ([\d.]+)/)) ? Sys.ie = s[0] :
            (s = ua.match(/version\/([\d.]+).*safari/)) ? Sys.safari = s[0] : 0;
        return Sys;
    },
    /*判断是否IE内核的国产浏览器下，as无法二次呼叫*/
    checkIsIEloadSwfFailed : function() {
        return !!(MGC.browser().ie6 || MGC.browser().ie7 || MGC.browser().ie8 || MGC.browser().ie9 || MGC.browser().ie10 || MGC.browser().ie11 || MGC.browser().qqbrowser);
    },
    loadJS: function(url) {
        $j.ajaxSetup({ cache: true });//缓存js
        $j.getScript(url);
    },
    pvCount: function() {
        try {
            $j.getScript('http://tajs.qq.com/stats?sId=49477277', function() {
                try {
                    $j.getScript('http://pingjs.qq.com/ping_tcss_ied.js', function() {
                        try {
                            pgvMain();
                        } catch (e) {
                            console.log("pvCount - error 3: " + e.message);
                        }
                    });
                } catch (e) {
                    console.log("pvCount - error 2: " + e.message);
                }
            });
        } catch (e) {
            console.log("pvCount - error 1: " + e.message);
        }
    },
    tabCon: function(id, con) {
        var tabArr = $j("#" + id).find("li a"), len = tabArr.length;
        tabArr.each(function(index) {
            $j(this).bind("mouseenter", function() {
                tabArr.removeClass().eq(index).addClass("current");
                for (var i = 0; i < len; i++) { $j("#" + con).find("ul").eq(i).hide(); }
                $j("#" + con).find("ul").eq(index).show();
            })
        })
    },
    dragArr: [],
    dragConArr: [],
    paneArr: [],
    paneConArr: [],
    tabCur: true,
    scrollPosition: function(con, i) {//滚动条位置
        var item = $j("#" + con), jspDrag = item.find(".jspDrag"), jspPane = item.find(".jspPane");
        var jspDragTop = jspDrag.css("top"),
			jspPaneTop = jspPane.css("top");
        if (i == 0) {
            MGC.dragArr.push(jspDragTop);
            MGC.dragConArr.push(jspPaneTop);
        } else {
            MGC.paneArr.push(jspDragTop);
            MGC.paneConArr.push(jspPaneTop);
        }
        if (i == 0) {
            if (MGC.tabCur) {
                jspDrag.css("top", 0);
                jspPane.css("top", 0);
                MGC.tabCur = false;
            } else {
                jspDrag.css("top", MGC.paneArr[0]);
                jspPane.css("top", MGC.paneConArr[0]);
            }
            MGC.paneArr.shift();
            MGC.paneConArr.shift();
        } else {
            if (MGC.tabCur) {
                jspDrag.css("top", 0);
                jspPane.css("top", 0);
                MGC.tabCur = false;
            } else {
                jspDrag.css("top", MGC.dragArr[0]);
                jspPane.css("top", MGC.dragConArr[0]);
            }
            MGC.dragArr.shift();
            MGC.dragConArr.shift();
        }
    },
    tabCut: function(id, con, i) {
        if (!isLoginCallback) {
            return;
        }
        var tabArr = $j("#" + id).find("li a");
        if (tabArr.eq(i).hasClass("current")) {
            return;
        }
        if(id == "sc_tab"){
            if (typeof ($chat) != 'undefined') {
                if(($chat.isPause == true) && (i == 0)){
                    $chat.privateIsPause = false;
                    $chat.helpIsPause = false;
                } else if(($chat.privateIsPause == true) && (i == 1)){
                    $chat.isPause = false;
                    $chat.helpIsPause = false;
                } else if(($chat.helpIsPause == true) && (i == 2)){
                    $chat.isPause = false;
                    $chat.privateIsPause = false;
                } else{
                    $chat.isPause = false;
                    $chat.privateIsPause = false;
                    $chat.helpIsPause = false;
                }
            }
            
            var AllMsgChatContainer = $j('#AllMsgChatContainer');
            var PrivateMsgChatContainer = $j('#PrivateMsgChatContainer');
            var FansGuildMsgChatContainer = $j('#FansGuildMsgChatContainer');
            var allMsg = $j("#AllMsgChatContainer").find("li");
            var privateMsg = $j("#PrivateMsgChatContainer").find("li");
            var helpMsg = $j("#FansGuildMsgChatContainer").find("li");
            var allMsgNum = allMsg.size();
            var privateMsgNum = privateMsg.size();
            var helpMsgNum = helpMsg.size();
           
            
            if (typeof ($chat) != 'undefined') {
                if($j("#AllMsgChatContainer").css("display") == "block"){
                    $chat.newMsg = 0;
                    AllMsgChatContainer.append($chat.newMsgArr.join(''));
                    $chat.newMsgArr = [];
                    allMsg = $j("#AllMsgChatContainer").find("li");
                    allMsgNum = allMsg.size();
                    // 只要消息超出50条，就清除
                    if ((allMsgNum - $chat.msgnum) >= 0) {
                        $j(allMsg.get(allMsgNum - $chat.msgnum)).prevAll().remove();
                    }

                } else if($j("#PrivateMsgChatContainer").css("display") == "block"){
                    $chat.privateNewMsg = 0;
                    PrivateMsgChatContainer.append($chat.privateNewMsgArr.join(''));
                    $chat.privateNewMsgArr = [];
                    privateMsg = $j("#PrivateMsgChatContainer").find("li");
                    privateMsgNum = privateMsg.size();
                    if ((privateMsgNum - $chat.msgnum) >= 0) {
                        $j(privateMsg.get(privateMsgNum - $chat.msgnum)).prevAll().remove();
                    }
                    
                } else if($j("#FansGuildMsgChatContainer").css("display") == "block"){
                    $chat.helpNewMsg = 0;
                    FansGuildMsgChatContainer.append($chat.helpNewMsgArr.join(''));
                    $chat.helpNewMsgArr = [];
                    helpMsg = $j("#FansGuildMsgChatContainer").find("li");
                    helpMsgNum = helpMsg.size();
                    if ((helpMsgNum - $chat.msgnum) >= 0) {
                        $j(helpMsg.get(helpMsgNum - $chat.msgnum)).prevAll().remove();
                    }
                }
            }
        }
        tabArr.removeClass("current").eq(i).addClass("current");
        $j("#" + con).find("ul").hide().eq(i).show();
        if (id == "sc_tab") {
            var num = i == 0 ? allMsgNum : i == 1 ? privateMsgNum : helpMsgNum;
            if ((num - $chat.msgnum) >= 0) {
                $c("#sc_con").find(".jspPane").removeClass("height-auto").height($chat.msgnum * $chat.oneMsgHeight);
                $c("#sc_con").find(".jspPane ul").eq(i).css({ 'position': 'absolute', 'bottom': '0px' });
                $chat.isPaneFixed[i] = true;
            } else {
                $c("#sc_con").find(".jspPane").addClass("height-auto");
                $c("#sc_con").find(".jspPane ul").eq(i).css({ 'position': 'static' });
                $chat.isPaneFixed[i] = false;
            }
        }
        var $scrollAPI;
        if (id == "aninfo_tab1") {
            $scrollAPI = $j("#" + con).find(".fans_list").eq(i - 1).data('jsp');
        } else {
            $scrollAPI = $j("#" + con).data('jsp');
        }
        //重绘滚动条
        if ($scrollAPI){
            $scrollAPI.initScroll();
            if(id == "sc_tab"){
                $("#sc_con .jspDrag").hide();
            }
        }
        // 只有聊天区域切换滚动条才会置底
        if (id == "sc_tab") {
            if (($chat.isPause == true) && ($c("#AllMsgChatContainer").css("display") == "block") || ($chat.privateIsPause == true) && ($c("#PrivateMsgChatContainer").css("display") == "block") || ($chat.helpIsPause == true) && ($c("#FansGuildMsgChatContainer").css("display") == "block")) {
                    
            } else {
                $chat.chatMessage();
                }
        }
    },
    //tabCutNoHide: function (id, con, i) {
    //    var tabArr = $j("#" + id).find("li a"), tim = null;
    //    tabArr.removeClass().eq(i).addClass("current");
    //    //$j("#" + con).find("ul").hide().eq(i).show();
    //    clearInterval(MGC.chatMessageTimer);
    //    MGC.chatMessageTimer = setInterval(function () {
    //        var gl = $j('.sc_con .jspDrag');
    //        if (gl.length > 0) {
    //            MGC.chatMessage();
    //            clearInterval(MGC.chatMessageTimer);
    //            MGC.chatMessageTimer = null;
    //        }
    //    }, 1);
    //},
    sidebarCut: function(id, con, i, chr) {
        var tabArr = $j("#" + id).find(chr);
        tabArr.removeClass().eq(i).addClass("current");
        $j("." + con).hide().eq(i).show();
    },
    personTips: function() {
        $j('#i_attend_list').on('mouseenter', 'a.del', function() {
            $j(this).next().css({ "display": "block" });
        }).on('mouseleave', 'a.del', function() {
            $j(this).next().css({ "display": "none" });
        });

        /*		cardTips:function(e,con){
		 var card=$j(".card_tips"),t=e.pageY+10,l=e.pageX+20;
		 if(defCard==true){
		 card.css({"left":l,"top":t}).show();
		 }else{
		 card.hide();
		 }*/
    },
    carousel: function (id, maxItem, minItem, h, tim, dir) {
        var idItem = $j("#" + id);
        var maxLen;
        var defaults = idItem.data("defaults");
        if (typeof defaults == 'undefined') {
            defaults = {
                maxClass: idItem.find("ul"),
                minClass: idItem.find("div"),
                maxCon: h,
                picTimer: null,
                num: 0
            };
            idItem.data("defaults", defaults);
            clearInterval(defaults.picTimer);
            //先做事件清除
            idItem.unbind("mouseover").unbind("mouseout").hover(function() {
                clearInterval(defaults.picTimer);
            }, function() {
                clearInterval(defaults.picTimer);
                //每次生成定时器之前，先清除定时器
                defaults.picTimer = setInterval(function() {
                    if (defaults.num == maxLen) {
                        picMoveFirst();
                        defaults.num = 0;
                    } else {
                        picMoves(defaults.num);
                    }
                    defaults.num++;
                }, tim);
            }).trigger("mouseout");
        }
        maxLen = defaults.maxClass.find("li").length
        defaults.minClass.find("span").each(function(index) {
            $j(this).bind("mouseover", function() {
                picMoves(index);
                defaults.num = index;
            });
        });
        function picMoves(index) {
            defaults.minClass.find("span").removeClass().eq(index).addClass("current");
            if (dir == "left") {
                defaults.maxClass.stop(true, false).animate({
                    "left": -defaults.maxCon * index
                });
            } else {
                defaults.maxClass.stop(true, false).animate({
                    "top": -defaults.maxCon * index
                });
            }
        }
        function picMoveFirst() {
            defaults.maxClass.append(defaults.maxClass.find("li:first").clone());
            if (dir == "left") {
                defaults.maxClass.stop(true, false).animate({
                    "left": -defaults.maxCon * maxLen
                }, 300, function() {
                    defaults.maxClass.css("left", "0");
                    defaults.maxClass.find("li:last").remove();
                });
            } else {
                defaults.maxClass.stop(true, false).animate({
                    "top": -defaults.maxCon * maxLen
                }, 300, function() {
                    defaults.maxClass.css("top", "0");
                    defaults.maxClass.find("li:last").remove();
                });
            }
            defaults.minClass.find("span").removeClass("current").eq(0).addClass("current");
        }
    },
    showTips: function(id, tipsItem) {
       $j("#" + id).off("mouseover,mouseout").on("mouseover", function(){
            $j("#" + tipsItem).stop(false, true).fadeIn();
        }).on("mouseout", function(){
            $j("#" + tipsItem).stop(false, true).fadeOut();
        });
    },
    evenTabClass: function(id, className) {
        $j("#" + id).find("tbody tr").each(function(index) {
            if (Math.round(index % 2) == 1) {
                $j(this).addClass(className);
            }
        })
    },
    switchTab: function(id, con) {
        var tabArr = $j("#" + id).find("a"), len = tabArr.length, s_href = location.href, s_position = s_href.indexOf("#"), s_param = parseInt(location.href.slice(s_position + 1));
        tabArr.each(function(index) {
            if (!isNaN(s_param)) {
                $j("." + con).eq(index).hide();
                tabArr.removeClass().eq(s_param).addClass("current");
            }
            $j(this).bind("click", function() {
                tabArr.removeClass().eq(index).addClass("current");
                for (var i = 0; i < len; i++) { $j("." + con).eq(i).hide(); }
                $j("." + con).eq(index).show();
            })
        });
        if (!isNaN(s_param)) {
            $j("." + con).eq(s_param).show();
        } else {
            $j("." + con).eq(0).show();
        }
    },
    personalData: function() {
        var loginedNav = $j(".logined_nav").find("a"), logined = $j(".logined"), userPic = $j(".s_user_pic");
        loginedNav.eq(3).on("mouseenter", function() {
            MGCLoginRequest.getCardInfo();
            $j(".logined_con").hide().eq(1).show();
            $j('.logined_status ul').hide();
        });
        userPic.on("mouseenter", function() {
            MGCLoginRequest.getCardInfo();
            $j(".logined_con").hide().eq(0).show();
        });
        loginedNav.eq(0).off("mouseover,mouseout").on("mouseover", function(){
            $j(".logined_con").hide();
            $j('.logined_status ul').hide();
        });
        loginedNav.eq(1).off("mouseover,mouseout").on("mouseover", function(){
            $j(".logined_con").hide();
            $j('.logined_status ul').hide();
        });
        loginedNav.eq(2).off("mouseover,mouseout").on("mouseover", function(){
            $j(".logined_con").hide();
            $j('.logined_status ul').hide();
        });
        logined.mouseleave(function() {
            $j(".logined_con").hide();
            $j('.logined_status ul').hide();
        });
        $j(".logined_con").not(".logined_status").click(function() {
            $j('.logined_status ul').hide();
        });
    },
    sub: 0,
    popLen: 1000,
    popFormsShow: function(id) {
        var popShade = $j(".pop_shade");
        MGC.popLen++;
        $j("#" + id).css({ "zIndex": MGC.popLen }).show();
        popShade.show();
    },
    popFormsHide: function() {//关闭所有弹窗和遮罩层
        var popItem = $j(".pop,.pop_card"), popShade = $j(".pop_shade");
        popShade.hide(); popItem.hide();
    },
    popAssignHide: function(id) {//关闭指定id弹窗
        var popItem = $j("#" + id), popShade = $j(".pop_shade");
        MGC.popLen--;
        popItem.hide();
        if (MGC.popLen <= 1000) {
            popShade.hide();
        }
    },
    recommend: function(isSmall) {
        var num = isSmall ? 3 : 5;
        var left = isSmall ? 339 : 880;
        var obj = isSmall ? $j(".video_recommend_list") : $j(".recommend_list").not(".video_recommend_list");
        var rlCon = obj.find(".rl_con"), page = 0, rlPre = obj.find(".rl_pre"), rlNext = obj.find(".rl_next");
        if (rlCon.find("li").length <= num) {
            rlPre.removeClass().addClass("rl_pre rl_pre_un");
            rlNext.removeClass().addClass("rl_next rl_next_un");
        } else {
            rlPre.removeClass().addClass("rl_pre rl_pre_un");
            rlNext.removeClass().addClass("rl_next");
        }

        rlPre.click(function() {
            var rList = rlCon.find("li"), len = rList.length;
            if (len >= num) {
                page--;
                if (page == 0) {
                    //rlNext.removeClass().addClass("rl_next rl_next_un");
                    rlPre.removeClass().addClass("rl_pre rl_pre_un");
                }
                if (page >= 0) {
                    rlCon.find("ul").animate({ "left": -left * page });
                    //rlPre.removeClass().addClass("rl_pre");
                    rlNext.removeClass().addClass("rl_next");
                } else {
                    page = 0;
                }
            }
        });
        rlNext.click(function() {
            var rList = rlCon.find("li"), len = rList.length, total = Math.ceil(len / num);
            if (len >= num) {
                page++;
                if (page < total) {
                    rlCon.find("ul").animate({ "left": -left * page });
                    //rlNext.removeClass().addClass("rl_next");
                    rlPre.removeClass().addClass("rl_pre");
                } if (page == total - 1) {
                    //rlPre.removeClass().addClass("rl_pre rl_pre_un");
                    rlNext.removeClass().addClass("rl_next rl_next_un");
                }
                if (page > total - 1) {
                    page--;
                }
            }

        });
    },
    popTips: function(id, item) {
        var arr = $j("." + id);
        arr.each(function() {
            /*			$j(this).find(item).mouseenter(function(){
			 $j(this).hide();
			 });*/
            //$j(this).hover(function(){
            //	$j(this).find(item).show();
            //},function(){
            //	$j(this).find(item).hide();
            //});

            var xOffset = 10;
            var yOffset = 0;

            var oldOffsetTop;
            var oldOffsetLeft;
            $j(this).off("mouseover,mouseout").on("mouseover", function(e){
                //$j(this).find(item).show();
                var liObj = $j(this).find(item);
                $j(this).find(item).off("mouseover").on('mouseover', function(e) {
                    liObj.hide();
                });
                $j(this).find(item)
						.css("top", (e.pageY + yOffset - liObj.parent().offset().top) + "px")
						.css("left", (e.pageX + xOffset - liObj.parent().offset().left) + "px")
                    .css("z-index", 999)
                    .show();
            }).on("mouseout", function(){
                $j(this).find(item).hide();
            });
            //$j(this).mousemove(function (e) {
            //    var liObj = $j(this).find(item);
            //    $j(this).find(item)
            //	.css("top", (e.pageY + yOffset - liObj.parent().offset().top) + "px")
            //	.css("left", (e.pageX + xOffset - liObj.parent().offset().left) + "px");
            //});
        });
    }, popTipss: function(id, item, mainType, subType) {
        if (mainType == undefined) {
            mainType = 1;
        }
        if (subType == undefined) {
            subType = 3;
        }
        var arr = $j("." + id);
        
        arr.off("mouseover,mouseout").on("mouseover", function(){
            window.mgc.popmanager.layerControlShow($j(this).find(item), mainType, subType);
        }).on("mouseout", function(){
            window.mgc.popmanager.layerControlHide($j(this).find(item), mainType, subType);
        });
    },
    popAnchor: function(id, item) {

        var arr = $j("." + id);
        arr.off("mouseover,mouseout").on("mouseover", function(){
            MGCData.anchor_area = false;
            window.mgc.popmanager.layerControlShow($j(this).find(item), 1, 3);
        }).on("mouseout", function(){
            window.mgc.popmanager.layerControlHide($j(this).find(item), 1, 3);
            MGCData.anchor_area = true;
        });
    },
    popAnchor_tips: function(topNum, leftNum) {
        var strongItem = $j('#anchor_level_tips').find("strong");

        $j('#is_bottleneck,#i_is_bottleneck,#pd_progress,#max_span,#max_i,#spanW0,#anchor_Per,#anchor_exp,#exp_max,#exp_common').css('display', 'none');
        $j('#anchor_level_temp').attr('class', '');
        $j('#anchor_level_temp').addClass("anchor_level_" + MGCData.anchor_level_bg).removeClass('anchor_level_');
        $j('#anchor_level_temp').html('<i>' + MGCData.anchor_level + '</i>');

        if (MGCData.is_bottleneck) {
            $j('#anchor_level_tips strong').css('width', '168px');
            $j('#is_bottleneck').css('display', 'inline-block');
            $j('#i_is_bottleneck').css('display', 'block');
            $j('#gift_mover,#exp_common,#exp_max').css('display', 'none');
            $j('#i_is_bottleneck').html("赠送炫豆礼物可帮助主播升阶哦<br>已获得："+MGCData.bottleneck_count);
        } else {
            $j('#is_bottleneck,#i_is_bottleneck').css('display', 'none');
            if (MGCData.anchor_levelup_exp == -1) {
                $j('#pd_progress').css('display', 'block');
                $j('#exp_common,#anchor_exp').css('display', 'none');
            }
        }

        $j("#anchor_level,.si_face_links,.layer-anchor .anchor-hot").off("mouseover,mouseout").on("mouseover", function(){
            //公会，演唱会房间在未开播时不能显示主播tip
            if((mgc.tools.is_live_room() || mgc.tools.is_show_room()) && !isLiveOpen)return;

        	var leftNumReal = leftNum;
            $j('#i_anchor_level').html('LV' + MGCData.anchor_level);
            $j('#forAnchor_exp').html(MGCData.total_anchor_exp + '/' + MGCData.max_anchor_exp);
            if (MGCData.is_bottleneck) {
                $j('#anchor_level_tips strong').css('width', '168px');
                $j('#gift_mover,#exp_common,#exp_max').css('display', 'none');
                $j('#is_bottleneck').css('height', '20px');
                $j('#i_is_bottleneck').css('display', 'block');
                $j('#i_is_bottleneck').html("赠送炫豆礼物可帮助主播升阶哦<br>已获得："+MGCData.bottleneck_count);
                $j('#anchor_level_txt').hide();
                //leftNumReal += 20;
            } else {
                if (filename == "liveroom.shtml" || filename == "caveolaeroom.shtml" || filename == "nest.shtml") {
                    $j('#anchor_level_tips strong').css('width', '303px');
                } else if (filename == "showroom.shtml") {
                    $j('#anchor_level_tips strong').css('width', '270px');
                }
                $j('#anchor_level_txt').show();
                $j('#i_is_bottleneck').css('display', 'none');
                if (MGCData.anchor_levelup_exp == -1) {
                	if (filename == "liveroom.shtml" || filename == "caveolaeroom.shtml" || filename == "nest.shtml") {
                	    $j('#max_span,#anchor_Per,#anchor_exp').css('display', 'block');
                	}
                    $j('#exp_common').css('display', 'none');
                    $j('#max_i,#exp_max').css('display', 'block');
                    $j('#i_mhb_exp').html(0);
                    $j('#i_star_exp').html(0);
                    $j('#gift_mover').css('display', 'block');
                    $j('#forAnchor_exp').html('0/0');
                } else if ((MGCData.anchor_exp == 0 && MGCData.anchor_levelup_exp != 0) || MGCData.anchor_Per == 0) {
                    $j('#spanW0').css('display', 'block');
                    $j('#anchor_exp,#exp_common').css('display', 'block');
                    $j('#anchor_exp').html(MGCData.anchor_exp + '/' + MGCData.anchor_levelup_exp);
                    $j('#exp_common').html('经验值：<i>' + MGCData.anchor_exp + '/' + MGCData.anchor_levelup_exp + '</i>');
                    $j('#forAnchor_exp').html(MGCData.total_anchor_exp + '/' + MGCData.max_anchor_exp);
                    $j('#i_mhb_exp').html(MGCData.dream_gift_rest_exp_today);
                    $j('#i_star_exp').html(MGCData.starlight_rest_exp_today);
                    $j('#i_lucky_exp').html(MGCData.lucky_draw_rest_exp_today);
                    $j('#gift_mover').css('display', 'block');
                } else {
                    $j('#anchor_Per').css('width', MGCData.anchor_Per);
                    $j('#anchor_Per,#anchor_exp,#exp_common').css('display', 'block');
                    $j('#gift_mover').css('display', 'block');
                    $j('#i_mhb_exp').html(MGCData.dream_gift_rest_exp_today);
                    $j('#i_star_exp').html(MGCData.starlight_rest_exp_today);
                    $j('#i_lucky_exp').html(MGCData.lucky_draw_rest_exp_today);
                    $j('#anchor_exp').html(MGCData.anchor_exp + '/' + MGCData.anchor_levelup_exp);
                    $j('#exp_common').html('经验值：<i>' + MGCData.anchor_exp + '/' + MGCData.anchor_levelup_exp + '</i>');
                    $j('#forAnchor_exp').html(MGCData.total_anchor_exp + '/' + MGCData.max_anchor_exp);
                }
            }
            var mhbHtml = '';
            $j.each(MGCData.fantasyGiftData, function(k, v) {
                mhbHtml += v[1] + '：' + v[0] + '主播经验/个 <br />';
            })
            $j('#mhb_anchor').html(mhbHtml);

            //var t = $j(this).offset().top + topNum;
            //var l = $j(this).offset().left + leftNumReal;
            var t = $j(".si_face").offset().top + topNum;
            var l = $j(".si_face").offset().left + leftNumReal;
            strongItem.css({
                "top": t,
                "left": l
            });
            $j('#anchor_level_tips').css('display', 'block');
            window.mgc.popmanager.layerControlShow(strongItem, 1, 3);
        }).on("mouseout", function(){
            $j('#anchor_level_tips').css('display', 'none');
            window.mgc.popmanager.layerControlHide(strongItem, 1, 3);
        });

    },
    /*
    * 获取事件  此处event为引类型，在传递过程中event改变,赋值变量随即改变，因此此处要复制一个event对象指向不同的地址。 兼容ie(ps:update时请与77说一下)
    */
    getEvent: function() {
        if (document.all) {
            return $.extend(true, {}, window.event);// 如果是ie
        }
        var func = this.getEvent.caller;
        while (func != null) {
            var arg0 = func.arguments[0];
            if (arg0) {
                if ((arg0.constructor == Event || arg0.constructor == MouseEvent) || (typeof (arg0) == "object" && arg0.preventDefault && arg0.stopPropagation)) {
                    return $.extend(true, {}, arg0);
                }
            }
            func = func.caller;
        }
        return null;
    },
    /*
    * 获取浏览器的宽度和高度
    */
    clientXY: function() {
        var X = document.body.clientWidth;
        var Y = document.body.clientHeight;
        return { X: X, Y: Y };
    },
    /*
    * 获取鼠标的位置坐标
    */
    mouseXY: function() {
        var evt = this.getEvent();
        var X, Y;
        if (evt.pageX || evt.pageY) {
            X = evt.pageX;
            Y = evt.pageY;
        } else if (evt.clientX || evt.clientY) {
            X = evt.clientX;
            Y = evt.clientY;
        }
        return { X: X, Y: Y };
    },
    //tips重新定位
    comm_tips_position: function(obj, position, x, y) {
        x = x || 0;
        y = y || 0;
        var _x, _y;
        var mouseXY = this.mouseXY();
        var clientXY = this.clientXY();
        var _w = obj.width();
        _x = mouseXY.X + 30;
        _y = mouseXY.Y - (obj.height() / 2);
        if (clientXY.X < _x + _w + 10) {
            if (position) {
                _x = x;
                _y = y;
            } else {
                _x = clientXY.X - _w - 10 + x;
                _y = mouseXY.Y + 25 + y;
            }
            obj.css({ "top": _y, "left": _x });
        }
    },
    //tips重新定位_主播星耀-人气
    comm_tips_position_change: function (obj, position, x, y) {
        x = x || 0;
        y = y || 0;
        var _x, _y;
        var mouseXY = this.mouseXY();
        var clientXY = this.clientXY();
        var _w = obj.width();
        _x = mouseXY.X + 30;
        _y = mouseXY.Y - (obj.height() / 2);
        if (clientXY.X <= _x + _w +90) {
            if (position) {
                _x = x;
                _y = y;
            } else {
                _x = clientXY.X - _w - 10 + x;
                _y = mouseXY.Y + 25 + y;
            }
            obj.css({ "top": _y, "left": _x });
        }
    },
    pop_rqTips: function(e, n, val) {
        var _e = e.target == undefined ? e.toElement : e.target;
        var t = _e.offsetTop - 10;
        var l = _e.offsetLeft + 110;
        if (n == 1 && val == '') {
            return false;
        }
        var susTips = $j('#i_top');
        susTips.css({ "top": t, "left": l, "z-index": 999 });
        if (n == 1) {
            if (val != '') {
                susTips.text(val);
            }
            //重新定位
            if(mgc.tools.is_show_room()){
                MGC.comm_tips_position_change(susTips, true, 100, -16);
            } else{
                MGC.comm_tips_position_change(susTips, true, 100, 60);
            }
            //susTips.show();
            window.mgc.popmanager.layerControlShow(susTips, 1, 3);
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, 1, 3);
        }


    },
    pop_rq_two_Tips: function(e, n, val) {
        var _e = e.target == undefined ? e.toElement : e.target;
        var t = _e.offsetTop - 8;
        var l = _e.offsetLeft + 125;
        if (n == 1 && val == '') {
            return false;
        }
        var susTips = $j('#i_top_two');
        susTips.css({ "top": t, "left": l, "z-index": 999 });
        if (n == 1) {
            if (val != '') {
                susTips.text(val);
            }
            //重新定位
            if(mgc.tools.is_show_room()){
                MGC.comm_tips_position_change(susTips, true, 100, 5);
            } else{
                MGC.comm_tips_position_change(susTips, true, 100, 85);
            }
            
            //susTips.show();
            window.mgc.popmanager.layerControlShow(susTips, 1, 3);
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, 1, 3);
        }


    },
    popGguestTips: function(id, item) {
        var arr = $j("." + id);
        arr.each(function() {
            /*			$j(this).find(item).mouseenter(function(){
             $j(this).hide();
             });*/
            //$j(this).hover(function(){
            //	$j(this).find(item).show();
            //},function(){
            //	$j(this).find(item).hide();
            //});

            var xOffset = 5;

            var oldOffsetTop;
            var oldOffsetLeft;
            $j(this).off("mouseover,mouseout").on("mouseover", function(){
                //$j(this).find(item).show();
                var liObj = $j(this).find(item);
                $j(this).find(item).off("mouseover").on('mouseover', function(e) {
                    liObj.hide();
                });
                $j(this).find(item)
                .css("top", (liObj.offset().top + 85) + "px")
                .css("left", (xOffset + liObj.offset().left + 73) + "px")
                    .css("z-index", 999)
                    .show();
            }).on("mouseout", function(){
                $j(this).find(item).hide();
            });
        });
    },
    //飞屏功能移植到flash实现，调用方法移植到mgc.common.js（MGC_Comm.setFlyScreenSwfObj方法附近）中。
    /*
    flyDataArr: [],
    flyDataArr_GrabSelf: [],
    flyDataArr_GrabOther: [],
    flyDataArr_GrabOut: [],
    flyViplevel: [],
    flyData: null,
    flyNum: 0,
    flyDec: true,
    flyTim: null,
    //b是否守护 isConcert是否演唱会
    flyScreenArr: function(obj, b, isConcert) {
        MGC.flyData = obj;
        var senderdefendHtml = MGC.flyData.senderdefend < 10 ? '' : '<i class="icon_lv icon_lv' + MGC.flyData.senderdefend + '"></i>';
        var viplevelHtml = MGC.flyData.viplevel == 0 ? '' : '<i class="icon_honor icon_honor' + MGC.flyData.viplevel + '"></i>';
        var wealthlevelHtml = MGC.flyData.wealth_level == 0 ? '' : '<i class="wealth_level_' + MGC.flyData.wealth_level + '"></i>';
        var strPic = '';
        if (b == def && (MGC.flyData.isTakeVip == false)) {
            strPic = "【" + wealthlevelHtml + senderdefendHtml + MGC.flyData.senderName + viplevelHtml + "】:" + MGC.flyData.MsgStr;
            //    MGC.flyDataArr.push(strPic);
            MGC.flyDataArr_GrabOut.push(strPic);
        } else if (MGC.flyData.isTakeVip) {
            if (wealthlevelHtml == '' && senderdefendHtml == '' && viplevelHtml == '') {
                strPic = MGC.flyData.MsgStr;
                if (MGC.flyData.isSelf == 3) {
                    MGC.flyDataArr_GrabSelf.push(strPic);
                } else if (MGC.flyData.isSelf == 4) {
                    MGC.flyDataArr_GrabOther.push(strPic);
                }
            } else {
                strPic = wealthlevelHtml + senderdefendHtml + viplevelHtml + MGC.flyData.MsgStr;
                if (MGC.flyData.isSelf == 3) {
                    MGC.flyDataArr_GrabSelf.push(strPic);
                } else if (MGC.flyData.isSelf == 4) {
                    MGC.flyDataArr_GrabOther.push(strPic);
                }
            }
        } else {
            strPic = "【" + wealthlevelHtml + MGC.flyData.senderName + viplevelHtml + "】:" + MGC.flyData.MsgStr;
            //   MGC.flyDataArr.push(strPic);
            MGC.flyDataArr_GrabOut.push(strPic);
        }
        MGC.flyViplevel.push(MGC.flyData.viplevel);
        //遍历抢座飞屏、自己抢座飞屏、礼物飞屏队列数组

        if ((MGC.flyDataArr.length == 0 || MGC.flyDataArr.length > 0) && (MGC.flyDataArr_GrabSelf.length > 0)) {
            MGC.flyDataArr = MGC.flyDataArr_GrabSelf;
        }
        else if (MGC.flyDataArr_GrabOther.length > 0) {
            MGC.flyDataArr = MGC.flyDataArr_GrabOther;
        }
        else {
            MGC.flyDataArr = MGC.flyDataArr_GrabOut;
        }
        if (MGC.flyDataArr.length > 0) {
            MGC.flyTim = setInterval(function() {
                if (MGC.flyDataArr.length >= 1) {
                    MGC.flyScreen(b);
                } else {
                    clearInterval(MGC.flyTim);
                    return;
                }
            }, 500);
        } else {
            return;
        }

        if (isConcert) {
            //====horizon====//
            MGC.topArr = [10 + 40, 62 + 40, 282 + 170, 332 + 170];
            //====tencent====//
            //MGC.topArr = [10, 62, 282 + 25, 332 + 25];
        }
        else {
            //====horizon====//
            MGC.topArr = [10 + 50, 62 + 50, 282 + 50, 332 + 50];
            //====tencent====//
            //MGC.topArr = [10 - 10, 62 - 10, 282 - 10, 332 - 10];
        }

    },
    topArr: [10, 62, 282, 332],
    anArr: [1, 1, 1, 1, 1, 1, 1, 1, 1, 1],//记录节点是否在动画
    delArr: [],
    hashArr: {},
    lastY: 0,
    thisY: 0,
    canFly: true,
    _left: -1110,
    _movestep: 20000,
    flyScreen: function() {//0普通1近卫2	骑士3将军4亲王5皇帝
        var fly = $j("#fly"), flyArr = fly.find("li"), c = $j("#content")[0].offsetLeft, w = $j(window).width() - c, _html = "", len = MGC.topArr.length;
        if (MGC.flyDec) {
            flyArr.css({ "left": w });
            MGC.flyDec = false;
        }
        if (!MGC.canFly) return;
        if (MGC.flyDataArr.length > 0) {
            for (var i = 0; i < MGC.anArr.length; i++) {
                if (MGC.anArr[i] == 1) {
                    var size = MGC.flyDataArr[0].length;
                    var sLeft;
                    if (document.compatMode == "BackCompat") {
                        sLeft = document.body.scrollLeft;
                    }
                    else { //document.compatMode == \"CSS1Compat\" 
                        sLeft = document.documentElement.scrollLeft == 0 ? document.body.scrollLeft : document.documentElement.scrollLeft;
                    }
                    _html = MGC.tcHtml();
                    console.log("飞屏数据监测：" + _html.replace(/</g, '[').replace(/>/g, ']'));
                    MGC.anArr[i] = 0;
                    //不能跟上一个坐标重复
                    MGC.thisY = MGC.thisY;
                    do{
                        var randNum = Math.floor(Math.random() * (len));//取随机数
                        MGC.thisY = MGC.topArr[randNum];
                    }
                    while (MGC.lastY == MGC.thisY) 
                    MGC.lastY = MGC.thisY;
                    //console.error("上次坐标：" + MGC.lastY + " 坐标数组：" + MGC.topArr + " 飞屏y坐标：" + MGC.thisY);
                    flyArr.eq(i).css({ "top": MGC.thisY, "left": w + sLeft }).append(_html);
                    flyArr.eq(i).animate({ "left": MGC._left-c }, MGC._movestep, "linear", function() {
                        $j(this).css({ "left": w }).children().remove();

                        MGC.anArr[i] = 1;
                    });
                    //下一个飞屏的间隔
                    MGC.canFly = false;
                    setTimeout('MGC.canFly=true', 4000);
                    break;//这里是关键，跳出循环
                }
            }
        }        
    },
    tcHtml: function() {
        var _html = "";
        if ((MGC.flyViplevel[0] == 0) && (MGC.flyData.isTakeVip == false)) {
            _html = '<i class="fly_pt_left"/><p class="fly_pt">' + MGC.flyDataArr[0] + '</p><i class="fly_pt_right"/>'; MGC.flyDataArr.shift(); MGC.flyViplevel.shift();
        } else if ((MGC.flyViplevel[0] == 1) && (MGC.flyData.isTakeVip == false)) {
            _html = '<i class="fly_jw_left"/><p class="fly_jw">' + MGC.flyDataArr[0] + '</p><i class="fly_jw_right"/>'; MGC.flyDataArr.shift(); MGC.flyViplevel.shift();
        } else if ((MGC.flyViplevel[0] == 2) && (MGC.flyData.isTakeVip == false)) {
            _html = '<i class="fly_qs_left"/><p class="fly_qs">' + MGC.flyDataArr[0] + '</p><i class="fly_qs_right"/>'; MGC.flyDataArr.shift(); MGC.flyViplevel.shift();
        } else if ((MGC.flyViplevel[0] == 3) && (MGC.flyData.isTakeVip == false)) {
            _html = '<i class="fly_jj_left"/><p class="fly_jj">' + MGC.flyDataArr[0] + '</p><i class="fly_jj_right"/>'; MGC.flyDataArr.shift(); MGC.flyViplevel.shift();
        } else if ((MGC.flyViplevel[0] == 4) && (MGC.flyData.isTakeVip == false)) {
            _html = '<i class="fly_qw_left"/><p class="fly_qw">' + MGC.flyDataArr[0] + '</p><i class="fly_qw_right"/>'; MGC.flyDataArr.shift(); MGC.flyViplevel.shift();
        } else if ((MGC.flyViplevel[0] == 5) && (MGC.flyData.isTakeVip == false)) {
            _html = '<i class="fly_hd_left"/><p class="fly_hd">' + MGC.flyDataArr[0] + '</p><i class="fly_hd_right"/>'; MGC.flyDataArr.shift(); MGC.flyViplevel.shift();
        } else if (((MGC.flyViplevel[0] == 0) || (MGC.flyViplevel[0] == 1) || (MGC.flyViplevel[0] == 2) || (MGC.flyViplevel[0] == 3) || (MGC.flyViplevel[0] == 4) || (MGC.flyViplevel[0] == 5)) && (MGC.flyData.isTakeVip == true)) {
            _html = '<i class="fly_qz_left"/><p class="fly_qz">' + MGC.flyDataArr[0] + '</p><i class="fly_qz_right"/>'; MGC.flyDataArr.shift(); MGC.flyViplevel.shift();
        }
        return _html;
    },
    */
    marData: null,
    marDataArr: [],
    marRankDataArr: [],
    canFlyMarquee: true,
    flyMarqueeTim: null,
    marqueeArr: function(obj) {
        var lvswf = getSWF("LiveVideoSwfContainer");
        lvswf.addMarquee(obj.MsgStr);
        obj = null;
        lvswf = null;
        return;
        var videoItem = $j(".video_light");
        MGC.marData = obj;
        if (MGC.marData.op_type == 235) {
            MGC.marRankDataArr.push({ "guard_level": MGC.marData.guard_level, "type": MGC.marData.op_type, "str": MGC.marData.MsgStr });
        } else {
            MGC.marDataArr.push({ "guard_level": MGC.marData.guard_level, "type": MGC.marData.op_type, "str": MGC.marData.MsgStr });
        }
        if (MGC.flyMarqueeTim == null) {
            MGC.flyMarqueeTim = setInterval(function() {
                if (MGC.marDataArr.length > 0) {
                    MGC.flyMarquee(0);
                } else if (MGC.marRankDataArr.length > 0) {
                    MGC.flyMarquee(1);
                } else {
                    clearInterval(MGC.flyMarqueeTim);
                    MGC.flyMarqueeTim = null;
                }
            }, 500);
        }

        /*
        if(MGC.marDataArr.length>0)
        {
            if(MGC.flyMarqueeTim == null) {
                MGC.flyMarqueeTim = setInterval(function () {
                    MGC.flyMarquee();
                }, 500);
            }
        }
        else
        {
            clearInterval(MGC.flyMarqueeTim);
            MGC.flyMarqueeTim = null;
        }
        */

        /*		if(MGC.marDataArr.length>0){
		 MGC.flyMarquee();
		 }else{
		 return;
		 }*/
        obj = null;
    },
    getLength: function(str) {
        return String(str).replace(/[^\x00-\xff]/g, 'aa').length;
    },
    /*
    *走马灯
    *去除老的处理逻辑
    *update by 77
    */
    flyMarquee: function(i) {
        if (!MGC.canFlyMarquee) return;
        var videoItem = $j(".video_light"),
            dataNum = parseInt(videoItem.attr("data-num"));
        if (videoItem.attr("hide") == 1) {
            videoItem.fadeIn();
            videoItem.attr("hide", 0)
        }
        //清除队列
        var tempArr;
        if (i == 0 && MGC.marDataArr.length > 0) {//其它走马灯
            tempArr = MGC.marDataArr[0];
            MGC.marDataArr.shift();
        } else if (i == 1 && MGC.marRankDataArr.length > 0) {//排行榜排名变化
            tempArr = MGC.marRankDataArr[0];
            var o = MGC.marRankDataArr.shift();
            o = null;
        }
        if (tempArr) {
            var span = $j("<span>" + tempArr.str + "</span>"), strLen, type;
            videoItem.append(span);
            type = tempArr.type;
            strLen = span.width();
            var nexttime = 10000;
            var steptime = 15000;
            if (dataNum != 1) {//直播房间房间
                //超凡守护  独立样式
                if (tempArr.guard_level == 500) {
                    span.css("color", "#fdff7c");
                    steptime = 18000;
                    nexttime = 15000;
                }
                //根据走马灯类型，定义下一个出现的时间
                if (type == 235) {
                    steptime = 18000;
                    nexttime = 15000;
                }
                //若走马灯长度大于450，这时需要定义其走过的时间，防止重叠
                if (strLen > 800) {
                    steptime = 18000;
                    nexttime = 15000;
                }
            }
            else {//演唱会
                span.css("left", '875px');
                steptime = 18000;
                nexttime = 15000;
            }

            //移动
            span.animate({ "left": -strLen }, steptime, "linear", function() {
                $j(this).remove();
                if (videoItem.find("span").length == 0) {
                    videoItem.fadeOut();
                    videoItem.attr("hide", 1)
                }
            });
            MGC.canFlyMarquee = false;
            setTimeout("MGC.canFlyMarquee=true;", nexttime);
        }
    },
    clickTab: function(id, con) {
        var tab = $j("#" + id), tabArr = tab.find("a"), conArr = $j("." + con);
        tabArr.each(function(index) {
            $j(this).click(function() {
                tabArr.removeClass().eq(index).addClass("current");
                conArr.hide().eq(index).show();
            });
        });
    },
    mnSelect: function(id, list) {
        $j("#" + id).find("b").click(function() {
            $j("#" + list).toggle();
        });
        $j(document).click(function(e) {
            e = e || window.event; // 兼容IE7
            obj = $j(e.srcElement || e.target);
            if ($j(obj).is("#" + id + ",#" + id + " *")) {
                //$j("#"+list).toggle();
                $j("#" + list).show();
            } else {
                $j("#" + list).hide();
            }
        });

        $j("#" + list).on('click', 'li', function() {
            $j("#" + list).hide();
            var shtml = $j(this).find("span").html();
            if (typeof ($j(this).attr('data')) != 'undefined') {
                $j("#" + id).attr('data', $j(this).attr('data'));
            }
            $j("#" + id).find("span").html(shtml);
        });
    },
    mnsSelect: function(id, list) {
        $j("#" + id).find("b").unbind("click").click(function() {
            if (id == "select_open_btn") {
                if ($j("#" + list).css("display") == "none") {
                    window.mgc.popmanager.layerControlShow($j("#" + list), 4, 2);
                } else {
                    window.mgc.popmanager.layerControlHide($j("#" + list), 4, 2);
                }
            } else {
                $j("#" + list).toggle();
            }
        });
        $j(document).unbind("click").click(function(e) {
            e = e || window.event; // 兼容IE7
            obj = $j(e.srcElement || e.target);
            if ($j(obj).is("#" + id + ",#" + id + " *")) {
                if (id == "select_open_btn") {
                    if ($j("#" + list).css("display") == "none") {
                        window.mgc.popmanager.layerControlShow($j("#" + list), 4, 2);
                    } else {
                        window.mgc.popmanager.layerControlHide($j("#" + list), 4, 2);
                    }
                } else {
                    $j("#" + list).toggle();
                    //$j("#"+list).show();
                }
            } else {
                if (id == "select_open_btn") {
                    window.mgc.popmanager.layerControlHide($j("#" + list), 4, 2);
                } else {
                    $j("#" + list).hide();
                }
            }
        });

        $j("#" + list).unbind("click").on('click', 'li', function() {
            if (id == "select_open_btn") {
                window.mgc.popmanager.layerControlHide($j("#" + list), 4, 2);
            } else {
                $j("#" + list).hide();
            }
            var shtml = $j(this).html();
            if (typeof ($j(this).attr('data')) != 'undefined') {
                $j("#" + id).attr('data', $j(this).attr('data'));
            }
            $j("#" + id).find("span").html(shtml);
        });
    },
    mnssSelect: function(id, list) {
        $j("#" + id).click(function() {
            if ($j("#" + list).css("display") == "none") {
                window.mgc.popmanager.layerControlShow($j("#" + list), 4, 2);
            } else {
                window.mgc.popmanager.layerControlHide($j("#" + list), 4, 2);
            }
        });
        $j(document).click(function(e) {
            e = e || window.event;
            // 兼容IE7
            obj = $j(e.srcElement || e.target);
            if (!$j(obj).is("#" + id + ",#" + id + " *")) {
                window.mgc.popmanager.layerControlHide($j("#" + list), 4, 2);
            }
        });

        $j("#" + list).on('click', 'li', function() {
            window.mgc.popmanager.layerControlHide($j("#" + list), 4, 2);
            var shtml = $j(this).html();
            if (typeof ($j(this).attr('data')) != 'undefined') {
                $j("#" + id).attr('data', $j(this).attr('data'));
            }
            $j("#" + id).find("span").html(shtml);
        });
    },
    onFouse: function(id, txt) {
        var thisItem = $j("#" + id), thistxt = thisItem.val();
        thisItem.css({ "color": "#1c1c1c" });
        if (thistxt == txt) {
            thisItem.val("");
        }
    },
    onblur: function(id, txt) {
        var thisItem = $j("#" + id), thistxt = thisItem.val();
        if (thisItem.val() == "") {
            thisItem.val(txt).css({ "color": "#bcbcbc" });
        }
    },
    cardTips: function(evt, con) {
        var posx = 0, posy = 0, l, t, card = $j(".card_tips");
        if (/firefox/.test(navigator.userAgent.toLowerCase())) {
            evt = evt
        } else {
            evt = evt || window.event;
        }
        //var evt = evt || window.event;
        if (evt == undefined) {
            var Y = $j('#GiftSwf').offset().top;
            var X = $j('#GiftSwf').offset().left;
            t = mouseY + Y + 10;
            l = mouseX + X + 20;
        }
        else {
            if (evt.pageX || evt.pageY) {
                posx = evt.pageX;
                posy = evt.pageY;
            } else if (evt.clientX || evt.clientY) {
                posx = evt.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
                posy = evt.clientY + document.documentElement.scrollTop + document.body.scrollTop;
            }
            if (navigator.userAgent.toLocaleLowerCase().indexOf('msie') !== -1) {
                t = posy + 10, l = posx + 20;
            } else {
                t = posy + 10, l = posx + 20;
            }
        }

        //判断是否出边界
        if ((l + 204) > $j(window).width()) {
            l = l - 204;
        }
        var cardHeight = card.height();
        if ((t + cardHeight) > $j(window).height()) {
            t = t - cardHeight;
        }
        var sideStat = $(".side-left").attr("side_state");
        var mainType = 3;
        if (filename != "showroom.shtml") {
            //不是演唱会
            if(evt == null)
            {
                mainType = 3;//之前是2，现在3：bug号：78467
            }
            else{
                var thisEle = evt.srcElement || evt.currentTarget;
            	if ($(thisEle).is(".li_player,.li_sz_room,.userbtn") || $(thisEle).parents(".li_player").length > 0 || $(thisEle).parents(".li_sz_room").length > 0) {
                    if (sideStat == "1") {
                        mainType = 3;
                    }
                }
            }
            
        }

        if (defCard == true) {
            card.css({ "left": l, "top": t });
            window.mgc.popmanager.layerControlShow(card, mainType, 2);
        } else {
            //card.hide();
            window.mgc.popmanager.layerControlHide(card, mainType, 2);
        }
        $j(document).click(function(e) {
            e = e || window.event; // 兼容IE7
            var obj = $j(e.srcElement || e.target);
            if ($j(obj).is("#" + con + ",#" + con + " *   ,.card_tips")) {
                card.css({ "left": l, "top": t });
                window.mgc.popmanager.layerControlShow(card, mainType, 2);
            } else {
                //card.hide();
                window.mgc.popmanager.layerControlHide(card, mainType, 2);
                oldClientWidth = 0;
                oldClientLeft = 0;
                $j(document).off("click");
            }
        });
        oldClientWidth = document.body.clientWidth;//记录当前浏览器文档宽度 77 review
        oldClientLeft = l;//记录当前鼠标位置 77 review
    },//抢座名片
    grabChaircardTips: function(evt, con) {
        var posx = 0, posy = 0, l, t, card = $j(".card_tips");
        if (/firefox/.test(navigator.userAgent.toLowerCase())) {
            evt = evt
        } else {
            evt = evt || window.event;
        }
        //var evt = evt || window.event;
        if (evt == undefined) {
            var Y = $j('#GiftSwf').offset().top;
            var X = $j('#GiftSwf').offset().left;
            t = mouseY + Y + 10;
            l = mouseX + X + 20;
        }
        else {
            if (evt.pageX || evt.pageY) {
                posx = evt.pageX;
                posy = evt.pageY;
            } else if (evt.clientX || evt.clientY) {
                posx = evt.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
                posy = evt.clientY + document.documentElement.scrollTop + document.body.scrollTop;
            }
            if (navigator.userAgent.toLocaleLowerCase().indexOf('msie') !== -1) {
                t = posy + 10, l = posx + 20;
            } else {
                t = posy + 10, l = posx + 20;
            }
        }

        //判断是否出边界
        if ((l + 204) > $j(window).width()) {
            l = l - 204;
        }
        var cardHeight = card.height();
        if ((t + cardHeight) > $j(window).height()) {
            t = t - cardHeight;
        }
        
        var sideStat = $(".side-left").attr("side_state");
        var mainType = 1;
        
        
        if (filename != "nest.shtml") {
            if (sideStat == "1") {
                mainType = 3;
            }
            else if(con == 's_con_card')
            {
                mainType = 3;
            }
        }
        else {
        	mainType = 3;
        }

        if (defCard == true) {
            card.css({ "left": l, "top": t });
            window.mgc.popmanager.layerControlShow(card, mainType, 2);
        } else {
            //card.hide();
            window.mgc.popmanager.layerControlHide(card, mainType, 2);
        }
        $j(document).click(function(e) {
            e = e || window.event; // 兼容IE7
            var obj = $j(e.srcElement || e.target);
            if ($j(obj).is("#" + con + ",#" + con + " *   ,.card_tips")) {
                card.css({ "left": l, "top": t });
                window.mgc.popmanager.layerControlShow(card, mainType, 2);
            } else {
                //card.hide();
                window.mgc.popmanager.layerControlHide(card, mainType, 2);
                oldClientWidth = 0;
                oldClientLeft = 0;
                $j(document).off("click");
            }
        });
        oldClientWidth = document.body.clientWidth;//记录当前浏览器文档宽度 77 review
        oldClientLeft = l;//记录当前鼠标位置 77 review
    },
    //抢座名片
    grabChairNullcardTips: function(evt, con) {
        var posx = 0, posy = 0, l, t, card = $j(".card_tips");
        if (/firefox/.test(navigator.userAgent.toLowerCase())) {
            evt = evt
        } else {
            evt = evt || window.event;
        }
        //var evt = evt || window.event;
        if (evt == undefined) {
            var Y = $j('#GiftSwf').offset().top;
            var X = $j('#GiftSwf').offset().left;
            t = mouseY + Y + 10;
            l = mouseX + X + 20;
        }
        else {
            if (evt.pageX || evt.pageY) {
                posx = evt.pageX;
                posy = evt.pageY;
            } else if (evt.clientX || evt.clientY) {
                posx = evt.clientX + document.documentElement.scrollLeft + document.body.scrollLeft;
                posy = evt.clientY + document.documentElement.scrollTop + document.body.scrollTop;
            }
            if (navigator.userAgent.toLocaleLowerCase().indexOf('msie') !== -1) {
                t = posy + 10, l = posx + 20;
            } else {
                t = posy + 10, l = posx + 20;
            }
        }

        //判断是否出边界
        if ((l + 204) > $j(window).width()) {
            l = l - 204;
        }
        var cardHeight = card.height();
        if ((t + cardHeight) > $j(window).height()) {
            t = t - cardHeight;
        }
        
        var sideStat = $(".side-left").attr("side_state");
        var mainType = 1;
        
        if (filename != "nest.shtml") {
            if (sideStat == "1") {
                mainType = 3;
            }
        }
        else {
        	mainType = 3;
        }

        if (defCard == true) {
            card.css({ "left": l, "top": t });
            window.mgc.popmanager.layerControlShow(card, mainType, 2);
        } else {
            //card.hide();
            window.mgc.popmanager.layerControlHide(card, mainType, 2);
        }

        $j(document).click(function(e) {
            e = e || window.event; // 兼容IE7
            var obj = $j(e.srcElement || e.target);
            if ($j(obj).is(".vipPopClass") || $j(obj).is(".sv_0")) {
                card.css({ "left": l, "top": t });
                window.mgc.popmanager.layerControlShow(card, mainType, 2);
            } else {
                //card.hide();
                window.mgc.popmanager.layerControlHide(card, mainType, 2);
                oldClientWidth = 0;
                oldClientLeft = 0;
                $j(document).off("click");
            }
        });
        oldClientWidth = document.body.clientWidth;//记录当前浏览器文档宽度 77 review
        oldClientLeft = l;//记录当前鼠标位置 77 review
    },
    getEvent: function() {//获取事件  此处event为引类型，在传递过程中event改变,赋值变量随即改变，因此此处要复制一个event对象指向不同的地址。 兼容ie(ps:update时请与77说一下)
        if (document.all) {
            return $j.extend(true, {}, window.event);// 如果是ie
        }
        var func = MGC.getEvent.caller;
        while (func != null) {
            var arg0 = func.arguments[0];
            if (arg0) {
                if ((arg0.constructor == Event || arg0.constructor == MouseEvent)
					|| (typeof (arg0) == "object" && arg0.preventDefault && arg0.stopPropagation)) {
                    return $j.extend(true, {}, arg0);
                }
            }
            func = func.caller;
        }
        return null;
    },
    timer: null,
    progressTime: function(id, second) {
    	//传入的秒数应该在十分钟以内
        var progressTime = $j("#" + id);
        var timeArea = progressTime.find("strong");
        var mm = timeArea.find("i").eq(0);
        var ss = timeArea.find("i").eq(1);
        progressTime.show();
        mgc.consts.isRongruTime = true;
        clearInterval(MGC.timer);
        var startTime = new Date().getTime();
        var s = second;
        MGC.timer = setInterval(function() {
        	var nowTime = new Date().getTime();
            var selTime = second - Math.floor((nowTime - startTime)/ 1000);
            if(selTime < s)
            {
            	s = selTime;
            }
        	if (s >= 0) {
                var min = Math.floor(s / 60) % 60;
                var sec = s % 60;
                var t = "";
                if (sec < 10) {
                    t += "0";
                }
                t += sec;
                mm.html(min), ss.html(t);
            } else {
                clearInterval(MGC.timer);
                progressTime.hide();
                mgc.consts.isRongruTime = false;
            }
            s--;
        }, 1000);
    },
    progressTimeOld: function(id, second) {
        var progressTime = $j("#" + id), progressTimeArr = progressTime.find("i"), pFirst = progressTimeArr.eq(0), pSecond = progressTimeArr.eq(1), m = 0, s = 0;
        progressTime.show();
        m = Math.floor(second / 60);//转化分钟
        s = second - (m * 60);//转化秒钟
        pFirst.html(m);
        if (s < 10) { pSecond.html("0" + s); } else { pSecond.html(s); }
        clearInterval(MGC.timer);
        MGC.timer = setInterval(function() {
            if (m >= 0 && s >= 0) {
                if (s > 0) {
                    s--;
                    if (s < 10) { pSecond.html("0" + s); } else { pSecond.html(s); }
                    if (s == 59 && m > 0) {
                        s = 60;
                        m--;
                        if (m > 0) {
                            pFirst.html(m);
                        } else {
                            pFirst.html(0);
                        }
                    }
                } else {
                    s = 59;
                    if (s < 10) { pSecond.html("0" + s); } else { pSecond.html(s); }
                    if (m > 0) {
                        m--;
                        pFirst.html(m);
                    } else {
                        pFirst.html(0);
                        clearInterval(MGC.timer);
                        progressTime.hide();
                    }
                }
            } else {
                clearInterval(MGC.timer);
                progressTime.hide();
            }
        }, 1000);
    },
    intervalMap : {},
    progressTimeMulti: function(id, second) {
        var progressTime = $j("#" + id), progressTimeArr = progressTime.find("i"), pFirst = progressTimeArr.eq(0), pSecond = progressTimeArr.eq(1), m = 0, s = 0;
        progressTime.show();
        m = Math.floor(second / 60);//转化分钟
        s = second - (m * 60);//转化秒钟
        pFirst.html(m);
        if (s < 10) { pSecond.html("0" + s); } else { pSecond.html(s); }
        if(MGC.intervalMap[id])
        {
        	clearInterval(MGC.intervalMap[id]);
        }
        var mInterval = setInterval(function() {
            if (m >= 0 && s >= 0) {
                if (s > 0) {
                    s--;
                    if (s < 10) { pSecond.html("0" + s); } else { pSecond.html(s); }
                    if (s == 59 && m > 0) {
                        s = 60;
                        m--;
                        if (m > 0) {
                            pFirst.html(m);
                        } else {
                            pFirst.html(0);
                        }
                    }
                } else {
                    s = 59;
                    if (s < 10) { pSecond.html("0" + s); } else { pSecond.html(s); }
                    if (m > 0) {
                        m--;
                        pFirst.html(m);
                    } else {
                        pFirst.html(0);
                        clearInterval(mInterval);
                        progressTime.hide();
                    }
                }
            } else {
                clearInterval(mInterval);
                progressTime.hide();
            }
        }, 1000);
        MGC.intervalMap[id]=mInterval;
    },
    timer_grab: null,
    progressGrabTime: function(id, idBtn, idBtnShow, idNext, second) {
        var progressTime = $j("#" + id), idBtn = $j("#" + idBtn), idBtnShow = $j("#" + idBtnShow), idNext = $j("#" + idNext), progressTimeArr = progressTime.find("i"), pFirst = progressTimeArr.eq(0), pSecond = progressTimeArr.eq(1), m = 0, s = 0;
        m = Math.floor(second / 60);//转化分钟
        s = second - (m * 60);//转化秒钟
        pFirst.html(m);
        if (s < 10) { pSecond.html("0" + s); } else { pSecond.html(s); }
        clearInterval(MGC.timer_grab);
        MGC.timer_grab = setInterval(function() {
            if (m >= 0 && s >= 0) {
                if (s > 0) {
                    s--;
                    if (s < 10) { pSecond.html("0" + s); } else { pSecond.html(s); }
                    if (s == 59 && m > 0) {
                        s = 60;
                        m--;
                        if (m > 0) {
                            pFirst.html(m);
                        } else {
                            pFirst.html(0);
                        }
                    }
                } else {
                    s = 59;
                    if (s < 10) { pSecond.html("0" + s); } else { pSecond.html(s); }
                    if (m > 0) {
                        m--;
                        pFirst.html(m);
                    } else {
                        pFirst.html(0);
                        clearInterval(MGC.timer_grab);
                        progressTime.hide();
                        $j(idNext).css('display', 'block');
                        $j(idBtnShow).css('display', 'block');
                        $j(idBtn).css('display', 'none');
                    }
                }
            } else {
                clearInterval(MGC.timer_grab);
                progressTime.hide();

            }
        }, 1000);
    },
    controlCon: function(con, def) {
        var con = $j("." + con);
        if (def == true) {
            //con.show();
            window.mgc.popmanager.layerControlShow(con, 1, 2);
        } else if (def == false) {
            //con.hide();
            window.mgc.popmanager.layerControlHide(con, 1, 2);
        } else {
            //con.hide();
            window.mgc.popmanager.layerControlHide(con, 1, 2);
        }
    },
    boxAnimation: function() {
        var box = $j("#box"), boxTips = $j(".box_tips"), boxList = box.find("li"), boxPrizeList = box.find("span"), boxAuto = true, timer = null;
        box.show();
        boxList.eq(0).animate({ "left": "0px" });
        boxList.eq(2).animate({ "left": "390px" });
        boxPrizeList.each(function(index) {
            $j(this).click(function() {
                if (boxAuto == true) {
                    $j(this).find("img").attr("src", "http://ossweb-img.qq.com/images/mgc/css_img/video_room/prize1.jpg?v=3_8_8_2016_15_4_final_3"); boxAuto = false;
                    boxTips.find("b").html(index + 1);
                }
                boxList.delay(500).animate({ "left": "195px" }, 1000, function() {
                    box.fadeOut();
                    clearTimeout(timer);
                    timer = setTimeout(function() {
                        MGC.popFormsShow("boxGiftContainer");
                    }, 1000);
                });
            });
        });
    },
    mvQuality: function() {
        return null;
        var mvQuality = $j(".mvc_quality"), start = true;
        mvQuality.find("b").click(function() {
            if (start) {
                mvQuality.find("ul").show(); start = false;
            } else {
                mvQuality.find("ul").hide(); start = true;
            }
        });
        mvQuality.find("li").each(function(index) {
            $j(this).click(function() {
                var this_html = $j(this).html();
                mvQuality.find("li").removeClass().eq(index).addClass("current");
                mvQuality.find("b").html(this_html);
                mvQuality.find("ul").hide(); start = true;
            });
        });
        mvQuality.find("ul").mouseleave(function() { mvQuality.find("ul").hide(); start = true; });
    },
    entertainment: function() {
        var url = location.href, start = url.indexOf("#"), end = parseInt(url.substring(start + 1, start + 2));
        MGC.tabCut("show_tab", "show_con", end);
    },
    crosswise: function() {
        /*
        $j(window).resize(function () {
            var _w = $j(window).width();
            if (_w <= 1300) {
                $j(document.body).css({ "overflow-x": "scroll" });
            } else {
                $j(document.body).css({ "overflow-x": "hidden" });
            }
        })
        */
    },
    crosswiseLeft: function() {
        $j(window).resize(function() {
            var _w = $j(window).width();
            if (_w <= 1300) {
                $j('.wrapper').css({ "float": "right" });
            } else {
                $j('.wrapper').css({ "float": "inherit" });
            }
        })
    },/*    页面窗口缩小以后当再次加载任意房间, 仍旧保持左侧先消失，右边再消失，最后中间视频区域，放大倒序展开*/
    onLoadshrinkLeft: function() {
        var _w = $j(window).width();
        if (_w <= 1300) {
            $j('.wrapper').css({ "float": "right" });
        } else {
            $j('.wrapper').css({ "float": "inherit" });
        }
    },
    setScreenHeight: function() {//自适应屏幕分辨率
        var bodyHeight = $j(window).height(), sl_rank = $j(".sl_rank"), sr_con = $j("#sr_con");
        if (bodyHeight < 900) {
            /*left*/
            sl_rank.css({ "height": bodyHeight - 590 });
            sr_con.css({ "height": bodyHeight - 640 });
            /*middle*/
        }
    },
    susTips: function(e, n, val) {
        if ((n == 1 && val == '') || (n == 1 && val == '无')) {
            return false;
        }
        var susTips = $j(".sus_tips"), t = (e.pageY == undefined ? (e.clientY + document.documentElement.scrollTop) : e.pageY) - 15, l = (e.pageX == undefined ? (e.clientX + document.documentElement.scrollLeft) : e.pageX) + 20;
        susTips.css({ "top": t, "left": l });
        if (n == 1) {
            if (val != '') {
                susTips.text(val);
            }

            //susTips.show();
            window.mgc.popmanager.layerControlShow(susTips, 4, 3);
            $j(window).scroll(function(e) {
                window.mgc.popmanager.layerControlHide(susTips, 4, 3);
            });
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, 4, 3);
        }
    },//个人中心-我关注的主播列表tips
    susTips_personal: function(e, n, val) {
        if ((n == 1 && val == '') || (n == 1 && val == '无')) {
            return false;
        }
        var susTips = $j(".sus_tips"), t = (e.pageY == undefined ? e.clientY : e.pageY) - 15, l = (e.pageX == undefined ? e.clientX : e.pageX) + 20;
        susTips.css({ "top": t, "left": l });
        if (n == 1) {
            if (val != '') {
                susTips.text(val);
            }

            //susTips.show();
            window.mgc.popmanager.layerControlShow(susTips, 4, 3);
            $j(window).scroll(function(e) {
                window.mgc.popmanager.layerControlHide(susTips, 4, 3);
            });
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, 4, 3);
        }
    },
    newTips: function(val, el, mainType, subType) {
        if (mainType == undefined) {
            mainType = 1;
        }
        if (subType == undefined) {
            subType = 3;
        }
        var susTips = $j(".sus_tips");
        var pos = {
            y: -15,
            x: 20
        };
        MGC.showTips(val, el, susTips, pos, mainType, subType);
    },//左对齐
    newTipsLeft: function(val, el, mainType, subType) {
        if (mainType == undefined) {
            mainType = 1;
        }
        if (subType == undefined) {
            subType = 3;
        }
        var susTips = $j(".sus_tips");
        susTips.css('text-align', 'left');
        var pos = {
            y: -15,
            x: 20
        };
        MGC.showTips(val, el, susTips, pos, mainType, subType);
    },
    showTips: function(val, el, susTips, pos, mainType, subType) {
        if (val == '' || val == '无') {
            return false;
        }
        el.off('mouseover mouseout').on({
            mouseover: function(e) {
                var t = (e.pageY == undefined ? e.clientY : e.pageY) + pos.y;
                var l = (e.pageX == undefined ? e.clientX : e.pageX) + pos.x;
                susTips.css({
                    "top": t,
                    "left": l
                });
                susTips.html(val);
                window.mgc.popmanager.layerControlShow(susTips, mainType, subType);
            },
            mouseout: function() {
                window.mgc.popmanager.layerControlHide(susTips, mainType, subType);
            }
        });
    },
    zhuboTips: function(tipsName, _el, n, val) {
        var el = $(_el);
        var tips = $j('#' + tipsName);
        tips.text(val);
        var pos = {
            y: 30,
            x: -1200
        };
        MGC.cssFixPosTips(n, val, el, tips, pos, null, 3, 1);
    },
    jiangLiTips: function(_el, n, val) {
        var el = $(_el);
        var tips = $j(".sus_tips");
        var pos = {
            y: -1,
            x: 22
        };
        var cssObj = {
            "padding": "2px 1px"
        };        
        MGC.cssFixPosTips(n, val, el, tips, pos, cssObj, 3, 3);
    },
    lastKingEduTips: function(_el, n, val){
        var el = _el;
        var tips = $j(".sus_tips");
        var pos = {
            y: -1,
            x: 22
        };
        var cssObj = {
            "padding": "2px 1px"
        };        
        MGC.cssFixPosTips(n, val, el, tips, pos, cssObj, 3, 3);
    },
    cssFixPosTips: function(n, val, el, tips, pos, cssObj, mainType, subType) {
        MGC.cssTips(n, val, el, tips, pos, cssObj, mainType, subType);
    },
    cssTips: function(n, val, el, tips, pos, cssObj, mainType, subType) {
        if (!val || val == '' || val == '无') {
            if (n == 1) {
                return false;
            }
        }
        if (mainType == undefined) {
            mainType = 1;
        }
        if (subType == undefined) {
            subType = 3;
        }
        if (n == 1) {
            if (tips.selector == "sus_tips") {
                tips.css({
                    "width": "auto"
                });
            }
            if (pos) {
                var t = el.offset().top + pos.y;
                var l = el.offset().left + pos.x;
                tips.css({
                    "top": t,
                    "left": l
                });
            }
            if (cssObj) {
                tips.css(cssObj);
            }
            tips.html(val);
            //MGC.comm_tips_position(tips);
            window.mgc.popmanager.layerControlShow(tips, mainType, subType);
        } else {
            window.mgc.popmanager.layerControlHide(tips, mainType, subType);
        }
    },

    susTipsHtml: function(e, n, val) {
        if ((n == 1 && val == '') || (n == 1 && val == '无')) {
            return false;
        }
        var susTips = $j(".sus_tips"), t = (e.pageY == undefined ? e.clientY : e.pageY) - 15, l = (e.pageX == undefined ? e.clientX : e.pageX) + 20;
        susTips.css({ "top": t, "left": l });
        var sideStat = $(".side-left").attr("side_state");
        var mainType = 1;
        if(sideStat == "1")
        {
        	mainType = 3;
        }
        if (n == 1) {
            if (val != '') {
                susTips.html(val);
            }

            //  susTips.show();
            window.mgc.popmanager.layerControlShow(susTips, mainType, 3);
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, mainType, 3);
        }
    },
    susTipsHtmlPop: function (e, n, val) {
        if ((n == 1 && val == '') || (n == 1 && val == '无')) {
            return false;
        }
        var susTips = $j(".sus_badge_tips"), t = (e.pageY == undefined ? e.clientY : e.pageY) - 15, l = (e.pageX == undefined ? e.clientX : e.pageX) + 20;
        susTips.css({ "top": t, "left": l ,"text-align":"left"});
        if (n == 1) {
            if (val != '') {
                susTips.html(val);
            }
            window.mgc.popmanager.layerControlShow(susTips, 4, 3);
            $j(window).scroll(function (e) {
                window.mgc.popmanager.layerControlHide(susTips, 4, 3);
            });
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, 4, 3);
        }
    },
    susTipsBadge: function (e, n, val) {
        if ((n == 1 && val == '') || (n == 1 && val == '无')) {
            return false;
        }
        var susTips = $j(".sus_badge_tips"), t = (e.pageY == undefined ? e.clientY : e.pageY) - 20, l = (e.pageX == undefined ? e.clientX : e.pageX) + 33;
        susTips.css({ "top": t, "left": l, "text-align": "left" });
        if (n == 1) {
            if (val != '') {
                susTips.html(val);
            }
            window.mgc.popmanager.layerControlShow(susTips, 4, 3);
            $j(window).scroll(function (e) {
                window.mgc.popmanager.layerControlHide(susTips, 4, 3);
            });
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, 4, 3);
        }
    },
    susTipsEnd: function(e, n, val) {
        if ((n == 1 && val == '') || (n == 1 && val == '无')) {
            return false;
        }
        var susTips = $j(".sus_tips_end"), t = (e.pageY == undefined ? e.clientY : e.pageY) - 10, l = (e.pageX == undefined ? e.clientX : e.pageX) + 20;
        susTips.css({ "top": t, "left": l });
        var sideStat = $(".side-left").attr("side_state");
        var mainType = 1;
        if(sideStat == "1")
        {
        	mainType = 3;
        }
        if (n == 1) {
            if (val != '') {
                susTips.text(val);
            }
            MGC.comm_tips_position(susTips);
            //  susTips.show();
            window.mgc.popmanager.layerControlShow(susTips, mainType, 3);
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, mainType, 3);
        }
    },
    attentionTips: function(e, n, val) {
        if (n == 1 && val == '') {
            return false;
        }
        var susTips = $j(".sus_tips"), t = (e.pageY == undefined ? e.clientY : e.pageY) + 15, l = (e.pageX == undefined ? e.clientX : e.pageX) + 20;
        susTips.css({ "top": t, "left": l });
        if (n == 1) {
            if (val != '') {
                susTips.text(val);
            }
            //  susTips.show();
            window.mgc.popmanager.layerControlShow(susTips, 1, 3);
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, 1, 3);
        }
    },
    suswTips: function(e, n, val) {
        if (n == 1 && val == '') {
            return false;
        }
        var susTips = $j(".susw_tips"), t = (e.pageY == undefined ? e.clientY : e.pageY) - 15, l = (e.pageX == undefined ? e.clientX : e.pageX) + 20;
        susTips.css({ "top": t, "left": l });
        if (n == 1) {
            if (val != '') {
                susTips.text(val);
            }
            //  susTips.show();
            window.mgc.popmanager.layerControlShow(susTips, 1, 3);
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, 1, 3);
        }
    },


    suswTips2: function(e, n, val, tips) {
        if (n == 1 && val == '') {
            return false;
        }
        var _e = e.target == undefined ? e.toElement : e.target;
        var qTop = _e.offsetTop;
        var qLeft = _e.offsetLeft;
        
        var susTips = $j(".susw_tips");
        var t = qTop + 66;
        var l = qLeft + 68;
        var W = 0;
        var indexNum = $j(_e).parent().parent().attr('data');
        var indexImg = Math.floor(l / 381);
        var ll = l;
        l=l%392;
        if (indexImg == 1 && ll > 392) {
            l = l + 12;
        } else if (indexImg > 1 && ll > indexImg * 381) {
            l = l + indexImg * 12;
        }
        if(indexNum > 5)
        {
        	l = qLeft + 65 - Math.floor((indexNum - 1) / 5) * 370;
        }
        if (val == '经验') {
            W = 24;
        } else if (val != undefined && val.indexOf("贵族身份") >= 0) {
            W = 75;
        } else if (val != undefined && val.indexOf("飞屏喇叭") >= 0) {
            W = 160;
        } else {
            W = 180;
        }
        if ((val != '经验' || val.indexOf("贵族身份") == -1 || val.indexOf("飞屏喇叭") == -1) && tips == "") {
            susTips.css({ "top": t, "left": l, "width": "auto","white-space":"nowrap" });
        } else {
            susTips.css({ "top": t, "left": l, "width": W + "px", "white-space": "inherit" });
        }
        if (n == 1) {
            if (val != '') {
                //    susTips.text(val);
                susTips.html(val + '</br>' + tips);
            }
            //  susTips.show();
            window.mgc.popmanager.layerControlShow(susTips, 5, 3);
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, 5, 3);
        }
    }, suswTips3: function(e, n, val, tips) {
        if (n == 1 && val == '') {
            return false;
        }
        var _e = e.target == undefined ? e.toElement : e.target;
        var susTips = $j(".susw_tips"), t = _e.offsetTop + 70, l = _e.offsetLeft + 85, W = 0;
        if ($j(_e.parentElement).attr('data') > 6) {
            l = _e.offsetLeft + 100 - 546;
        } else if ($j(_e.parentElement).attr('data') > 12) {
            l = _e.offsetLeft + 100 - 546;
        }
        if (val == '经验') {
            W = 24;
        } else if (val != undefined && val.indexOf("贵族身份") >= 0) {
            W = 75;
        } else if (val != undefined && val.indexOf("飞屏喇叭") >= 0) {
            W = 160;
        } else {
            W = 180;
        }
        if ((val != '经验' || val.indexOf("贵族身份") == -1 || val.indexOf("飞屏喇叭") == -1) && tips == "") {
            susTips.css({ "top": t, "left": l, "width": "auto", "white-space": "nowrap" });
        } else {
            susTips.css({ "top": t, "left": l, "width": W + "px", "white-space": "inherit" });
        }
        if (n == 1) {
            if (val != '') {
                susTips.html(val + "</br>" + tips);
            }
            //  susTips.show();
            window.mgc.popmanager.layerControlShow(susTips, 4, 3);
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, 4, 3);
        }
    }, suswTips4: function(e, n, val, tips) {
        if (n == 1 && val == '') {
            return false;
        }
        var susTips = $j(".sign_tips"), t = (e.pageY == undefined ? e.clientY : e.pageY) - $j(document).scrollTop() - $j("#pop_sign")[0].offsetTop - 15, l = (e.pageX == undefined ? e.clientX : e.pageX) - $j(document).scrollLeft() - $j("#pop_sign")[0].offsetLeft + 23;
        if ($j("#pop_sign").attr("style").indexOf("absolute") >= 0) {
            t += window.scrollY || window.screenTop;
        }
        if (val == '经验') {
            W = 24;
        } else if (val != undefined && val.indexOf("贵族身份") >= 0) {
            W = 75;
        } else if (val != undefined && val.indexOf("飞屏喇叭") >= 0) {
            W = 160;
        } else {
            W = 180;
        }
        if ((val != '经验' || val.indexOf("贵族身份") == -1 || val.indexOf("飞屏喇叭") == -1) && tips == "") {
            susTips.css({ "top": t, "left": l, "width": "auto", "white-space": "nowrap" });
        } else {
            susTips.css({ "top": t, "left": l, "width": W + "px", "white-space": "inherit" });
        }
        if (n == 1) {
            if (val != '') {
                susTips.html(val + "</br>" + tips);
            }
            window.mgc.popmanager.layerControlShow(susTips, 5, 3);
        } else {
            window.mgc.popmanager.layerControlHide(susTips, 5, 3);
        }
    }, suswTips5: function(e, n, val, tips) {
        if (n == 1 && val == '') {
            return false;
        }
        var _e = e.target == undefined ? e.toElement : e.target;
        var susTips = $j(".susw_tips"), t = _e.offsetTop + 33, l = _e.offsetLeft + 68, W = 0;
        var indexNum = $j(_e.parentElement).attr('data');
        var indexImg = Math.floor(l / 381);
        var ll = l;
        l = l % 392;
        if (indexImg == 1 && ll > 392) {
            l = l + 12;
        } else if (indexImg > 1 && ll > indexImg * 381) {
            l = l + indexImg * 12;
        }
        if(indexNum > 5)
        {
        	l = _e.offsetLeft + 65 - Math.floor((indexNum - 1) / 5) * 370;
        }
        susTips.css({ "top": t, "left": l, "width": 200 + "px" });

        if (n == 1) {
            if (val != '') {
                //    susTips.text(val);
                susTips.html(val + '</br>' + tips);
            }
            //  susTips.show();
            window.mgc.popmanager.layerControlShow(susTips, 5, 3);
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, 5, 3);
        }
    },
    suswTips6: function(e, n, val) {
        if (n == 1 && val == '') {
            return false;
        }
        var susTips = $j(".susw_tips_wealth"), t = 75, l = 97;
        susTips.css({ "top": t, "left": l });
        if (n == 1) {
            if (val != '') {
                susTips.text(val);
            }
            //  susTips.show();
            window.mgc.popmanager.layerControlShow(susTips, 1, 3);
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, 1, 3);
        }
    },
    susStateTipss: function(e, n, val) {
        var _e = e.target == undefined ? e.toElement : e.target;
        var t = $j(_e).offset().top - 26;
        var l = $j(_e).offset().left + 30;
        if (n == 1 && val == '') {
            return false;
        }
        var susTips = $j(".sus_tips_listLi");
        susTips.css({ "top": t, "left": l });
        if (n == 1) {
            if (val != '') {
                susTips.text(val);
            }
            //  susTips.show();
            window.mgc.popmanager.layerControlShow(susTips, 1, 3);
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, 1, 3);
        }

    },
    susStateTips: function(e, n, val, tnum, lnum) {
        var _e = e.target == undefined ? e.toElement : e.target;
        var t = _e.offsetTop + tnum;
        var l = _e.offsetLeft + lnum;
        if ((n == 1 && val == '') || (n == 1 && val == '无')) {
            return false;
        }
        var susTips = $j(".sus_tips_listLi");
        susTips.css({ "top": t, "left": l });
        if (n == 1) {
            if (val != '') {
                susTips.text(val);
            }
            //susTips.show();
            window.mgc.popmanager.layerControlShow(susTips, 1, 3);
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, 1, 3);
        }

    },
    susStateTips2: function(e, n, val, top, left) {
        var _e = e.target == undefined ? e.toElement : e.target;
        top = top ? top : -3;
        left = left ? left : 25;
        var t = _e.offsetTop + top;
        var l = _e.offsetLeft + left;
        if (n == 1 && val == '') {
            return false;
        }
        var susTips = $j(".sus_tips_list2");
        susTips.css({ "top": t, "left": l });
        if (n == 1) {
            if (val != '') {
                susTips.text(val);
            }
            //susTips.show();
            window.mgc.popmanager.layerControlShow(susTips, 1, 3);
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, 1, 3);
        }
    },
    susStateTipsGroup: function(e, n, val, tt, ll) {
        var _e = e.target == undefined ? e.toElement : e.target;
        tt || (tt = 20);
        ll || (ll = 50);
        var t = $j(_e).offset().top + tt;
        var l = $j(_e).offset().left + ll;
        if (n == 1 && val == '') {
            return false;
        }
        var susTips = $j(".sus_tips_list2");
        susTips.css({ "top": t, "left": l });
        if (n == 1) {
            if (val != '') {
                susTips.text(val);
            }
            window.mgc.popmanager.layerControlShow(susTips, 1, 3);
        } else {
            window.mgc.popmanager.layerControlHide(susTips, 1, 3);
        }
    },
    susStateTipsShort: function(e, n, val) {
        var _e = e.target == undefined ? e.toElement : e.target;
        var t = _e.offsetTop - 3;
        var l = _e.offsetLeft + 25;
        if (n == 1 && val == '') {
            return false;
        }
        var susTips = $j(".sus_tips_short");
        susTips.css({ "top": t, "left": l });
        if (n == 1) {
            if (val != '') {
                susTips.text(val);
            }
            //susTips.show();
            window.mgc.popmanager.layerControlShow(susTips, 1, 3);
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, 1, 3);
        }

    },
    susStateTipsRanklist: function(e, n, val) {

        var _e = e.target == undefined ? e.toElement : e.target;
        var lio = _e.srcElement ? _e.srcElement : _e;
        var t = 0;

        if ($j(lio.parentElement.parentElement.parentElement).hasClass("first") || $j(lio.parentElement.parentElement.parentElement).hasClass("second") || $j(lio.parentElement.parentElement.parentElement).hasClass("third")) {

            t = lio.parentElement.parentElement.parentElement.offsetTop + 21;

        } else {

            t = lio.parentElement.parentElement.parentElement.offsetTop + 6;
        }
        var l = _e.offsetLeft + 38;
        if (n == 1 && val == '') {
            return false;
        }
        var susTips = $j(".sus_tips_list");
        susTips.css({ "top": t, "left": l });
        if (n == 1) {
            if (val != '') {
                susTips.text(val);
            }
            //  susTips.show();
            window.mgc.popmanager.layerControlShow(susTips, 1, 3);
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, 1, 3);
        }

    },
    susTipsLvList: function(e, n, val, obj, ll, tt, tem, ii) {
        var _e = e.target == undefined ? e.toElement : e.target;
        var arr = {}, sum = 0;

        if ((n == 1 && val == '') || (n == 1 && val == "|@abc|@abc|@abc|@abc|@abc|@abc") || (n == 1 && val == "|@abc|@abc|@abc|@abc|@abc|@abc;cursor: auto") || (n == 1 && val == "|@abc|@abc|@abc|@abc|@abc;cursor: auto") || (n == 1 && val == "|@abc|@abc|@abc|@abc|@abc;cursor: auto|@abc")) {
            // return false;
        }
        var susTips = $j("." + tem);
        susTips.children().remove();
        if (n == 1) {
            if (val != '') {
                val = $j(obj).attr("name") + "|@abc" + val;
                arr = val.split('|@abc');
                if (arr[5] > 5) {
                    sum = 8 - arr[5]
                    sum2 = 0;
                } else {
                    sum = 5 - arr[5]
                    sum2 = 92;
                }
                var t = _e.offsetTop + tt + sum2;
                var l = _e.offsetLeft + (sum + 1) * 78 + ll;
                susTips.css({ "top": t, "left": l });
                susTips.append("<p>名字：<strong style='color:" + arr[6] + "'>" + arr[0] + "</strong></p><p>等级：LV" + arr[1] + "</p><p>财富等级：" + arr[2] + "</p><p>财富值：" + arr[3] + "</p><p>贵族身份：" + arr[4] + "</p><p>大区：" + arr[7] + "</p>");
            }
            var spanObj = obj.parentNode.childNodes[ii];
            $j(spanObj).css('display', 'block');
            if (arr[7] != '') {
                //susTips.show();
                //     window.mgc.popmanager.layerControlShow(susTips, 1, 3);
            }
            else {
                //   window.mgc.popmanager.layerControlHide(susTips,1,3);
            }
        } else {
            var spanObj = obj.parentNode.childNodes[ii];

            $j(spanObj).css('display', 'none');
            //susTips.hide();
            //    window.mgc.popmanager.layerControlHide(susTips,1,3);
        }

    },
    susTipsLvList_skin: function(e, n,obj,ii) {
            var _e = e.target == undefined ? e.toElement : e.target;
            if (n == 1) {        
                var spanObj = obj.parentNode.childNodes[ii];
                $j(spanObj).css('display', 'block');       
            } else {
                var spanObj = obj.parentNode.childNodes[ii];

                $j(spanObj).css('display', 'none');            
            }

        },
    susStatepositionTips: function(e, n, val) {
        var _e = e.target == undefined ? e.toElement : e.target;
        var t = _e.offsetTop + 35;
        var l = _e.offsetLeft-20;
        if (n == 1 && val == '') {
            return false;
        }
        var susTips = $j(".sus_tips_");
        susTips.css({ "top": t, "left": l });
        if (n == 1) {
            if (val != '') {
                susTips.text(val);
            }
            //susTips.show();
            window.mgc.popmanager.layerControlShow(susTips, 1, 3);
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, 1, 3);
        }

    },
    susHotTips: function(e, n, val) {
        var t = 35;
        var l = 150;
        if (n == 1 && val == '') {
            return false;
        }
        var susTips = $j(".hotTips");
        susTips.css({ "top": t, "left": l });
        if (n == 1) {
            if (val != '') {
                susTips.html(val);
            }
            //  susTips.show();
            window.mgc.popmanager.layerControlShow(susTips, 1, 3);
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, 1, 3);
        }

    },
    susHotTitleTips: function(e, n, val, istype) {
        var t;
        var l;

        if (istype == 1) {
            t = 50;
            l = 35;
        }
        else if (istype == 2) {
            t = 50;
            l = 150;
        }
        else {
            t = 35;
            l = 35;
        }

        if (n == 1 && val == '') {
            return false;
        }
        var susTips = $j(".hot_title_Tips");
        susTips.css({ "top": t, "left": l });
        if (n == 1) {
            if (val != '') {
                susTips.html(val);
            }
            //  susTips.show();
            window.mgc.popmanager.layerControlShow(susTips, 1, 3);
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, 1, 3);
        }
    },
    susSecretOrderTips: function(e, n, val) {
        var t = 35;
        var l = 150;
        if (n == 1 && val == '') {
            return false;
        }
        var susTips = $j(".hover-tips");
        susTips.css({ "top": t, "left": l });
        if (n == 1) {
            if (val != '') {
                susTips.html(val);
            }
            //  susTips.show();
            window.mgc.popmanager.layerControlShow(susTips, 1, 3);
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, 1, 3);
        }

    },
    susStatesTips: function(e, n, val) {

        var _e = e.target == undefined ? e.toElement : e.target;
        var td = _e.srcElement ? _e.srcElement : _e;
        var tr = td.parentElement.parentElement.parentElement.rowIndex;
        var t = _e.offsetTop - 25 + tr * 74;

        var l = _e.offsetLeft + 380;
        if (n == 1 && val == '') {
            return false;
        }
        var susTips = $j(".sus_tips_lists");
        susTips.css({ "top": t, "left": l });
        if (n == 1) {
            if (val != '') {
                susTips.text(val);
            }
            //  susTips.show();
            window.mgc.popmanager.layerControlShow(susTips, 1, 3);
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, 1, 3);
        }

    },//个人中心列表里的守护级别tips
    susPersonalTips: function(e, n, val, top, left) {
        if (val == '无') {
            return false;
        }
        var _e = e.target == undefined ? e.toElement : e.target;
        var td = _e.srcElement ? _e.srcElement : _e;
        var tr = td.parentElement.parentElement.rowIndex + 1;
        var t = _e.offsetTop + top + tr * 43;

        var l = _e.offsetLeft + left;
        if (n == 1 && val == '') {
            return false;
        }
        var susTips = $j(".sus_tips_lists");
        susTips.css({ "top": t, "left": l });
        if (n == 1) {
            if (val != '') {
                susTips.text(val);
            }
            //  susTips.show();
            window.mgc.popmanager.layerControlShow(susTips, 1, 3);
        } else {
            //susTips.hide();
            window.mgc.popmanager.layerControlHide(susTips, 1, 3);
        }

    },
    popLoading: function(num) {
        if (num == true) {
            var _html = '<div class="pop_loading" style="display: block"><span></span><img src="http://ossweb-img.qq.com/images/mgc/css_img/common/loading.gif?v=3_8_8_2016_15_4_final_3"></div>', scrHeight = $j("body").height();
            $j("body").append(_html);
        } else {
            $j(".pop_loading").remove();
        }
    },
    flipOver: function(id) {
        var rlCon = $j(id + " .task_list"), pageFlip = 0, rlPre = $j(id + " .task_pre"), rlNext = $j(id + " .task_next");
        if (rlCon.find("li").length <= 5) {
            rlPre.hide();
            rlNext.hide();
        } else {
            rlPre.show().removeClass().addClass("task_pre task_pre_un");
            rlNext.show().removeClass().addClass("task_next");
        }

        rlCon.find("ul").css({ "left": 0 });
        //====horizon====//
        rlPre.unbind('click').bind('click', function() {
            var thisClass = rlPre.attr("class");
            if (thisClass == "task_pre") {
                var rList = rlCon.find("li"), len = rList.length;
                if (len >= 5) {
                    pageFlip--;
                    if (pageFlip == 0) {
                        rlPre.removeClass().addClass("task_pre task_pre_un");
                    }
                    if (pageFlip >= 0) {
                        rlCon.find("ul").animate({ "left": -370 * pageFlip });
                        rlNext.removeClass().addClass("task_next");
                    } else {
                        pageFlip = 0;
                    }
                }
            }
        });
        rlNext.unbind('click').bind('click', function() {
            var thisClass = rlNext.attr("class");
            if (thisClass == "task_next") {
                var rList = rlCon.find("li"), len = rList.length, total = Math.ceil(len / 5);
                if (len >= 5) {
                    pageFlip++;
                    if (pageFlip < total) {
                        rlCon.find("ul").animate({ "left": -370 * pageFlip });
                        rlPre.removeClass().addClass("task_pre");
                    } if (pageFlip == total - 1) {
                        rlNext.removeClass().addClass("task_next task_next_un");
                    }
                } else {
                    pageFlip = 1;
                }
            }
        });
    },
    flipOver1: function(id) {
        var rlCon = $$(id + " .task_list"), page = 0, rlPre = $$(id + " .task_pre"), rlNext = $$(id + " .task_next");
        if (rlCon.find("li").length <= 5) {
            rlPre.removeClass().addClass("task_pre task_pre_un");
            rlNext.removeClass().addClass("task_next task_next_un");
        } else {
            rlPre.removeClass().addClass("task_pre task_pre_un");
            rlNext.removeClass().addClass("task_next");
        }
        rlCon.find("ul").css({ "left": 0 });
        rlPre.unbind('click').bind('click', function() {
            var thisClass = rlPre.attr("class");
            if (thisClass == "task_pre") {
                var rList = rlCon.find("li"), len = rList.length;
                if (len >= 5) {
                    page--;
                    if (page == 0) {
                        rlPre.removeClass().addClass("task_pre task_pre_un");
                    }
                    if (page >= 0) {
                        rlCon.find("ul").animate({ "left": -546 * page });
                        rlNext.removeClass().addClass("task_next");
                    } else {
                        page = 0;
                    }
                }
            }
        });
        rlNext.unbind('click').bind('click', function() {
            var thisClass = rlNext.attr("class");
            if (thisClass == "task_next") {
                var rList = rlCon.find("li"), len = rList.length, total = Math.ceil(len / 5);
                if (len >= 5) {
                    page++;
                    if (page < total) {
                        rlCon.find("ul").animate({ "left": -546 * page });
                        rlPre.removeClass().addClass("task_pre");
                    } if (page == total - 1) {
                        rlNext.removeClass().addClass("task_next task_next_un");
                    } else {
                        page = 1;
                    }
                }
            }
        });
    },
    flashChecker: function() {
        var hasFlash = 0;//是否安装了flash
        var flashVersion = 0;//flash版本
        if (document.all) {
            var swf = new ActiveXObject('ShockwaveFlash.ShockwaveFlash');
            if (swf) {
                hasFlash = 1;
                VSwf = swf.GetVariable("$version");
                flashVersion = parseInt(VSwf.split(" ")[1].split(",")[0]);
            }
        } else {
            if (navigator.plugins && navigator.plugins.length > 0) {
                var swf = navigator.plugins["Shockwave Flash"];
                if (swf) {
                    hasFlash = 1;
                    var words = swf.description.split(" ");
                    for (var i = 0; i < words.length; ++i) {
                        if (isNaN(parseInt(words[i]))) continue;
                        flashVersion = parseInt(words[i]);
                    }
                }
            }
        }
        return { f: hasFlash, v: flashVersion };
    },
    //isAnimate 是否开启平滑滚动
    chatMessageTimer: null,
    chatMessage: function() {
        //初始化滚动条
        if (!mgc.consts.API.scroll.chat)
            mgc.consts.API.scroll.chat = $j('.sc_con').data('jsp');
        //重绘滚动条
        if ($j('.sc_con').find(".jspVerticalBar").length == 0)
            mgc.consts.API.scroll.chat.initScroll();
        //滚动条置底
        mgc.consts.API.scroll.chat.scrollBy(0, Number.POSITIVE_INFINITY);
    },
    precinctSlide: function(page, id) {
        var index = 1;
        $j(".pop_next").click(function() {
            if (index < page) {
                $j(".pop_precinct_con").animate({ "left": -index * 480 });
                index++;
                $j('#' + id).text(index + '/' + page);
            }
        });
        $j(".pop_pre").click(function() {
            if (index > 1) {
                index--;
                $j('#' + id).text(index + '/' + page);
                $j(".pop_precinct_con").animate({ "left": -(index - 1) * 480 });
            }
        });
    },
    fansRankList: function() {
        /*var fansHtml='<li><b class="sr_first">1</b><div class="sc_zone_info"><p class="sz_room">萌萌兽 [华东一区]</p><p class="sz_fans">8182345</p><p class="sz_icon"><i class="s_icon_a"></i><i class="s_icon_b"></i></p></div></li><li><b class="sr_first">1</b><div class="sc_zone_info"><p class="sz_room">萌萌兽 [华东一区]</p><p class="sz_fans">8182345</p><p class="sz_icon"><i class="s_icon_a"></i><i class="s_icon_b"></i></p></div></li><li><b class="sr_first">1</b><div class="sc_zone_info"><p class="sz_room">萌萌兽 [华东一区]</p><p class="sz_fans">8182345</p><p class="sz_icon"><i class="s_icon_a"></i><i class="s_icon_b"></i></p></div></li><li><b class="sr_first">1</b><div class="sc_zone_info"><p class="sz_room">萌萌兽 [华东一区]</p><p class="sz_fans">8182345</p><p class="sz_icon"><i class="s_icon_a"></i><i class="s_icon_b"></i></p></div></li><li><b class="sr_first">1</b><div class="sc_zone_info"><p class="sz_room">萌萌兽 [华东一区]</p><p class="sz_fans">8182345</p><p class="sz_icon"><i class="s_icon_a"></i><i class="s_icon_b"></i></p></div></li><li><b class="sr_first">1</b><div class="sc_zone_info"><p class="sz_room">萌萌兽 [华东一区]</p><p class="sz_fans">8182345</p><p class="sz_icon"><i class="s_icon_a"></i><i class="s_icon_b"></i></p></div></li><li><b class="sr_first">1</b><div class="sc_zone_info"><p class="sz_room">萌萌兽 [华东一区]</p><p class="sz_fans">8182345</p><p class="sz_icon"><i class="s_icon_a"></i><i class="s_icon_b"></i></p></div></li><li><b class="sr_first">1</b><div class="sc_zone_info"><p class="sz_room">萌萌兽 [华东一区]</p><p class="sz_fans">8182345</p><p class="sz_icon"><i class="s_icon_a"></i><i class="s_icon_b"></i></p></div></li><li><b class="sr_first">1</b><div class="sc_zone_info"><p class="sz_room">萌萌兽 [华东一区]</p><p class="sz_fans">8182345</p><p class="sz_icon"><i class="s_icon_a"></i><i class="s_icon_b"></i></p></div></li><li><b class="sr_first">1</b><div class="sc_zone_info"><p class="sz_room">萌萌兽 [华东一区]</p><p class="sz_fans">8182345</p><p class="sz_icon"><i class="s_icon_a"></i><i class="s_icon_b"></i></p></div></li><li><b class="sr_first">1</b><div class="sc_zone_info"><p class="sz_room">萌萌兽 [华东一区]</p><p class="sz_fans">8182345</p><p class="sz_icon"><i class="s_icon_a"></i><i class="s_icon_b"></i></p></div></li>',
			guardHtml='<li><b class="sr_second">2</b><div class="sc_zone_info"><p class="sz_room">萌萌兽 [华东一区]</p><p class="sz_fans">8182345</p><p class="sz_icon"><i class="s_icon_a"></i><i class="s_icon_b"></i></p></div></li><li><b class="sr_second">2</b><div class="sc_zone_info"><p class="sz_room">萌萌兽 [华东一区]</p><p class="sz_fans">8182345</p><p class="sz_icon"><i class="s_icon_a"></i><i class="s_icon_b"></i></p></div></li><li><b class="sr_second">2</b><div class="sc_zone_info"><p class="sz_room">萌萌兽 [华东一区]</p><p class="sz_fans">8182345</p><p class="sz_icon"><i class="s_icon_a"></i><i class="s_icon_b"></i></p></div></li><li><b class="sr_second">2</b><div class="sc_zone_info"><p class="sz_room">萌萌兽 [华东一区]</p><p class="sz_fans">8182345</p><p class="sz_icon"><i class="s_icon_a"></i><i class="s_icon_b"></i></p></div></li><li><b class="sr_second">2</b><div class="sc_zone_info"><p class="sz_room">萌萌兽 [华东一区]</p><p class="sz_fans">8182345</p><p class="sz_icon"><i class="s_icon_a"></i><i class="s_icon_b"></i></p></div></li><li><b class="sr_second">2</b><div class="sc_zone_info"><p class="sz_room">萌萌兽 [华东一区]</p><p class="sz_fans">8182345</p><p class="sz_icon"><i class="s_icon_a"></i><i class="s_icon_b"></i></p></div></li><li><b class="sr_second">2</b><div class="sc_zone_info"><p class="sz_room">萌萌兽 [华东一区]</p><p class="sz_fans">8182345</p><p class="sz_icon"><i class="s_icon_a"></i><i class="s_icon_b"></i></p></div></li><li><b class="sr_second">2</b><div class="sc_zone_info"><p class="sz_room">萌萌兽 [华东一区]</p><p class="sz_fans">8182345</p><p class="sz_icon"><i class="s_icon_a"></i><i class="s_icon_b"></i></p></div></li><li><b class="sr_second">2</b><div class="sc_zone_info"><p class="sz_room">萌萌兽 [华东一区]</p><p class="sz_fans">8182345</p><p class="sz_icon"><i class="s_icon_a"></i><i class="s_icon_b"></i></p></div></li><li><b class="sr_second">2</b><div class="sc_zone_info"><p class="sz_room">萌萌兽 [华东一区]</p><p class="sz_fans">8182345</p><p class="sz_icon"><i class="s_icon_a"></i><i class="s_icon_b"></i></p></div></li><li><b class="sr_second">2</b><div class="sc_zone_info"><p class="sz_room">萌萌兽 [华东一区]</p><p class="sz_fans">8182345</p><p class="sz_icon"><i class="s_icon_a"></i><i class="s_icon_b"></i></p></div></li>';*/
        $j("#fansContainer").append(fansHtml);
        $j("#sr_tab li a").each(function(index) {
            $j(this).click(function() {
                $j("#sr_tab li a").removeClass(); $j(this).addClass("current");
                switch (index) {
                    case 0: $j("#fansContainer").html(fansHtml); MGC.scrollPosition("sr_con", 1); break;
                    case 1: $j("#fansContainer").html(guardHtml); MGC.scrollPosition("sr_con", 0); break;
                }
            });
        });
    },
    resetTipsLocation: function() {
        $j(".card_tips").css({ "left": oldClientLeft + (document.body.clientWidth - oldClientWidth) / 2 });
    },
    /*
    *淡入淡出图片切换
    */
    func_focus: function(arr) {
        var focus_id = 1;
        var focus_time = 0;
        var focus_bg = "";
        var focus_begin = true;
        var focus_interval;
        var focus_count;
        var focus_url = "";
        var focus_title = "";
        var focus_img_arr = [];
        function func_focus(arr) {
            if (arr)
                focus_img_arr = arr;
            focus_count = focus_img_arr.length;
            if (focus_id > focus_count) focus_id = 1;
            if (!focus_begin) clearInterval(focus_interval);
            focus_interval = setInterval("focus_show(" + focus_id + ")", 50);
        }
        function focus_show(id) {
            if (focus_time < 20 && focus_bg != "") {
                var v = 100 / 20;
                if (navigator.appName == "Microsoft Internet Explorer") {
                    document.getElementById("focus_show").style.filter = "Alpha(Opacity=" + (v * focus_time) + ")";
                } else {
                    document.getElementById("focus_show").style.opacity = v * focus_time / 100;
                }
                focus_time++;
            } else if (focus_count > 0) {
                if (!focus_begin) {
                    document.getElementById("focus_bg").innerHTML = "<img src='" + focus_bg + "' />";
                    focus_time = 0;
                    clearInterval(focus_interval);
                }
                if (navigator.appName == "Microsoft Internet Explorer") {
                    document.getElementById("focus_show").style.filter = "Alpha(Opacity=0)";
                } else {
                    document.getElementById("focus_show").style.opacity = 0;
                }
                document.getElementById("focus_show").innerHTML = "<a href='" + focus_url + "' target='_blank' title='" + focus_title + "'><img src='" + focus_img_arr[focus_id] + "' /></a>";
                if (focus_count > 1) focus_id++;
                if (!focus_begin) focus_interval = setInterval("func_focus()", 3000); else focus_begin = false;
                focus_bg = focus_img_arr[focus_id];
            }
        }
    },
    g_oTimerAutoPlay: null,
    g_iNowIndex: 0,
    FuncAutoPlay: function(id) {
        var oDiv = null;
        var oUlContent = null;
        var aLiImg = null;
        var g_aTimerImg = [];
        var g_iNowImg = 0;
        var g_iZIndexBase = 2;
        function onload() {
            var i = 0;
            //获取各类元素
            oUlContent = id;
            aLiImg = oUlContent.find('li');
            startAutoPlay();
        }
        onload();
        function gotoImg() {
            if (MGC.g_iNowIndex == g_iNowImg) {
                return;
            }
            $j(aLiImg[MGC.g_iNowIndex]).css({ "height": "0px", "display": "block", "z-index": g_iZIndexBase++ });

            if (g_aTimerImg[MGC.g_iNowIndex]) {
                clearInterval(g_aTimerImg[MGC.g_iNowIndex]);
            }
            //解决闭包调用
            g_aTimerImg[MGC.g_iNowIndex] = setInterval(slideDown, 30);
            g_iNowImg = MGC.g_iNowIndex;
        }
        function slideDown() {
            var h = $j(aLiImg[MGC.g_iNowIndex]).height() + 10;

            if (h >= oUlContent.height()) {
                h = oUlContent.height();

                clearInterval(g_aTimerImg[MGC.g_iNowIndex]);
                g_aTimerImg[MGC.g_iNowIndex] = null;
            }
            $j(aLiImg[MGC.g_iNowIndex]).css("height", h + "px");
        }
        function startAutoPlay() {
            if (MGC.g_oTimerAutoPlay) {
                clearInterval(MGC.g_oTimerAutoPlay);
            }

            MGC.g_oTimerAutoPlay = setInterval(gotoNext, 5000);
        }
        function gotoNext() {
            MGC.g_iNowIndex = (g_iNowImg + 1) % aLiImg.length;
            gotoImg();
        }
        function stopAutoPlay() {
            if (MGC.g_oTimerAutoPlay) {
                clearInterval(MGC.g_oTimerAutoPlay);
                MGC.g_oTimerAutoPlay = null;
            }
        }
    }
};



//热门推荐
var HotRoom = {

    index:0,

    total:0,

    roomWidth:168,

    roomGap:7,

    num:5,

    listWidth:800,

    isMove:false,

    bigPages: 0,

    //获取热门推荐
    getHotRoom: function() {
        //用于记录当前热门推荐模块是模块1或是2
        var roomHotModuleType = 1;//默认1：推荐模块1,2：推荐模块2
        if(mgc.tools.cookie("roomHotModule")==1){
            mgc.tools.cookie("roomHotModule",2);
            roomHotModuleType = 2;
        }else{
            mgc.tools.cookie("roomHotModule",1);
            roomHotModuleType = 1;
        }
        var _reqStr = "{\"op_type\":" + OpType.HotRecommRoomOpType + ", \"type\":0, \"zoneid\":0, \"category\":0, \"beginIndex\":0, \"requestNum\":8,\"position\":1,\"module_type\":"+roomHotModuleType+",\"source\":1}";
        console.log('推荐房间_reqStr：' + _reqStr);
        MGC_Comm.sendMsg(_reqStr, "HotRoom.getHotRoomCallBack");
    },

    //热门推荐回调
    getHotRoomCallBack: function(responseStr) {
        console.log("热门推荐_repStr:" + JSON.stringify(responseStr));
        var _repStr = MGC_Comm.strToJson(responseStr);
        if (_repStr.ret == 0) {
            var HotRecommRoomList = _repStr.rooms;
            var module = mgc.tools.cookie("roomHotModule");//判断是模块1还是模块2
            for(var i=0, n=HotRecommRoomList.length; i<n; i++){
                if(HotRecommRoomList[i].module_type == -1){
                    HotRecommRoomList[i].module_type = module;
                }
                HotRecommRoomList[i].page_capacity = 30;
                HotRecommRoomList[i].room_list_pos = 30 * HotRoom.bigPages + i;
                HotRecommRoomList[i].sub_level = (HotRecommRoomList[i].week_star_sub_level + "").split("");
            }
            HotRoom.bigPages ++;
            $m.each(HotRecommRoomList, function(k, v) {
                v.anchor_level_temp = Math.floor(v.anchor_level / 10) + 1;
                if (v.anchor_level == 0) {
                    v.anchor_level_temp = 0;
                }
                if(MgcAPI.SNSBrowser.IsQQGameLiveArea() == "true"){
                    if (v.isNest) {
                        if (v.room_skin_id && v.room_skin_id != 0 && v.room_skin_level > 0) {
                            v.url = mgc.consts.url.NEST_ROOM + "?roomId=" + v.roomID + "&source=0&tag_id=-1&skin_id=" + v.room_skin_id + "&skin_level=" + v.room_skin_level + "&param=" + MgcAPI.SNSBrowser.IsQQGameLiveArea() + "&module_type=" + v.module_type + "&page_capacity=" + v.page_capacity + "&room_list_pos=" + v.room_list_pos;
                        } else {
                            v.url = mgc.consts.url.CAVEOLAE_ROOM + "?roomId=" + v.roomID + "&source=0&tag_id=-1&skin_id=" + v.room_skin_id + "&skin_level=" + v.room_skin_level + "&param=" + MgcAPI.SNSBrowser.IsQQGameLiveArea() + "&module_type=" + v.module_type + "&page_capacity=" + v.page_capacity + "&room_list_pos=" + v.room_list_pos;
                        }
                        if (v.is_anchor_pk_room) {
                            v.url += "&is_pk=" + v.is_anchor_pk_room;
                        }
                    } else if (v.bSuperRoom) {
                        v.url = mgc.consts.url.SHOW_ROOM + "?roomId=" + v.roomID + "&source=0&tag_id=-1&param=" + MgcAPI.SNSBrowser.IsQQGameLiveArea() + "&module_type=" + v.module_type + "&page_capacity=" + v.page_capacity + "&room_list_pos=" + v.room_list_pos;
                    } else {
                        v.url = mgc.consts.url.LIVE_ROOM + "?roomId=" + v.roomID + "&source=0&tag_id=-1&param=" + MgcAPI.SNSBrowser.IsQQGameLiveArea() + "&module_type=" + v.module_type + "&page_capacity=" + v.page_capacity + "&room_list_pos=" + v.room_list_pos;
                    }
                } else{
                    if (v.isNest) {
                        if (v.room_skin_id && v.room_skin_id != 0 && v.room_skin_level > 0) {
                            v.url = mgc.consts.url.NEST_ROOM + "?roomId=" + v.roomID + "&source=0&tag_id=-1&skin_id=" + v.room_skin_id + "&skin_level=" + v.room_skin_level + "&module_type=" + v.module_type + "&page_capacity=" + v.page_capacity + "&room_list_pos=" + v.room_list_pos;
                        } else {
                            v.url = mgc.consts.url.CAVEOLAE_ROOM + "?roomId=" + v.roomID + "&source=0&tag_id=-1&skin_id=" + v.room_skin_id + "&skin_level=" + v.room_skin_level + "&module_type=" + v.module_type + "&page_capacity=" + v.page_capacity + "&room_list_pos=" + v.room_list_pos;
                        }
                        if (v.is_anchor_pk_room) {
                            v.url += "&is_pk=" + v.is_anchor_pk_room;
                        }
                    } else if (v.bSuperRoom) {
                        v.url = mgc.consts.url.SHOW_ROOM + "?roomId=" + v.roomID + "&source=0&tag_id=-1&module_type=" + v.module_type + "&page_capacity=" + v.page_capacity + "&room_list_pos=" + v.room_list_pos;
                    } else {
                        v.url = mgc.consts.url.LIVE_ROOM + "?roomId=" + v.roomID + "&source=0&tag_id=-1&module_type=" + v.module_type + "&page_capacity=" + v.page_capacity + "&room_list_pos=" + v.room_list_pos;
                    }
                }
                v.playerCount = mgc.tools.roomListNumFormat(v.playerCount);
            });
            var HotRecommRoomCon = $m('#RoomListTmpl');
            var HotRecommRoomTmpl;
            var HotRecommRoomContainer = $m('#HotRecommRoomContainer');
            HotRecommRoomContainer.children().remove();
            HotRecommRoomTmpl = HotRecommRoomCon.tmpl(HotRecommRoomList)
            HotRecommRoomTmpl.appendTo(HotRecommRoomContainer);
            HotRecommRoomContainer.css("left", 0);
            HotRecommRoomContainer.find("li").off("mouseover,mouseout").on("mouseover", function(){
                $m(this).css("border-color", "#6a41c6").find(".room-cover").show();
            }).on("mouseout", function(){
                $m(this).css("border-color", "#f5f5f5").find(".room-cover").hide();
            });
            var imgs = $("#HotRecommRoomContainer .room-img img");
            for(var i=0,n=imgs.length; i<n; i++){
                var img = new Image();
                img.src = imgs[i].src;
                img._img = imgs[i];
                if(img.complete){
                    mgc.tools.adjustPics(img);
                } else{
                    img.onload = function(e){
                        mgc.tools.adjustPics(e==undefined?this: e.target);
                    }
                }
            }
            HotRoom.init();
            HotRecommRoomTmpl = null;
            HotRecommRoomCon = null;
        } else {
            alert('很抱歉，拉取热门推荐失败，请重试');
        }
    },

    init:function(){
        this.index = 0;
        this.total = $m('#HotRecommRoomContainer').find("li").size();
        this.resize();

        $m(".side-hot .rl_pre").off().click(this,this.pre);
        $m(".side-hot .rl_next").off().click(this,this.next);
    },

    pre:function(e){
        var _this = e.data;

        var n = (_this.index - _this.num)<0?_this.index:_this.num;
        _this.move(-n);
    },

    next:function(e){
        var _this = e.data;

        var n = (_this.total - _this.index)>_this.num?_this.num:0;
        _this.move(n);
    },

    //向左或向右移动n个位置
    move:function(n){

        if(this.isMove)return;

        this.isMove = true;

        this.index += n;
        this.refresh();

        var $HotRecommRoomContainer = $m(".side-hot").find("ul");
        var left = $HotRecommRoomContainer.position().left;
        $HotRecommRoomContainer.animate({ "left": left -  n*(this.roomWidth + this.roomGap)},function(){
            HotRoom.isMove = false;
        });
    },

    refresh:function(){
        var $rl_pre = $m(".side-hot").find(".rl_pre");
        if(this.index > 0)
        {
            $rl_pre.removeClass().addClass("rl_pre");
        }
        else
        {
            $rl_pre.removeClass().addClass("rl_pre rl_pre_un");
        }

        var $rl_next = $m(".side-hot").find(".rl_next");
        if((this.total - this.index) > this.num)
        {
            $rl_next.removeClass().addClass("rl_next");
        }
        else
        {
            $rl_next.removeClass().addClass("rl_next rl_next_un");
        }
    },

    //热门推荐自适应宽度
    resize:function(){
        var left = 40;
        var right = 40;

        var width = $m(".side-hot").width();

        //计算能放几个房间
        HotRoom.num = parseInt((width - left - right)/(HotRoom.roomWidth + HotRoom.roomGap));
        HotRoom.num = HotRoom.num > HotRoom.total ? HotRoom.total : HotRoom.num;

        var $rl_con = $m(".side-hot .rl_con");
        //列表宽度
        HotRoom.listWidth = HotRoom.num*(HotRoom.roomWidth + HotRoom.roomGap);
        $rl_con.width(HotRoom.listWidth);
        //列表位置
        var listLeft = (width - HotRoom.listWidth - left - right)/2 + left;
        $rl_con.css("left",listLeft);

        HotRoom.refresh();

        //白线宽度
        $m(".side-hot .line").width(width - $m(".side-hot .recommend_title").width() - $m(".side-hot .recommend_more").width());
    }
}
//热门推荐(小)
var SmallHotRoom = {

    index:0,

    total:0,

    roomWidth:109,

    roomGap:4,

    num:3,

    listWidth:800,

    isMove:false,

    bigPages: 0,

    //获取热门推荐
    getHotRoom: function() {
        var _reqStr = { "op_type": 0, "type": 0, "category": 12, "beginIndex": 0, "requestNum": 5, "tag": 0, "position": 0 ,"module_type":1, "source":1};
        MGC_Comm.sendMsg(_reqStr, "SmallHotRoom.getHotRoomCallBack");
    },

    //热门推荐回调
    getHotRoomCallBack: function(responseStr) {
        console.log("未直播房间热门推荐_repStr:" + responseStr);
        if(MGCData.roomStatus != 2){
            var _repStr = MGC_Comm.strToJson(responseStr);
            if (_repStr.ret == 0) {
                var HotRecommRoomList = _repStr.rooms;
                var module = mgc.tools.cookie("roomHotModule");//判断是模块1还是模块2
                for(var i=0, n=HotRecommRoomList.length; i<n; i++){
                    if(HotRecommRoomList[i].module_type == -1){
                        HotRecommRoomList[i].module_type = module;
                    }
                    HotRecommRoomList[i].page_capacity = 30;
                    HotRecommRoomList[i].room_list_pos = 30 * SmallHotRoom.bigPages + i;
                    HotRecommRoomList[i].sub_level = (HotRecommRoomList[i].week_star_sub_level + "").split("");
                }
                SmallHotRoom.bigPages ++;
                $m.each(HotRecommRoomList, function(k, v) {
                    v.anchor_level_temp = Math.floor(v.anchor_level / 10) + 1;
                    if (v.anchor_level == 0) {
                        v.anchor_level_temp = 0;
                    }
                    if(MgcAPI.SNSBrowser.IsQQGameLiveArea() == "true"){
                        if (v.isNest) {
                            if (v.room_skin_id && v.room_skin_id != 0 && v.room_skin_level > 0) {
                                v.url = mgc.consts.url.NEST_ROOM + "?roomId=" + v.roomID + "&source=0&tag_id=-1&skin_id=" + v.room_skin_id + "&skin_level=" + v.room_skin_level + "&param=" + MgcAPI.SNSBrowser.IsQQGameLiveArea() + "&module_type=" + v.module_type + "&page_capacity=" + v.page_capacity + "&room_list_pos=" + v.room_list_pos;
                            } else {
                                v.url = mgc.consts.url.CAVEOLAE_ROOM + "?roomId=" + v.roomID + "&source=0&tag_id=-1&skin_id=" + v.room_skin_id + "&skin_level=" + v.room_skin_level + "&param=" + MgcAPI.SNSBrowser.IsQQGameLiveArea() + "&module_type=" + v.module_type + "&page_capacity=" + v.page_capacity + "&room_list_pos=" + v.room_list_pos;
                            }
                        } else if (v.bSuperRoom) {
                            v.url = mgc.consts.url.SHOW_ROOM + "?roomId=" + v.roomID + "&source=0&tag_id=-1&param=" + MgcAPI.SNSBrowser.IsQQGameLiveArea() + "&module_type=" + v.module_type + "&page_capacity=" + v.page_capacity + "&room_list_pos=" + v.room_list_pos;
                        } else {
                            v.url = mgc.consts.url.LIVE_ROOM + "?roomId=" + v.roomID + "&source=0&tag_id=-1&param=" + MgcAPI.SNSBrowser.IsQQGameLiveArea() + "&module_type=" + v.module_type + "&page_capacity=" + v.page_capacity + "&room_list_pos=" + v.room_list_pos;
                        }
                        if (v.is_anchor_pk_room) {
                            v.url += "&is_pk=" + v.is_anchor_pk_room;
                        }
                    } else{
                        if (v.isNest) {
                            if (v.room_skin_id && v.room_skin_id != 0 && v.room_skin_level > 0) {
                                v.url = mgc.consts.url.NEST_ROOM + "?roomId=" + v.roomID + "&source=0&tag_id=-1&skin_id=" + v.room_skin_id + "&skin_level=" + v.room_skin_level + "&module_type=" + v.module_type + "&page_capacity=" + v.page_capacity + "&room_list_pos=" + v.room_list_pos;
                            } else {
                                v.url = mgc.consts.url.CAVEOLAE_ROOM + "?roomId=" + v.roomID + "&source=0&tag_id=-1&skin_id=" + v.room_skin_id + "&skin_level=" + v.room_skin_level + "&module_type=" + v.module_type + "&page_capacity=" + v.page_capacity + "&room_list_pos=" + v.room_list_pos;
                            }
                            if (v.is_anchor_pk_room) {
                                v.url += "&is_pk=" + v.is_anchor_pk_room;
                            }
                        } else if (v.bSuperRoom) {
                            v.url = mgc.consts.url.SHOW_ROOM + "?roomId=" + v.roomID + "&source=0&tag_id=-1&module_type=" + v.module_type + "&page_capacity=" + v.page_capacity + "&room_list_pos=" + v.room_list_pos;
                        } else {
                            v.url = mgc.consts.url.LIVE_ROOM + "?roomId=" + v.roomID + "&source=0&tag_id=-1&module_type=" + v.module_type + "&page_capacity=" + v.page_capacity + "&room_list_pos=" + v.room_list_pos;
                        }
                    }
                    v.playerCount = mgc.tools.roomListNumFormat(v.playerCount);
                });
                var HotRecommRoomCon = $m('#RoomListTmpl');
                var HotRecommRoomTmpl;
                var HotRecommRoomContainer = $m('#videoHotRecommRoomContainer');
                HotRecommRoomContainer.children().remove();
                HotRecommRoomTmpl = HotRecommRoomCon.tmpl(HotRecommRoomList);
                HotRecommRoomTmpl.appendTo(HotRecommRoomContainer);
                HotRecommRoomContainer.css("left", 0);
                $m(".layer-video .recommend_list").show();
                HotRecommRoomContainer.find("li").off("mouseover,mouseout").on("mouseover", function(){
                    $m(this).css("border-color", "#6a41c6").find(".room-cover").show();
                }).on("mouseout", function(){
                    $m(this).css("border-color", "#f5f5f5").find(".room-cover").hide();
                });
                var imgs = $("#videoHotRecommRoomContainer .room-img img");
                for(var i=0,n=imgs.length; i<n; i++){
                    var img = new Image();
                    img.src = imgs[i].src;
                    img._img = imgs[i];
                    if(img.complete){
                        mgc.tools.adjustPics(img);
                    } else{
                        img.onload = function(e){
                            mgc.tools.adjustPics(e==undefined?this: e.target);
                        }
                    }
                }
                SmallHotRoom.init();
                HotRecommRoomTmpl = null;
                HotRecommRoomCon = null;
            } else {
                alert('很抱歉，拉取热门推荐失败，请重试');
            }
        }
    },

    init:function(){
        this.index = 0;
        this.total = $m('#videoHotRecommRoomContainer').find("li").size();
        this.resize();

        $m(".video_recommend_list #rl_pre_small").off().click(this,this.pre);
        $m(".video_recommend_list #rl_next_small").off().click(this,this.next);
    },

    pre:function(e){
        var _this = e.data;

        var n = (_this.index - _this.num)<0?_this.index:_this.num;
        _this.move(-n);
    },

    next:function(e){
        var _this = e.data;

        var n = (_this.total - _this.index)>_this.num?_this.num:0;
        _this.move(n);
    },

    //向左或向右移动n个位置
    move:function(n){

        if(this.isMove)return;

        this.isMove = true;

        this.index += n;
        this.refresh();

        var $videoHotRecommRoomContainer = $m("#videoHotRecommRoomContainer");
        var left = $videoHotRecommRoomContainer.position().left;
        $videoHotRecommRoomContainer.animate({ "left": left -  n*(this.roomWidth + this.roomGap)},function(){
            SmallHotRoom.isMove = false;
        });
    },

    refresh:function(){
        var $rl_pre_small = $m(".video_recommend_list #rl_pre_small");
        if(this.index > 0)
        {
            $rl_pre_small.removeClass().addClass("rl_pre");
        }
        else
        {
            $rl_pre_small.removeClass().addClass("rl_pre rl_pre_un");
        }

        var $rl_next_small = $m(".video_recommend_list #rl_next_small");
        if((this.total - this.index) > this.num)
        {
            $rl_next_small.removeClass().addClass("rl_next");
        }
        else
        {
            $rl_next_small.removeClass().addClass("rl_next rl_next_un");
        }
    },

    //热门推荐自适应宽度
    resize:function(){
        var left = 15 + 4;
        var right = 15;

        var width = $m(".video_recommend_list").width();

        //计算能放几个房间
        SmallHotRoom.num = parseInt((width - left - right)/(SmallHotRoom.roomWidth + SmallHotRoom.roomGap));
        SmallHotRoom.num = SmallHotRoom.num > SmallHotRoom.total ? SmallHotRoom.total : SmallHotRoom.num;

        var $rl_con = $m(".video_recommend_list .rl_con");
        //列表宽度
        SmallHotRoom.listWidth = SmallHotRoom.num*(SmallHotRoom.roomWidth + SmallHotRoom.roomGap);
        $rl_con.width(SmallHotRoom.listWidth);
        //列表位置
        var listLeft = (width - SmallHotRoom.listWidth - left - right)/2 + left;
        $rl_con.css("left",listLeft);

        SmallHotRoom.refresh();
    }
}

$j(window).on("load", function() { MGC.pvCount(); });
MGC.loadJS("http://ossweb-img.qq.com/images/js/comm/tgadshow.min.js?v=3_8_8_2016_15_4_final_3");
MGC.mnssSelect("select_open_btn", "select_open_list");
MGC.mnssSelect("select_pay_btn", "select_pay_list");/*  |xGv00|c85db16e6c7e4d622abd10685aa00d29 */
//重置玩家名片位置 77review
var oldClientWidth = 0, oldClientLeft = 0;
$j(window).resize(function() {
    if (oldClientWidth == 0 || oldClientLeft == 0)
        return;
    MGC.resetTipsLocation();
});

(function($) {
    /**
     * 清除dom的容器
     */
    var removeElement = document.createElement('div');

    //兼容IE下的移除DOM方法
    $.fn.removeAll = function(){
        //移除所有子元素的事件
        this.find("*").each(function() {
            if($._data(this,"events") != undefined)
            {
                $(this).off();
            }
        });

        this.each(function() {
            $(this).off();
            $(this).remove();
            if (!+'\v1') {
                removeElement.appendChild(this);
                removeElement.innerHTML = "";
            }
        });
    };

    $.fn.inViewPort = function(container) {
        var $window = $(window);
        var element = this;
        $.belowthefold = function() {
            var fold;
            if (container === undefined || container === window) {
                fold = $window.height() + $window.scrollTop();
            } else {
                fold = $(container).offset().top + $(container).height();
            }
            return fold <= $(element).offset().top;
        };
        $.rightoffold = function() {
            var fold;
            if (container === undefined || container === window) {
                fold = $window.width() + $window.scrollLeft();
            } else {
                fold = $(container).offset().left + $(container).width();
            }
            return fold <= $(element).offset().left;
        };
        $.abovethetop = function() {
            var fold;
            if (container === undefined || container === window) {
                fold = $window.scrollTop();
            } else {
                fold = $(container).offset().top;
            }
            return fold >= $(element).offset().top + $(element).height();
        };
        $.leftofbegin = function() {
            var fold;
            if (container === undefined || container === window) {
                fold = $window.scrollLeft();
            } else {
                fold = $(container).offset().left;
            }
            return fold >= $(element).offset().left + $(element).width();
        };
        return !$.rightoffold() && !$.leftofbegin() && !$.belowthefold() && !$.abovethetop();
    };
    $.fn.centerDisp = function() {
        this.css("left", "50%");
        this.css("top", "50%");
        this.css("marginLeft", -this.outerWidth() / 2 + "px");
        this.css("marginTop", -this.outerHeight() / 2 + "px");
    };
})($j);
