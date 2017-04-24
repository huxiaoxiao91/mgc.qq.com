/*
 * Created by wangjian
 * 礼物tips
 */

var GiftTip2 = {
    show:function(data){

        var container = $m('.gifttip');

        if(data.visible)
        {
            var con = $m('#giftTipTmpl');

            if(data.id !=43 && data.type != 5 && data.type != 6 && data.price != 0)
            {
                data.intro = data.intro.substring(0,data.intro.length-1);
                data.intro = (data.intro + "。");
            }

            var tmpl = con.tmpl(data);
            container.html("").append(tmpl);
            //container.show();
            window.mgc.popmanager.layerControlShow(container,1,3);

            //礼物图上下居中
            $m('.gifttip>div.first-child').css("padding-top",(container.height() - 50)/2);

            //礼物位置
            var top = $m("#GiftSwf").offset().top;
            var left = $m("#GiftSwf").offset().left;

            //礼物插件长宽
            var giftHeight = $m("#GiftSwf").height();

            //tip长宽
            var w = container.width();
            var h = container.height();

            //礼物区内位置
            var x = data.mouseX + 120;
            var y = data.mouseY;
            container.offset({ top: top + giftHeight - 85 - h, left: left + x - w/2 });
            tmpl = null;
            con = null;
        }
        else
        {
            //container.hide();
            window.mgc.popmanager.layerControlHide(container,1,3);
        }
    }
};


var GiftRankPane = {

    //主播周星礼物数据
    data:[],

    anchor_id:"",

    init:function(){

        $m(".giftrank .close").click(this,this.onClose);
        //缩放规则写入room_entry
        //$m(window).resize(this.onResize);
    },

    onResize:function(e){
        //礼物插件位置
        var top = $m("#GiftSwf").offset().top;
        var left = $m("#GiftSwf").offset().left;

        //礼物插件长宽
        var giftWidth = $m("#GiftSwf").width();
        var giftHeight = $m("#GiftSwf").height();

        var container1 = $m('.giftrank');
        var w1 = container1.width();
        var h1 = container1.height();
        container1.offset({ top: top + giftHeight - 85 - h1, left: left });

        var container2 = $m('.giftquick');
        var w2 = container2.width();
        var h2 = container2.height();
        container2.offset({ top: top + giftHeight - 85 - h2, left: left + 310 });
    },

    //获取某个id的主播周星礼物数据
    getdata:function(id){
        var data;
        for(var i = 0;i<this.data.length;i++)
        {
            if(this.data[i].gift_id == id)
            {
                data = this.data[i];
            }
        }
        return data;
    },

    //显示周星礼物排行
    show:function(b){
        var container = $m('.giftrank');

        if(b)
        {
            //是否游客
            if (MGC_Comm.CheckGuestStatus(false)) return;

            $m(document).off().mousedown(this,this.onDocument);

            //礼物插件位置
            var top = $m("#GiftSwf").offset().top;
            var left = $m("#GiftSwf").offset().left;

            //礼物插件长宽
            var giftHeight = $m("#GiftSwf").height();

            //tip长宽
            var w = container.width();
            var h = container.height();

            //container.show();
            window.mgc.popmanager.layerControlShow(container,1,4);
            container.offset({ top: top + giftHeight - 85 - h, left: left });

            this.getGiftList();
        }
        else{
            window.mgc.popmanager.layerControlHide(container,1,4);
        }

    },

    onClose:function(e){
        var _this = e.data;
        _this.show(false);
        GiftQuickPane.show(false);
    },

    onGift:function(e){
        var $li = $m(e.currentTarget);
        var id = $li.data("id");

        var _this = e.data;
        var data = _this.getdata(id);
        GiftQuickPane.show(true,data);
    },

    onDocument:function(e){
        var _this = e.data;

        if(($m(e.target).parents(".giftrank").length == 0 && !$m(e.target).is(".giftrank")) && ($m(e.target).parents(".giftquick").length == 0 && !$m(e.target).is(".giftquick")))
        {
            _this.show(false);
            GiftQuickPane.show(false);
            return;
        }

        if(($m(e.target).parents(".giftrank .giftlist").length == 0 && !$m(e.target).is(".giftrank .giftlist")) && ($m(e.target).parents(".giftquick").length == 0 && !$m(e.target).is(".giftquick")))
        {
            GiftQuickPane.show(false);
            return;
        }
    },

    //加载主播周星数据
    getGiftList:function(){
        var _repStr = {};
        _repStr.op_type = 273;
        _repStr.m_anchor_id = MGCData.anchorID;
        MGC_Comm.sendMsg(_repStr, "GiftRankPane.getGiftListCallBack");

        var giftListContainer = $m(".giftrank ul");
        giftListContainer.children().remove();
    },

    //加载主播周星数据回调
    getGiftListCallBack:function(responseStr) {
        var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
        console.log("周星礼物面板："+JSON.stringify(obj));
        //console.log("主播周星礼物："+JSON.stringify(obj.star_gifts));
        //console.log("主播周星赛成绩："+ JSON.stringify(obj.match_info));

        GiftRankPane.data = obj.star_gifts;
        GiftRankPane.anchor_id = obj.anchor_id;

        var week_star_medals = obj.match_info.week_star_medals || [];
        var grade_name="";
        $.each(week_star_medals ,function(k,v){
            if(v.grade == obj.match_info.grade){
                grade_name = v.grade_name;
            }
        });
        obj.match_info.grade_name = grade_name;
        $.each(obj.star_gifts,function(k,v){
            v.gift_cnt = v.gift_cnt > 99999999 ? 99999999:v.gift_cnt;
            v.gift_count_diff = v.gift_count_diff > 99999999 ? 99999999:v.gift_count_diff;
            v.last_anchor_rank = v.last_anchor_rank > 9999 ? 9999:v.last_anchor_rank;
            v.rank = v.rank > 9999 ? 9999:v.rank;
        });
        var giftListContainer = $m(".giftrank ul");
        var giftRankCon = $m('#giftRankTmpl');
        var starWeekResult = $m('#starWeekResult');
        var giftRankTmpl;

        if(obj.match_info && obj.match_info.status==0 ){ //status为0，表示主播参加周星赛
            starWeekResult.show();
            obj.match_info.sub_level_array = (obj.match_info.sub_level + "").split("");
            obj.match_info.total_score = obj.match_info.total_score > 999999 ? "999999+": obj.match_info.total_score;
            obj.match_info.total_rank = obj.match_info.total_rank > 9999 ? "9999+": obj.match_info.total_rank;
            obj.match_info.sub_rank = obj.match_info.sub_rank > 9999 ? "9999+": obj.match_info.sub_rank;
            var starWeekResultTmp = $m('#starWeekResultTmp').tmpl(obj.match_info);
            starWeekResult.children().remove();
            starWeekResultTmp.appendTo(starWeekResult);
        }else{//status为2，主播未参加周星赛
            starWeekResult.hide();
        }
        this.onResize();
        giftListContainer.children().remove();
        giftRankTmpl = giftRankCon.tmpl(obj.star_gifts);
        giftRankTmpl.appendTo(giftListContainer);

        //头像
        $m(".giftrank .avatar").attr("src",obj.url);

        giftListContainer.find("li").click(this,this.onGift);
        giftRankTmpl = null;
        giftRankCon = null;
    }

}


var GiftQuickPane = {

    data: {},

    againData: {},

    maxCount: 1,

    init: function() {
        $m(".giftquick .choosecount").click(this, this.onShowCount);
        $m(".giftquick .send").click(this, this.onSend);
        //礼物数量文本变化
        $m(".giftquick .count").keyup(this, this.changeCount);
    },

    changeCount: function(e) {
        var $input = $m(e.currentTarget);
        var _this = e.data;

        //数量超过上限时显示最大值
        if ($input.val() > _this.maxCount) {
            $input.val(_this.maxCount);
        }

        //输入为空时显示默认值0
        if ($input.val() == "" || $input.val()==0 ) {
            $input.val(1);
        }

        //过滤数字前的0
        var value = parseInt($input.val());
        $input.val(value);

        //总价
        $m(".giftquick .price").html($input.val() * _this.data.gift_price);
    },

    //显示快捷送礼
    show: function(b, data) {
        var container = $m('.giftquick');

        if (b) {
            this.data = data;
            this.maxCount = data.drop_list[data.drop_list.length - 1].count;

            container.find("img").attr("src", data.gift_icon);
            container.find(".giftname").html(data.gift_name);
            container.find(".price").html(data.gift_price);
            container.find(".count").val(1);

            //炫豆or梦幻币
            if (data.gift_id == 30 || data.gift_id == 31 || data.gift_id == 32) {
                container.find(".icon_coin").removeClass().addClass("icon_coin icon_coin_1");
            }
            else {
                container.find(".icon_coin").removeClass().addClass("icon_coin");
            }

            var countlist = container.find(".countlist ul");
            var countlistCon = $m('#countlistTmpl');
            var countlistTmpl;
            countlist.children().remove();
            countlistTmpl = countlistCon.tmpl(data.drop_list);
            countlistTmpl.appendTo(countlist);
            countlist.find("li").click(this, this.onCount);

            this.showCount(false);

            //礼物插件位置
            var top = $m("#GiftSwf").offset().top;
            var left = $m("#GiftSwf").offset().left;

            //礼物插件长宽
            var giftHeight = $m("#GiftSwf").height();

            //tip长宽
            var w = container.width();
            var h = container.height();

            window.mgc.popmanager.layerControlShow(container, 1, 5);
            container.offset({ top: top + giftHeight - 85 - h, left: left + 310 });
            countlistTmpl = null;
            countlistCon = null;
        }
        else {
            window.mgc.popmanager.layerControlHide(container, 1, 5);
        }

    },

    onCount: function(e) {
        var $li = $m(e.currentTarget);
        var num = $li.data("count");
        var _this = e.data;

        $m(".giftquick .count").val(num);
        //alert(num);

        _this.showCount(false);

        //总价
        $m(".giftquick .price").html(num * _this.data.gift_price);
    },

    onShowCount: function(e) {
        var $countlist = $m(".giftquick .countlist");

        var visible = $countlist.data("visible");

        var _this = e.data;

        _this.showCount();
    },

    showCount: function(b) {
        var $countlist = $m(".giftquick .countlist");
        var visible = $countlist.data("visible");
        if (b != null) {
            visible = !b;
        }

        if (visible) {
            $countlist.hide();
        }
        else {
            $countlist.show();
        }

        $countlist.data("visible", !visible);

        var height = $countlist.height();
        $countlist.css("top", 140 - height);
    },

    onSend: function(e) {
        //是否游客
        if (MGC_Comm.CheckGuestStatus(false)) return;

        var _this = e.data;

        _this.sendGift(GiftRankPane.anchor_id, _this.data.gift_id, $m(".giftquick .count").val(), true);
    },

    showSendAgainTip: function(data) {
        this.againData = data;

        var dialog = {};
        dialog.Title = '提示信息';
        dialog.BtnNum = 2;
        dialog.BtnName = '赠送';
        dialog.BtnName2 = '取消';
        dialog.Note = '周星礼物已经更换啦！是否继续赠送？';
        MGC_Comm.CommonDialog(dialog, this.sendGiftAgain);
    },

    sendGiftAgain: function() {
        GiftQuickPane.sendGift(GiftRankPane.anchor_id, GiftQuickPane.againData.gift_id, GiftQuickPane.againData.gift_cnt, false);
    },

    sendGift: function(anchorID, gift_id, gift_cnt, star_gift) {
        var _repStr = {};
        _repStr.op_type = 19;
        _repStr.anchorID = anchorID;
        _repStr.gift_id = gift_id;
        _repStr.gift_cnt = gift_cnt;
        _repStr.star_gift = star_gift;
        MGC_Comm.sendMsg(_repStr);
    }
}

//<!-- 梦幻宝箱 -->
var DreamBox = {

    /*
     * 宝箱id
     */
    id:0,

    /*
     * 宝箱状态
     * 0:隐藏
     * 1:倒计时
     * 2:可领取
     * 3:已领取
     */
    status:0,

    /*
     * 宝箱数量
     */
    count:0,

    /*
     * 倒计时时间 秒
     */
    leftTime:0,

    /*
     * 是否倒计时
     */
    isCutDown:false,

    init:function(){
        $m(".dreambox").mouseover(this,this.onOver);
        $m(".dreambox").mouseout(this,this.onOut);

        //$m(".dreambox").click(this,this.onGrab);

        //this.initflash();

        //$m(window).resize(this.onResize);
        //this.setStatus(0);
        //this.onResize();
    },

    initflash:function(){
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
        attributes.id = "dreamBoxContent";
        attributes.name = "dreamBoxContent";
        attributes.align = "middle";

        var swfurl = "http://ossweb-img.qq.com/images/mgc/css_img/swf/dreambox.swf?v=3_8_8_2016_15_4_final_3_" + (new Date()).getTime();

        if (MGC.checkIsIEloadSwfFailed())
            swfurl += "&r=" + new Date();
        swfobject.embedSWF(swfurl, "dreamBoxContent", "100%", "100%",
            swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);
    },

    onResize:function(){
        //礼物插件位置
        var top = $m("#GiftSwf").offset().top;
        var left = $m("#GiftSwf").offset().left;

        //礼物插件长宽
        var giftWidth = $m("#GiftSwf").width();
        var giftHeight = $m("#GiftSwf").height();

        var container3 = $m('.dreambox');
        var w3 = container3.width();
        var h3 = container3.height();
        container3.offset({ top: top + 45, left: left + giftWidth - w3 - 25 });
    },

    onOver:function(e){
        _this = e.data;
        _this.showTip(true);
    },

    onOut:function(e){
        _this = e.data;
        _this.showTip(false);
    },

    onGrab:function(e){
        _this = e.data;

        if(_this.status == 2)
        {
            _this.grab();
        }
    },

    showTip:function(b,stageY){
        $dreamboxtip = $m(".dreamboxtip");
        if(b)
        {
            if(this.status == 1)
            {
                $dreamboxtip.find(".text").html("梦幻宝箱还在倒计时中，请再耐心等一会儿哦~");
            }
            else if(this.status == 3 && this.count > 1){
                $dreamboxtip.find(".text").html("点券被抢完或过期后，方可开启后续梦幻宝箱。");
            }
            else{
                return;
            }

            window.mgc.popmanager.layerControlShow($dreamboxtip,1,3);

            //梦幻宝箱位置
            //var top = $m(".dreambox").offset().top;
            //var left = $m(".dreambox").offset().left;

            //梦幻宝箱高度
            //var boxHeight = $m(".dreambox").height();

            //礼物插件位置
            var top = $m("#GiftSwf").offset().top;
            var left = $m("#GiftSwf").offset().left;

            //礼物插件长宽
            var giftWidth = $m("#GiftSwf").width();
            var giftHeight = $m("#GiftSwf").height();

            //tip长宽
            var w = $dreamboxtip.width();
            var h = $dreamboxtip.height();

            //$dreamboxtip.offset({ top: top - h, left: left});
            $dreamboxtip.offset({ top: top - h + stageY - 50, left: left + giftWidth - 100});

        }
        else{
            window.mgc.popmanager.layerControlHide($dreamboxtip,1,3);
        }
    },

    //设置宝箱数量
    setCount:function(count){
        this.count = count;

        getSWF("GiftSwf").setCount(count);

        if(count == 0)
        {
            this.setStatus(0);
        }

        //$m(".dreambox .count").html(count);
    },

    //设置宝箱状态
    setStatus:function(status){
        this.status = status;

        getSWF("GiftSwf").setStatus(status);
    },

    //设置新老角色
    setRole:function(b){
        getSWF("GiftSwf").setRole(b);
    },

    //倒计时
    countDown:function(){
        //可领取
        if(this.leftTime == 0)
        {
            if(this.count == 0)
            {
                this.setStatus(0);
            }
            else{
                this.setStatus(2);
            }

            this.isCutDown = false;
            return;
        }

        this.isCutDown = true;
        this.leftTime --;
        //$m(".dreambox .time").html(this.getTimeStr(this.leftTime));
        getSWF("GiftSwf").setTime(this.getTimeStr(this.leftTime));
        setTimeout('DreamBox.countDown()',1000);
    },

    getTimeStr:function(num){
        var min = parseInt(num/60);

        if(min < 10)
        {
            min = "0" + min;
        }

        var sec = parseInt(num%60);

        if(sec < 10)
        {
            sec = "0" + sec;
        }

        return min + ":" +sec;
    },

    //抢宝箱
    grab:function(){
        //是否游客
        if (MGC_Comm.CheckGuestStatus(false)) return;

        this.setStatus(3);

        var _repStr = {};
        _repStr.op_type = OpType.GrabDreamBox;
        _repStr.box_id = this.id;
        MGC_Comm.sendMsg(_repStr,"DreamBox.grabCallBack");
    },

    //抢宝箱回调
    grabCallBack:function(obj){

        DreamBoxRecord.id = obj.box_id;

        switch (parseInt(obj.res)) {
            case 0:
                DreamBoxPop.show(true,obj);
                break;

            case 2:
                DreamBoxPop.show(true,obj);
                break;

            default :
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '手慢了，宝箱已经被抢光了！';
                MGC_Comm.CommonDialog(dialog);
                break;
        }
    },

    //发布梦幻宝箱通知
    getDreamBoxCallBack:function(obj){

        this.getDreamBoxCallBackObj = obj;
        try{
            getSWF("GiftSwf").setData(obj);
        }catch(e)
        {
            return;
        }

        this.setCount(obj.box_count);
        this.id = obj.info.box_id;
        //$m(".dreambox .reward").html(obj.info.total_money);

        //已领取
        if(obj.info.has_grabbed)
        {
            //this.setStatus(3);
            this.status = 3;
            return;
        }

        //可领取
        if(obj.info.count_down <= 0)
        {
            //this.setStatus(2);
            this.status = 2;
            return;
        }

        //倒计时
        //this.setStatus(1);
        this.status = 1;
        this.leftTime = obj.info.count_down;
        if(!this.isCutDown)
        {
            this.countDown();
        }
    },

    //刷新梦幻宝箱数量回调
    setCountCallBack:function(obj){
        this.setCount(obj.box_count);
    },

    getDreamBoxCallBackObj:null,
    //梦幻宝箱加载成功后调用
    initComplete:function(){
        if(this.getDreamBoxCallBackObj != null)
        {
            //getSWF("GiftSwf").setData(this.getDreamBoxCallBackObj);
            this.getDreamBoxCallBack(this.getDreamBoxCallBackObj);
        }
    }
}

//<!-- 梦幻宝箱提示框 -->
var DreamBoxPop = {

    //计时器id
    id:0,

    leftTime:0,

    maxTime:30,

    show:function(b,data){
        var $dreamboxpop = $m(".dreamboxpop");

        if(b)
        {
            if(data.res == 0)
            {
                if(data.money_type == 0)
                {
                    if(window.mgc.config.channel == 0){
                        $m(".dreamboxpop .text").html("恭喜你抢到了<span style='color:#ee5f38'>点劵X" + data.money_count + "</span>已发到您的<span style='color:#ee5f38'>游戏账户</span>内");
                    } else{
                        $m(".dreamboxpop .text").html("恭喜你抢到了<span style='color:#ee5f38'>点劵X" + data.money_count + "</span>已发到您的<span style='color:#ee5f38'>游戏账户</span>内，可通过游戏内邮件来进行收取。");
                    }
                }
                else if(data.money_type == 1){
                    $m(".dreamboxpop .text").html("恭喜你抢到了<span style='color:#ee5f38'>梦幻币X" + data.money_count + "</span>");
                }
            }
            else if(data.res == 2){
                $m(".dreamboxpop .text").html("手慢了哦，已经被抢完啦");
            }

            this.leftTime = this.maxTime;
            $m(".dreamboxpop .countdown span").html(this.maxTime);

            $dreamboxpop.find(".btn_record").click(this,this.onRecord);
            $dreamboxpop.find(".btn_close").click(this,this.onClose);
            $dreamboxpop.find(".pop_close").click(this,this.onClose);

            clearInterval(this.id);
            this.id = setInterval(this.nextTime,1000);

            //if ($m("#_overlay_").length == 0)
            //   $m("body").append('<div id="_overlay_" style="border-top-width: 1px; border-top-style: solid; border-top-color: rgb(17, 17, 17); position: fixed; height: ' + $m(document).height() + 'px; z-index: 90000; width: 100%; left: 0px; top: 0px; opacity: 0.5;filter:alpha(opacity=50); background-color: rgb(17, 17, 17);"></div>');
            window.mgc.popmanager.layerControlShow($dreamboxpop,4,1);
        }
        else{

            $dreamboxpop.find(".btn_record").off();
            $dreamboxpop.find(".btn_close").off();
            $dreamboxpop.find(".pop_close").off();
            clearInterval(this.id);

            //if ($m("#_overlay_").length == 0)
            //    $m("body").append('<div id="_overlay_" style="border-top-width: 1px; border-top-style: solid; border-top-color: rgb(17, 17, 17); position: fixed; height: ' + $m(document).height() + 'px; z-index: 90000; width: 100%; left: 0px; top: 0px; opacity: 0.5;filter:alpha(opacity=50); background-color: rgb(17, 17, 17);"></div>');
            window.mgc.popmanager.layerControlHide($dreamboxpop,4,1);
        }
    },

    onRecord:function(e){
        _this = e.data;
        _this.show(false);
        DreamBoxRecord.show(true);
    },

    onClose:function(e){
        _this = e.data;
        _this.show(false);
    },

    nextTime:function(){
        DreamBoxPop.leftTime --;

        if(DreamBoxPop.leftTime == 0)
        {
            DreamBoxPop.show(false);
            return;
        }

        $m(".dreamboxpop .countdown span").html(DreamBoxPop.leftTime);
    }
}



//<!-- 梦幻宝箱记录提示框 -->
var DreamBoxRecord = {

    id:0,
    currentPage:1,
    totalPage:1,

    tempPage:0,
    tempData:{},

    //是否在加载
    isLoad:false,

    show:function(b){
        var $dreamboxrecord = $m(".dreamboxrecord");

        if(b)
        {
            this.setPage(1,1);
            this.getDreamBoxRecord();

            $dreamboxrecord.find(".btn_close").click(this,this.onClose);
            $dreamboxrecord.find(".pop_close").click(this,this.onClose);
            //if ($m("#_overlay_").length == 0)
            //    $m("body").append('<div id="_overlay_" style="border-top-width: 1px; border-top-style: solid; border-top-color: rgb(17, 17, 17); position: fixed; height: ' + $m(document).height() + 'px; z-index: 90000; width: 100%; left: 0px; top: 0px; opacity: 0.5;filter:alpha(opacity=50); background-color: rgb(17, 17, 17);"></div>');
            window.mgc.popmanager.layerControlShow($dreamboxrecord,4,1);
            $dreamboxrecord.centerDisp();
        }
        else{

            this.tempPage = 0;
            this.tempData = {};

            $m('.dreamboxrecord .recordlist ul').children().remove();

            $dreamboxrecord.find(".btn_close").off();
            $dreamboxrecord.find(".pop_close").off();
            //if ($m("#_overlay_").length == 0)
            //    $m("body").append('<div id="_overlay_" style="border-top-width: 1px; border-top-style: solid; border-top-color: rgb(17, 17, 17); position: fixed; height: ' + $m(document).height() + 'px; z-index: 90000; width: 100%; left: 0px; top: 0px; opacity: 0.5;filter:alpha(opacity=50); background-color: rgb(17, 17, 17);"></div>');
            window.mgc.popmanager.layerControlHide($dreamboxrecord,4,1);
        }
    },

    onPre:function(e){
        _this = e.data;

        if(_this.isLoad)return;

        _this.currentPage --;
        _this.getDreamBoxRecord();
    },

    onNext:function(e){
        _this = e.data;

        if(_this.isLoad)return;

        _this.currentPage ++;
        _this.getDreamBoxRecord();
    },

    onClose:function(e){
        _this = e.data;
        _this.show(false);
    },


    setPage:function(currentPage,totalPage){
        this.currentPage = currentPage;
        this.totalPage = totalPage;

        var $btn_pre = $m(".dreamboxrecord .btn_pre");
        $btn_pre.removeClass();
        var $btn_next = $m(".dreamboxrecord .btn_next");
        $btn_next.removeClass();

        if(currentPage == 1)
        {
            $btn_pre.addClass("btn_pre btn_pre_disable");
            $btn_pre.off();
        }
        else{
            $btn_pre.addClass("btn_pre");
            $btn_pre.off().click(this,this.onPre);
        }

        if(currentPage == totalPage)
        {
            $btn_next.addClass("btn_next btn_next_disable");
            $btn_next.off();
        }
        else{
            $btn_next.addClass("btn_next");
            $btn_next.off().click(this,this.onNext);
        }

        $m(".dreamboxrecord .page .text").html(currentPage + "/" + totalPage);
    },

    //拉取梦幻宝箱记录
    getDreamBoxRecord:function(){

        this.isLoad = true;

        //是否拉取缓存数据
        if(this.currentPage < this.tempPage)
        {
            this.getDreamBoxRecordCallBack1(this.tempData[this.currentPage]);
            return;
        }

        var _repStr = {};
        _repStr.op_type = OpType.GetDreamBoxRecord;
        _repStr.box_id = this.id;
        _repStr.index = this.currentPage;
        MGC_Comm.sendMsg(_repStr,"DreamBoxRecord.getDreamBoxRecordCallBack");
    },

    getDreamBoxRecordCallBack:function(obj){

        this.clear();
        this.isLoad = false;

        //判断是否失效
        if(obj.res != 0)
        {
            //更新缓存的总页数
            $m.each(this.tempData, function(k, v) {
                v.tolcnt = DreamBoxRecord.tempPage;
            });

            //设为最后一页
            this.setPage(this.tempPage,this.tempPage);

            this.getDreamBoxRecordCallBack1(this.tempData[this.tempPage]);
            return;
        }

        this.setPage(this.currentPage,obj.tolcnt);

        //加入缓存
        if(this.currentPage > this.tempPage)
        {
            this.tempPage = this.currentPage;
        }
        this.tempData[this.currentPage] = obj;

        //更新缓存的总页数
        $m.each(this.tempData, function(k, v) {
            v.tolcnt = obj.tolcnt;
        });

        $m(".dreamboxrecord .info .name i").html(obj.player_name);
        $m(".dreamboxrecord .info .reward_count i").html(obj.grab_count);
        $m(".dreamboxrecord .info .count i").html(obj.total_money + "点券/" + obj.total_money * obj.video_money_rate + "梦幻币");

        //奖励类型
        $m.each(obj.vecs, function (index, value) {
            if(value.money_type == 1)
            {
                value.money = value.money * obj.video_money_rate;
            }
            value.money_str = (value.money_type == 0?"点券":"梦幻币");
        });

        var con = $m('#dreamboxrecordlistTmpl');
        var tmpl;
        var container = $m('.dreamboxrecord .recordlist ul');
        container.children().remove();
        tmpl = con.tmpl(obj.vecs);
        tmpl.appendTo(container);
        tmpl = null;
        con = null;
    },

    //缓存数据处理
    getDreamBoxRecordCallBack1:function(obj){

        this.clear();
        this.isLoad = false;

        this.setPage(this.currentPage,obj.tolcnt);

        $m(".dreamboxrecord .info .name i").html(obj.player_name);
        $m(".dreamboxrecord .info .reward_count i").html(obj.grab_count);
        $m(".dreamboxrecord .info .count i").html(obj.total_money + "点券/" + obj.total_money * obj.video_money_rate + "梦幻币");

        var con = $m('#dreamboxrecordlistTmpl');
        var tmpl;
        var container = $m('.dreamboxrecord .recordlist ul');
        container.children().remove();
        tmpl = con.tmpl(obj.vecs);
        tmpl.appendTo(container);
        tmpl = null;
        con = null;
    },

    clear:function(){
        $m(".dreamboxrecord .info .name i").children().remove();
        $m(".dreamboxrecord .info .reward_count i").children().remove();
        $m(".dreamboxrecord .info .count i").children().remove();
        $m('.dreamboxrecord .recordlist ul').children().remove();
    }
}

//<!-- 梦幻宝箱飞屏 -->
//火箭飞屏移植到MGC_Comm.addRocketScreenMsg方法实现
/*
var DreamFly = {

    flyArr:[],

    isPlay:false,

    add:function(data){
        this.flyArr.push(data);

        this.play();
    },

    play:function(){
        if(this.isPlay)return;

        if(this.flyArr.length == 0)return;

        this.isPlay = true;

        //var $dreamflyContainer = $m(".dreamflyContainer");
        //$dreamflyContainer.show();
        var sLeft;
        if (document.compatMode == "BackCompat") {
            sLeft = document.body.scrollLeft;
        }
        else { //document.compatMode == \"CSS1Compat\" 
            sLeft = document.documentElement.scrollLeft == 0 ? document.body.scrollLeft : document.documentElement.scrollLeft;
        }
        var data = this.flyArr.shift();
        var dreamFlyTmpl = $m('#dreamFlyTmpl');
        var $dream = dreamFlyTmpl.tmpl(data).appendTo($m("#content"));
        var contentLeft = -1400 - $m("#content")[0].offsetLeft;
        $dream.css({left:$m(window).width()-$m("#content")[0].offsetLeft+sLeft,top:45});
        $dream.click(this.onClick);

        $dream.animate({ "left": contentLeft}, 20000, "linear", function () {
            $m(this).remove();

            // if(DreamFly.flyArr.length == 0 && $dreamflyContainer.find(".dreamfly").length == 0)
            // {
            //     $m(window).off("resize",DreamFly.onResize);
            //     $dreamflyContainer.hide();
            // }
        });

        setTimeout('DreamFly.next()', 8000);

        //$m(window).resize(this.onResize);
        //this.onResize();
    },

    //宽度和窗口一致
    onResize:function(e){
        $m(".dreamflyContainer").width($m(document).width());
        //$m(".dreamflyContainer").offset({left:0});
    },

    next:function(){
        this.isPlay = false;
        this.play();
    },

    onClick:function(e){

        //是否游客
        if (MGC_Comm.CheckGuestStatus(false)) return;

        var $dream = $m(e.currentTarget);
        var room_id = $dream.data("room_id");

        if(room_id != MGCData.roomID)
        {
            //location.href = "transfer.shtml?roomId=" + $dream.data("room_id") + "&source=8";
            if (MgcAPI.SNSBrowser.IsQQGame() || MgcAPI.SNSBrowser.IsX52())
            {
                window.open("transfer.shtml?roomId=" + room_id + "&source=8","_self");
            }
            else{
                window.open("transfer.shtml?roomId=" + room_id + "&source=8");
            }
        }
    }

}
*/


var DreamBoxEffect = {

    //显示火箭礼物特效
    show: function (data) {
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
        attributes.id = "dreamBoxEffect";
        attributes.name = "dreamBoxEffect";
        attributes.align = "middle";

        var swfurl = data.path + "?v=3_8_8_2016_15_4_final_3_" + (new Date()).getTime();

        if (MGC.checkIsIEloadSwfFailed())
            swfurl += "&r=" + new Date();
        swfobject.embedSWF(swfurl, "dreamBoxEffectContent", "100%", "100%",
            swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);

        //$m('.dreamBoxEffect').css("top",$m("#LiveVideoSwfContainer").offset().top);
        window.mgc.popmanager.layerControlShow($m('.dreamBoxEffect'),2,1, null,{ saveFocus: true });

        $m(window).resize(this.onResize);
        //针对于中间模块左右居中
        $m('.dreamBoxEffect').css("left",20 - (1024 - $m(".side-middle").width())/2);

        //演唱会炸弹特殊化处理
        if(filename == "showroom.shtml" && data.giftData.giftItemID == 47)
        {
            var top = $m('.dreamBoxEffect').offset().top;
            $m('.dreamBoxEffect').css("top",top + 50);
        }

        data = null;
    },

    //隐藏特效
    hide: function () {

        window.mgc.popmanager.layerControlHide($m('.dreamBoxEffect'),2,1);

        $m('.dreamBoxEffect').remove();
        $m('.side-middle').append('<div class="dreamBoxEffect" style="display: none;"></div>');
        $m('.dreamBoxEffect').append("<p id='dreamBoxEffectContent'></p>");

        $m(window).off("resize",this.onResize);
    },

    onResize:function(e){
        //针对于中间模块左右居中
        $m('.dreamBoxEffect').css("left",20 - (1024 - $m(".side-middle").width())/2);
    }

}

var DiceEffect = {

    //显示骰子礼物特效
    show: function (data) {
        var swfVersionStr = "11.1.0";
        var xiSwfUrlStr = "playerProductInstall.swf?v=3_8_8_2016_15_4_final_3";
        var flashvars = {};
        //flashvars.m_level = data.giftData.m_level;
        flashvars.m_dice_val_1 = data.giftData.m_dice_val_1;
        flashvars.m_dice_val_2 = data.giftData.m_dice_val_2;
        flashvars.m_dice_val_3 = data.giftData.m_dice_val_3;
        var params = {};
        params.quality = "high";
        params.bgcolor = "#000";
        params.allowscriptaccess = "always";
        params.allowfullscreen = "true";
        params.allowFullScreenInteractive = "true";
        params.wmode = "transparent";
        var attributes = {};
        attributes.id = "dreamBoxEffect";
        attributes.name = "dreamBoxEffect";
        attributes.align = "middle";

        var swfurl = data.playEffectVO.path + "?v=3_8_8_2016_15_4_final_3_" + (new Date()).getTime();

        if (MGC.checkIsIEloadSwfFailed())
            swfurl += "&r=" + new Date();
        swfobject.embedSWF(swfurl, "dreamBoxEffectContent", "100%", "100%",
            swfVersionStr, xiSwfUrlStr, flashvars, params, attributes);

        //$m('.dreamBoxEffect').css("top",$m("#LiveVideoSwfContainer").offset().top);
        window.mgc.popmanager.layerControlShow($m('.dreamBoxEffect'),2,1, null,{ saveFocus: true });

        $m(window).resize(this.onResize);
        //针对于中间模块左右居中
        $m('.dreamBoxEffect').css("left",20 - (1024 - $m(".side-middle").width())/2);

        data = null;
    },

    //隐藏特效
    hide: function () {

        window.mgc.popmanager.layerControlHide($m('.dreamBoxEffect'),2,1);

        $m('.dreamBoxEffect').remove();
        $m('.side-middle').append('<div class="dreamBoxEffect" style="display: none;"></div>');
        $m('.dreamBoxEffect').append("<p id='dreamBoxEffectContent'></p>");

        $m(window).off("resize",this.onResize);
    },

    onResize:function(e){
        //针对于中间模块左右居中
        $m('.dreamBoxEffect').css("left",20 - (1024 - $m(".side-middle").width())/2);
    }

}