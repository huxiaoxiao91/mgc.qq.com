/**
 * Created by WJ on 2016/5/6.
 */

define(['backbone', 'jquery'], function (Backbone,$) {

    var ad = {};

    /**
     * 演唱会粉丝区广告
     */
    ad.ADView = Backbone.View.extend({
        el: ".ad",
        model: ad.ADModel,

        initialize: function () {
            this.model.on("change:uiList", this.uiListChange, this);
            this.model.on("change:index", this.indexChange, this);
            //this.model.on("change:length", this.lengthChange, this);
            this.model.on("change:bgUrl", this.bgUrlChange, this);
        },

        uiListChange: function () {
            var uiList = this.model.get("uiList");

            var listContainer = this.$el.find(".list");
            listContainer.children().remove();
            var adCon = $("#adTmpl");
            var adTmpl;
            adTmpl = adCon.tmpl(uiList);
            adTmpl.appendTo(listContainer);

            /*
            if(this.model.get("type") == 2)
            {
                listContainer.find("li").each(function(index){
                    $(this).css({"z-index":10000+index,"display":"block"});
                });
            }
            */
            var type = this.model.get("type");

            //固定广告数为0时背景不显示
            if(type == 1)
            {
                if(uiList.length == 0)
                {
                    this.$el.hide();
                }
                else{
                    this.$el.show();
                }
            }

            //关闭按钮
            listContainer.find(".close").click(this,this.closeHandler);

            //超链接
            if(type == 2)
            {
                listContainer.find(".link").click(this,this.linkHandler);
                listContainer.find("img").click(this,this.linkHandler);
            }
            //视频区没有鼠标动作
            if(type == 2)return;
            var self = this;
            //滑过
            this.$el.off().mouseenter(function(){
                self.model.stopChange();
            }).mouseleave(function(){
                self.model.startChange();
            });
            adTmpl = null;
            adCon = null;
        },

        closeHandler:function(e){
            var _this = e.data;

            if(_this.model.get("type") == 1)
            {
                _this.model.stopChange();
                _this.$el.remove();
            }
            else{
                _this.model.set("list",[]);
                _this.model.refreshUIList();
            }
        },

        linkHandler:function(e){
            var _this = e.data;

            var id = $(this).data("id");
            //幻灯片不能点击
            if(id == -1)return;

            //广告统计
            var _reqStr = {op_type: 316, ad_type: 2,ad_site:id};
            MGC_Comm.sendMsg(_reqStr);
            
            var link = $(this).data("link");
            var _url = "";
            //判断是否跳转房间
            if(link.indexOf("#entervideoroom:") != -1)
            {
                var roomid = (link.split("#entervideoroom:"))[1];
                _url = "transfer.shtml?source=3&roomId=" + roomid;
                if (mgc.tools.is_in_room_page() || MgcAPI.SNSBrowser.IsQQGame() || MgcAPI.SNSBrowser.IsX52()) {
                    //当前页打开
                    window.location.href = window.mgc.tools.changeUrlToLivearea(_url);
                } else {
                    //新开页打开
                    window.open(_url);
                }
            }
            else{
                _url = $(this).data("link");
                window.open(_url);
            }

        },

        indexChange: function () {
            var index = this.model.get("index");
            var oldindex = this.model.previous("index");

            var $list = this.$el.find(".list li");

            var type = this.model.get("type");
            if(type == 1)
            {
                $list.eq(index).css({"z-index":1});
                $list.eq(index).fadeIn(10);
                if(oldindex != -1)
                {
                    $list.eq(oldindex).css({"z-index":2});
                    $list.eq(oldindex).fadeOut();
                }
                //$list.eq(index).fadeIn();
            }
            else if(type == 2)
            {
                $list.eq(index).css({"z-index":2,"display":"block","height":0});
                $list.eq(index).animate({height:"100%"},1000,function(){
                    //$(this).css({"height":"100%","display":"none"});
                    if(oldindex != -1)
                    {
                        $list.eq(oldindex).css({"z-index":1,"display":"none"});
                    }
                });


                if(oldindex != -1)
                {
                    $list.eq(oldindex).css({"z-index":1,"display":"block"});
                    /*
                    $list.eq(oldindex).animate({height:0},1000,function(){
                        $(this).css({"height":"100%","display":"none"});
                    });
                    */
                }

            }

            var $button = this.$el.find(".button span");
            $button.eq(oldindex).removeClass();
            $button.eq(index).addClass("current");
        },

        lengthChange: function () {
            var length = this.model.get("length");

            var $button = this.$el.find(".button");
            $button.children().remove();

            //1个不显示按钮
            if(length == 1)return;

            for(var i = 0;i<length;i++)
            {
                $button.append("<span data-index=" + i + "></span>");
            }
            $button.find("span").mouseover(this,this.changeIndexHandler);
        },

        changeIndexHandler:function(e){
            var _this = e.data;
            var index = $(this).data("index");
            //_this.model.stopChange();
            _this.model.set("index",index);
        },

        bgUrlChange:function(){
            this.$el.find(".bg").attr("src",this.model.get("bgUrl"));
        }

    });

    ad.ADModel = Backbone.Model.extend({
        defaults: {
            /**
             * 广告列表 UI
             * {id:1,src:"",link:""}
             */
            uiList: [],

            /**
             * 广告列表全部数据
             */
            list:[],

            /**
             * 幻灯片列表
             */
            bgList:[],

            /**
             * 播放索引
             */
            index: -1,

            /**
             * 广告数量
             */
            length:0,

            timeid:0,

            /**
             * 广告类型
             * 1 iframe 2 图片
             */
            type:1,

            /**
             * 背景图地址  不参与轮播的
             */
            bgUrl:""
        },

        /**
         * 设置背景图  不参与轮播的
         */
        setBg:function(url){
            this.set("bgUrl",url);
            this.refreshUIList();
        },

        /**
         * 设置幻灯片
         */
        setBgList:function(list){
            var bgList = [];
            for(var i = 0;i<list.length;i++)
            {
                //id为-1 幻灯片背景
                var obj = {id:-1,type:2,src:"",link:"",startTime:0,endTime:0};
                obj.src = list[i];
                bgList.push(obj);
            }

            this.set("bgList",bgList);
            this.refreshUIList();
        },

        /**
         * 设置广告列表
         * [{id,pic_link,jump_link,begin_time,end_Time}]
         */
        setADList:function(list){

            if(list == null)
            {
                list = [{id:1,src:"http://p.qpic.cn/qdancersec/PiajxSqBRaEI51z8202JrNqTkGmO9SFY2hATFT156JJSMia9GWibkaH6SU9w8N7gU5baicBliakfnuz4/0?v=360442399",link:"http://www.163.com",startTime:0,endTime:25000},
                    {id:2,src:"http://p.qpic.cn/qdancersec/ajNVdqHZLLAIZtciaD4VF2m3R5WiaEVltaHCib3j17ic0TKNMAwqJ1H1jNNp69HwLLYGs96jISCxRiaE/0?v=302620078",link:"http://x5.qq.com/act/a20141219ticket/index.htm?ADTAG=cop.innercop.x5.shipinfangjian&atm_cl=ad&atm_pos=5779&e_code=127472#entervideoroom:520",startTime:10000,endTime:0},
                    {id:3,src:"http://p.qpic.cn/qdancersec/ajNVdqHZLLBtKWrlKgQVWYCQeoMClWFHU6KcPObxuvtDJadGAzovf1K6QzVHzuyQnXADJMDVgUU/0?v=558945269",link:"http://www.163.com",startTime:52000,endTime:1000},
                    {id:4,src:"http://p.qpic.cn/qdancersec/ajNVdqHZLLBiaDbUXKPdj9PVW7icqibxbAsy8SZ54GOVbLKficuDRhkVTT4ZXm3iaXcGibPwB6k9ibq3y4/0?v=255140543",link:"http://www.163.com",startTime:35000,endTime:1000},
                    {id:5,src:"http://p.qpic.cn/qdancersec/ajNVdqHZLLB4MOg6LIeZHlQiavAA3wSibxfB7TY5myUC5YCEZHrrm2HYVKw8IO6z5VZR8LZnKcLQA/0?v=93322051",link:"http://www.163.com",startTime:19000,endTime:1000},
                    {id:6,src:"http://p.qpic.cn/qdancersec/ajNVdqHZLLAFFCQN4VVyaybzaxNxWgBastDBMYrajiaLXthGqtDOzviam7jZQI6mlMuhIqicwPmSGY/0?v=235079790",link:"http://www.163.com",startTime:28000,endTime:1000}];
            }

            /**
             * 转化本地变量
             */
                /*
            var serverList = [];
            for(var i = 0;i<list.length;i++)
            {
                var o = {};
                o.id = list[i].id;
                o.src = list[i].pic_link;
                o.link = list[i].jump_link;
                o.startTime = list[i].begin_time;
                o.endTime = list[i].end_Time;
            }
            */

            var localList = [];
            for(var i = 0;i<list.length;i++)
            {
                list[i].type = this.get("type");
                var model = new ad.ADCellModel(list[i]);
                localList.push(model);
                model.on("show",this.addHandler,this);
                model.on("hide",this.addHandler,this);
            }

            this.set("list",localList);

            this.refreshUIList();
        },

        addHandler:function(id){
            //alert(id);
            this.refreshUIList();
        },

        /**
         * 刷新用于UI的广告列表
         */
        refreshUIList:function(){
            var list = this.get("list");

            var uiList = [];
            //过滤可显示的广告
            $.each(list,function(k,v){
                if(v.get("show"))
                {
                    uiList.push(v.get("obj"));
                }
            });

            //添加幻灯片
            var bgList = this.get("bgList");
            $.each(bgList,function(k,v){
                uiList.push(v);
            });
            
             //强制更新
            if(uiList.length != 0)
            {
                this.set({uiList:[]},{silent:true});
            }

            this.set("uiList",uiList);

            this.set("length",uiList.length);

            //this.set("timeid",0);

            //强制从0开始渲染
            this.set({index:-1},{silent:true});
            this.set("index",0);

            this.stopChange();
            this.startChange();
        },

        startChange:function(){
            var timeid = this.get("timeid");
            if(timeid != 0)
            {
                clearTimeout(timeid);
                var index = this.get("index");
                var nextIndex = ((index + 1) == this.get("length")) ? 0:(index + 1);
                this.set("index",nextIndex);
            }
            timeid = setTimeoutMy(this,this.startChange,3000);
            this.set("timeid",timeid);
        },

        stopChange:function(){
            var timeid = this.get("timeid");
            clearTimeout(timeid);
            this.set("timeid",0);
        }

    });

    ad.ADCellModel = Backbone.Model.extend({
        defaults: {
            obj:{},
            id:0,

            /**
             * 剩余多长时间开始
             */
            startTime:0,

            /**
             * 剩余多时间结束
             */
            endTime:1000,

            /**
             * 是否显示
             */
            show:true
        },

        initialize: function (obj) {
            obj.startTime = obj.startTime > 2147483 ? 2147483 : obj.startTime;
            obj.endTime = obj.endTime > 2147483 ? 2147483 : obj.endTime;

            this.set("obj",obj);
            this.set("id",obj.id);
            this.set("startTime",obj.startTime);
            this.set("endTime",obj.endTime);

            //还没开始不显示
            if(obj.startTime > 0)
            {
                this.set("show",false);
                setTimeoutMy(this,this.show,obj.startTime * 1000);
                return;
            }

            //倒计时
            if(obj.endTime > 0)
            {
                this.set("show",true);
                setTimeoutMy(this,this.hide,obj.endTime * 1000);
                return;
            }
        },

        show:function(){
            this.set("show",true);
            this.trigger("show",this.get("id"));
        },

        hide:function(){
            this.set("show",false);
            this.trigger("hide",this.get("id"));
        }

    });

    function setTimeoutMy(obj,fn,time){
        return setTimeout(function(){ fn.call(obj);},time);
    }

    /**
     * 贴边广告
     */
    ad.SideADView = Backbone.View.extend({

        el: ".layer-ad",
        model: ad.SideADModel,

        initialize: function () {
            this.model.on("change:url", this.urlChange, this);
            this.$el.find("iframe").hide();
        },

        urlChange:function(){
            var url = this.model.get("url");
            if(url == "")
            {
                this.$el.find("iframe").hide();
                return;
            }
            else{
                this.$el.find("iframe").show();
            }

            this.$el.find("iframe").attr("src",url);
        }
    });

    ad.SideADModel = Backbone.Model.extend({
        defaults: {
            url:""
        },

        initialize: function () {

        }
    });


    /**
     * 视频区广告
     */
    ad.ADVideoView = Backbone.View.extend({
        el: ".ad",
        model: ad.ADVideoModel,

        initialize: function () {
            this.model.on("change:uiList", this.uiListChange, this);
            this.model.on("change:index", this.indexChange, this);
            //this.model.on("change:length", this.lengthChange, this);
            this.model.on("change:bgUrl", this.bgUrlChange, this);
        },

        uiListChange: function () {
            var uiList = this.model.get("uiList");

            var listContainer = this.$el.find(".list");
            listContainer.children().remove();
            var adCon = $("#adTmpl");
            var adTmpl;
            adTmpl = adCon.tmpl(uiList);
            adTmpl.appendTo(listContainer);

            //关闭按钮
            listContainer.find(".close").click(this,this.closeHandler);
        },

        closeHandler:function(e){
            var _this = e.data;
            _this.model.set("list",[]);
            _this.model.refreshUIList();
        },

        indexChange: function () {
            var index = this.model.get("index");
            var oldindex = this.model.previous("index");

            if(this.$el.find("li").eq(index).find("iframe").length != 0)
            {
                this.model.stopChange();
                var list = this.model.get("list");
                var $iframe = this.$el.find("li").eq(index).find("iframe");
                $iframe.attr("src",list[0].src);
                /*
                setTimeout(function(){
                    $iframe.get(0).contentWindow.start();
                },100);
                */
            }

            var $list = this.$el.find(".list li");
            $list.eq(index).css({"z-index":1});
            $list.eq(index).fadeIn(10);
            if(oldindex != -1)
            {
                $list.eq(oldindex).css({"z-index":2});
                $list.eq(oldindex).fadeOut();
            }
        },

        bgUrlChange:function(){
            this.$el.find(".bg").attr("src",this.model.get("bgUrl"));
        }

    });

    ad.ADVideoModel = Backbone.Model.extend({
        defaults: {
            /**
             * 广告列表 UI
             * {id:1,src:"",link:""}
             */
            uiList: [],

            /**
             * 广告列表全部数据
             */
            list:[],

            /**
             * 幻灯片列表
             */
            bgList:[],

            /**
             * 播放索引
             */
            index: -1,

            /**
             * 广告数量
             */
            length:0,

            timeid:0,

            /**
             * 广告类型
             * 1 iframe 2 图片
             */
            type:1,

            /**
             * 背景图地址  不参与轮播的
             */
            bgUrl:"",
        },

        /**
         * 设置背景图  不参与轮播的
         */
        setBg:function(url){
            this.set("bgUrl",url);
            this.refreshUIList();
        },

        /**
         * 设置幻灯片
         */
        setBgList:function(list){
            var bgList = [];
            for(var i = 0;i<list.length;i++)
            {
                //id为-1 幻灯片背景
                var obj = {id:-1,type:2,src:"",link:"",startTime:0,endTime:0};
                obj.src = list[i];
                bgList.push(obj);
            }

            this.set("bgList",bgList);
            this.refreshUIList();
        },

        /**
         * 设置广告iframe地址
         */
        setUrl:function(url){

            var localList = [];
            //type为1时为iframe
            var obj = {id:0,type:1,src:url,link:"",startTime:0,endTime:0};
            localList.push(obj);

            this.set("list",localList);

            this.refreshUIList();
        },

        /**
         * 刷新用于UI的广告列表
         */
        refreshUIList:function(){
            var list = this.get("list");

            var uiList = [];

            $.each(list,function(k,v){
                uiList.push(v);
            });

            //添加幻灯片
            var bgList = this.get("bgList");
            $.each(bgList,function(k,v){
                uiList.push(v);
            });

            //强制更新
            if(uiList.length != 0)
            {
                this.set({uiList:[]},{silent:true});
            }

            this.set("uiList",uiList);

            this.set("length",uiList.length);

            //this.set("timeid",0);

            //强制从0开始渲染
            this.set({index:-1},{silent:true});
            this.set("index",0);

            this.stopChange();
            //没有广告则幻灯片轮播
            if(list.length == 0)
            {
                this.startChange(0);
            }
        },

        /*
        * type 0 本次不轮播
        *      iframe 广告播完回调
        */
        startChange:function(type){
            var timeid = setTimeoutMy(this,this.startChange,4000);
            this.set("timeid",timeid);

            if(type == 0)return;

            if(type == "iframe" && this.get("bgList").length != 0)
            {
                $(".layer-video .video_pic iframe").attr("src","");
            }

            var index = this.get("index");
            var nextIndex = ((index + 1) == this.get("length")) ? 0:(index + 1);
            this.set("index",nextIndex);
        },

        stopChange:function(){
            var timeid = this.get("timeid");
            clearTimeout(timeid);
            this.set("timeid",0);
        }

    });


    return ad;
});