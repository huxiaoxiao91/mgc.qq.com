/**
 * 后援团
 * Created by WangJian on 2015/11/20.
 */

define(['backbone', 'jquery','jqtmpl','underscore','mgc_network', 'mgc_group_model','mgc_callcenter'], function (Backbone,$,jquery_tmpl,_,network,Model,callcenter) {

// jQuery url get parameters function [获取URL的GET参数值]
// <code>
// var GET = $.urlGet(); //获取URL的Get参数
// var id = GET['id']; //取得id的值
// </code>
//  url get parameters
//  public
//  return array()
    (function($m) {
        $m.extend({
            urlGet:function()
            {
                var aQuery = window.location.href.split("?");  //取得Get参数
                var aGET = new Array();
                if(aQuery.length > 1)
                {
                    var aBuf = aQuery[1].split("&");
                    for(var i=0, iLoop = aBuf.length; i<iLoop; i++)
                    {
                        var aTmp = aBuf[i].split("=");  //分离key与Value
                        aGET[aTmp[0]] = aTmp[1];
                    }
                }
                return aGET;
            }
        })

        $m(document).off('click').on('click',function (e) {
            e = window.event || e; // 兼容IE7
            e.stopPropagation();
            obj = $m(e.srcElement || e.target);
            if (!$m(obj).is("#anchorListSel,#anchorListSel *,#anchorListSelList")) {
                $m("#anchorListSel").hide();
            }
            if (!$m(obj).is("#memberListSel,#memberListSel *,#memberListSelList")) {
                $m("#memberListSel").hide();
            }
        });
    })($);


    var View = {};

    //初始化
    View.init = function(){
        network.listenToBroadcastMsg(View.broadcast);

        View.myGroupView = new View.MyGroupView({model:Model.myGroupModel});
        View.listGroupView = new View.ListGroupView({model:Model.listGroupModel});

        View.tabView = new View.TabView({model:Model.tabModel,el:".tab ul"});
        View.tabView.init();
    };

    //广播消息
    View.broadcast = function(jsonstr, params){

    };

    //导航条view
    View.TabView = Backbone.View.extend({

        model:Model.TabModel,

        template: _.template($('#tpl-tab').html()),

        events: {
            'click li': 'onTabPage'
        },

        init:function(){
            this.model.getGroupInfo();
        },

        initialize:function(){
            this.model.on("change:curData",this.curDataHandler,this);
            this.model.on("change:pageid",this.pageidHandler,this);
        },

        curDataHandler:function(obj){
            var data = this.model.get("curData");

            $(this.el).children().remove();

            for(var i = 0;i<data.length;i++)
            {
                this.$el.append(this.template(data[i]));
            }
        },

        onTabPage:function(e){
            var $li = $(e.currentTarget);
            var id = $li.data("id");
            this.model.set("pageid",id);
        },

        /**
         * 跳转到相应id的页面
         */
        pageidHandler:function(){
            var id = this.model.get("pageid");
            var data = this.model.getTabData(id);

            var label = data.label;
            var url = data.url;
            var parent = data.parent;
            var goto = data.goto;

            //自己高亮
            this.$el.find("li").removeClass("select");
            this.$el.find("li[data-id=" + id + "]").addClass("select");

            //父级是否高亮
            if(parent != "")
            {
                this.$el.find("li[data-id=" + parent + "]").addClass("select");
            }

            //是否有跳转页面
            if(goto != "")
            {
                url = this.model.getTabData(goto).url;
                this.$el.find("li[data-id=" + goto + "]").addClass("select");
            }

            //alert("点击导航" + id + "  " + label);
            if(url != "")
            {
                loadPage(data);
            }
        }

    });


    //我的后援团view
    View.MyGroupView = Backbone.View.extend({

        el:".groupContent",

        model:Model.MyGroupModel,

        memberTemplate:null,

        events: {
            'click .sign.signenabled': 'onSign',
            'click a.quit': 'onQuit'
        },

        init:function(){
            this.memberTemplate =  _.template($('#tpl-member').html());

            this.model.set({isSign:null},{silent: true});
            this.model.set({groupInfo:null},{silent: true});
            this.model.set({members:null},{silent: true});
            this.model.set("isSign",true);

            this.model.getGroupInfo();
        },

        initialize:function(){
            this.model.on("change:groupInfo",this.groupInfoHandler,this);
            this.model.on("change:isSign",this.isSignHandler,this);
            this.model.on("change:members",this.membersHandler,this);
        },

        groupInfoHandler:function(){
            var obj = this.model.get("groupInfo");
            //后援团信息
            $("#vg_notice").html(obj.info.vg_notice);
            $("#vg_name").html(obj.info.vg_name);
            $("#vg_wealth").html(obj.info.vg_wealth);
            $("#member_count").html(obj.info.member_count);
            $("#vg_score").html(obj.info.vg_score);
            $("#anchor_name").html(obj.info.anchor_name);
            $("#anchor_score").html(obj.anchor_score);
            $("#anchor_cont_score").html(obj.info.anchor_cont_score);

            if (obj.anchor_rank <= 0) {
                $("#anchor_rank").html("未上榜");
            } else {
                $("#anchor_rank").html(obj.anchor_rank);
            }

            if (obj.info.last_score_rank <= 0) {
                $("#last_score_rank").html("未上榜");
            } else{
                $("#last_score_rank").html(obj.info.last_score_rank);
            }

            $("#anchor_give_score").html(obj.info.anchor_give_score);
            $("#m_member_score").html(obj.self_info.m_member_score);
            $("#m_position").html(obj.self_info.m_position_name);
            $("#anchorAvatarUrl").attr('src',obj.info.anchorAvatarUrl);
            $("#anchor_pstid").data("id",obj.info.anchor_pstid);

            //是否正在解散
            if(parseInt(obj.info.vg_dismiss) > 0)
            {
                $(".groupinfo .dismiss").show();
            }
            else
            {
                //是否正在传位
                if(parseInt(obj.info.vg_demise_time) > 0)
                {
                    $(".groupinfo .demise").show();
                }
            }
        },

        /**
         * 是否签到
         * b true 已签到
         */
        isSignHandler:function(){
            var isSign = this.model.get("isSign");
            var $a = $(".groupinfo .sign");
            if(isSign)
            {
                $a.removeClass();
                $a.addClass("sign signdisabled");
            }
            else
            {
                $a.removeClass();
                $a.addClass("sign signenabled");
            }
        },

        /**
         * 成员列表更新
         */
        membersHandler:function(){
            var data = this.model.get("members");

            var $memberContainer = $('.member .list ul');
            $memberContainer.children().remove();

            for(var i = 0;i<data.length;i++)
            {
                $memberContainer.append(this.memberTemplate(data[i]));
            }
        },

        /**
         * 点击签到
         */
        onSign:function(e){
            this.model.signGroup();
            this.model.set("isSign",true);
        },

        /**
         * 点击退出后援团
         */
        onQuit:function(e){
            this.model.quitGroup();
            return;
            // TODO
            var dialog = {};
            dialog.Title = '提示信息';
            dialog.BtnNum = 2;
            dialog.BtnName2 = '取消';
            dialog.Note = '您确定要退出后援团吗？退出之后，您的所有团内个人积分将会被清空。';
            MGC_Comm.CommonDialog(dialog, MyGroup.quitGroup);
        },

        /**
         * 弹出成员名片 TODO
         */
        showMemberCard:function(e){
            var $a = $m(e.currentTarget);
            // MGC_cardRequest.getListCardInfo($a.data("nick"), $a.data("zone"));
            MGC_cardRequest.getListCardInfo($a.data("playerid"), $a.data("source"));
        },

        /**
         * 弹出主播名片 TODO
         */
        showAnchorCard:function(e){
            var $a = $m(e.currentTarget);
            MGC_CommRequest.getAnchorCard($a.data("id"));
        }

    });

    //后援团列表
    View.ListGroupView = Backbone.View.extend({

        el:".groupContent",

        model:Model.ListGroupModel,

        events: {
            'click .searchgroup .find': 'onFind',
            'click .searchgroup .all': 'onAll',
            'click .grouplist .score': 'onScore',
            'click .grouplist .totalscore': 'onTotalScore'
        },

        init:function(){
            //this.model.set({grouplist:null},{silent: true});
            //this.delegateEvents(this.events);

            this.model.set({scoreType:null},{silent: true});
            this.model.set({totalScoreType:null},{silent: true});

            this.model.set({keyword:""});
            this.model.set({page:0});
            this.model.set({scoreType:0});
            this.model.set({totalScoreType:-1});

            var data = $.urlGet();
            if(data.keyword)
            {
                this.model.set({keyword:decodeURI(data.keyword)});
                $(".searchgroup input").val(this.model.get("keyword"));
            }

            this.model.getGroup();
            $(window).off().scroll(this,this.onWindowScroll);
        },

        initialize:function(){
            this.model.on("change:grouplist",this.grouplistHandler,this);
            this.model.on("change:scoreType",this.scoreTypeHandler,this);
            this.model.on("change:totalScoreType",this.totalScoreTypeHandler,this);
            this.model.on("change:loaded",this.loadedHandler,this);
            this.model.on("change:empty",this.emptyHandler,this);
        },

        grouplistHandler:function(){

            this.model.set("loaded",false);

            var grouplist = this.model.get("grouplist");

            //是否没有数据了
            if(grouplist.length == 0)
            {
                //如果是查找状态 则弹出提示
                if(this.model.get("keyword") != "" && this.model.get("page") == 0)
                {
                    /*
                    var dialog = {};
                    dialog.Title = '提示信息';
                    dialog.Note = '对不起，找不到名称类似的后援团。';
                    MGC_Comm.CommonDialog(dialog);
                    */

                    alert("对不起，找不到名称类似的后援团。");

                    //恢复之前状态
                    this.model.set({keyword:""});
                    return;
                }

                this.model.set({empty:true});
            }
            else
            {
                this.model.set({empty:false});
            }

            var groupContainer = $('.grouplist .list ul');

            //是否第一页
            if(this.model.get("page") == 0)
            {
                groupContainer.children().remove();
            }

            var groupCon = $('#groupTmpl');
            var groupTmpl;
            groupTmpl = groupCon.tmpl(this.model.get("grouplist"));
            groupTmpl.appendTo(groupContainer);

            //名片
            //groupContainer.find(".card a").click(ListGroup.onGroupCard);
            groupCon = null;
            groupTmpl = null;
        },

        /**
         * 点击查找
         */
        onFind:function(){
            this.model.set("page",0);
            this.model.set("keyword",$(".searchgroup input").val());
            this.model.getGroup();
        },

        /**
         * 点击全部
         */
        onAll:function(){
            this.model.set("page",0);
            this.model.set("keyword","");
            this.model.getGroup();
        },

        /**
         * 点击活跃积分排列
         */
        onScore:function(e){
            switch(this.model.get("scoreType"))
            {
                case -1:
                    this.model.set("scoreType",0);
                    break;

                case 1:
                    this.model.set("scoreType",0);
                    break;

                case 0:
                    this.model.set("scoreType",1);
                    break;
            }

            this.model.set("totalScoreType",-1);
            this.model.set("sort_type",this.model.get("scoreType"));
            this.model.set("page",0);
            this.model.getGroup();
        },

        /**
         * 点击总积分排列
         */
        onTotalScore:function(e){
            switch(this.model.get("totalScoreType"))
            {
                case -1:
                    this.model.set("totalScoreType",2);
                    break;

                case 2:
                    this.model.set("totalScoreType",3);
                    break;

                case 3:
                    this.model.set("totalScoreType",2);
                    break;
            }

            this.model.set("scoreType",-1);
            this.model.set("sort_type",this.model.get("totalScoreType"));
            this.model.set("page",0);
            this.model.getGroup();
        },

        /**
         * 浏览器滚动触发
         */
        onWindowScroll:function(e){
            var _this = e.data;

            if(_this.model.get("loaded"))return;

            var scrollTop = $(window).scrollTop();
            var scrollHeight = $(document).height();
            var windowHeight = $(window).height();
            if (scrollTop + windowHeight == scrollHeight) {
                _this.model.set("page",_this.model.get("page") + 1);
                _this.model.getGroup();
            }
        },

        /**
         * 活跃积分排序类型变化
         */
        scoreTypeHandler:function(){
            var $a = $(".grouplist .score");
            //$a.data("type",type);
            $a.removeClass();
            $a.addClass("score");

            switch(this.model.get("scoreType"))
            {
                case -1:
                    $a.addClass("scoredefault");
                    break;

                case 1:
                    $a.addClass("scoreup");
                    //JoinGroup.sort_type = 1;
                    //JoinGroup.getGroup();
                    break;

                case 0:
                    $a.addClass("scoredown");
                    //JoinGroup.sort_type = 0;
                    //JoinGroup.getGroup();
                    break;
            }
        },

        /**
         * 总活跃积分排序类型变化
         */
        totalScoreTypeHandler:function(){
            var $a = $(".grouplist .totalscore");
            //$a.data("type",type);
            $a.removeClass();
            $a.addClass("totalscore");

            switch(this.model.get("totalScoreType"))
            {
                case -1:
                    $a.addClass("totalscoredefault");
                    break;

                case 3:
                    $a.addClass("totalscoreup");
                    //JoinGroup.sort_type = 1;
                    //JoinGroup.getGroup();
                    break;

                case 2:
                    $a.addClass("totalscoredown");
                    //JoinGroup.sort_type = 0;
                    //JoinGroup.getGroup();
                    break;
            }
        },

        /**
         * 是否加载中
         */
        loadedHandler:function(){
            if(this.model.get("loaded"))
            {
                $(".grouplist .bottom img").show();
                this.model.set("empty",false);
            }
            else
            {
                $(".grouplist .bottom img").hide();
            }
        },

        /**
         * 设置是否没有数据
         */
        emptyHandler:function(b){
            if(this.model.get("empty"))
            {
                $(".grouplist .bottom span").show();
            }
            else
            {
                $(".grouplist .bottom span").hide();
            }
        }

    });

    return View;

    /**
     * 加载相应页面
     */
    function loadPage(data){
        $(".groupContent").children().remove();
        $(".groupContent").load(data.url,loadPageComplete);
        /**
         * 加载相应页面完成事件
         */
        function loadPageComplete(response, status, xhr){
            if(status != "success")return;

            switch(data.id){
                case 3:
                    View.myGroupView.init();
                    break;

                case 11:
                    View.listGroupView.init();
                    break;
            }

        }
    };

});