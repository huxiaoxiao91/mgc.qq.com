/*
 * Created by v_binjinluo on 2015/4/29
 * 显示各类直播房间列表
 * op_type :0 （拉取房间列表）
 * category：房间子类型
 * -1 全部房间
 *　0 推荐房间
 *  1 娱乐直播
 *　3 人气直播
 *  4 新星主播
 *  5 星级主播
 */

//发送请求========================================
var MGC_SpecialRequest = {
    //进入房间
    showList: function (category) {
        var callback = '', _zoneID = 888;
        switch (parseInt(category)) {
            /*主播小窝*/
            case -2:
                callback = 'MGC_CommResponse.CaveolaeCallBack';
                break;
            /*男神*/
            case -3:
                callback = 'MGC_CommResponse.BoyCallBack';
                break;
            /*女神*/
            case -4:
                callback = 'MGC_CommResponse.GirlCallBack';
                break;
            default:
                break;
        }
        var _reqStr = "{\"op_type\":" + OpType.HotRecommRoomOpType + ", \"type\":0, \"zoneid\":" + _zoneID + ", \"category\":" + category + ", \"beginIndex\":" + pageIndex * 20 + ", \"requestNum\":20}";//先取20个
        MGC_Comm.sendMsg(_reqStr, callback);
    }

};

var MGC_SpecialResponse = {

    //当前页
    currentPage : 1,
    //总页
    totalPage : 0,

    //=============主播小窝==============
    CaveolaeCallBack: function (responseStr) {

        var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
        if (obj.ret == 0) {
            var _roomList = obj.nests;
            if (_roomList.length == 0) {
                isSteep = true;
                scroll_load_toggle(false, "已经没有直播了哦");
                return;
            }
            var caveolaeListTmpl = $m('#caveolaeListTmpl');
            var caveolaeContainer = $m('#caveolaeContainer');
            if (typeof caveolaeContainer.data('showlist') == 'undefined' && _roomList.length > 0) {
                console.log('主播小窝数据已缓存');
                caveolaeContainer.data('showlist', responseStr);//缓存
            }
            if (pageIndex == 0)
                caveolaeContainer.children().remove();
            caveolaeListTmpl.tmpl(_roomList).appendTo(caveolaeContainer);
            pageIndex++; isSteep = true;
            //js实现旋转 
            caveolaeContainer.find(".allListA").rotate({
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
        } else {
            //异常
        }
        scroll_load_toggle(false);
    },

    //=============娱乐表演标签列表==============
    labelListCallBack: function (responseStr) {

        totalPage = Math.ceil(responseStr.tags.length/8);
        currentPage = 0;

        var arr = responseStr.tags.splice(currentPage*8,8);

        var labelList = $m('#labelList');
        var entertainment_label = $m('#entertainment_label');
        caveolaeListTmpl.tmpl(arr).appendTo(entertainment_label);
        entertainment_label.eq(0).addClass("current")
    },

    //=============男神主播==============
    BoyCallBack: function (responseStr) {
        var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
        if (obj.ret == 0) {
            var _roomList = obj.nests;
            if (_roomList.length == 0) {
                isSteep = true;
                scroll_load_toggle(false, "已经没有直播了哦");
                return;
            }
            var caveolaeListTmpl = $m('#caveolaeListTmpl');
            var boyContainer = $m('#boyContainer');
            if (typeof boyContainer.data('showlist') == 'undefined' && _roomList.length > 0) {
                console.log('男神主播数据已缓存');
                boyContainer.data('showlist', responseStr);//缓存
            }
            if (pageIndex == 0)
                boyContainer.children().remove();
            caveolaeListTmpl.tmpl(_roomList).appendTo(boyContainer);
            console.log("直播列表回调：" + responseStr);
            pageIndex++; isSteep = true;
            $m("#show_tab").find("li a").eq(pageNum).attr("pageIndex", pageIndex);
            //js实现旋转
            boyContainer.find(".allListA").rotate({
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
        } else {
            //异常
        }
        scroll_load_toggle(false);
    },

    anchorLabelCreate:function(responseStr)
    {
        //var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
        //if (obj.ret == 0) {
        var obj = [{"anchor_label_string":"全部"},{"anchor_label_string":"男神"},{"anchor_label_string":"女神"}];
            //var _roomList = obj.rooms;
            var _roomList = obj;
            if (_roomList.length == 0) {
                scroll_load_toggle(false, "已经没有直播了哦");
                return;
            }
            var anchorLabelTmpl = $m('#anchorLabelTmpl');
            var anchor_label = $m('#anchor_label');
            if (typeof anchor_label.data('showlist') == 'undefined' && _roomList.length > 0) {
                console.log('全部主播房间数据已缓存');
                anchor_label.data('showlist', responseStr);//缓存
            }
            anchorLabelTmpl.tmpl(_roomList).appendTo(anchor_label);
        //}
        //else {
        //    //异常
        //}
    },

    //=============女神主播==============
    GirlCallBack: function (responseStr) {
        var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
        if (obj.ret == 0) {
            var _roomList = obj.nests;
            if (_roomList.length == 0) {
                isSteep = true;
                scroll_load_toggle(false, "已经没有直播了哦");
                return;
            }
            var caveolaeListTmpl = $m('#caveolaeListTmpl');
            var girlContainer = $m('#girlContainer');
            if (typeof girlContainer.data('showlist') == 'undefined' && _roomList.length > 0) {
                console.log('女神主播数据已缓存');
                girlContainer.data('showlist', responseStr);//缓存
            }
            if (pageIndex == 0)
                girlContainer.children().remove();
            caveolaeListTmpl.tmpl(_roomList).appendTo(girlContainer);
            console.log("直播列表回调：" + responseStr);
            pageIndex++; isSteep = true;
            $m("#show_tab").find("li a").eq(pageNum).attr("pageIndex", pageIndex);
            //js实现旋转
            girlContainer.find(".allListA").rotate({
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
        } else {
            //异常
        }
        scroll_load_toggle(false);
    }
};

$m.extend(MGC_CommRequest, MGC_SpecialRequest);
$m.extend(MGC_CommResponse, MGC_SpecialResponse);


var MGC_Response = function (responseStr) {
    var _repStr = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr), _category = _repStr.category;
    switch (parseInt(_category)) {
        case -2:
            MGC_CommResponse.CaveolaeCallBack(_repStr);
            break;
        default:
            break;
    }
}

//本页需要回调加载的功能
var loginCallBack = function () {
    //获取标签列表
    MGC_CommResponse.anchorLabelCreate();
    myTabCut('show_tab','show_con');
     MGC.tabCut("show_tab", "show_con", 0);
    toDoShowList();
    MGCLoginRequest.getCardInfo();//加载右上角个人信息
}
var toDoShowList = function (num) {
    isSteep = false;
    scroll_load_toggle(true);
    MGC_CommRequest.showList(-2);//加载主播小窝
}
var scroll_load_toggle = function (isShow, msg) {
    if (isShow) {
        $m(".scroll-load").removeClass("hide").html('<img alt="loading" src="http://ossweb-img.qq.com/images/mgc/css_img/common/loading_normal.gif?v=3_8_8_2016_15_4_final_3" />');
    } else {
        if (msg) {
            $m(".scroll-load").html("<i>" + msg + "</i>");
        } else {
            $m(".scroll-load").addClass("hide");
        }
    }
}

var myTabCut = function (id, con) {
    var tabArr = $m("#" + id).find("li a"), len = tabArr.length;
    tabArr.each(function (index) {
        $m(this).bind("click", function () {
            isSteep = false;
            tabArr.removeClass().eq(index).addClass("current");
            for (var i = 0; i < len; i++) { $m("#" + con).find("ul").eq(i).hide(); }
            pageNum = index;
            pageIndex = tabArr.eq(index).attr("pageIndex") || 0;
            var _con = $m("#" + con).find("ul").eq(index);
            if (tabArr.eq(index).attr("pageIndex") != undefined) {
                _con.show();
                isSteep = true;
                return;
            }
            scroll_load_toggle(true);
            if (typeof (_con.data('showlist')) != 'undefined') {
                console.log('使用缓存数据');
                MGC_Response(_con.data('showlist'));
            } else {
                //无缓存则发送请求
                MGC_CommRequest.showList(_con.attr('data-cag'));
            }
            _con.show();
        })
    })
}

var pageNum = 0, pageIndex = 0; isSteep = false;
$m(window).scroll(function () {
    if (!isSteep)
        return;
    var scrollTop = $m(this).scrollTop();
    var scrollHeight = $m(document).height();
    var windowHeight = $m(this).height();
    if (scrollTop + windowHeight == scrollHeight) {
        toDoShowList();
    }
});
/*  |xGv00|91a2dce4238f4785f586869e3acff4a3 */
