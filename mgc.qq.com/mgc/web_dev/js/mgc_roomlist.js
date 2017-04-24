/**
 * Created by zhaojingsi on 2015/4/23.
 * 提供房间列表和top排行接口
 */
var selectTabIndex = 0;
//=============热门推荐==================
var HotCallBack = function(responseStr)
{
    var repStr = MGC_Comm.strToJson(responseStr);
    var _roomList = repStr.rooms, _totleCount = parseInt(repStr.totalCount);
	var _superRoom = new Array();
	var _normalRoom = new Array();
	var _superRoomTemp = 0;
	//先特殊处理
	$m.each(_roomList,function(k,v){
		if ( v.bSuperRoom ) { //演唱会
			++_superRoomTemp;
			if ( _superRoomTemp<=1 ) {
				_superRoom.push(v);
			} else　{
				_normalRoom.push(v);
			}
		} else {
			_normalRoom.push(v);
		}
	});
	if ( _superRoomTemp==0 ) {
		var _caslRoom = _normalRoom.slice(0, 4);
	} else {
		var _caslRoom = _superRoom;
	}

	$m.each(_caslRoom, function (k, v) {
	    v.anchor_level_temp = Math.floor(v.anchor_level / 10) + 1;
	    if (v.anchor_level == 0) {
	        v.anchor_level_temp = 0;
	    }
	})

    var HotPhotoBoardListTmpl = $m('#HotTopicListTmpl');
    var HotPhotoBoardListCon;
    var HotPhotoBoardListContainer = $m('#HotPhotoBoardListContainer');
    HotPhotoBoardListContainer.children().remove();
    HotPhotoBoardListTmpl = HotPhotoBoardListCon.tmpl(_caslRoom);
    HotPhotoBoardListTmpl.appendTo(HotPhotoBoardListContainer);

    var _carouseHtml = '';
    for (var i = 0, j = _caslRoom.length; i < j; i++) {
        if (i == 0) {
            _carouseHtml += '<span class="current compatible_css3"></span>';
        } else {
            _carouseHtml += '<span class="compatible_css3"></span>';
        }
    }
    $m("#hotcarousel").html(_carouseHtml);
	if ( _superRoomTemp==0 ) {
		var _caslRoom2 = _normalRoom.slice(4, _totleCount);
	} else {
		var _caslRoom2 = _normalRoom.slice(0, 8);
	}
	$m.each(_caslRoom2, function (k, v) {
	    v.anchor_level_temp = 0;
	    if (v.anchor_level > 0 && v.anchor_level < 10) {
	        v.anchor_level_temp = 1;
	    } else if (v.anchor_level > 9 && v.anchor_level < 20) {
	        v.anchor_level_temp = 2;
	    } else if (v.anchor_level > 19 && v.anchor_level < 30) {
	        v.anchor_level_temp = 3;
	    } else if (v.anchor_level > 29 && v.anchor_level < 40) {
	        v.anchor_level_temp = 4;
	    } else if (v.anchor_level > 39 && v.anchor_level < 50) {
	        v.anchor_level_temp = 5;
	    } else if (v.anchor_level > 49 && v.anchor_level < 60) {
	        v.anchor_level_temp = 6;
	    } else if (v.anchor_level >= 60) {
	        v.anchor_level_temp = 7;
	    }
	})
    var HotPhotoCon = $m('#HotListTmpl');
    var HotPhotoTmpl;
    var HotListContainer = $m('#hotList');
    HotListContainer.children().remove();
    HotPhotoTmpl = HotPhotoCon.tmpl(_caslRoom2);
    HotPhotoTmpl.appendTo(HotListContainer);
    //js实现旋转 
    HotListContainer.find(".r_pic_hover").rotate({
        bind: {
            mouseover: function () {
                $m(this).find("i").rotate({
                    duration: 1000,
                    angle: 0,
                    animateTo: 360,
                    callback: function () {
                    }
                });
            }
        }
    });
    if (_superRoomTemp > 0) { //有演唱会
        $m("#r_carousel").css('cssText', 'overflow:inherit');
        $m("#HotPhotoBoardListContainer").css('cssText', 'width:auto');
	    $m("#hotcarousel").hide();
	} else {
        $m("#hotcarousel").show();
        $m("#r_carousel").css('cssText', 'overflow:hidden');
        $m("#HotPhotoBoardListContainer").css('cssText', 'width:1000%');
		MGC.carousel("r_carousel","rc_con","rc_btn",456,5000,"left");
	}
    //css3兼容
    //try {
    //    $m("#hotcarousel").find(".compatible_css3").each(function () {
    //        PIE.attach(this);
    //    });
    //} catch (e) {
    //    console.log("error:css3兼容 " + e.message + " mgc.roomlist.js");
    //}
    HotPhotoBoardListTmpl = null;
    HotPhotoBoardListCon = null;
    HotPhotoTmpl = null;
    HotPhotoCon = null;
};

//=============星级主播==============
var StarCallBack = function(responseStr)
{
	console.log('星级'+JSON.stringify(responseStr));
    var repStr = MGC_Comm.strToJson(responseStr);
    var _roomList = repStr.rooms, _totleCount = parseInt(repStr.totalCount);
    var _caslRoom = _roomList.slice(0, 8);
    $m.each(_caslRoom, function (k, v) {
        v.anchor_level_temp = 0;
        if (v.anchor_level > 0 && v.anchor_level < 10) {
            v.anchor_level_temp = 1;
        } else if (v.anchor_level > 9 && v.anchor_level < 20) {
            v.anchor_level_temp = 2;
        } else if (v.anchor_level > 19 && v.anchor_level < 30) {
            v.anchor_level_temp = 3;
        } else if (v.anchor_level > 29 && v.anchor_level < 40) {
            v.anchor_level_temp = 4;
        } else if (v.anchor_level > 39 && v.anchor_level < 50) {
            v.anchor_level_temp = 5;
        } else if (v.anchor_level > 49 && v.anchor_level < 60) {
            v.anchor_level_temp = 6;
        } else if (v.anchor_level >= 60) {
            v.anchor_level_temp = 7;
        }
    })
    var StarListCon = $m('#StarListTmpl');
    var StarListTmpl;
    var StarContainer = $m('#StarContainer');
    StarContainer.children().remove();
    StarListTmpl = StarListCon.tmpl(_caslRoom);
    StarListTmpl.appendTo(StarContainer);
    //js实现旋转 
    StarContainer.find(".anchor_links").rotate({
        bind: {
            mouseover: function () {
                $m(this).find("i").rotate({
                    duration: 1000,
                    angle: 0,
                    animateTo: 360,
                    callback: function () {
                    }
                });
            }
        }
    });
    StarListTmpl = null;
    StarListCon = null;
};

var StarCallBackNew = function(responseStr)
{
    console.log('首页娱乐表演返回数据'+JSON.stringify(responseStr));
    var repStr = MGC_Comm.strToJson(responseStr);
    var _roomList = repStr.rooms, _totleCount = parseInt(repStr.totalCount);
    Array.prototype.push.apply(MGCData.totalRoomList, repStr.rooms);
    MGCRoomList.ylflag = true;
    var _caslRoom = _roomList.slice(0, 8);
    $m.each(_caslRoom, function (k, v) {
        v.anchor_level_temp = 0;
        if (v.anchor_level > 0 && v.anchor_level < 10) {
            v.anchor_level_temp = 1;
        } else if (v.anchor_level > 9 && v.anchor_level < 20) {
            v.anchor_level_temp = 2;
        } else if (v.anchor_level > 19 && v.anchor_level < 30) {
            v.anchor_level_temp = 3;
        } else if (v.anchor_level > 29 && v.anchor_level < 40) {
            v.anchor_level_temp = 4;
        } else if (v.anchor_level > 39 && v.anchor_level < 50) {
            v.anchor_level_temp = 5;
        } else if (v.anchor_level > 49 && v.anchor_level < 60) {
            v.anchor_level_temp = 6;
        } else if (v.anchor_level >= 60) {
            v.anchor_level_temp = 7;
        }
    })
    var StarContainer ;
    if($m('#StarContainer'+ responseStr.tag).length == 0)
    {
        var idName = "StarContainer" + responseStr.tag;
        $m('#indexEntertainment').append("<ul id='"+ idName +"'><\/ul\>");
    }

    StarContainer =  $m('#StarContainer'+ responseStr.tag);

    if (typeof StarContainer.data(responseStr.tag) == 'undefined' && _caslRoom.length > 0) {
        console.log('全部主播房间数据已缓存');
        anchor_label.data(responseStr.tag, responseStr);//缓存
    }

    //$m('#StarContainer').empty();
    var StarListCon = $m('#StarListTmpl');
    var StarListTmpl;

    StarContainer.children().remove();
    StarListTmpl = StarListCon.tmpl(_caslRoom);
    StarListTmpl.appendTo(StarContainer);
    //js实现旋转
    StarContainer.find(".anchor_links").rotate({
        bind: {
            mouseover: function () {
                $m(this).find("i").rotate({
                    duration: 1000,
                    angle: 0,
                    animateTo: 360,
                    callback: function () {
                    }
                });
            }
        }
    });
    if (MGCRoomList.ghflag == true && MGCRoomList.xxflag == true && MGCRoomList.ylflag == true) {
        MGCRoomList.flag = true;
        if (MGCRoomList.flag && (MGCData.totalRoomList.length>0)) {
            MGC_CommResponse.checkIsFirstLoginCallBack2();
        }
    }
    StarListTmpl = null;
    StarListCon = null;
};

//=============人气公会==============
var PopCallBack = function(responseStr)
{
    var repStr = MGC_Comm.strToJson(responseStr);
    var _roomList = repStr.rooms, _totleCount = parseInt(repStr.totalCount);
    Array.prototype.push.apply(MGCData.totalRoomList, repStr.rooms);
    MGCRoomList.ghflag = true;
    var _caslRoom = _roomList.slice(0, 8);
    $m.each(_caslRoom, function (k, v) {
        v.anchor_level_temp = 0;
        if (v.anchor_level > 0 && v.anchor_level < 10) {
            v.anchor_level_temp = 1;
        } else if (v.anchor_level > 9 && v.anchor_level < 20) {
            v.anchor_level_temp = 2;
        } else if (v.anchor_level > 19 && v.anchor_level < 30) {
            v.anchor_level_temp = 3;
        } else if (v.anchor_level > 29 && v.anchor_level < 40) {
            v.anchor_level_temp = 4;
        } else if (v.anchor_level > 39 && v.anchor_level < 50) {
            v.anchor_level_temp = 5;
        } else if (v.anchor_level > 49 && v.anchor_level < 60) {
            v.anchor_level_temp = 6;
        } else if (v.anchor_level >= 60) {
            v.anchor_level_temp = 7;
        }
    })
    var PeopleListCom= $m('#peopleListTmpl');
    var PeopleListTmpl;
    var PeopleContainer = $m('#newStartList');
    PeopleContainer.children().remove();
    PeopleListTmpl = PeopleListCom.tmpl(_caslRoom);
    PeopleListTmpl.appendTo(PeopleContainer);
    //js实现旋转
    PeopleContainer.find(".anchor_links").rotate({
        bind: {
            mouseover: function () {
                $m(this).find("i").rotate({
                    duration: 1000,
                    angle: 0,
                    animateTo: 360,
                    callback: function () {
                    }
                });
            }
        }
    });
    if (MGCRoomList.ghflag == true && MGCRoomList.xxflag == true && MGCRoomList.ylflag == true) {
        MGCRoomList.flag = true;
        if (MGCRoomList.flag && (MGCData.totalRoomList.length > 0)) {
            MGC_CommResponse.checkIsFirstLoginCallBack2();
        }
    }
    PeopleListTmpl = null;
    PeopleListCom = null;
};

//=============新星主播==============
var NewStarCallBack = function (responseStr) {
    console.log('新星' + JSON.stringify(responseStr));
    var repStr = MGC_Comm.strToJson(responseStr);
    var _roomList = repStr.rooms, _totleCount = parseInt(repStr.totalCount);
    Array.prototype.push.apply(MGCData.totalRoomList, repStr.rooms);
    MGCRoomList.xxflag = true;
    var _caslRoom = _roomList.slice(0, 8);
    $m.each(_caslRoom, function (k, v) {
        v.anchor_level_temp = 0;
        if (v.anchor_level > 0 && v.anchor_level < 10) {
            v.anchor_level_temp = 1;
        } else if (v.anchor_level > 9 && v.anchor_level < 20) {
            v.anchor_level_temp = 2;
        } else if (v.anchor_level > 19 && v.anchor_level < 30) {
            v.anchor_level_temp = 3;
        } else if (v.anchor_level > 29 && v.anchor_level < 40) {
            v.anchor_level_temp = 4;
        } else if (v.anchor_level > 39 && v.anchor_level < 50) {
            v.anchor_level_temp = 5;
        } else if (v.anchor_level > 49 && v.anchor_level < 60) {
            v.anchor_level_temp = 6;
        } else if (v.anchor_level >= 60) {
            v.anchor_level_temp = 7;
        }
    })
    var PeopleListCon = $m('#newStarListTmpl');
    var PeopleListTmpl;
    var PeopleContainer = $m('#PeopleContainer');
    PeopleContainer.children().remove();
    PeopleListTmpl = PeopleListCon.tmpl(_caslRoom);
    PeopleListTmpl.appendTo(PeopleContainer);
    //js实现旋转
    PeopleContainer.find(".anchor_links").rotate({
        bind: {
            mouseover: function () {
                $m(this).find("i").rotate({
                    duration: 1000,
                    angle: 0,
                    animateTo: 360,
                    callback: function () {
                    }
                });
            }
        }
    });
    if (MGCRoomList.ghflag == true && MGCRoomList.xxflag == true && MGCRoomList.ylflag == true) {
        MGCRoomList.flag = true;
        if (MGCRoomList.flag && (MGCData.totalRoomList.length > 0)) {
            MGC_CommResponse.checkIsFirstLoginCallBack2();
        }
    }
    PeopleListTmpl = null;
    PeopleListCon = null;
};
//=============主播小窝==============
var CaveolaeCallBack = function (responseStr) {
    console.log('主播小窝' + JSON.stringify(responseStr));
    var repStr = MGC_Comm.strToJson(responseStr);
    var _roomList = repStr.nests, _totleCount = parseInt(repStr.totalCount);
    var _caslRoom = _roomList.slice(0, 8);
    $m.each(_caslRoom, function (k, v) {
        v.anchor_level_temp = 0;
        if (v.anchor_level > 0 && v.anchor_level < 10) {
            v.anchor_level_temp = 1;
        } else if (v.anchor_level > 9 && v.anchor_level < 20) {
            v.anchor_level_temp = 2;
        } else if (v.anchor_level > 19 && v.anchor_level < 30) {
            v.anchor_level_temp = 3;
        } else if (v.anchor_level > 29 && v.anchor_level < 40) {
            v.anchor_level_temp = 4;
        } else if (v.anchor_level > 39 && v.anchor_level < 50) {
            v.anchor_level_temp = 5;
        } else if (v.anchor_level > 49 && v.anchor_level < 60) {
            v.anchor_level_temp = 6;
        } else if (v.anchor_level >= 60) {
            v.anchor_level_temp = 7;
        }
    })
    var caveolaeListCon = $m('#caveolaeListTmpl');
    var caveolaeListTmpl;
    var caveolaeContainer = $m('#caveolaeList');
    caveolaeContainer.children().remove();
    caveolaeListTmpl = caveolaeListCon.tmpl(_caslRoom);
    caveolaeListTmpl.appendTo(caveolaeContainer);
    //js实现旋转
    caveolaeContainer.find(".anchor_links").rotate({
        bind: {
            mouseover: function () {
                $m(this).find("i").rotate({
                    duration: 1000,
                    angle: 0,
                    animateTo: 360,
                    callback: function () {
                    }
                });
            }
        }
    });
    caveolaeListTmpl = null;
    caveolaeListCon = null;
};


//=============娱乐表演标签列表==============
var labelListCallBack = function (responseStr) {

    totalPage = Math.ceil(responseStr.tags.length/8);
    currentPage = 0;

    labelListArr = responseStr.tags;
    //while(responseStr.tags.length > 0)
    //{
    //    var arr = responseStr.tags.splice(0,8);
    //    labelListArr.push(arr);
    //}

    pageProcessing();
    flipFunction();
};

var flipFunction = function () {
    $m('[id*="StarContainer"]').hide();
    var ar ;
    if(labelListArr.length <(currentPage+1)*8)
    {
        ar = labelListArr.slice((labelListArr.length-8),labelListArr.length);
    }
    else
    {
        ar = labelListArr.slice(currentPage*8,(currentPage+1)*8);

    }

    tag_id = labelListArr[selectTabIndex].tag_id;
    var len = ar.length;
    var selectIndex = 0;
    var i=0;
    for(i;i<len;i++)
    {
        if(ar[i].tag_id == tag_id)
        {
            selectIndex = i;
            break;
        }
    }

    i = 0;
    tag_id = ar[selectIndex].tag_id;

    len = labelListArr.length;
    selectTabIndex = 0;
    for(i;i<len;i++)
    {
        if(labelListArr[i].tag_id == tag_id)
        {
            selectTabIndex = i;
            break;
        }
    }

    if($m('#StarContainer'+ tag_id).length > 0)
    {
        $m('#StarContainer'+ tag_id).show();
    }
    else
    {
        MGCRoomList.requestStarCallBack(tag_id,0);
    }

    var labelListCon = $m('#labelList');
    var labelListTmpl = $m('#labelList');
    var entertainment_label = $m('#entertainment_label');
    entertainment_label.empty();
    labelListTmpl = labelListCon.tmpl(ar);
    labelListTmpl.appendTo(entertainment_label);

    //entertainment_label.find("li:eq(0) a").addClass("current");
    entertainment_label.find("li a").eq(selectIndex).addClass("current");

    myClickTab1("entertainment_label","anchor_list clearfix");
    labelListTmpl = null;
    labelListCon = null;
};

var pageProcessing = function()
{
    if(totalPage > 1)
    {
        $m('#pageUp').show();
        $m('#pageDown').show();
        $m('#pageUp').unbind('click').click(function () {
            if ($m('#pageUp').attr("class") == "pageUp_prev")
                return false;
            currentPage--;
            if (tag_id && $m('#StarContainer' + tag_id).length > 0) {
                $m('#StarContainer' + tag_id).hide();
            }
            flipFunction();
            pageProcessing();
        });
        $m('#pageDown').unbind('click').click(function () {
            if($m('#pageDown').attr("class") == "pageDown_prev")
                return false;
            currentPage++;
            if (tag_id && $m('#StarContainer'+ tag_id).length > 0)
            {
                $m('#StarContainer'+ tag_id).hide();
            }
            flipFunction();
            pageProcessing();
        });
        if(currentPage == 0)
        {
            $m('#pageUp').removeClass().addClass("pageUp_prev");
        }
        else
        {
            $m('#pageUp').removeClass().addClass("pageUp")
        }

        if((currentPage + 1 ) == totalPage)
        {
            $m('#pageDown').removeClass().addClass("pageDown_prev");
        }
        else
        {
            $m('#pageDown').removeClass().addClass("pageDown")
        }
    }
    else
    {
        $m('#pageUp').hide();
        $m('#pageDown').hide();
    }
};

var jumpTab = function(responseStr)
{
    $m('#submitTab').attr('action', "show.shtml#"+tag_id);
    $m('#submitTab').submit();

};

var tag_id = 0 ;
//=============TOP10排行==============
var TopTenCallBack = function(responseStr)
{
    console.log("top10排行:"+JSON.stringify(responseStr));
    var repStr = MGC_Comm.strToJson(responseStr);
    var _rankList = repStr.rank.anchorRank, _tmplList = new Array();
    var _newRank = _rankList.slice(0, 10);
    var _rankClassName = {
        1:'first',2:'second',3:'third',4:'fourth',5:'fifth',6:'sixth',7:'seventh',8:'eighth',9:'ninth',10:'tenth'
    };
    var StarLightCom = $m('#StarLightTopTenTmpl');
    var StarLightTmpl;
    var starListContainer = $m('#StarLightTopTen');
    if (typeof starListContainer.data('showlist' + responseStr.timedimension) == 'undefined') {
        starListContainer.data('showlist' + responseStr.timedimension, responseStr);//缓存
    }
    if (_newRank.length > 0) {
        for (var i = 0, j = _newRank.length; i < j; i++) {
            _newRank[i]["rankClassName"] = _rankClassName[i + 1];
            if (i >= 3) {
                _newRank[i]["_icon"] = _newRank[i]["order_change"] > 0 ? "up" : _newRank[i]["order_change"] == 0 ? "nor" : _newRank[i]["order_change"] < 0 ? "down" : "nor";
            } else {
                _newRank[i]["_icon"] = _newRank[i]["order_change"] > 0 ? "up1" : _newRank[i]["order_change"] == 0 ? "nor" : _newRank[i]["order_change"] < 0 ? "down" : "nor";
            }
            _newRank[i]["_order_change"] = _newRank[i]["order_change"] == 0 ? "" : Math.abs(_newRank[i]["order_change"]);
            _tmplList.push(_newRank[i]);
        }
        starListContainer.children().remove();
        StarLightTmpl = StarLightCom.tmpl(_tmplList);
        StarLightTmpl.appendTo(starListContainer);
        StarLightTmpl = null;
        StarLightCom = null;
    } else {
        starListContainer.html('<div class="bg_none"><p class="bg_none_img"></p><p class="bg_none_txt">主播排队中，快去支持喜爱的主播吧</p></div>');
    }
};

//发送请求========================================
var MGCRoomList = {
    //发送请求
    /*
     category：房间子类型
     -1 全部房间
     0  推荐房间
     1  娱乐直播
     3  人气直播
     4  新星主播
     5  星级主播
     -2 主播小窝
     */
    doRequest : function(category, iNum) {

        var callback = '';
        switch (category)
        {
            case 0:
                callback = 'HotCallBack';
                break;
            case 10:
                callback = 'PopCallBack';
                break;
            case 4:
                callback = 'NewStarCallBack';
                break;
            case 5:
                callback = 'StarCallBack';
                break;
            case -2:
                callback = 'CaveolaeCallBack';
                break;
            default :
                break;
        }

        var _num = (typeof iNum == 'undefined') ? 8 : iNum;
        var _reqStr = "{\"op_type\":0, \"type\":0, \"zoneid\":888, \"category\":"+category+", \"beginIndex\":0, \"requestNum\":"+_num+"}";
        MGC_Comm.sendMsg(_reqStr, callback);
    },

    requestLabel: function() {
        var _reqStr = "{\"op_type\":233, \"is_home\":true}";
        MGC_Comm.sendMsg(_reqStr, "labelListCallBack");
    },

    requestStarCallBack : function(tag,position) {
        tag_id = tag;
        var _reqStr = {"op_type":0,"type":0, "zoneid":888,"category":0,"beginIndex":0,"requestNum":8,"tag":tag,"position":position};
        MGC_Comm.sendMsg(_reqStr, "StarCallBackNew");
    },
    //星top10
    doStarLightTop: function (timedimension) {
        var cacheData = $m('#StarLightTopTen').data('showlist' + timedimension);
        if (typeof cacheData == 'undefined') {
            var _reqStr = "{\"op_type\":" + OpType.GetAnchorStarRankOpType + ",\"timedimension\":" + timedimension + "}";
            MGC_Comm.sendMsg(_reqStr, "TopTenCallBack");
        } else {
            TopTenCallBack(cacheData);
        }
    },
    flag: false,
    ghflag: false,
    xxflag: false,
    ylflag:false,
};

$m('body').on('mouseover', 'em[class^="badge"]', function (e) {
    var badge_id = $m(this).attr('mgc_data');
    var tips = '';
    if (badge_id == '0') {
        return;
    } else if (badge_id) {
        tips = window.mgc.config.BADGE_CONFIG[badge_id].badge_tips;
    }
    MGC.susTipsHtmlPop(e, 1, tips);
});

$m('body').on('mouseout', 'em[class^="badge"]', function (e) {
    MGC.susTipsHtmlPop(e, 0);
});

var myTabCon = function (id, con) {
    var tabArr = $m("#" + id).find("li a"), len = tabArr.length;
    tabArr.each(function (index) {
        $m(this).bind("mouseenter", function () {
            tabArr.removeClass().eq(index).addClass("current");
            var _con = $m("#" + con).find("ul").eq(0);
            MGCRoomList.doStarLightTop(index);
        })
    })
}
/*  |xGv00|bc975e5889bb607947e561925b45e4cc */
