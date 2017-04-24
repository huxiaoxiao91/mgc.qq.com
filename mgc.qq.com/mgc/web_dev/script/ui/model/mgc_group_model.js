/*
* Author:             Jason
* Version:            1.0 (2015/11/20)
* Discription:        后援团模块模型
*/
define(['backbone', 'jquery', 'mgc_network', 'mgc_callcenter'], function (Backbone, $, network, callcenter) {
    var Model = {};

    //是否团长
    Model.isChief = 0;
    //职位级别
    Model.position = 0
    //权限
    Model.privilege = {};


    /*
     * 导航
     */
    Model.TabModel = Backbone.Model.extend({
        defaults:{
            /**
             * 当前导航id
             */
            pageid:0,

            /**
             * 当前页面的对象
             */
            currentPage:{},

            /**
             * 导航数据
             */
            data:[
                {id:1,level:"1",label:"加入后援团",parent:"",goto:"",url:"/inc/joingroup.shtml"},
                {id:2,level:"1",label:"创建后援团",parent:"",goto:"",url:"/inc/creategroup.shtml"},
                {id:3,level:"1",label:"我的后援团",parent:"",goto:"",url:"/inc/mygroup.shtml"},
                {id:4,level:"1",label:"后援团管理",parent:"",goto:"5",url:""},
                {id:5,level:"2",label:"后援团信息",parent:"4",goto:"",url:"/inc/groupinfo.shtml"},
                {id:6,level:"2",label:"成员管理",parent:"4",goto:"",url:"/inc/membergroup.shtml"},
                {id:7,level:"2",label:"职位权限",parent:"4",goto:"",url:"/inc/positiongroup.shtml"},
                {id:8,level:"2",label:"申请审核",parent:"4",goto:"",url:"/inc/groupapply.shtml"},
                {id:9,level:"2",label:"助威",parent:"4",goto:"",url:"/inc/cheergroup.shtml"},
                {id:10,level:"1",label:"团长专属",parent:"",goto:"",url:"/inc/headgroup.shtml"},
                {id:11,level:"1",label:"后援团列表",parent:"",goto:"",url:"/inc/listgroup.shtml"}
            ],

            /**
             * 当前导航数据
             */
            curData:[]
        },

        /**
         * 请求后援团信息
         */
        getGroupInfo:function(){
            var params = {};
            params.caller = this;
            callcenter.getGroupInfo(true,this.getGroupInfoCallBack,params);
        },

        /**
         * 请求后援团信息回调
         */
        getGroupInfoCallBack:function(obj){

            var pageid = 0;
            var idArr = [];
            //没有后援团
            if(obj.result == 25 || obj.result == 26)
            {
                idArr = [1,2];
                //默认为加入后援团
                if(this.get("pageid") != 2)
                {
                    pageid = 1;
                }
            }
            else if(obj.result == 0)
            {
                pageid = 3;

                Model.isChief = obj.self_info.isChief;
                //GroupConfig.vgid = obj.self_info.m_vg_id;
                Model.position = obj.self_info.m_position;
                Model.privilege.manage = obj.self_info.Manage;
                Model.privilege.invite = obj.self_info.InviteApprove;
                Model.privilege.kick = obj.self_info.Kick;
                Model.privilege.fans = obj.self_info.Ticket;
                Model.privilege.position = obj.self_info.PositionManage;

                //默认显示导航
                idArr = [3,4,5,9,11];

                //根据权限增加导航
                if(Model.privilege.manage == 1)
                {
                    //idArr.push(5);
                }

                if(Model.privilege.invite == 1)
                {
                    idArr.push(8);
                }

                if(Model.privilege.kick == 1)
                {
                    //idArr.push(6);
                }

                if(Model.privilege.position == 1)
                {
                    idArr.push(6);
                    idArr.push(7);
                }

                if(Model.isChief)
                {
                    idArr.push(10);
                }

                //id从小到大排序
                idArr.sort(function(a,b){return a-b});
            }
            else{
                //refresh();
            }

            //生成导航数据
            var curData = [];
            for(var i = 0;i<idArr.length;i++)
            {
                var id = idArr[i];
                curData.push(this.getTabData(id));
            }

            this.set("curData",curData);
            this.set("pageid",pageid);
        },

        /**
         * 通过id获取某个tab数据
         */
        getTabData:function(id){
            var obj;
            var data = this.get("data");
            for(var i = 0;i<data.length;i++)
            {
                if(data[i].id == id)
                {
                    obj = data[i];
                }
            }
            return obj;
        }

    });


    /*
     * 我的后援团
     */
    Model.MyGroupModel = Backbone.Model.extend({

        defaults: {
            /**
             * 后援团信息数据
             */
            groupInfo: {},

            /**
             * 是否签到
             */
            isSign:false,

            /**
             * 成员列表
             */
            members:[]
        },


        /**
         * 请求后援团信息
         */
        getGroupInfo:function(){
            var params = {};
            params.caller = this;
            callcenter.getGroupInfo(true,this.getGroupInfoCallBack,params);
        },

        /**
         * 请求后援团信息回调
         */
        getGroupInfoCallBack:function(obj){
            this.set("groupInfo",obj);
            this.set("isSign",obj.self_info.isSignToday);
            this.set("members",obj.members);
        },

        /**
         * 签到
         */
        signGroup:function(){
            var params = {};
            params.caller = this;
            callcenter.signGroup(this.signGroupCallBack,params);
        },

        /**
         * 签到回调
         */
        signGroupCallBack:function(obj){
            switch (parseInt(obj.result)) {
                case 0:
                    var dialog = {};
                    dialog.Title = '提示信息';
                    if(obj.slef_score_add != 0 || obj.vg_wealth_add != 0)
                    {
                        dialog.Note = "签到成功~<br>您获得" + obj.slef_score_add + "点个人积分，您的后援团获得" + obj.vg_wealth_add + "点团资产。提升贵族等级，可以增加签到所得团资产。";
                    }
                    else
                    {
                        dialog.Note = "签到成功~<br>入团达到3天后，签到时可以获得个人积分以及团资产哦~";
                    }
                    MGC_Comm.CommonDialog(dialog);
                    MyGroup.getGroupInfo();
                    break;

                case 7:
                    var dialog = {};
                    dialog.Title = '提示信息';
                    dialog.Note = '今日已经签到~';
                    MGC_Comm.CommonDialog(dialog);
                    break;

                default:
                    //refresh();
                    break;
            }
        },

        /**
         * 退出后援团
         */
        quitGroup:function(){
            var params = {};
            params.caller = this;
            callcenter.quitGroup(this.quitGroupCallBack,params);
        },

        /**
         * 退出后援团回调
         */
        quitGroupCallBack:function(obj){
            switch (parseInt(obj.result)) {
                case 0:
                    var dialog = {};
                    dialog.Title = '提示信息';
                    dialog.Note = "您已退出后援团。";
                    MGC_Comm.CommonDialog(dialog);

                    setTimeout("window.location.href = '/group.shtml?param=' + MgcAPI.SNSBrowser.IsQQGameLiveArea()",1000);
                    break;
                case 25:
                    var dialog = {};
                    dialog.Title = '提示信息';
                    dialog.Note = "你已经不在后援团中了！";
                    MGC_Comm.CommonDialog(dialog);
                    break;
                case 43:
                    var dialog = {};
                    dialog.Title = '提示信息';
                    dialog.Note = "团长不能退出后援团。";
                    MGC_Comm.CommonDialog(dialog);
                    break;

                default:
                    refresh();
                    break;
            }
        }
    });

    /*
     * 后援团列表
     */
    Model.ListGroupModel = Backbone.Model.extend({
        defaults: {
            /**
             * 搜索的关键字
             */
            keyword:"",

            /**
             * 当前页数
             */
            page:0,

            /**
             * 排序类型
             * 0 活跃积分降序
             * 1 活跃积分升序
             * 2 总积分降序
             * 3 总积分升序
             * 4 移动端，活跃积分降序，团员人数降序
             */
            sort_type:0,

            /**
             * 后援团列表数据
             */
            grouplist:[],

            /**
             * 积分排序类型
             */
            scoreType:-1,

            /**
             * 总积分排序类型
             */
            totalScoreType:-1,

            /**
             * 是否加载中
             */
            loaded:false,

            /**
             * 是否没有数据了
             */
            empty:false

        },

        /**
         * 获取后援团列表
         */
        getGroup:function(){
            this.set({grouplist:null},{silent: true});
            this.set({loaded:true});

            var params = {};
            params.caller = this;
            callcenter.getGroup(this.get("page"),this.get("keyword"),this.get("sort_type"),this.getGroupCallBack,params);
        },

        /**
         * 获取后援团列表回调
         */
        getGroupCallBack:function(obj){
            this.set("grouplist",obj.video_guilds);
        }

    });

    Model.tabModel = new Model.TabModel();
    Model.myGroupModel = new Model.MyGroupModel();
    Model.listGroupModel = new Model.ListGroupModel();

    return Model;
});