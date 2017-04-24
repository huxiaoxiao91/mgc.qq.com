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
    upClickTab:null,
    tabContainer: null,
    showList: function (category) {
        var callback = '', _zoneID = 888;
        callback = 'MGC_CommResponse.AllShowCallBack';
        //switch (parseInt(category)) {
        //    /*全部房间*/
        //    case 1:
        //        callback = 'MGC_CommResponse.AllShowCallBack';
        //        break;
        //        /*人气直播*/
        //    case 3:
        //        callback = 'MGC_CommResponse.PopShowCallBack';
        //        break;
        //        /*新星主播*/
        //    case 4:
        //        callback = 'MGC_CommResponse.NewShowStarCallBack';
        //        break;
        //        /*星级主播*/
        //    case 5:
        //        callback = 'MGC_CommResponse.StarShowCallBack';
        //        break;
        //    default:
        //        break;
        //}
        var _reqStr = "{\"op_type\":" + OpType.HotRecommRoomOpType + ", \"type\":0, \"zoneid\":" + _zoneID + ", \"category\":" + category + ", \"beginIndex\":" + pageIndex * 20 + ", \"requestNum\":20}";//先取20个
        console.log("直播列表请求：" + _reqStr);
        MGC_Comm.sendMsg(_reqStr, callback);
    }

};

var MGC_SpecialResponse = {
    //=============全部房间==============
    selectTabIndex : 0,

    AllShowCallBack: function (responseStr,isRefresh) {
        var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
        if (obj.ret == 0) {
            var _roomList = obj.rooms;
            if (_roomList.length == 0) {
                isSteep = true;
                scroll_load_toggle(false, "已经没有直播了哦");
                return;
            }
            var allListCom = $m('#allListTmpl');
            var allListTmpl;
            var allContainer = $m('#allContainer');
            if (typeof allContainer.data('showlist'+pageNum) == 'undefined' && _roomList.length > 0) {
                console.log('全部主播房间数据已缓存');
                allContainer.data('showlist'+pageNum, responseStr);//缓存
            }
            if(!isRefresh && pageIndex != 0)
            {
                    pageIndex--;
            }
            if (pageIndex == 0)
                allContainer.children().remove();
            allListTmpl = allListCom.tmpl(_roomList);
            allListTmpl.appendTo(allContainer);
            console.log("直播列表回调：" + responseStr);
            if(isRefresh ||isRefresh == undefined )
            {
                pageIndex++;
                $m("#show_tab").find("li a").eq(pageNum).attr("pageIndex", pageIndex);
            }
            isSteep = true;
            //js实现旋转 
            allContainer.find(".allListA").rotate({
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
            allListTmpl = null;
            allListCom = null;
        } else {
            //异常
        }
        isSteep = true;
        scroll_load_toggle(false);
    },

    requestLabel: function() {
        var _reqStr = "{\"op_type\":233, \"is_home\":false}";
        //MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.anchorLabelCreate");
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.labelListCallBack");
    },

    labelListCallBack : function (responseStr) {

        //responseStr.tags.splice(0,0,{"tag_id":-1,"tag_name":"全部"},{"tag_id":-2,"tag_name":"新星主播"},{"tag_id":-3,"tag_name":"公会"});
        responseStr.tags.splice(0,0,{"tag_id":-3,"tag_name":"全部公会"},{"tag_id":-1,"tag_name":"个人show"},{"tag_id":-2,"tag_name":"新星主播"});
        totalPage = Math.ceil(responseStr.tags.length/8);
        currentPage = 0;
        labelListArr =  responseStr.tags;
        //labelListArr.splice(labelListArr.length - 1,1);
        //while(responseStr.tags.length > 0)
        //{
        //    var arr = responseStr.tags.splice(0,8);
        //    labelListArr.push(arr);
        //}

        if(pageNum == 0)
        {
            selectTabIndex = 0;
        }
        else
        {
            selectTabIndex = 0;
            var i = 0;
            for (i; i <  labelListArr.length ;i++)
            {
                if(labelListArr[i].tag_id == pageNum)
                {
                    currentPage = Math.floor(i/8);
                    selectTabIndex = i;
                    break;
                }
            }

            //tagIndex:for(currentPage;currentPage<labelListArr.length;currentPage++){
            //    selectTabIndex = 0;
            //    for(selectTabIndex;selectTabIndex<labelListArr[currentPage].length;selectTabIndex++)
            //    {
            //        if(labelListArr[currentPage][selectTabIndex].tag_id == pageNum)
            //        {
            //            break tagIndex;
            //        }
            //    }
            //}
        }

        MGC_CommResponse.pageProcessing();
        MGC_CommResponse.flipFunction();
    },

    myClickTab2 : function(id,con){
        var tabArr=$m("#"+id).find("a"),conArr=$m("."+con);
        var len = tabArr.length;
        tabArr.each(function(index){
            $m(this).unbind("click").click(function(){
                tabArr.removeClass().eq(index).addClass("current");
                for (var i = 0; i < len; i++) { $m("#show_con").find("ul").eq(i).hide(); }
                upClickTab = $m(this);
                pageIndex = upClickTab.attr("pageIndex") || 0;
                //conArr.hide().eq(index).show();
                var _category;
                tag_id =  $m(this).attr("tag_id");

                var ii = 0;
                var len1 = labelListArr.length;
                selectTabIndex = 0;
                for(ii;ii<len1;ii++)
                {
                    if(labelListArr[ii].tag_id == tag_id)
                    {
                        selectTabIndex = ii;
                        break;
                    }
                }

                //if(MGC_CommResponse.tabContainer)
                //{
                //    MGC_CommResponse.tabContainer.hide();
                //}
                $m('[id*="StarContainer"]').hide();
                isSteep = false;
                scroll_load_toggle(true);
                if(parseInt(tag_id) > 0)
                {
                    if ($m('#StarContainer'+ tag_id).length > 0 &&  typeof $m('#StarContainer'+ tag_id) != 'undefined') {
                        $m('#StarContainer'+ tag_id).show();
                        isSteep = true;
                        scroll_load_toggle(false);
                    } else {
                        MGC_CommResponse.requestStarCallBack1(tag_id,1);
                    }
                }
                else
                {
                    switch(parseInt(tag_id))
                    {
                        case 0:
                        case -1:
                            _category = 9;
                            break;
                        case -2:
                            _category = 4;
                            break;
                        case -3:
                            _category = 11;
                            break;
                    }
                    if ($m('#StarContainer_'+ _category).length > 0 &&  typeof $m('#StarContainer_'+ _category) != 'undefined') {
                        $m('#StarContainer_'+ _category).show();
                        isSteep = true;
                        scroll_load_toggle(false);
                    } else {
                        MGC_CommResponse.requestStarCallBack1(tag_id,1);
                    }
                }


                //tabArr.removeClass().eq(index).addClass("current");
                //conArr.hide().eq(index).show();
            });
        });
    },

    flipFunction : function () {
        //tag_id = labelListArr[selectTabIndex].tag_id;
        $m('[id*="StarContainer"]').hide();
        var ar;
        if (labelListArr.length < 8) {
            ar = labelListArr;
        }
        else  if(labelListArr.length <(currentPage+1)*8)
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

        switch (parseInt(tag_id))
        {
            case 0:
            case -1:
                if($m('#StarContainer_9').length > 0)
                {
                    $m('#StarContainer_9').show();
                }
                else
                {
                    MGC_CommResponse.requestStarCallBack1(tag_id,1);
                }
                break;
            case -2:
                if($m('#StarContainer_4').length > 0)
                {
                    $m('#StarContainer_4').show();
                }
                else
                {
                    MGC_CommResponse.requestStarCallBack1(tag_id,1);
                }
                break;
            case -3:
                if($m('#StarContainer_11').length > 0)
                {
                    $m('#StarContainer_11').show();
                }
                else
                {
                    MGC_CommResponse.requestStarCallBack1(tag_id,1);
                }
                break;
            default :
                if($m('#StarContainer'+tag_id).length > 0)
                {
                    $m('#StarContainer'+tag_id).show();
                }
                else
                {
                    MGC_CommResponse.requestStarCallBack1(tag_id,1);
                }
                break;
        }
        var labelListCon = $m('#anchorLabelTmpl');
        var labelListTmpl;
        var entertainment_label = $m('#anchor_label');
        entertainment_label.empty();
        labelListTmpl = labelListCon.tmpl(ar);
        labelListTmpl.appendTo(entertainment_label);

        upClickTab = $m("#show_tab").find("li a").eq(selectIndex);
        entertainment_label.find("li a").eq(selectIndex).addClass("current");
        MGC_CommResponse.myClickTab2("anchor_label","show_con");
        labelListTmpl = null;
        labelListCon = null;
    },

    requestStarCallBack1 : function(tag,position) {
        isSteep = false;
        scroll_load_toggle(true);
        var _reqStr ;
        switch (parseInt(tag))
        {
            case 0:
            case -1:
                tag_id = -1;
                _reqStr = {"op_type":0,"type":0, "zoneid":888,"category":9,"beginIndex":0,"requestNum":8,"beginIndex":pageIndex * 20,"requestNum":20};
                break;
            case -2:
                tag_id = -2;
                _reqStr = {"op_type":0,"type":0, "zoneid":888,"category":4,"beginIndex":0,"requestNum":8,"beginIndex":pageIndex * 20,"requestNum":20};
                break;
            case -3:
                tag_id = -3;
                _reqStr = {"op_type":0,"type":0, "zoneid":888,"category":11,"beginIndex":0,"requestNum":8,"beginIndex":pageIndex * 20,"requestNum":20};
                break;
            default :
                tag_id = tag;
                _reqStr = {"op_type":0,"type":0, "zoneid":888,"category":0,"beginIndex":0,"requestNum":8,"tag":parseInt(tag),"position":position,"beginIndex":pageIndex * 20,"requestNum":20};
                break;
        }

        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.StarCallBackNew1");
    },

    StarCallBackNew1 : function(responseStr)
    {
        var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
        if (obj.ret == 0) {
            var _roomList = obj.rooms;

            if (_roomList.length == 0) {
                isSteep = true;
                scroll_load_toggle(false, "已经没有直播了哦");
                return;
            }

            if(parseInt(responseStr.tag) == 0)
            {
                if($m('#StarContainer_'+ responseStr.category).length == 0)
                {
                    idName = "StarContainer_" + responseStr.category;
                    $m('#show_con').append("<ul class='clearfix' id='"+ idName +"'><\/ul\>");
                }
            }else if($m('#StarContainer'+ responseStr.tag).length == 0)
            {
                idName = "StarContainer" + responseStr.tag;
                $m('#show_con').append("<ul class='clearfix' id='"+ idName +"'><\/ul\>");
            }

            MGC_CommResponse.tabContainer =  $m('#'+ idName);

            if (typeof MGC_CommResponse.tabContainer.data(idName) == 'undefined' && _roomList.length > 0) {
                console.log('全部主播房间数据已缓存');
                $m.each(_roomList, function (k, v) {                
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
                MGC_CommResponse.tabContainer.data(idName, responseStr);//缓存
            }

            var allListCon = $m('#allListTmpl');
            var allListTmpl;
            //var allContainer = $m('#allContainer');
            //if (typeof allContainer.data('showlist') == 'undefined' && _roomList.length > 0) {
            //    console.log('全部主播房间数据已缓存');
            //    allContainer.data('showlist', responseStr);//缓存
            //}
            if (pageIndex == 0)
                MGC_CommResponse.tabContainer.children().remove();
            allListTmpl = allListCon.tmpl(_roomList);
            allListTmpl.appendTo(MGC_CommResponse.tabContainer);
            console.log("直播列表回调：" + responseStr);
            pageIndex++;
            upClickTab.attr("pageIndex", pageIndex);
            if(upClickTab)
            {
                upClickTab.attr("pageIndex", pageIndex)
            }

            //$m("#show_tab").find("li a").eq(pageNum).attr("pageIndex", pageIndex);
            //js实现旋转
            MGC_CommResponse.tabContainer.find(".allListA").rotate({
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
            allListTmpl = null;
            allListCon = null;
        } else {
            //异常
        }
        isSteep = true;
        scroll_load_toggle(false);
    },

    pageProcessing : function()
    {
        if(totalPage > 1)
        {
            $m('#pageUp').show();
            $m('#pageDown').show();
            $m('#pageUp').unbind('click').click(function () {
                if($m('#pageUp').attr("class") == "pageUp_prev")
                    return false;
                currentPage--;

                //MGC_CommResponse.selectTabIndexUpdate();
                pageIndex = 0;
                MGC_CommResponse.hideStarContainer();
                MGC_CommResponse.pageProcessing();
                MGC_CommResponse.flipFunction();
            });
            $m('#pageDown').unbind('click').click(function () {
                if($m('#pageDown').attr("class") == "pageDown_prev")
                    return false;
                currentPage++;
                //MGC_CommResponse.selectTabIndexUpdate();
                pageIndex = 0;
                MGC_CommResponse.hideStarContainer();
                MGC_CommResponse.pageProcessing();
                MGC_CommResponse.flipFunction();
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
    },

    selectTabIndexUpdate : function (){
        var len = labelListArr.length;
        if(labelListArr.length <(currentPage+1)*8)
        {
            selectTabIndex = labelListArr.length-8;
        }
        else
        {
            selectTabIndex = currentPage*8;
        }

        var i = 0;
        for (i;i < len;i++)
        {
            if(labelListArr[i].tag_id == tag_id)
            {
                selectTabIndex = i;
                break;
            }
        }
    },

    hideStarContainer:function()
    {
        if (tag_id) {
            switch (parseInt(tag_id))
            {
                case 0:
                case -1:
                    if($m('#StarContainer_9').length > 0)
                    {
                        $m('#StarContainer_9').hide();
                    }
                    break;
                case -2:
                    if($m('#StarContainer_4').length > 0)
                    {
                        $m('#StarContainer_4').hide();
                    }
                    break;
                case -3:
                    if($m('#StarContainer_11').length > 0)
                    {
                        $m('#StarContainer_11').hide();
                    }
                    break;
                default :
                    if($m('#StarContainer'+tag_id).length > 0)
                    {
                        $m('#StarContainer'+tag_id).hide();
                    }
                    break;
            }
        }
    },

    anchorLabelCreate:function(responseStr)
    {
        //var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
        //if (obj.ret == 0) {
        var obj = [{"anchor_label_string":"全部"},{"anchor_label_string":"星级主播"},{"anchor_label_string":"人气主播"},{"anchor_label_string":"新星主播"}];
        //var _roomList = obj.rooms;
        var _roomList = obj;
        if (_roomList.length == 0) {
            isSteep = true;
            scroll_load_toggle(false, "已经没有直播了哦");
            return;
        }
        var anchorLabelCon = $m('#anchorLabelTmpl');
        var anchorLabelTmpl;
        var anchor_label = $m('#anchor_label');
        if (typeof anchor_label.data('showlist') == 'undefined' && _roomList.length > 0) {
            console.log('全部主播房间数据已缓存');
            anchor_label.data('showlist', responseStr);//缓存
        }
        anchorLabelTmpl = anchorLabelCon.tmpl(_roomList);
        anchorLabelTmpl.appendTo(anchor_label);
        //}
        //else {
        //    //异常
        //}
        anchorLabelTmpl = null;
        anchorLabelCon = null;
    },

    //=============星级主播==============
    StarShowCallBack: function (responseStr) {
        var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
        if (obj.ret == 0) {
            var _roomList = obj.rooms;
            if (_roomList.length == 0) {
                isSteep = true;
                scroll_load_toggle(false, "已经没有直播了哦");
                return;
            }
            var starListCon = $m('#starListTmpl');
            var starListTmpl;
            var starContainer = $m('#allContainer');
            if (typeof starContainer.data('showlist') == 'undefined' && _roomList.length > 0) {
                console.log('星级主播数据已缓存');
                starContainer.data('showlist', responseStr);//缓存
            }
            if (pageIndex == 0)
                starContainer.children().remove();
            starListTmpl = starListCon.tmpl(_roomList);
            starListTmpl.appendTo(starContainer);
            console.log("直播列表回调：" + responseStr);
            pageIndex++; isSteep = true;
            $m("#show_tab").find("li a").eq(pageNum).attr("pageIndex", pageIndex);
            //js实现旋转 
            starContainer.find(".allListA").rotate({
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
            starListTmpl = null;
            starListCon = null;
        } else {
            //异常
        }
        isSteep = true;
        scroll_load_toggle(false);
    },

    //=============人气主播==============
    PopShowCallBack: function (responseStr) {
        var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
        if (obj.ret == 0) {
            var _roomList = obj.rooms;
            if (_roomList.length == 0) {
                isSteep = true;
                scroll_load_toggle(false, "已经没有直播了哦");
                return;
            }
            var popularListCon = $m('#popularListTmpl');
            var popularListTmpl;
            var popularContainer = $m('#allContainer');
            if (typeof popularContainer.data('showlist') == 'undefined' && _roomList.length > 0) {
                console.log('人气主播数据已缓存');
                popularContainer.data('showlist', responseStr);//缓存
            }
            if (pageIndex == 0)
                popularContainer.children().remove();
            popularListTmpl = popularListCon.tmpl(_roomList);
            popularListTmpl.appendTo(popularContainer);
            console.log("直播列表回调：" + responseStr);
            pageIndex++; isSteep = true;
            $m("#show_tab").find("li a").eq(pageNum).attr("pageIndex", pageIndex);
            //js实现旋转 
            popularContainer.find(".allListA").rotate({
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
            popularListTmpl = null;
            popularListCon = null;
        } else {
            //异常
        }
        isSteep = true;
        scroll_load_toggle(false);
    },

    //=============新星主播==============
    NewShowStarCallBack: function (responseStr) {
        var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
        if (obj.ret == 0) {
            var _roomList = obj.rooms;
            if (_roomList.length == 0) {
                isSteep = true;
                scroll_load_toggle(false, "已经没有直播了哦");
                return;
            }
            var newStarListCon = $m('#newStarListTmpl');
            var newStarListTmpl;
            var newStarContainer = $m('#allContainer');
            if (typeof newStarContainer.data('showlist') == 'undefined' && _roomList.length > 0) {
                console.log('新星主播数据已缓存');
                newStarContainer.data('showlist', responseStr);//缓存
            }
            if (pageIndex == 0)
                newStarContainer.children().remove();
            newStarListTmpl = newStarListCon.tmpl(_roomList);
            newStarListTmpl.appendTo(newStarContainer);
            console.log("直播列表回调：" + responseStr);
            pageIndex++; isSteep = true;
            $m("#show_tab").find("li a").eq(pageNum).attr("pageIndex", pageIndex);
            //js实现旋转 
            newStarContainer.find(".allListA").rotate({
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
            newStarListTmpl = null;
            newStarListCon = null;
        } else {
            //异常
        }
        isSteep = true;
        scroll_load_toggle(false);
    }
};

$m.extend(MGC_CommRequest, MGC_SpecialRequest);
$m.extend(MGC_CommResponse, MGC_SpecialResponse);


var MGC_Response = function (responseStr) {
    var _repStr = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr), _category = _repStr.category;
    MGC_CommResponse.AllShowCallBack(_repStr,true);
}

//本页需要回调加载的功能
var loginCallBack = function () {

    //myTabCut('show_tab','show_con');
    var url = location.href, start = url.indexOf("#"), end = start > 0 ? parseInt(url.substr(start + 1)) : 0;
    pageNum = end;
    //获取标签列表
    MGC_CommResponse.requestLabel();
    //MGC.tabCutNoHide("show_tab", "show_con", end);
    //toDoShowList(-1);
    MGCLoginRequest.getCardInfo();//加载右上角个人信息
    scrollFun();
}
var toDoShowList = function (num) {

    MGC_CommResponse.requestStarCallBack1(num,1);
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
            var _con = $m("#" + con).find("ul").eq(0);
            //if (tabArr.eq(index).attr("pageIndex") != undefined) {
            //    _con.show();
            //    isSteep = true;
            //    return;
            //}
            isSteep = false;
            scroll_load_toggle(true);
            if (typeof (_con.data('showlist'+pageNum)) != 'undefined') {
                console.log('使用缓存数据');
                MGC_CommResponse.AllShowCallBack(_con.data('showlist'+pageNum),false);
            } else {
                //无缓存则发送请求
                switch (pageNum) {
                    case 0: MGC_CommRequest.showList(1); break;//加载全部房间
                    case 1: MGC_CommRequest.showList(5); break;//加载星级
                    case 2: MGC_CommRequest.showList(3); break;//加载人气
                    case 3: MGC_CommRequest.showList(4); break;//加载新星
                    default: MGC_CommRequest.showList(1); break;
                }
            }
            _con.show();
        })
    })
}
var pageNum = 0, pageIndex = 0; isSteep = false;
var scrollFun = function () {
    $m(window).scroll(function () {
        if (!isSteep)
            return;
        var scrollTop = $m(this).scrollTop();
        var scrollHeight = $m(document).height();
        var windowHeight = $m(this).height();
        if (scrollTop + windowHeight == scrollHeight) {
            toDoShowList(tag_id);
        }
    });
}

/*  |xGv00|91a2dce4238f4785f586869e3acff4a3 */
