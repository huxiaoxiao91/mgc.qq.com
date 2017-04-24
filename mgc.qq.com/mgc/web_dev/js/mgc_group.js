/**
 * Created by Jason on 2015/9/14.
 */

// jQuery url get parameters function [获取URL的GET参数值]
// <code>
//     var GET = $.urlGet(); //获取URL的Get参数
//     var id = GET['id']; //取得id的值
// </code>
//  url get parameters
//  public
//  return array()
(function ($m) {
    $m.extend({
        urlGet: function () {
            var aQuery = window.location.href.split("?");
            //取得Get参数
            var aGET = new Array();
            if (aQuery.length > 1) {
                var aBuf = aQuery[1].split("&");
                for (var i = 0, iLoop = aBuf.length; i < iLoop; i++) {
                    var aTmp = aBuf[i].split("=");
                    //分离key与Value
                    aGET[aTmp[0]] = aTmp[1];
                }
            }
            return aGET;
        }
    })

    $m(document).off('click').on('click', function (e) {
        e = e || window.event;
        // 兼容IE7
        e.stopPropagation();
        obj = $m(e.srcElement || e.target);
        if (!$m(obj).is("#anchorListSel,#anchorListSel *,#anchorListSelList")) {
            $m("#anchorListSel").hide();
        }
        if (!$m(obj).is("#memberListSel,#memberListSel *,#memberListSelList")) {
            $m("#memberListSel").hide();
        }
    });

})(jQuery);

/**
 * 配置
 */
var GroupConfig = {
    /**
     * 是否入团
     */
    isJoin: false,

    /**
     * 是否团长
     */
    isChief: false,

    /**
     * 玩家所在后援团id
     */
    vgid: 0,

    /**
     * 玩家所在后援团公告
     */
    vgnotice: 0,

    /**
     * 玩家所在后援团公告
     */
    vgnotice_callback: 0,
    /**
     * 玩家所在后援团简介
     */
    vgdesc: 0,
    /**
     * 玩家所在后援团简介回调后
     */
    vgdesc_callback: 0,

    /**
     * 玩家所在后援团职位
     */
    position: 0,

    /**
     * 玩家拥有权限
     */
    privilege: {
        //管理后援团信息
        manage: 0,
        //邀请和审核
        invite: 0,
        //开除
        kick: 0,
        //助威粉丝榜
        fans: 0,
        //职位管理
        position: 0
    }

};

/**
 * 左侧导航
 */
var Tab = {

    /**
     * 默认的导航id
     */
    pageid: 3,

    /**
     * 当前页面的对象
     */
    currentPage: {},

    /**
     * 导航数据
     */
    data: [
        { id: 1, level: "1", label: "加入后援团", parent: "", goto: "", url: "/inc/joingroup.shtml" },
        { id: 2, level: "1", label: "创建后援团", parent: "", goto: "", url: "/inc/creategroup.shtml" },
        { id: 3, level: "1", label: "我的后援团", parent: "", goto: "", url: "/inc/mygroup.shtml" },
        { id: 4, level: "1", label: "后援团管理", parent: "", goto: "5", url: "" },
        { id: 5, level: "2", label: "后援团信息", parent: "4", goto: "", url: "/inc/groupinfo.shtml" },
        { id: 6, level: "2", label: "成员管理", parent: "4", goto: "", url: "/inc/membergroup.shtml" },
        { id: 7, level: "2", label: "职位权限", parent: "4", goto: "", url: "/inc/positiongroup.shtml" },
        { id: 8, level: "2", label: "申请审核", parent: "4", goto: "", url: "/inc/groupapply.shtml" },
        { id: 9, level: "2", label: "助威", parent: "4", goto: "", url: "/inc/cheergroup.shtml" },
        { id: 10, level: "1", label: "团长专属", parent: "", goto: "", url: "/inc/headgroup.shtml" },
        { id: 11, level: "1", label: "后援团列表", parent: "", goto: "", url: "/inc/listgroup.shtml" }
    ],

    /**
     * 通过id获取某个tab数据
     */
    getTabData: function (id) {
        var obj;
        for (var i = 0; i < this.data.length; i++) {
            if (this.data[i].id == id) {
                obj = this.data[i];
            }
        }

        return obj;
    },

    /**
     * 初始化
     */
    init: function () {
        loginCallBack();
        //获取页面的url参数
        var data = $m.urlGet();
        if (data.id) {
            Tab.pageid = data.id;
        }

        Tab.getGroupInfo();
    },

    /**
     * 点击导航切换页面
     */
    onTabPage: function (e) {
        var $li = $m(e.currentTarget);
        var id = $li.data("id");

        //Tab.tabPage(id);
        Tab.pageid = id;
        Tab.getGroupInfo();
    },

    /**
     * 跳转到相应id的页面
     */
    tabPage: function (id) {
        var data = Tab.getTabData(id);

        var label = data.label;
        var url = data.url;
        var parent = data.parent;
        var goto = data.goto;

        var tabContainer = $m('.tab ul');

        //自己高亮
        tabContainer.find("li").removeClass("select");
        tabContainer.find("li[data-id=" + id + "]").addClass("select");

        //父级是否高亮
        if (parent != "") {
            tabContainer.find("li[data-id=" + parent + "]").addClass("select");
        }

        //是否有跳转页面
        if (goto != "") {
            url = Tab.getTabData(goto).url;
            tabContainer.find("li[data-id=" + goto + "]").addClass("select");
        }

        //alert("点击导航" + id + "  " + label);
        if (url != "") {
            Tab.loadPage(url);
        }
        if (id == 2 || id == 4 || id == 5) {
            GroupInfo.CallBack_notice = 0;
            GroupInfo.CallBack_intro = 0;
            MyGroup.getGroupInfo();
        }
    },

    /**
     * 加载相应页面
     */
    loadPage: function (url) {
        //加载前先销毁上个界面
        if (Tab.currentPage.destroy) {
            Tab.currentPage.destroy();
        }

        $m(".groupContent").children().remove();
        $m(".groupContent").load(url);
    },

    /**
     * 请求后援团信息
     */
    getGroupInfo: function () {

        var _reqStr = {"op_type":OpType.GetGroupInfo,"from_home":true };
        MGC_Comm.sendMsg(_reqStr, "Tab.getGroupInfoCallBack");
    },

    /**
     * 请求后援团信息回调
     */
    getGroupInfoCallBack: function (obj) {

        var idArr = [];
        //没有后援团
        if (obj.result == 25 || obj.result == 26) {
            idArr = [1, 2];

            //默认为加入后援团
            if (Tab.pageid != 2) {
                Tab.pageid = 1;
            }
        } else if (obj.result == 0) {
            GroupConfig.isChief = obj.self_info.isChief;
            //GroupConfig.vgid = obj.self_info.m_vg_id;
            GroupConfig.position = obj.self_info.m_position;
            GroupConfig.privilege.manage = obj.self_info.Manage;
            GroupConfig.privilege.invite = obj.self_info.InviteApprove;
            GroupConfig.privilege.kick = obj.self_info.Kick;
            GroupConfig.privilege.fans = obj.self_info.Ticket;
            GroupConfig.privilege.position = obj.self_info.PositionManage;

            //默认显示导航
            idArr = [3, 4, 5, 9, 11];

            //根据权限增加导航
            if (GroupConfig.privilege.manage == 1) {
                //idArr.push(5);
            }

            if (GroupConfig.privilege.invite == 1) {
                idArr.push(8);
            }

            if (GroupConfig.privilege.kick == 1) {
                //idArr.push(6);
            }

            if (GroupConfig.privilege.position == 1) {
                idArr.push(6);
                idArr.push(7);
            }

            if (GroupConfig.isChief) {
                idArr.push(10);
            }

            //id从小到大排序
            idArr.sort(function (a, b) {
                return a - b
            });

            //如果玩家之前在1,2界面则默认为3我的后援团
            if (Tab.pageid == 1 || Tab.pageid == 2) {
                Tab.pageid = 3;
            }
        } else {
            refresh();
        }
        /*
        else if(obj.result == -4)
        {
        var _reqStr = "{\"op_type\":" + OpType.GetGroupInfo+"}";
        MGC_Comm.sendMsg(_reqStr, "Tab.getGroupInfoCallBack");
        return;
        }
        */

        //生成导航数据
        var data = [];
        for (var i = 0; i < idArr.length; i++) {
            data.push(Tab.getTabData(idArr[i]));
        }

        //生成导航模板
        var tabCon = $m('#tabTmpl');
        var tabTmpl;
        var tabContainer = $m('.tab ul');
        tabContainer.children().remove();
        tabTmpl = tabCon.tmpl(data);
        tabTmpl.appendTo(tabContainer);

        tabContainer.find("li").click(Tab.onTabPage);

        //跳转到相应页面
        Tab.tabPage(Tab.pageid);
        tabTmpl = null;
        tabCon = null;
    }
};

/**
 * 加入后援团
 */
var JoinGroup = {

    /**
     * 搜索的关键字
     */
    keyword: "",

    /**
     * 当前页数 从0开始
     */
    page: 0,

    /**
     * 排序类型
     * 0 活跃积分降序
     * 1 活跃积分升序
     * 2 总积分降序
     * 3 总积分升序
     * 4 移动端，活跃积分降序，团员人数降序
     */
    sort_type: 0,

    /**
     * 是否正在加载列表
     */
    loaded: false,

    /**
     * 是否没有数据了
     */
    empty: false,

    /**
     * 初始化
     */
    init: function () {

        JoinGroup.page = 0;

        var data = $m.urlGet();
        if (data.keyword) {
            JoinGroup.keyword = decodeURI(data.keyword);
            $m(".searchgroup input").val(JoinGroup.keyword);
        } else {
            JoinGroup.keyword = "";
        }

        //查找
        $m(".searchgroup .find").off().click(JoinGroup.onFind);
        //全部
        $m(".searchgroup .all").off().click(JoinGroup.onAll);

        //活跃积分排列按钮
        $m(".grouplist .score").off().click(JoinGroup.onScore);
        //总积分排列按钮
        $m(".grouplist .totalscore").off().click(JoinGroup.onTotalScore);

        //成员列表滚动条
        //$m('.grouplist .list').jScrollPane({ autoReinitialise: true,animateScroll:true});
        $m(window).off().scroll(JoinGroup.onWindowScroll);

        //默认活跃积分降序
        JoinGroup.sortScore("down");
        JoinGroup.sortTotalScore("default");
    },

    refresh: function () {
        window.location.href = "/group.shtml?keyword=" + encodeURI(JoinGroup.keyword) + "&param=" + MgcAPI.SNSBrowser.IsQQGameLiveArea();
    },

    /**
     * 销毁
     */
    destroy: function () {

    },

    /**
     * 设置是否加载中
     */
    setloaded: function (b) {
        JoinGroup.loaded = b;
        if (b) {
            $m(".grouplist .bottom img").show();
            JoinGroup.setempty(false);
        } else {
            $m(".grouplist .bottom img").hide();
        }
    },

    /**
     * 设置是否没有数据
     */
    setempty: function (b) {
        JoinGroup.empty = b;
        if (b) {
            $m(".grouplist .bottom span").show();
        } else {
            $m(".grouplist .bottom span").hide();
        }
    },

    /**
     * 浏览器滚动触发
     */
    onWindowScroll: function () {
        if (JoinGroup.loaded)
            return;

        var scrollTop = $m(window).scrollTop();
        var scrollHeight = $m(document).height();
        var windowHeight = $m(window).height();
        if (scrollTop + windowHeight == scrollHeight) {
            JoinGroup.page++;
            JoinGroup.getGroup();
        }
    },

    /**
     * 查找
     */
    onFind: function () {
        //alert("查找：" + $m(".searchgroup input").val());
        JoinGroup.page = 0;
        JoinGroup.keyword = $m(".searchgroup input").val();
        JoinGroup.getGroup();
    },

    /**
     * 全部
     */
    onAll: function () {
        $m(".searchgroup input").val("");
        JoinGroup.page = 0;
        JoinGroup.keyword = "";
        JoinGroup.getGroup();
    },

    /**
     * 活跃积分排列
     */
    onScore: function (e) {
        var $a = $m(e.currentTarget);
        var type = $a.data("type");

        switch (type) {
            case "default":
                type = "down";
                break;

            case "up":
                type = "down";
                break;

            case "down":
                type = "up";
                break;
        }

        JoinGroup.page = 0;
        JoinGroup.sortScore(type);
        JoinGroup.sortTotalScore("default");
    },

    /**
     * 总积分排列
     */
    onTotalScore: function (e) {
        var $a = $m(e.currentTarget);
        var type = $a.data("type");

        switch (type) {
            case "default":
                type = "down";
                break;

            case "up":
                type = "down";
                break;

            case "down":
                type = "up";
                break;
        }

        JoinGroup.page = 0;
        JoinGroup.sortTotalScore(type);
        JoinGroup.sortScore("default");
    },

    /**
     * 点击后援团专属名片
     */
    onGroupCard: function (e) {
        var $a = $m(e.currentTarget);
        var vgid = $a.data("vgid");

        MGC_CommRequest.getbackupGroupCard(vgid);
    },

    /**
     * 切换活跃积分排列顺序
     */
    sortScore: function (type) {
        var $a = $m(".grouplist .score");
        $a.data("type", type);
        $a.removeClass();
        $a.addClass("score");
        switch (type) {
            case "default":
                $a.addClass("scoredefault");
                break;

            case "up":
                $a.addClass("scoreup");
                JoinGroup.sort_type = 1;
                JoinGroup.getGroup();
                break;

            case "down":
                $a.addClass("scoredown");
                JoinGroup.sort_type = 0;
                JoinGroup.getGroup();
                break;
        }
    },

    /**
     * 切换总积分排列顺序
     */
    sortTotalScore: function (type) {
        var $a = $m(".grouplist .totalscore");
        $a.data("type", type);
        $a.removeClass();
        $a.addClass("totalscore");
        switch (type) {
            case "default":
                $a.addClass("totalscoredefault");
                break;

            case "up":
                $a.addClass("totalscoreup");
                JoinGroup.sort_type = 3;
                JoinGroup.getGroup();
                break;

            case "down":
                $a.addClass("totalscoredown");
                JoinGroup.sort_type = 2;
                JoinGroup.getGroup();
                break;
        }
    },

    /**
     * 获取后援团列表
     */
    getGroup: function () {
        JoinGroup.setloaded(true);
        var _reqStr = {
            "op_type": OpType.GetGroup,
            "page": JoinGroup.page,
            "name_pattern": JoinGroup.keyword,
            "sort_type": JoinGroup.sort_type
        };
        MGC_Comm.sendMsg(_reqStr, "JoinGroup.getGroupCallBack");
    },

    /**
     * 获取后援团列表回调
     */
    getGroupCallBack: function (obj) {
        var groupCon = $m('#groupTmpl');
        var groupTmpl;
        var groupContainer = $m('.grouplist .list ul');

        if(obj.result == 44)
        {
            window.mgc.common_logic.CheckNameError(60);
            return;
        }

        JoinGroup.setloaded(false);

        //是否没有数据了
        if (obj.video_guilds.length == 0) {
            //如果是查找状态 则弹出提示
            if (JoinGroup.keyword != "" && JoinGroup.page == 0) {
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '对不起，找不到名称类似的后援团。';
                MGC_Comm.CommonDialog(dialog);

                //恢复之前状态
                JoinGroup.keyword = "";
                return;
            }

            JoinGroup.setempty(true);
        } else {
            JoinGroup.setempty(false);
        }

        //是否第一页
        if (JoinGroup.page == 0) {
            groupContainer.children().remove();
        }

        for (var i = 0; i < obj.video_guilds.length; i++) {
            var guild = obj.video_guilds[i];
            //大区
            guild.chief_zone = (guild.chief_zone == "梦工厂" ? guild.chief_zone : "炫舞-" + guild.chief_zone);

        }
        $m.each(obj.video_guilds, function (k, v) {
            v.anchor_level_temp = Math.floor(v.anchor_level / 10) + 1;
            if (v.anchor_level == 0) {
                v.anchor_level_temp = 0;
            }
        });
        groupTmpl = groupCon.tmpl(obj.video_guilds);
        groupTmpl.appendTo(groupContainer);

        //名片
        groupContainer.find(".vg_name a").click(JoinGroup.onGroupCard);

        //特么的 居然这个兼容360兼容模式下加载后援团列表不自适应高度 我了个去的
        $m(".main").height($m(".group").height());
        groupTmpl = null;
        groupCon = null;
    }
}

/**
 * 后援团列表
 */
var ListGroup = {

    /**
     * 搜索的关键字
     */
    keyword: "",

    /**
     * 当前页数
     */
    page: 1,

    /**
     * 排序类型
     * 0 活跃积分降序
     * 1 活跃积分升序
     * 2 总积分降序
     * 3 总积分升序
     * 4 移动端，活跃积分降序，团员人数降序
     */
    sort_type: 0,

    /**
     * 初始化
     */
    init: function () {

        //查找
        $m(".searchgroup .find").click(ListGroup.onFind);
        //全部
        $m(".searchgroup .all").click(ListGroup.onAll);

        //活跃积分排列按钮
        $m(".grouplist .score").click(ListGroup.onScore);
        //总积分排列按钮
        $m(".grouplist .totalscore").click(ListGroup.onTotalScore);

        //成员列表滚动条
        $m('.grouplist .list').jScrollPane({
            autoReinitialise: true,
            animateScroll: true
        });
        //重绘滚动条 
        var scrollAPI_grouplist = $m('.grouplist .list').data('jsp');
        if(scrollAPI_grouplist){
            scrollAPI_grouplist.initScroll();
        }

        //默认活跃积分降序
        ListGroup.sortScore("down");
        ListGroup.sortTotalScore("default");
    },

    /**
     * 查找
     */
    onFind: function () {
        //alert("查找：" + $m(".searchgroup input").val());
        ListGroup.keyword = $m(".searchgroup input").val();
        ListGroup.getGroup();
    },

    /**
     * 全部
     */
    onAll: function () {
        ListGroup.keyword = "";
        ListGroup.getGroup();
    },

    /**
     * 活跃积分排列
     */
    onScore: function (e) {
        var $a = $m(e.currentTarget);
        var type = $a.data("type");

        switch (type) {
            case "default":
                type = "down";
                break;

            case "up":
                type = "down";
                break;

            case "down":
                type = "up";
                break;
        }

        ListGroup.sortScore(type);
        ListGroup.sortTotalScore("default");
    },

    /**
     * 总积分排列
     */
    onTotalScore: function (e) {
        var $a = $m(e.currentTarget);
        var type = $a.data("type");

        switch (type) {
            case "default":
                type = "down";
                break;

            case "up":
                type = "down";
                break;

            case "down":
                type = "up";
                break;
        }

        ListGroup.sortTotalScore(type);
        ListGroup.sortScore("default");
    },

    /**
     * 点击后援团专属名片
     */
    onGroupCard: function (e) {
        var $a = $m(e.currentTarget);
        var vgid = $a.data("vgid");

        MGC_CommRequest.getbackupGroupCard(vgid);
    },

    /**
     * 切换活跃积分排列顺序
     */
    sortScore: function (type) {
        var $a = $m(".grouplist .score");
        $a.data("type", type);
        $a.removeClass();
        $a.addClass("score");
        switch (type) {
            case "default":
                $a.addClass("scoredefault");
                break;

            case "up":
                $a.addClass("scoreup");
                ListGroup.sort_type = 1;
                ListGroup.getGroup();
                break;

            case "down":
                $a.addClass("scoredown");
                ListGroup.sort_type = 0;
                ListGroup.getGroup();
                break;
        }
    },

    /**
     * 切换总积分排列顺序
     */
    sortTotalScore: function (type) {
        var $a = $m(".grouplist .totalscore");
        $a.data("type", type);
        $a.removeClass();
        $a.addClass("totalscore");
        switch (type) {
            case "default":
                $a.addClass("totalscoredefault");
                break;

            case "up":
                $a.addClass("totalscoreup");
                ListGroup.sort_type = 3;
                ListGroup.getGroup();
                break;

            case "down":
                $a.addClass("totalscoredown");
                ListGroup.sort_type = 2;
                ListGroup.getGroup();
                break;
        }
    },

    /**
     * 获取后援团列表
     */
    getGroup: function () {
        var _reqStr = {
            "op_type": OpType.GetGroup,
            "page": ListGroup.page,
            "name_pattern": ListGroup.keyword,
            "sort_type": ListGroup.sort_type
        };
        MGC_Comm.sendMsg(_reqStr, "JoinGroup.getGroupCallBack");
    },

    /**
     * 获取后援团列表回调
     */
    getGroupCallBack: function (obj) {
        var groupCon = $m('#groupTmpl');
        var groupTmpl;
        var groupContainer = $m('.grouplist .list ul');
        groupContainer.children().remove();
        $m.each(obj.video_guilds, function (k, v) {
            v.anchor_level_temp = Math.floor(v.anchor_level / 10) + 1;
            if (v.anchor_level == 0) {
                v.anchor_level_temp = 0;
            }
        });
        groupTmpl = groupCon.tmpl(obj.video_guilds);
        groupTmpl.appendTo(groupContainer);
        //重绘滚动条 
        var scrollAPI_grouplist = $m('.groupContainer').data('jsp');
        if(scrollAPI_grouplist){
            scrollAPI_grouplist.initScroll();
        }
        //名片
        groupContainer.find(".card a").click(ListGroup.onGroupCard);
        groupTmpl = null;
        groupCon = null;
    }
}

/**
 * 我的后援团
 */
var MyGroup = {
    /**
     * 初始化
     */
    init: function () {

        MyGroup.isSign(true);

        //退出后援团
        $m(".groupinfo .quit").click(MyGroup.onQuit);
        //主播名片
        $m(".anchor .card").click(MyGroup.showAnchorCard);

        //公告滚动条
        $m('.groupinfo .box').jScrollPane({
            autoReinitialise: true,
            animateScroll: true
        });
        //重绘滚动条 
        var scrollAPI_groupinfobox = $m('.groupinfo .box').data('jsp');
        if(scrollAPI_groupinfobox){
            scrollAPI_groupinfobox.initScroll();
        }
        //成员列表滚动条
        $m('.member .list').jScrollPane({
            autoReinitialise: true,
            animateScroll: true
        });
        //重绘滚动条 
        var scrollAPI_memberlist = $m('.member .list').data('jsp');
        if(scrollAPI_memberlist){
            scrollAPI_memberlist.initScroll();
        }

        MyGroup.getGroupInfo();
    },

    /**
     * 请求后援团信息
     */
    getGroupInfo: function () {
        var _reqStr;
        //if (GroupConfig.isChief) {
        _reqStr = {"op_type":OpType.GetGroupInfo,"from_home":true };
        //}
        //else {
        //    _reqStr = "{\"op_type\":" + OpType.GetGroupInfo + "}";
        //}
        MGC_Comm.sendMsg(_reqStr, "MyGroup.getGroupInfoCallBack");
    },

    /**
     * 请求后援团信息回调
     */
    getGroupInfoCallBack: function (obj) {
        //后援团信息
        $m("#vg_notice").html(obj.info.vg_notice);
        $m("#vg_name").html(obj.info.vg_name);
        $m("#vg_wealth").html(obj.info.vg_wealth);
        $m("#member_count").html(obj.info.member_count + "/" + obj.info.member_limit);
        $m("#vg_score").html(obj.info.vg_score);
        if (obj.info.anchor_level != 0) {

            obj.info.anchor_level_temp = Math.floor(obj.info.anchor_level / 10) + 1;
            if (obj.info.anchor_level == 0) {
                obj.info.anchor_level_temp = 0;
            }

            $m("#anchor_level").attr('class', 'anchor_level_' + obj.info.anchor_level_temp);
            $m("#anchor_level").css({"background": "url(http://ossweb-img.qq.com/images/mgc/css_img/common/anchor_level/" + obj.info.anchor_level_temp +".png?v=3_8_8_2016_15_4_final_3) no-repeat"});
            $m("#anchor_level").attr('onmouseover', 'MGC.susTips_personal(event,1,"主播等级:' + obj.info.anchor_level + '")');
            $m("#anchor_level").attr('onmouseout', 'MGC.susTips_personal(event,0)');
            $m("#anchor_level").html('<i>' + obj.info.anchor_level + '</i>');
        }

        $m("#anchor_name").html(obj.info.anchor_name);
        $m("#anchor_score").html(obj.anchor_score);
        $m("#anchor_cont_score").html(obj.info.anchor_cont_score);

        if (obj.anchor_rank <= 0) {
            $m("#anchor_rank").html("未上榜");
        } else {
            $m("#anchor_rank").html(obj.anchor_rank);
        }

        if (obj.info.last_score_rank <= 0) {
            $m("#last_score_rank").html("1000名以后");
        } else {
            $m("#last_score_rank").html(obj.info.last_score_rank);
        }

        $m("#anchor_give_score").html(obj.info.anchor_give_score);
        $m("#m_member_score").html(obj.self_info.m_member_score);
        $m("#m_position").html(obj.self_info.m_position_name);
        $m("#anchorAvatarUrl").attr('src', obj.info.anchorAvatarUrl);
        $m("#anchor_pstid").data("id", obj.info.anchor_pstid);

        //是否正在解散
        if (parseInt(obj.info.vg_dismiss) > 0) {
            $m(".groupinfo .dismiss").show();
        } else {
            //是否正在传位
            if (parseInt(obj.info.vg_demise_time) > 0) {
                $m(".groupinfo .demise").show();
            }
        }

        MyGroup.isSign(obj.self_info.isSignToday);

        for (var i = 0; i < obj.members.length; i++) {
            var member = obj.members[i];
            member.vipName = vipLevelTab[member.m_member_vip];
        }

        for (var i = 0; i < obj.members.length; i++) {
            var member = obj.members[i];
            //大区
            member.m_member_zone = (member.m_member_zone == "梦工厂" ? member.m_member_zone : "炫舞-" + member.m_member_zone);
        }
        var memberCon = $m('#memberTmpl');
        var memberTmpl;
        var memberContainer = $m('.member .list ul');
        memberContainer.children().remove();
        memberTmpl = memberCon.tmpl(obj.members);
        memberTmpl.appendTo(memberContainer);
        //重绘滚动条 
        var scrollAPI_notice = $m('.groupinfo .mymain .box').data('jsp');
        if(scrollAPI_notice){
            scrollAPI_notice.initScroll();
        }
        //重绘滚动条 
        var scrollAPI_memberlist = $m('.member .list').data('jsp');
        if(scrollAPI_memberlist){
            scrollAPI_memberlist.initScroll();
        }
        memberContainer.find(".card a").click(MyGroup.showMemberCard);

        memberTmpl = null;
        memberCon = null;
    },

    /**
     * 签到
     */
    onSign: function (e) {
        MyGroup.signGroup();
        MyGroup.isSign(true);
    },

    /**
     * 点击退出后援团
     */
    onQuit: function (e) {
        var dialog = {};
        dialog.Title = '提示信息';
        dialog.BtnNum = 2;
        dialog.BtnName2 = '取消';
        dialog.Note = '您确定要退出后援团吗？退出之后，您的所有团内个人积分将会被清空。';
        MGC_Comm.CommonDialog(dialog, MyGroup.quitGroup);
    },

    /**
     * 是否签到
     * b true 已签到
     */
    isSign: function (b) {
        var $a = $m(".groupinfo .sign");
        if (b) {
            $a.removeClass();
            $a.addClass("sign signdisabled");
            $a.off();
        } else {
            $a.removeClass();
            $a.addClass("sign signenabled");
            $a.off().click(MyGroup.onSign);
        }
    },

    /**
     * 签到
     */
    signGroup: function () {
        var _reqStr = {"op_type":OpType.SignGroup };
        MGC_Comm.sendMsg(_reqStr, "MyGroup.signGroupCallBack");
    },

    /**
     * 签到回调
     */
    signGroupCallBack: function (obj) {
        switch (parseInt(obj.result)) {
            case 0:
                var dialog = {};
                dialog.Title = '提示信息';
                if (obj.slef_score_add != 0 || obj.vg_wealth_add != 0) {
                    dialog.Note = "签到成功~<br>您获得" + obj.slef_score_add + "点个人积分，您的后援团获得" + obj.vg_wealth_add + "点团资产。提升贵族等级，可以增加签到所得团资产。";
                } else {
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
                refresh();
                break;
        }
    },

    /**
     * 退出后援团
     */
    quitGroup: function () {
        var _reqStr = {"op_type":OpType.QuitGroup };
        MGC_Comm.sendMsg(_reqStr, "MyGroup.quitGroupCallBack");
    },

    /**
     * 退出后援团回调
     */
    quitGroupCallBack: function (obj) {
        switch (parseInt(obj.result)) {
            case 0:
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = "您已退出后援团。";
                MGC_Comm.CommonDialog(dialog);

                setTimeout("window.location.href = '/group.shtml?param=' + MgcAPI.SNSBrowser.IsQQGameLiveArea()", 1000);
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
    },

    /**
     * 弹出成员名片
     */
    showMemberCard: function (e) {
        var $a = $m(e.currentTarget);
        // MGC_cardRequest.getListCardInfo($a.data("nick"), $a.data("zone"));
        MGC_cardRequest.getListCardInfo($a.data("playerid"), $a.data("source"));
    },

    /**
     * 弹出主播名片
     */
    showAnchorCard: function (e) {
        var $a = $m(e.currentTarget);
        MGC_CommRequest.getAnchorCard($a.data("id"));
    },
};

/**
 * 后援团成员管理
 */
var MemberGroup = {

    /**
     * 当前选中的用户id（用于职位修改）
     */
    memberid: 0,

    /**
     * 当前选中的用户id（用于开除）
     */
    kickmemberid: 0,

    /**
     * 成员列表
     */
    members: [],

    /**
     * 职位列表
     */
    positions: [],

    /**
     * 新职位id
     */
    newposition: 0,

    /**
     * 初始化
     */
    init: function () {

        Tab.currentPage = MemberGroup;

        MemberGroup.getGroupPosition();
        MemberGroup.getGroupMember();

        //成员列表滚动条
        $m('.member .list').jScrollPane({
            autoReinitialise: true,
            animateScroll: true,
            callback: this.onScrollMember
        });
        //重绘滚动条 
        var scrollAPI_memberlist = $m('.member .list').data('jsp');
        if(scrollAPI_memberlist){
            scrollAPI_memberlist.initScroll();
        }

        //职位列表滚动条
        $m('.positionContainer').jScrollPane({
            autoReinitialise: true,
            animateScroll: true
        });
        //重绘滚动条 
        var scrollAPI_positionContainer = $m('.positionContainer').data('jsp');
        if(scrollAPI_positionContainer){
            scrollAPI_positionContainer.initScroll();
        }  

        //隐藏职位列表
        $m("body").not(".member .list .position a,.jspVerticalBar").click(MemberGroup.onBodyClick);
        $m(window).resize(this.onScrollMember);
    },

    /**
     * 销毁
     */
    destroy: function () {
        $m("body").off();
    },

    onBodyClick: function (e) {
        if (e.target.className == 'jspDrag jspHover' || e.target.className == 'positionContainer jspScrollable') return; /*|| e.target.className == 'memberlist' */
        MemberGroup.showPosition(false);
    },

    onScrollMember: function (e) {
        MemberGroup.showPosition(false);
    },

    /**
     * 根据id获取一个用户数据
     */
    getMember: function (id) {
        var obj;
        for (var i = 0; i < MemberGroup.members.length; i++) {
            if (MemberGroup.members[i].m_member_id == id) {
                obj = MemberGroup.members[i];
            }
        }

        return obj;
    },

    /**
     * 根据id获取一个职位数据
     */
    getPosition: function (id) {
        var obj;
        for (var i = 0; i < MemberGroup.positions.length; i++) {
            if (MemberGroup.positions[i].m_position_id == id) {
                obj = MemberGroup.positions[i];
            }
        }

        return obj;
    },

    /**
     * 请求职位列表
     */
    getGroupPosition: function () {

        var _reqStr = {"op_type": OpType.getGroupPosition};
        MGC_Comm.sendMsg(_reqStr, "MemberGroup.getGroupPositionCallBack");
    },

    /**
     * 请求职位列表回调
     */
    getGroupPositionCallBack: function (obj) {
        MemberGroup.positions = obj.positions;
    },

    /**
     * 请求后援团成员列表
     */
    getGroupMember: function () {
        var _reqStr = {"op_type":OpType.getGroupMember};
        MGC_Comm.sendMsg(_reqStr, "MemberGroup.getGroupMemberCallBack");
    },

    /**
     * 请求后援团成员列表回调
     */
    getGroupMemberCallBack: function (obj) {
        for (var i = 0; i < obj.members.length; i++) {
            //是否显示下拉按钮  有职位管理权限  职位大的
            if (GroupConfig.privilege.position == 1 && GroupConfig.position < obj.members[i].m_position) {
                obj.members[i].canEdit = true;
            } else {
                obj.members[i].canEdit = false;
            }
        }

        MemberGroup.members = obj.members;

        $m.each(obj.members, function (k, v) {
            v.m_member_zone = $m.mZone(v.m_member_zone);
        });

        var memberCon= $m('#memberTmpl');
        var memberTmpl;
        var memberContainer = $m('.member .list ul');
        memberContainer.children().remove();
        memberTmpl = memberCon.tmpl(obj.members);
        memberTmpl.appendTo(memberContainer);
        //重绘滚动条 
        //var scrollAPI_memberlist = $m('.member .list').data('jsp');
        //scrollAPI_memberlist.initScroll();
        //注册开除按钮
        memberContainer.find("li .kick a").click(MemberGroup.onKick);
        //注册职位下拉框
        memberContainer.find("li .position a").click(MemberGroup.onShowPosition);
        memberTmpl = null;
        memberCon = null;
    },

    /**
     * 弹出职位列表
     */
    onShowPosition: function (e) {
        e.stopPropagation();

        var $a = $m(e.currentTarget);
        //先让之前的弹框消失
        if ($a.data("id") != MemberGroup.memberid) {
            MemberGroup.showPosition(false);
        }

        MemberGroup.memberid = $a.data("id");
        if ($a.data("select")) {
            MemberGroup.showPosition(false);
        } else {
            MemberGroup.showPosition(true);
        }
    },

    /**
     * 显示/隐藏职位列表
     * @b true显示
     */
    showPosition: function (b) {
        var positionContainer = $m('.positionContainer');
        var $a = $m('.member .list .position a[data-id=' + MemberGroup.memberid + ']');

        if (!b) {
            $a.data("select", false);
            positionContainer.hide();
            $a.removeClass("select");
            return;
        }

        $a.data("select", true);
        positionContainer.show();
        $a.addClass("select");

        //玩家id
        var id = MemberGroup.memberid;
        //玩家职位
        var position = MemberGroup.getMember(MemberGroup.memberid).m_position;

        var data = [];
        //取出比玩家低级的职位
        for (var i = 0; i < MemberGroup.positions.length; i++) {
            if ((MemberGroup.positions[i].m_position_id > GroupConfig.position) && (MemberGroup.positions[i].m_position_id != position)) {
                data.push(MemberGroup.positions[i]);
            }
        }

        //生成职位列表
        var positionCon = $m('#positionTmpl');
        var positionTmpl;
        var positionList = $m('.positionContainer ul');
        positionList.children().remove();
        positionTmpl = positionCon.tmpl(data);
        positionTmpl.appendTo(positionList);
        //重绘滚动条 
        var scrollAPI_grouppositionlist = $m('.positionContainer').data('jsp');
        if(scrollAPI_grouppositionlist){
            scrollAPI_grouppositionlist.initScroll();
        }
        //在相应的成员处显示
        var memberContainer = $m('.member .list ul');
        var $li = memberContainer.find("li[data-id=" + id + "]");
        //$li.append(positionContainer);
        //alert($li.offset().left + "," + $li.offset().top);
        $m('.positionContainer').offset({ top: $li.offset().top + 36, left: ($li.offset().left + 522) });

        //用户id
        positionContainer.data("player_id", id);

        //注册职位按钮
        positionContainer.find("li").click(MemberGroup.onChangePosition);

        //点击成员列表滚动条后隐藏职位列表
        $m(".member .list .jspDrag").off("mousedown", this.onScrollMember).mousedown(this.onScrollMember);
        positionTmpl = null;
        positionCon = null;
    },

    /**
     * 点击某个职位
     */
    onChangePosition: function (e) {
        var $li = $m(e.currentTarget);
        MemberGroup.showPosition(false);

        //用户id
        var positionContainer = $m('.positionContainer ul');
        var player_id = positionContainer.data("player_id");
        MemberGroup.newposition = $li.data("position_id");

        MemberGroup.changePosition();
    },

    /**
     * 修改职位
     */
    changePosition: function () {
        var _reqStr = {"op_type":OpType.ChangePosition ,"player_id":MemberGroup.memberid ,"new_position":MemberGroup.newposition };
        MGC_Comm.sendMsg(_reqStr, "MemberGroup.changePositionCallBack");
    },

    /**
     * 修改职位回调
     */
    changePositionCallBack: function (obj) {
        switch (parseInt(obj.result)) {
            case 0:
                var $li = $m('.member .list li[data-id=' + obj.target_id + ']');
                var position = MemberGroup.getPosition(obj.position_id);
                $li.find(".position span").html(position.m_position_name);
                MemberGroup.getMember(MemberGroup.memberid).m_position = obj.position_id;
                break;

            case 44:
                window.mgc.common_logic.CheckNameError(58);
                break;
        }
    },

    /**
     * 点击开除
     */
    onKick: function (e) {
        var $a = $m(e.currentTarget);
        MemberGroup.kickmemberid = $a.data("id");

        var member = MemberGroup.getMember(MemberGroup.kickmemberid);

        var dialog = {};
        dialog.Title = "提示信息";
        dialog.BtnNum = 2;
        dialog.BtnName2 = "取消";

        dialog.Note = "您确定要将" + member.m_member_nick + "开除出团吗？";

        MGC_Comm.CommonDialog(dialog, MemberGroup.kick);
    },

    /**
     * 开除
     */
    kick: function () {
        var _reqStr = {"op_type":OpType.KickMember , "player_id": MemberGroup.kickmemberid };
        MGC_Comm.sendMsg(_reqStr, "MemberGroup.kickCallBack");
    },

    /**
     * 开除回调
     */
    kickCallBack: function (obj) {
        var member = MemberGroup.getMember(obj.target_id);

        switch (parseInt(obj.result)) {
            case 0:
                var dialog = {};
                dialog.Title = '提示信息';

                dialog.Note = member.m_member_nick  + "已被开除出团。";


                MGC_Comm.CommonDialog(dialog);

                var $li = $m('.member .list li[data-id=' + obj.target_id + ']');
                $li.remove();
                break;

            case 2:
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = "您没有开除的权限";
                MGC_Comm.CommonDialog(dialog);

                break;
        }
    }
};

/**
 * 后援团职位管理
 */
var PositionGroup = {

    /**
     * 当前选中的职位id
     */
    position_id: 0,

    /**
     * 当前选中的职位名称
     */
    position_name: "",

    /**
     * 当前选中的职位数据
     */
    curPosition: {},

    /**
     * 职位列表
     */
    positions: [],

    /**
     * 权限列表
     */
    rights: [],

    /**
     * 初始化
     */
    init: function () {
        PositionGroup.getGroupPosition();
    },

    /**
     * 根据id获取某个职位数据
     */
    getPositionData: function (id) {
        var obj;
        for (var i = 0; i < PositionGroup.positions.length; i++) {
            if (PositionGroup.positions[i].m_position_id == id) {
                obj = PositionGroup.positions[i];
            }
        }

        return obj;
    },

    /**
     * 请求职位列表
     */
    getGroupPosition: function () {

        var _reqStr = {"op_type":OpType.getGroupPosition };
        MGC_Comm.sendMsg(_reqStr, "PositionGroup.getGroupPositionCallBack");
    },

    /**
     * 请求职位列表回调
     */
    getGroupPositionCallBack: function (obj) {

        //比玩家职位小的职位  不显示改名按钮
        for (var i = 0; i < obj.positions.length; i++) {
            if (obj.positions[i].m_position_id > GroupConfig.position) {
                obj.positions[i].canRename = true;
            } else {
                obj.positions[i].canRename = false;
            }
        }
        PositionGroup.positions = obj.positions;

        //生成职位列表
        var positionCon = $m('#positionTmpl');
        var positionTmpl;
        var positionContainer2 = $m('.positionContainer2 .list ul');
        positionContainer2.children().remove();
        positionTmpl = positionCon.tmpl(PositionGroup.positions);
        positionTmpl.appendTo(positionContainer2);

        //选中事件
        positionContainer2.find("li").click(PositionGroup.selectPosition);
        //改名
        positionContainer2.find("a.rename").click(PositionGroup.onRename);
        //确定改名
        positionContainer2.find("a.confirm").click(PositionGroup.renameConfirm);
        //改名输入框限制6个中文字符
        positionContainer2.find("input").keydown(PositionGroup.onNameChange).keyup(PositionGroup.onNameChange);

        //默认显示第一个职位的权限
        PositionGroup.position_id = 0;
        PositionGroup.updateRight(PositionGroup.positions[0].m_position_id);
        positionTmpl = null;
        positionCon = null;
    },

    /**
     * 改名输入框限制6个中文字符
     */
    onNameChange: function (e) {
        var $input = $m(e.currentTarget);
        var val = $input.val();
        var len = MGC_Comm.Strlen(val);

        if (len > 12) {
            $input.val(MGC_Comm.Strcut(val, 12));
        }
    },

    /**
     * 改名
     */
    onRename: function (e) {
        var $a = $m(e.currentTarget);
        var id = $a.data("position_id");
        PositionGroup.updateRight(id);
        PositionGroup.canEdit(true);
    },

    /**
     * 是否编辑状态
     * @b 可编辑
     */
    canEdit: function (b) {
        //先确定是否可编辑
        if (!PositionGroup.curPosition.canRename)
            return;

        var positionContainer2 = $m('.positionContainer2');
        var $li = positionContainer2.find("li[data-position_id=" + PositionGroup.position_id + "]");
        if ($li.length <= 0)
            return;
        //可编辑
        var $input = $li.find(".name input");
        if (b) {
            $input.attr("readOnly", false);
            //光标放最后
            var t = $input.val();
            $input.val("").focus().val(t);

            $li.find(".rename").hide();
            $li.find(".confirm").show();
        } else {
            $input.attr("readOnly", true);

            $li.find(".rename").show();
            $li.find(".confirm").hide();

            //回滚之前的名称
            var position = PositionGroup.getPositionData(PositionGroup.position_id);
            $input.val(position.m_position_name);
        }

    },

    /**
     * 确定改名
     */
    renameConfirm: function (e) {
        var positionContainer2 = $m('.positionContainer2');
        var $li = positionContainer2.find("li[data-position_id=" + PositionGroup.position_id + "]");

        var $input = $li.find(".name input");

        //判断空格
        if ($input.val().indexOf(" ") != -1) {
            var dialog = {};
            dialog.Title = '提示信息';
            dialog.Note = '职位名不能包含空格';
            MGC_Comm.CommonDialog(dialog);
            return;
        }

        //修改本地数据
        PositionGroup.curPosition.m_position_name = $input.val();
        //提交服务器
        PositionGroup.updateGroupPosition();
        //不可编辑
        //PositionGroup.canEdit(false);
    },

    /**
     * 选中某个职位
     */
    selectPosition: function (e) {
        var $li = $m(e.currentTarget);
        PositionGroup.updateRight($li.data("position_id"));
    },

    /**
     * 更新权限界面
     * @id 职位id
     */
    updateRight: function (id) {
        //跟之前选择一致不用更新
        if (PositionGroup.position_id == id)
            return;

        //取消之前的编辑状态
        PositionGroup.canEdit(false);

        PositionGroup.position_id = id;

        //职位选中效果
        var positionContainer2 = $m('.positionContainer2 .list ul');
        positionContainer2.find("li").removeClass("select");
        positionContainer2.find("li[data-position_id=" + id + "]").addClass("select");

        //获取相应权限的数据  拷贝数据
        PositionGroup.curPosition = $m.extend({}, PositionGroup.getPositionData(PositionGroup.position_id));
        PositionGroup.rights = [];
        PositionGroup.rights.push({
            right_id: "Manage",
            name: "管理后援团信息(编辑后援团的团公告与团简介)",
            select: PositionGroup.curPosition.Manage
        });
        PositionGroup.rights.push({
            right_id: "InviteApprove",
            name: "邀请和审核团员（邀请人加入后援团，以及审核入团申请）",
            select: PositionGroup.curPosition.InviteApprove
        });
        PositionGroup.rights.push({
            right_id: "Kick",
            name: "开除出团（将团员开除出本团）",
            select: PositionGroup.curPosition.Kick
        });
        PositionGroup.rights.push({
            right_id: "Ticket",
            name: "助威&粉丝牌（进行助威以及PC粉丝牌的购买）",
            select: PositionGroup.curPosition.Ticket
        });
        PositionGroup.rights.push({
            right_id: "PositionManage",
            name: "成员职位管理（为团成员赋予职务，以及管理职位的权限）",
            select: PositionGroup.curPosition.PositionManage
        });

        //生成权限列表
        var rightCon= $m('#rightTmpl');
        var rightTmpl;
        var rightlist = $m('.rightlist ul');
        rightlist.children().remove();
        rightTmpl = rightCon.tmpl(PositionGroup.rights);
        rightTmpl.appendTo(rightlist);

        //勾选按钮
        rightlist.find("li a").click(PositionGroup.selectRight);
        rightTmpl = null;
        rightCon = null;
    },

    /**
     * 勾选某个权限
     */
    selectRight: function (e) {
        if (GroupConfig.position >= PositionGroup.position_id) {
            return;
        }
        var $a = $m(e.currentTarget);

        //alert("勾选权限：" + $a.data("right_id"));
        var right_id = $a.data("right_id");
        if ($a.data("select") == 1) {
            $a.data("select", 0);
            $a.removeClass("select");
        } else {
            $a.data("select", 1);
            $a.addClass("select");
        }

        //修改本地数据
        PositionGroup.curPosition[right_id] = $a.data("select");
        //提交服务器
        PositionGroup.updateGroupPosition();
    },

    /**
     * 提交修改职位信息
     */
    updateGroupPosition: function () {
        //var _reqStr = "{\"op_type\":" + OpType.KickMember + ", \"player_id\":\"" + MemberGroup.kickmemberid + "\"}";
        //var _reqStr = "{\"op_type\":" + OpType.UpdateGroupPosition + ", \"position_id\":" + PositionGroup.curPosition.m_position_id + ", \"position_name\":" + PositionGroup.curPosition.m_position_name + ", \"manage\":" + PositionGroup.curPosition.Manage + ", \"inviteApprove\":" + PositionGroup.curPosition.InviteApprove + ", \"kick\":" + PositionGroup.curPosition.Kick + ", \"ticket\":" + PositionGroup.curPosition.Ticket + ", \"positionManage\":" + PositionGroup.curPosition.PositionManage +  "}";
        //MGC_Comm.sendMsg(_reqStr, "PositionGroup.updateGroupPositionCallBack");

        var _reqStr = {};
        _reqStr.op_type = OpType.UpdateGroupPosition;
        _reqStr.position_id = PositionGroup.curPosition.m_position_id;
        _reqStr.position_name = PositionGroup.curPosition.m_position_name;
        _reqStr.manage = PositionGroup.curPosition.Manage;
        _reqStr.inviteApprove = PositionGroup.curPosition.InviteApprove;
        _reqStr.kick = PositionGroup.curPosition.Kick;
        _reqStr.ticket = PositionGroup.curPosition.Ticket;
        _reqStr.positionManage = PositionGroup.curPosition.PositionManage;
        MGC_Comm.sendMsg(_reqStr, "PositionGroup.updateGroupPositionCallBack");
    },

    /**
     * 修改职位信息回调
     */
    updateGroupPositionCallBack: function (obj) {
        //alert("修改职位信息回调");
        obj = MGC_Comm.strToJson(obj);
        switch (obj.result) {
            case 0:
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '职位名修改成功！';
                //MGC_Comm.CommonDialog(dialog);
                //CheerGroup.getGroupInfo();
                //成功后同步本地数据
                PositionGroup.updateLocalPosition();
                PositionGroup.canEdit(false);
                break;
            case 2:
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '没有修改权限，请刷新重试~！';
                MGC_Comm.CommonDialog(dialog);
                break;
            case 38:
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '职位名重复！';
                MGC_Comm.CommonDialog(dialog);
                //CheerGroup.getGroupInfo();
                break;
            case 33:
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '职名有敏感词';
                MGC_Comm.CommonDialog(dialog);
                break;
            case 34:
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '职位名长度错误！';
                MGC_Comm.CommonDialog(dialog);
                break;

            case 44:
                window.mgc.common_logic.CheckNameError(59);
                break;
        }
    },

    /**
     * 同步本地数据
     */
    updateLocalPosition: function () {
        var obj = PositionGroup.getPositionData(PositionGroup.curPosition.m_position_id);
        $m.extend(obj, PositionGroup.curPosition);
    }
};

/**
 * 后援团助威
 */
var CheerGroup = {

    /**
     * 助威次数
     */
    cheerCount: 0,

    /**
     * 后援团id
     */
    vgid: 0,

    /**
     * 已助威次数
     */
    hasCheerCount: 0,

    /**
     * 最大助威次数
     */
    maxCheerCount: 10,

    /**
     * 初始化
     */
    init: function () {
        //请求后援团信息
        CheerGroup.getGroupInfo();

        //主播名片
        $m(".cheer .left .card").click(CheerGroup.showAnchorCard);

        //助威文本变化
        $m(".cheer .right .count").keyup(CheerGroup.changeCheer);
        //助威按钮未激活
        CheerGroup.canCheer(false);

        if (GroupConfig.privilege.fans != 1) {
            $m(".cheer .right .count").attr("disabled", "");
        }

        //助威滚动条
        $m('.cheerinfo .list').jScrollPane({
            autoReinitialise: true,
            animateScroll: true
        });
        //重绘滚动条 
        var scrollAPI_cheerinfolist = $m('.cheerinfo .list').data('jsp');
        if(scrollAPI_cheerinfolist){
            scrollAPI_cheerinfolist.initScroll();
        }
    },

    /**
     * 弹出主播名片
     */
    showAnchorCard: function (e) {
        var $a = $m(e.currentTarget);
        MGC_CommRequest.getAnchorCard($a.data("id"));
    },

    /**
     * 助威次数确定
     */
    confirmCheer: function(e) {
        var $input = $m(".cheer .right .count");
        CheerGroup.cheerCount = $input.val();
        $input.val(0);
        CheerGroup.canCheer(false);
        CheerGroup.sendCheer();
    },
    /**
    * 助威次数确定
    */
    confirmCheerDis: function(e) {
        var $input = $m(".cheer .right .count");
        CheerGroup.cheerCount = $input.val();
        $input.val(0);
    },

    /**
     * 助威文本变化
     */
    changeCheer: function (e) {
        var $input = $m(e.currentTarget);

        //数量超过上限时显示最大值
        var leftCheerCount = CheerGroup.maxCheerCount - CheerGroup.hasCheerCount;
        if ($input.val() > leftCheerCount) {
            $input.val(leftCheerCount);
        }

        //输入为空时显示默认值0
        if ($input.val() == "") {
            $input.val(0);
        }

        //过滤数字前的0
        var value = parseInt($input.val());
        $input.val(value);

        //是否激活助威按钮
        if ($input.val() == "0") {
            CheerGroup.canCheer(false);
        } else {
            CheerGroup.canCheer(true);
        }
    },

    /**
     * 助威按钮是否激活
     */
    canCheer: function (b) {
        var $a = $m(".cheer .right .confirm");
        if (b) {
            $a.removeClass();
            $a.addClass("confirm confirmenabled");
            $a.off().click(CheerGroup.confirmCheer);
        } else {
            $a.removeClass();
            $a.addClass("confirm confirmdisabled");
            $a.off().click(CheerGroup.confirmCheerDis);;
        }
    },

    /**
     * 发送助威
     */
    sendCheer: function () {
        var _reqStr = {"op_type": OpType.SendCheer,"cnt": CheerGroup.cheerCount };
        MGC_Comm.sendMsg(_reqStr, "CheerGroup.sendCheerCallBack");
    },

    /**
     * 发送助威回调
     */
    sendCheerCallBack: function (obj) {
        switch (parseInt(obj.result)) {
            case 0:
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = "助威成功~您的主播增加了" + obj.score_add + "点主播积分。";
                MGC_Comm.CommonDialog(dialog);
                break;
            case 10:
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '您的团内资产不足，请重新输入数量';
                MGC_Comm.CommonDialog(dialog);
                break;
            case 9:
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '对不起，每天助威的次数不能超过10次。';
                MGC_Comm.CommonDialog(dialog);
                break;
            case 2:
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '对不起，您没有权限。';
                MGC_Comm.CommonDialog(dialog);
                break;

            case 25:
                refresh();
                break;
        }

        //请求后援团信息
        CheerGroup.getGroupInfo();
    },

    /**
     * 请求后援团信息
     */
    getGroupInfo: function () {
        var _reqStr = {"op_type": OpType.GetGroupInfo };
        MGC_Comm.sendMsg(_reqStr, "CheerGroup.getGroupInfoCallBack");
    },

    /**
     * 请求后援团信息回调"' + _info.video_money + '梦幻币"
     */
    getGroupInfoCallBack: function (obj) {
        //后援团信息
        $m("#vg_wealth").html(obj.info.vg_wealth);
        if (obj.info.anchor_level != 0) {

            obj.anchor_level_temp = 0;
            obj.anchor_level_temp = Math.floor(obj.info.anchor_level / 10) + 1;
            if (obj.info.anchor_level == 0) {
                obj.anchor_level_temp = 0;
            }
            $m("#anchor_level").attr('class', 'anchor_level_' + obj.anchor_level_temp);
            $m("#anchor_level").css({"background": "url(http://ossweb-img.qq.com/images/mgc/css_img/common/anchor_level/" + obj.anchor_level_temp +".png?v=3_8_8_2016_15_4_final_3) no-repeat"});
            $m("#anchor_level").attr('onmouseover', 'MGC.susTips_personal(event,1,"主播等级:' + obj.info.anchor_level + '")');
            $m("#anchor_level").attr('onmouseout', 'MGC.susTips_personal(event,0)');
            $m("#anchor_level").html('<i>' + obj.info.anchor_level + '</i>');
        }
        $m("#anchor_name").html(obj.info.anchor_name);
        $m("#anchor_score").html(obj.anchor_score);
        $m("#anchor_cont_score").html(obj.info.anchor_cont_score);
        $m("#anchorAvatarUrl").attr('src', obj.info.anchorAvatarUrl);
        $m("#today_ticket_acc").html(obj.info.today_ticket_acc + "/10");
        $m("#anchor_pstid").data("id", obj.info.anchor_pstid);

        if (obj.anchor_rank <= 0) {
            $m("#anchor_rank").html("未上榜");
        } else {
            $m("#anchor_rank").html(obj.anchor_rank);
        }

        //已助威次数
        CheerGroup.hasCheerCount = obj.info.today_ticket_acc;
        CheerGroup.vgid = obj.self_info.m_vg_id;

        //请求后援团日志
        CheerGroup.getGroupLog();
    },

    /**
     * 请求后援团日志
     */
    getGroupLog: function () {
        var _reqStr = {"op_type":OpType.GetGroupLog,"vgid":CheerGroup.vgid };
        MGC_Comm.sendMsg(_reqStr, "CheerGroup.getGroupLogCallBack");
    },

    /**
     * 请求后援团日志回调
     */
    getGroupLogCallBack: function (obj) {
        var cheerCon = $m('#cheerTmpl');
        var cheerTmpl;
        var cheerlist = $m('.cheerinfo ul');
        cheerlist.children().remove();
        $m.each(obj.recordInfo, function (k, v) {
            var msg = v.msg;
            // if (msg.indexOf('[梦工厂]') < 0) {
            // var insertPos = msg.indexOf('[');
            // if (insertPos >= 0) {
            // v.msg = msg.substr(0, insertPos + 1) + '炫舞-' + msg.substr(insertPos + 1);
            // }
            // }
            var zcIndex = msg.indexOf("为支持的主播");
            var leftIndex = 0;
            for (var i = zcIndex; i > 0; i--) {
                if (msg[i] == "[") {
                    leftIndex = i;
                }
            }
            v.msg = msg.substring(0, leftIndex) + msg.substring(zcIndex);
        });
        cheerTmpl = cheerCon.tmpl(obj.recordInfo);
        cheerTmpl.appendTo(cheerlist);
        //重绘滚动条 
        var scrollAPI_grouploglist = $m('.cheerinfo .list').data('jsp');
        if(scrollAPI_grouploglist){
            scrollAPI_grouploglist.initScroll();
        }
        cheerTmpl = null;
        cheerCon = null;
    }
};

/**
 * 团长专属
 */
var HeadGroup = {

    /**
     * 要修改的团名
     */
    headName: "",

    /**
     * 要支持的主播id
     */
    anchorid: "",

    /**
     * 要支持的主播名
     */
    anchornick: "",

    /**
     * 要传位的成员id
     */
    memberid: "",

    /**
     * 要传位的成员名
     */
    membernick: "",

    /**
     * 传位倒计时  分钟  0位无传位
     */
    demiseTime: 0,

    /**
     * 解散倒计时  分钟  0位无传位
     */
    dismissTime: 0,

    /**
     * 初始化
     */
    init: function () {
        //获取成员列表
        HeadGroup.getMemberList();
        //获取后援团信息
        HeadGroup.getGroupInfo();

        //主播列表滚动条
        $m('.anchorList').jScrollPane({
            autoReinitialise: true,
            animateScroll: true
        });
        //重绘滚动条 
        var scrollAPI_anchorList = $m('.anchorList').data('jsp');
        if(scrollAPI_anchorList){
            scrollAPI_anchorList.initScroll();
        }
        //成员列表滚动条
        $m('.memberList').jScrollPane({
            autoReinitialise: true,
            animateScroll: true
        });
        //重绘滚动条 
        var scrollAPI_memberList = $m('.memberList').data('jsp');
        if(scrollAPI_memberList){
            scrollAPI_memberList.initScroll();
        }

        $m('.jspDrag').css('backgroundColor', '#25a8e9')

        //修改团名按钮未激活
        HeadGroup.canRenameHead(false);
        $m(".groupname .name").keyup(HeadGroup.onRenameHeadChange);

        //修改团名
        HeadGroup.onHeadName();

        //点击更改支持主播未激活
        HeadGroup.canChangeAnchor(false);
        //主播下拉框按钮
        $m(".anchor .list").click(HeadGroup.onAnchorList);

        //点击团长传位未激活
        HeadGroup.canDemise(false);

        //取消团长传位
        $m(".position .cancel").click(HeadGroup.onCancelDemise);
        //成员下拉框按钮
        $m(".position .list").click(HeadGroup.onMemberList);

        //解散按钮未激活
        HeadGroup.canDismiss(false);
        $m(".dismiss .name").keyup(HeadGroup.onDismissChange);
        //取消解散按钮
        $m(".dismiss .cancel").click(HeadGroup.onCancelDismiss);

    },

    /**
     * 销毁
     */
    destroy: function () {
        $m("body").off();
    },

    onBodyClick: function (e) {
        HeadGroup.showAnchorList(false);
        HeadGroup.showMemberList(false);
    },

    /**
     * 点击修改团名
     */
    onHeadName: function (e) {
        HeadGroup.headName_before = "请输入团名";
        $m("#putGroupName").keyup(function () {
            var v = $m.trim($m(this).val());
            if (MGC_Comm.Strlen(v) > 16) {
                $m(this).val(MGC_Comm.Strcut(v, 16));
            }
        }).keydown(function () {
            var v = $m(this).val();
            if (MGC_Comm.Strlen(v) >= 16) {
                event.returnValue = false;
            }
            if (event.keyCode == 8) {
                event.returnValue = true;
                ;
            }
        })
        var dialog = {};        
        
        HeadGroup.headName = $m("#putGroupName").val();
        if (HeadGroup.headName_before != HeadGroup.headName) {
            if (HeadGroup.headName.indexOf(" ") != -1) {                
                    dialog.Note = "名字不能包含空格。";
                    MGC_Comm.CommonDialog(dialog);
                    return false;                    
            } else if (HeadGroup.headName.length == 0) {
                dialog.Note = "名字不能为空。";
                MGC_Comm.CommonDialog(dialog);
                return false;
            } else {
                HeadGroup.renameHead();
            }
            
           
        }
    },

    /**
     * 点击更改支持主播
     */
    onChangeAnchor: function (e) {
        HeadGroup.changeAnchor();
        //alert("点击更改支持主播" + HeadGroup.anchornick);
    },

    /**
     * 选中某个主播
     */
    onSelectAnchor: function (e) {
        var $li = $m(e.currentTarget);
        HeadGroup.anchorid = $li.data("id");
        HeadGroup.anchornick = $li.data("nick");
        HeadGroup.showAnchorList(false);

        $m(".anchor .name").html(HeadGroup.anchornick);
        HeadGroup.canChangeAnchor(true);
    },

    /**
     * 点击主播下拉框
     */
    onAnchorList: function (e) {
        e.stopPropagation();

        var $a = $m(e.currentTarget);
        if ($a.data("select")) {
            HeadGroup.showAnchorList(false);
        } else {
            HeadGroup.showAnchorList(true);
        }
    },

    /**
     * 点击团长传位
     */
    onDemise: function (e) {
        HeadGroup.demise();
        //alert("点击团长传位" + HeadGroup.memberid);
    },

    /**
     * 点击取消团长传位
     */
    onCancelDemise: function (e) {
        var dialog = {};
        dialog.Title = '取消团长传位';
        dialog.BtnNum = 2;
        dialog.BtnName = '取消传位';
        dialog.BtnName2 = '关闭';
        dialog.Note = '您是否要取消团长的传位操作？';
        MGC_Comm.CommonDialog(dialog, HeadGroup.cancelDemise);
    },

    /**
     * 选中某个成员
     */
    onSelectMember: function (e) {
        var $li = $m(e.currentTarget);
        HeadGroup.memberid = $li.data("id");
        HeadGroup.membernick = $li.data("nick");
        HeadGroup.showMemberList(false);

        $m(".position .name").html(HeadGroup.membernick);
        HeadGroup.canDemise(true);
    },

    /**
     * 点击成员下拉框
     */
    onMemberList: function (e) {
        e.stopPropagation();

        var $a = $m(e.currentTarget);
        if ($a.data("select")) {
            HeadGroup.showMemberList(false);
        } else {
            HeadGroup.showMemberList(true);
        }
    },

    /**
     * 解散
     */
    onDismiss: function (e) {
        HeadGroup.dismissGroup();
    },

    /**
     * 取消解散
     */
    onCancelDismiss: function (e) {
        var dialog = {};
        dialog.Title = '取消解散后援团';
        dialog.BtnNum = 2;
        dialog.BtnName = '取消解散';
        dialog.BtnName2 = '关闭';
        dialog.Note = '您是否确定要取消对后援团的解散操作？';
        MGC_Comm.CommonDialog(dialog, HeadGroup.cancelDismissGroup);
    },

    /**
     * 显示/隐藏主播列表
     * @b true 显示
     */
    showAnchorList: function (b) {
        var $a = $m(".anchor .list");
        if (b) {
            //获取玩家关注的主播
            HeadGroup.getAnchorList();

            $a.addClass("select");
            $a.data("select", true);
            window.mgc.popmanager.layerControlShow($m('.anchorList'), 1, 2);
            //隐藏主播/团员列表
            //$m("body").click(HeadGroup.onBodyClick);
        } else {
            //隐藏主播/团员列表
            $m("body").off();

            $a.removeClass("select");
            $a.data("select", false);
            window.mgc.popmanager.layerControlHide($m('.anchorList'), 1, 2);
        }
    },

    /**
     * 显示/隐藏成员列表
     * @b true 显示
     */
    showMemberList: function (b) {
        var $a = $m(".position .list");
        if (b) {
            HeadGroup.getMemberList();
            $a.addClass("select");
            $a.data("select", true);
            window.mgc.popmanager.layerControlShow($m('.memberList'), 1, 2);
            //隐藏主播/团员列表
            //$m("body").click(HeadGroup.onBodyClick);
        } else {
            //隐藏主播/团员列表
            $m("body").off();

            $a.removeClass("select");
            $a.data("select", false);
            window.mgc.popmanager.layerControlHide($m('.memberList'), 1, 2);

        }
    },

    /**
     * 修改团名文本框改变
     */
    onRenameHeadChange: function (e) {
        var $input = $m(e.currentTarget);
        var txt = $input.val();
        if (txt.length > 0) {
            HeadGroup.canRenameHead(true);
        } else {
            HeadGroup.canRenameHead(false);
        }
    },

    /**
     * 解散后媛团文本框改变
     */
    onDismissChange: function (e) {
        var $input = $m(e.currentTarget);
        if ($input.val() == "DISMISS") {
            HeadGroup.canDismiss(true);
        } else {
            HeadGroup.canDismiss(false);
        }
    },

    /**
     * 修改团名按钮是否激活
     */
    canRenameHead: function (b) {
        //点击修改团名
        var $a = $m(".groupname .confirm");
        if (b) {
            $a.removeClass();
            $a.addClass("confirm confirmenabled");            
            $a.off().click(HeadGroup.onHeadName);
        } else {
            $a.removeClass();
            $a.addClass("confirm confirmdisabled");
            $a.off();
        }
    },

    /**
     * 更改主播按钮是否激活
     */
    canChangeAnchor: function (b) {
        //点击修改团名
        var $a = $m(".anchor .confirm");
        if (b) {
            $a.removeClass();
            $a.addClass("confirm confirmenabled");
            $a.off().click(HeadGroup.onChangeAnchor);
        } else {
            $a.removeClass();
            $a.addClass("confirm confirmdisabled");
            $a.off();
        }
    },

    /**
     * 团长传位按钮是否激活
     */
    canDemise: function (b) {
        //点击修改团名
        var $a = $m(".position .confirm");
        if (b) {
            $a.removeClass();
            $a.addClass("confirm confirmenabled");
            $a.off().click(HeadGroup.onDemise);
        } else {
            $a.removeClass();
            $a.addClass("confirm confirmdisabled");
            $a.off();
        }
    },

    /**
     * 解散后援团按钮是否激活
     */
    canDismiss: function (b) {
        //点击修改团名
        var $a = $m(".dismiss .confirm");
        if (b) {
            $a.removeClass();
            $a.addClass("confirm confirmenabled");
            $a.off().click(HeadGroup.onDismiss);
        } else {
            $a.removeClass();
            $a.addClass("confirm confirmdisabled");
            $a.off();
        }
    },

    /**
     * 修改团名
     */
    renameHead: function () {
        var _reqStr = {"op_type":OpType.RenameHead , "name":HeadGroup.headName };
        MGC_Comm.sendMsg(_reqStr, "HeadGroup.renameHeadCallBack");
    },

    /**
     * 修改团名回调
     */
    renameHeadCallBack: function (obj) {
        switch (parseInt(obj.result)) {
            case 0:
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '后援团更名成功~';
                MGC_Comm.CommonDialog(dialog);
                HeadGroup.getGroupInfo();
                break;
            case 4:
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '服务器内部错误~';
                MGC_Comm.CommonDialog(dialog);
                break;
            case 17:
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '对不起，您的团名中存在敏感字，请重新输入。';
                MGC_Comm.CommonDialog(dialog);
                break;
            case 15:
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '对不起，您的团名与其他团重复，或者输入有误，请重新输入。';
                MGC_Comm.CommonDialog(dialog);
                break;
            case 13:
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '您的炫豆不足，改名失败。';
                MGC_Comm.CommonDialog(dialog);
                break;
        }
    },

    /**
     * 更改支持主播
     */
    changeAnchor: function () {
        var _reqStr = {"op_type":OpType.ChangeAnchor , "anchor_pstid":HeadGroup.anchorid , "anchor_nick":HeadGroup.anchornick };
        MGC_Comm.sendMsg(_reqStr, "HeadGroup.changeAnchorCallBack");
    },

    /**
     * 更改支持主播回调
     */
    changeAnchorCallBack: function (obj) {
        switch (parseInt(obj.result)) {
            case 0:
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '支持主播更换成功。';
                MGC_Comm.CommonDialog(dialog);
                break;
            case 12:
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '您选择的主播名有误，或者您选择了正在支持的主播，无法更改。';
                MGC_Comm.CommonDialog(dialog);
                break;
            case 13:
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '您的炫豆不足，无法更改。';
                MGC_Comm.CommonDialog(dialog);
                break;
                //TODO
            case 39:
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '您选择的主播名有误，或者您选择了正在支持的主播，无法更改。';
                MGC_Comm.CommonDialog(dialog);
                break;
        }
    },

    /**
     * 团长传位
     */
    demise: function () {
        var _reqStr = {"op_type":OpType.Demise,"player_id":(HeadGroup.memberid).toString() };
        MGC_Comm.sendMsg(_reqStr, "HeadGroup.demiseCallBack");
    },

    /**
     * 团长传位回调
     */
    demiseCallBack: function (obj) {
        switch (parseInt(obj.result)) {
            case 0:
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '您的团长身份将会在7天后转移给其他团员，您可以随时取消团长的传位操作。';
                MGC_Comm.CommonDialog(dialog);
                break;
        }

        HeadGroup.getGroupInfo();
    },

    /**
     * 取消团长传位
     */
    cancelDemise: function () {
        var _reqStr = {"op_type":OpType.CancelDemise , "player_id": HeadGroup.memberid };
        MGC_Comm.sendMsg(_reqStr, "HeadGroup.cancelDemiseCallBack");
    },

    /**
     * 取消团长传位回调
     */
    cancelDemiseCallBack: function (obj) {
        HeadGroup.getGroupInfo();
    },

    /**
     * 解散后援团
     */
    dismissGroup: function () {
        var _reqStr = {"op_type":OpType.DismissGroup };
        MGC_Comm.sendMsg(_reqStr, "HeadGroup.dismissGroupCallBack");
    },

    /**
     * 解散后援团回调
     */
    dismissGroupCallBack: function (obj) {
        switch (parseInt(obj.result)) {
            case 0:
                var dialog = {};
                dialog.Title = '提示信息';
                dialog.Note = '您的所在的后援团将在7天后解散，您可以随时取消后援团的解散操作。';
                MGC_Comm.CommonDialog(dialog);
                break;
        }

        HeadGroup.getGroupInfo();
    },

    /**
     * 取消解散后援团
     */
    cancelDismissGroup: function () {
        var _reqStr = {"op_type": OpType.CancelDismissGroup };
        MGC_Comm.sendMsg(_reqStr, "HeadGroup.cancelDismissGroupCallBack");
    },

    /**
     * 取消解散后援团回调
     */
    cancelDismissGroupCallBack: function (obj) {
        HeadGroup.getGroupInfo();
        HeadGroup.canDismiss(false);
        $m('.dismiss .name').val('');
    },

    /**
     * 获取玩家关注的主播
     */
    getAnchorList: function () {
        var _reqStr = {"op_type": OpType.GetAnchorList };
        MGC_Comm.sendMsg(_reqStr, "HeadGroup.getAnchorListCallBack");
    },

    /**
     * 获取玩家关注的主播回调
     */
    getAnchorListCallBack: function (obj) {
        var anchorCon = $m('#anchorTmpl');
        var anchorTmpl;
        var anchorlist = $m('.anchorList ul');
        anchorlist.children().remove();
        anchorTmpl = anchorCon.tmpl(obj.infos);
        anchorTmpl.appendTo(anchorlist);
        //重绘滚动条 
        var scrollAPI_groupanchorlist = $m('#anchorListSel').data('jsp');
        if(scrollAPI_groupanchorlist){
            scrollAPI_groupanchorlist.initScroll();
        }
        //点击列表事件
        anchorlist.find("li").click(HeadGroup.onSelectAnchor);
        anchorTmpl = null;
        anchorCon = null;
    },

    /**
     * 获取成员列表(团长传位)
     */
    getMemberList: function () {
        var _reqStr = {"op_type":OpType.GetMemberList};
        MGC_Comm.sendMsg(_reqStr, "HeadGroup.getMemberListCallBack");
    },

    /**
     * 获取成员列表回调
     */
    getMemberListCallBack: function (obj) {
        var memberCon = $m('#memberTmpl');
        var memberTmpl;
        var memberList = $m('.memberList ul');
        memberList.children().remove();
        memberTmpl = memberCon.tmpl(obj.members);
        memberTmpl.appendTo(memberList);
        //重绘滚动条 
        var scrollAPI_groupmemberlist = $m('#memberListSel').data('jsp');
        if(scrollAPI_groupmemberlist){
            scrollAPI_groupmemberlist.initScroll();
        }
        //点击列表事件
        memberList.find("li").click(HeadGroup.onSelectMember);
        memberTmpl = null;
        memberCon = null;
    },

    /**
     * 请求后援团信息
     */
    getGroupInfo: function () {

        var _reqStr = {"op_type":OpType.GetGroupInfo };
        MGC_Comm.sendMsg(_reqStr, "HeadGroup.getGroupInfoCallBack");
    },

    /**
     * 请求后援团信息回调
     */
    getGroupInfoCallBack: function (obj) {
        //没有后援团
        if (obj.result == 25) {

        } else if (obj.result == 0) {
            HeadGroup.dismissTime = obj.info.vg_dismiss;
            if (HeadGroup.dismissTime <= 0) {
                $m(".dismiss .confirm").show();
                $m(".dismiss .cancel").hide();

                $m(".dismiss .box").show();
                $m(".dismiss .name").show();
                $m(".dismiss .info").hide();
            } else {
                $m(".dismiss .confirm").hide();
                $m(".dismiss .cancel").show();

                $m(".dismiss .box").hide();
                $m(".dismiss .name").hide();
                $m(".dismiss .info").show();

                $m("#dismissTime").html(HeadGroup.getTime(HeadGroup.dismissTime));
            }

            HeadGroup.demiseTime = obj.info.vg_demise_time;
            if (HeadGroup.demiseTime <= 0) {
                $m(".position .confirm").show();
                $m(".position .cancel").hide();

                $m(".position .head").show();
                $m(".position .box").show();
                $m(".position .name").show();
                $m(".position .list").show();
                $m(".position .info").hide();
            } else {
                $m(".position .confirm").hide();
                $m(".position .cancel").show();

                $m(".position .head").hide();
                $m(".position .box").hide();
                $m(".position .name").hide();
                $m(".position .list").hide();
                $m(".position .info").show();

                HeadGroup.memberid = obj.info.demised_chief_pstid;
                $m("#demiseTime").html(HeadGroup.getTime(HeadGroup.demiseTime));
                $m("#demised_chief_name").html(obj.info.demised_chief_name);
            }
        }
    },

    /**
     * 返回格式化的时间
     * @time 分钟
     */
    getTime: function (time) {
        var day = parseInt(time / (60 * 60 * 24));

        if (day > 0) {
            return day + "天";
        }

        var hour = parseInt(time / (60 * 60));

        if (hour > 0) {
            return hour + "小时";
        }

        return "不足1小时";
    }
};

/**
 * 后援团信息
 */
var GroupInfo = {
    /**
     * 初始化
     */
    init: function () {

        //获取后援团信息
        GroupInfo.getGroupInfo();
        //修改团公告
        GroupInfo.signatureLimit();
        //修改团简介
        GroupInfo.introLimit();

    },

    /**
     * 请求后援团信息
     */
    getGroupInfo: function () {

        var _reqStr = {"op_type":OpType.GetGroupInfo };
        MGC_Comm.sendMsg(_reqStr, "GroupInfo.getGroupInfoCallBack");
    },

    /**
     * 请求后援团信息回调
     */
    getGroupInfoCallBack: function (obj) {
        //后援团信息
        $m("#activeIntegral").html(obj.info.vg_score);
        $m("#actIntegral").html(obj.info.vg_score);
        $m("#thisMonthContribute").html(obj.info.anchor_cont_score);
        $m("#lastMonthContribute").html(obj.info.last_month_cont);
        var lastContributeRank = obj.info.last_cont_rank;
        if (lastContributeRank != -1) {
            $m("#lastContributeRank").html(lastContributeRank += 1);
        } else {
            $m("#lastContributeRank").html('1000名以后');
        }
        $m("#anchorGiveScore").html(obj.info.anchor_give_score);
        if (obj.info.vg_notice != "") {
            $m("#vgNotice").html(obj.info.vg_notice);
        }
        else {
            $m("#vgNotice").html("请输入内容，上限为80个汉字");
            $m("#vgNotice").css("color", "#9b9b9b");
        }
        if (obj.info.vg_desc != "") {
            $m("#vgDesc").html(obj.info.vg_desc);
        }
        else {
            $m("#vgDesc").html("请输入内容，上限为80个汉字");
            $m("#vgDesc").css("color", "#9b9b9b");
        }
        GroupConfig.vgnotice = obj.info.vg_notice;
        GroupConfig.vgdesc = obj.info.vg_desc;
        //没有后援团修改公告、简介权限 不可编辑，无确认修改按钮
        if (GroupConfig.privilege.manage != 0) {
            $m("#vgNoticeSubmit").css('display', '').unbind("click").click(GroupInfo.updateMygroupNotice);
            $m("#vgDescSubmit").css('display', '').unbind("click").click(GroupInfo.updateMygroupDesc);

        } else if (GroupConfig.privilege.manage == 0) {
            $m("#vgNoticeSubmit").css('display', 'none');
            $m("#vgDescSubmit").css('display', 'none');
            $m("#vgNotice").attr('disabled', 'disabled');
            $m("#vgDesc").attr('disabled', 'disabled');
        }
    },

    //修改团公告
    signatureLimit: function () {
        $m('#vgNotice').focus(function () {
            $m(this).css('color', '#1c1c1c');
        }).keyup(function () {
            var v = $m.trim($m(this).val());
            if (MGC_Comm.Strlen(v) > 160) {
                $m(this).val(MGC_Comm.Strcut(v, 160));
            }
        }).keydown(function () {
            var v = $m(this).val();
            if (MGC_Comm.Strlen(v) > 160) {
                $m(this).val(MGC_Comm.Strcut(v, 160));
                event.returnValue = false;
            }
            if (event.keyCode == 8) {
                event.returnValue = true;
            }
            if (event.keyCode == 13) {
                event.returnValue = true;
            }
        });
    },
    //修改团简介
    introLimit: function () {

        $m('#vgDesc').focus(function () {
            $m(this).css('color', '#1c1c1c');
        }).keyup(function () {
            var v = $m.trim($m(this).val());
            if (MGC_Comm.Strlen(v) > 160) {
                $m(this).val(MGC_Comm.Strcut(v, 160));
            }
        }).keydown(function () {
            var v = $m(this).val();
            if (MGC_Comm.Strlen(v) > 160) {
                $m(this).val(MGC_Comm.Strcut(v, 160));
                event.returnValue = false;
            }
            if (event.keyCode == 8) {
                event.returnValue = true;
            }
            if (event.keyCode == 13) {
                event.returnValue = true;
            }
        });
    }, //发送修改后援团公告保存请求
    updateMygroupNotice: function () {
        var vg_notice = $m('#vgNotice').val();
        if (vg_notice == "请输入内容，上限为80个汉字") {
            //alert("请输入后援团名");
            vg_notice = "";
            //return;
        }
        if (GroupConfig.vgnotice != vg_notice) {
            var _reqStr = {
                "op_type": OpType.updateMygroupNotice,
                "notice": vg_notice
            };
            MGC_Comm.sendMsg(_reqStr, 'GroupInfo.getMygroupNoticeCallBack');
            //window.location.href = '/group.shtml?id=5'
        } else {
            alert("后援团公告无修改~");
        }
    },
    //发送修改后援团简介保存请求
    updateMygroupDesc: function () {
        var vg_desc = $m('#vgDesc').val();
        if (vg_desc == "请输入内容，上限为80个汉字") {
            //alert("请输入后援团简介");
            vg_desc = "";
            //return;
        }
        if (GroupConfig.vgdesc != vg_desc) {
            var _reqStr = {"op_type":OpType.updateMygroupDesc,"desc":vg_desc};
            MGC_Comm.sendMsg(_reqStr, 'GroupInfo.getMygroupDescCallBack');
            //window.location.href = '/group.shtml?id=5';
        } else {
            alert("后援团简介无修改~");
        }
    },
    //回调以后后援团公告修改信息重复判断标识；
    CallBack_notice: 0,
    //回调以后后援团简介修改信息重复判断标识；
    CallBack_intro: 0,
    //回调后援团公告保存成功提示
    getMygroupNoticeCallBack: function (obj) {
        var vg_notice = $m('#vgNotice').val();
        var dialogStr = {};
        switch (parseInt(obj.result)) {
            case 0:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '我的后援团公告修改成功';
                GroupConfig.vgnotice = vg_notice;
                MGC_Comm.CommonDialog(dialogStr);
                $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                $m('#CommonDialog').css("top", "310px");
                break;
            case 2:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '您没有后援团公告的修改权限！';
                MGC_Comm.CommonDialog(dialogStr);
                $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                $m('#CommonDialog').css("top", "310px");
                break;
            case 17:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '对不起，您的后援团公告存在敏感字，请重新输入！';
                MGC_Comm.CommonDialog(dialogStr);
                $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                $m('#CommonDialog').css("top", "310px");
                break;
            default:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '操作失败！';
                MGC_Comm.CommonDialog(dialogStr);
                $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                $m('#CommonDialog').css("top", "310px");
                break;
        }

    },
    //回调后援团简介保存成功提示
    getMygroupDescCallBack: function (obj) {
        var vg_desc = $m('#vgDesc').val();
        var dialogStr = {};
        switch (parseInt(obj.result)) {
            case 0:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '我的后援团简介修改成功!';
                GroupConfig.vgdesc = vg_desc;
                MGC_Comm.CommonDialog(dialogStr);
                $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                $m('#CommonDialog').css("top", "310px");
                break;
            case 1:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '您没有后援团简介的修改权限！';
                MGC_Comm.CommonDialog(dialogStr);
                $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                $m('#CommonDialog').css("top", "310px");
                break;
            case 2:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '您没有后援团简介的修改权限！';
                MGC_Comm.CommonDialog(dialogStr);
                $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                $m('#CommonDialog').css("top", "310px");
                break;
            case 17:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '对不起，您的后援团简介存在敏感字，请重新输入！';
                MGC_Comm.CommonDialog(dialogStr);
                $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                $m('#CommonDialog').css("top", "310px");
                break;
            case 18:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '对不起，您的后援团简介存在敏感字，请重新输入！';
                MGC_Comm.CommonDialog(dialogStr);
                $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                $m('#CommonDialog').css("top", "310px");
                break;
            default:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '操作失败！';
                MGC_Comm.CommonDialog(dialogStr);
                $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                $m('#CommonDialog').css("top", "310px");
                break;
        }
    }
};

/**
 * 后援团申请审核
 */
var GroupApply = {
    /**
     * 初始化
     */
    init: function () {

        //获取后援团申请审核玩家列表
        GroupApply.getGroupApply();
        //获取后援团拒绝申请按钮状态
        GroupApply.getGroupRefuse();
        //申请后援团列表下拉框
        $m('.table .groupList').jScrollPane({
            autoReinitialise: true,
            animateScroll: true
        });
        //重绘滚动条 
        var scrollAPI_tablegroupList = $m('.table .groupList').data('jsp');
        if(scrollAPI_tablegroupList){
            scrollAPI_tablegroupList.initScroll();
        }

    },

    /**
     * 请求后援团申请审核玩家列表
     */
    getGroupRefuse: function () {

        var _reqStr = {"op_type": OpType.GetGroupInfo };
        MGC_Comm.sendMsg(_reqStr, "GroupApply.getGroupRefuseCallBack");
    },

    /**
     * 请求后援团申请审核玩家列表回调
     */
    getGroupRefuseCallBack: function (obj) {
        var forbid_join_apply = obj.info.forbid_join_apply;
        if (forbid_join_apply == 0) {
            $m('#refuseCheck').attr('check-data', '1');
            $m('#refuseCheck').addClass('uncheck').removeClass('check');
        } else {
            $m('#refuseCheck').attr('check-data', '0');
            $m('#refuseCheck').addClass('check').removeClass('uncheck');
        }
    },

    /**
     * 请求后援团申请审核玩家列表
     */
    getGroupApply: function () {

        var _reqStr = {"op_type":OpType.getGroupApply };
        MGC_Comm.sendMsg(_reqStr, "GroupApply.getGroupApplyCallBack");
    },

    /**
     * 请求后援团申请审核玩家列表回调
     */
    getGroupApplyCallBack: function (obj) {
        //后援团申请审核玩家
        var applys = {};
        obj = MGC_Comm.strToJson(obj);
        applys = obj.applys;
        if (obj.result == 2) {
            alert('没有权限');
        } else {
            $m.each(applys, function (k, v) {
                //性别0：女；性别1：男
                if (v.sex == 0) {
                    v.sex = 'woman';
                } else {
                    v.sex = 'man';
                }
                v.vipName = vipLevelTab[v.vip_level];
                v.zone_name = $m.mZone(v.zone_name);
            });

            var groupApplyListCon = $m('#groupApplyListTmpl');
            var groupApplyListTmpl;
            var groupApplyList = $m('#groupApplyList');
            groupApplyList.children().remove();
            groupApplyListTmpl = groupApplyListCon.tmpl(applys);
            groupApplyListTmpl.appendTo(groupApplyList);

            //绑定后援团的弹框
            $m('.msgBtn').off('click').on('click', function () {
                MGC_cardRequest.getListCardInfo($m(this).attr('nick'), $m(this).attr('zone_name'));
            });
            //重绘滚动条 
            var scrollAPI_groupApplyList = $m('.member .list').data('jsp');
            if(scrollAPI_groupApplyList){
                scrollAPI_groupApplyList.initScroll();
            }
            groupApplyListTmpl = null;
            groupApplyListCon = null;
        }
    },

    /**
     * 请求后援团申请审核请求
     */
    getGroupApplyRequest: function (player_id) {
        var _reqStr = {"op_type":OpType.getGroupApplyRequest, "player_id":player_id , "is_approve":true };
        MGC_Comm.sendMsg(_reqStr, "GroupApply.getGroupApplyResponseCallBack");
    },

    /**
     * 请求后援团申请审核玩家请求回调
     */
    getGroupApplyResponseCallBack: function (obj) {

        var dialogStr = {};
        var $li = $m('#groupApplyList li[data-pstid=' + obj.player_id + ']');
        document.onkeydown = function () {
            if (window.event && window.event.keyCode == 13) {
                window.event.returnValue = false;
            }
        };
        switch (parseInt(obj.result)) {
            case 0:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '操作成功，' + obj.player_name + '加入我们的后援团~';
                MGC_Comm.CommonDialog(dialogStr);

                $m('#CommonDialog').css("top", "310px");
                $m('#ConfirmBtn').unbind('click').on('click', function () {
                    $li.fadeOut('fast', function () {
                        $m(this).remove();
                    });
                });
                break;
            case 2:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '没有修改权限，请刷新重试~！';
                MGC_Comm.CommonDialog(dialogStr);

                $m('#CommonDialog').css("top", "310px");
                $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                break;
            case 19:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '操作失败，后援团人数已满~';
                MGC_Comm.CommonDialog(dialogStr);

                $m('#CommonDialog').css("top", "310px");
                $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                break;
            case 32:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '该玩家的申请消息已失效，请刷新重试~！';
                MGC_Comm.CommonDialog(dialogStr);

                $m('#CommonDialog').css("top", "310px");
                $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                break;
            default:
                break;
        }

    },
    /**
     * 请求后援团申请审核不通过请求
     */
    getGroupApplydeleRequest: function (player_id) {
        var _reqStr = {"op_type":OpType.getGroupApplyRequest , "player_id":player_id , "is_approve":false };
        MGC_Comm.sendMsg(_reqStr, "GroupApply.getGroupApplydeleResponseCallBack");
    },

    /**
     * 请求后援团申请审核玩家请求回调
     */
    getGroupApplydeleResponseCallBack: function (obj) {
        var dialogStr = {};
        var $li = $m('#groupApplyList li[data-pstid=' + obj.player_id + ']');
        document.onkeydown = function () {
            if (window.event && window.event.keyCode == 13) {
                window.event.returnValue = false;

            }

        }
        switch (parseInt(obj.result)) {
            case 0:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '操作成功';
                MGC_Comm.CommonDialog(dialogStr);
                $m('#CommonDialog').css("top", "310px");
                $m('#ConfirmBtn').unbind('click').on('click', function () {
                    $li.fadeOut('fast', function () {
                        $m(this).remove();
                    });
                });
                break;
            case 2:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '没有修改权限，请刷新重试~！';
                MGC_Comm.CommonDialog(dialogStr);
                $m('#CommonDialog').css("top", "310px");
                $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                break;
            case 32:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '该玩家的申请消息已失效，请刷新重试~！';
                MGC_Comm.CommonDialog(dialogStr);
                $m('#CommonDialog').css("top", "310px");
                $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                break;
            default:
                break;
        }

    },

    /**
     * 后援团申请审核拒绝任何人入团
     */
    refuseGroupApply: function () {
        if ($m('#refuseCheck').attr('check-data') == '1') {
            $m('#refuseCheck').attr('check-data', '0');
            $m('#refuseCheck').addClass('check').removeClass('uncheck');
            var _reqStr = {"op_type": OpType.getGroupApplyRefuse , "is_forbid": true };
            MGC_Comm.sendMsg(_reqStr);

        } else if ($m('#refuseCheck').attr('check-data') == '0') {
            $m('#refuseCheck').attr('check-data', '1');
            $m('#refuseCheck').addClass('uncheck').removeClass('check');
            var _reqStr = {"op_type":OpType.getGroupApplyRefuse, "is_forbid":false };
            MGC_Comm.sendMsg(_reqStr);

        }
    },
    applyForGroup: function (callback_obj) {
        if (callback_obj.is_approve) {
            alert("加入后援团成功");
        } else {
            alert("踢出后援团");
        }
    }
};

/**
 * 创建后援团
 */
var CreateGroup = {
    /**
     * 初始化
     */
    init: function () {

        //获取首页个人信息关注主播列表，回调后援团玩家关注的主播列表请求
        CreateGroup.getAttentionAnchorList();
        //创建团名称
        CreateGroup.signatureLimit();
        //创建团简介
        CreateGroup.introLimit();
        $m('.creatBtn').click(CreateGroup.getCreatGroupResponse);
        //主播列表滚动条
        $m('#selectListCon').jScrollPane({
            autoReinitialise: true,
            animateScroll: true
        });
        //重绘滚动条 
        var scrollAPI_selectListCon = $m('#selectListCon').data('jsp');
        if(scrollAPI_selectListCon){
            scrollAPI_selectListCon.initScroll();
        }
    },
    /**
     * 获取后援团玩家关注的主播列表请求
     */
    getAttentionAnchorList: function () {
        var _reqStr = {"op_type":OpType.GetAnchorList };
        MGC_Comm.sendMsg(_reqStr, "CreateGroup.getAttentionAnchorListCallBack");
    },

    /**
     * 后援团关注主播列表回调
     */
    getAttentionAnchorListCallBack: function (obj) {
        //后援团关注主播列表
        var createGroups = {};
        obj = MGC_Comm.strToJson(obj);
        createGroups = obj.infos;
        var selectListCon = $m('#selectListTmpl');
        var selectListTmpl;
        var selectList = $m('#selectList');
        selectList.children().remove();
        selectListTmpl = selectListCon.tmpl(createGroups);
        selectListTmpl.appendTo(selectList);

        $m(".selectRight").off('click').on('click', function (e) {
            if ($m("#selectListCon").css("display") == "none") {
                window.mgc.popmanager.layerControlShow($m('#selectListCon'), 1, 2);
                //重绘滚动条 
                var scrollAPI_groupselectlist = $m('#selectListCon').data('jsp');
                if(scrollAPI_groupselectlist){ 
                    scrollAPI_groupselectlist.initScroll();
                }
            } else {
                window.mgc.popmanager.layerControlHide($m('#selectListCon'), 1, 2);
            }
        });

        $m(document).off('click').on('click', function (e) {
            e = e || window.event;
            // 兼容IE7
            obj = $m(e.srcElement || e.target);

            if (!$m(obj).is("#selectListCon,#selectListCon *,.selectRight")) {
                window.mgc.popmanager.layerControlHide($m('#selectListCon'), 1, 2);
            }
        });

        $m("#selectList").on('click', 'li', function () {
            $m("#selectListCon").hide();
            var shtml = $m(this).html();
            if (typeof ($m(this).attr('data')) != 'undefined') {
                $m("#anPstid").attr('data', $m(this).attr('data'));
            }
            $m("#anPstid").find("span").html(shtml);
        });
        selectListTmpl = null;
        selectListCon = null;
    },
    //创建团名称
    signatureLimit: function () {
        $m('#putGroupName').keyup(function () {
            var v = $m.trim($m(this).val());
            if (MGC_Comm.Strlen(v) > 16) {
                $m(this).val(MGC_Comm.Strcut(v, 16));
            }
        }).keydown(function () {
            var v = $m(this).val();
            if (MGC_Comm.Strlen(v) >= 16) {
                event.returnValue = false;
            }
            if (event.keyCode == 8) {
                event.returnValue = true;                
            }
            if (event.keyCode == 13) {
                event.returnValue = true;
            }
        })
    },
    //创建团简介
    introLimit: function () {

        $m('#createGroupinfo').focus(function () {
            $m(this).css('color', '#1c1c1c');
        }).blur(function () {
            $m(this).css('color', '#9b9b9b');
        }).keyup(function () {
            var v = $m.trim($m(this).val());
            if (MGC_Comm.Strlen(v) > 160) {
                $m(this).val(MGC_Comm.Strcut(v, 160));
            }
        }).keydown(function () {
            var v = $m(this).val();
            if (MGC_Comm.Strlen(v) >= 160) {
                event.returnValue = false;
            }
            if (event.keyCode == 8) {
                event.returnValue = true;
                ;
            }
            if (event.keyCode == 13) {
                event.returnValue = true;
            }
        })
    },
    //发送创建后援团请求
    getCreatGroupResponse: function () {
        console.log("进入发送创建后援团请求");
        var guild_name = $m('#putGroupName').val();
        var anchor_pstid = $m('#anPstid').attr('data');
        var guild_desc = $m('#createGroupinfo').val();
        if ((guild_name == '请输入团名')||(guild_name =='')) {
            alert("团名不能为空，请重新输入！");
        } else if (guild_name.indexOf(" ") != -1) {
            alert("名字不能包含空格，请重新输入！");
        } else if (anchor_pstid == undefined) {
            alert("支持的主播不能为空，请重新输入！");
        } else if (guild_desc == "") {
            alert("团简介不能为空，请重新输入！");
        } else {
            var _reqStr = {"op_type":OpType.createGroup , "guild_name":guild_name , "anchor_pstid":anchor_pstid , "guild_desc":guild_desc };
            MGC_Comm.sendMsg(_reqStr, "CreateGroup.getCreatGroupResponseCallBack");
            console.log("进入发送创建后援团请求完毕" + _reqStr);
        }
    },
    jumpurl: function () {
        location = 'group.shtml';
    },
    //后援团创建信息回调
    getCreatGroupResponseCallBack: function (obj) {
        console.log("进入发送创建后援团请求回调" + obj);
        var dialogStr = {};
        switch (parseInt(obj.result)) {
            case 12:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '您选择的主播名有误，请重新选择！';
                MGC_Comm.CommonDialog(dialogStr);
                $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                $m('#CommonDialog').css("top", "310px");
                break;
            case 13:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '您的炫豆不足，创建失败！';
                MGC_Comm.CommonDialog(dialogStr);
                $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                $m('#CommonDialog').css("top", "310px");
                break;
            case 14:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '创建失败，您已是后援团成员了！';
                MGC_Comm.CommonDialog(dialogStr);
                $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                $m('#CommonDialog').css("top", "310px");
                break;
            case 15:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '与其他团名重复，请重新输入！';
                MGC_Comm.CommonDialog(dialogStr);
                $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                $m('#CommonDialog').css("top", "310px");
                break;
            case 16:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '保存后援团信息失败，请重新输入！';
                MGC_Comm.CommonDialog(dialogStr);
                $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                $m('#CommonDialog').css("top", "310px");
                break;
            case 17:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '对不起，您的团名中存在敏感字，请重新输入！';
                MGC_Comm.CommonDialog(dialogStr);
                $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                $m('#CommonDialog').css("top", "310px");
                break;
            case 18:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '对不起，您的后援团简介中存在敏感字，请重新输入！';
                MGC_Comm.CommonDialog(dialogStr);
                $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                $m('#CommonDialog').css("top", "310px");
                break;
            case 0:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '后援团创建成功~请快去招募团员，为您心仪的主播贡献力量吧！';
                MGC_Comm.CommonDialog(dialogStr);
                $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                $m('#CommonDialog').css("top", "310px");
                setTimeout("CreateGroup.jumpurl()", 3000);
                break;
            case 41:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '对不起，扣炫豆失败，请重新输入！';
                MGC_Comm.CommonDialog(dialogStr);
                $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                $m('#CommonDialog').css("top", "310px");
                break;
            case 14:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '您已经加入了一个后援团，点击确定进入后援团！';
                MGC_Comm.CommonDialog(dialogStr);
                $m('#ConfirmBtn').attr("href", "/group.shtml");
                $m('#CommonDialog').css("top", "310px");
                break;
            default:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '后援团创建失败！';
                MGC_Comm.CommonDialog(dialogStr);
                $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                $m('#CommonDialog').css("top", "310px");
                break;
        }

    },
};

var refresh = function () {
    window.location.href = '/group.shtml?param=' + MgcAPI.SNSBrowser.IsQQGameLiveArea();
}
/*本页需要回调加载的功能*/
var loginCallBack = function () {
    //Tab.init();
}
window.mgc.roomLoginCallBack = Tab.init;
/* 通用回调方法 */
var MGC_Response = function (callback_obj) {
    var _op_type = callback_obj.op_type;
    switch (parseInt(_op_type)) {
        case -2:
            Tab.init();
            break;

        case 70:
            GroupApply.applyForGroup(callback_obj);
            break;

            //收到被传位成功消息
        case 84:
            var dialog = {};
            callback_obj.old_chief_name
            callback_obj.old_chief_zone
            dialog.Title = '提示信息';
            dialog.Note = callback_obj.old_chief_name + "已将后援团团长之位传给了你，你成为了新的团长。";
            MGC_Comm.CommonDialog(dialog, refresh);
            break;

            //收到传位成功消息
        case 85:
            var dialog = {};
            //callback_obj.old_chief_name;
            //callback_obj.old_chief_zone;
            dialog.Title = '提示信息';
            dialog.Note = '您已成功将团长之位传给了' + callback_obj.new_chief_name;
            MGC_Comm.CommonDialog(dialog, refresh);
            break;

            //后援团最终解散的时候 通知
        case 86:
            var dialog = {};
            dialog.Title = '提示信息';
            dialog.Note = '您所在的后援团已解散。';
            MGC_Comm.CommonDialog(dialog, refresh);
            break;

            //被开除后援团，通知被开除的玩家
        case 87:
            var dialog = {};
            callback_obj.name
            dialog.Title = '提示信息';
            dialog.Note = '您已被开除出' + callback_obj.name + '后援团。';
            MGC_Comm.CommonDialog(dialog, refresh);
            break;

        default:
            break;
    }
}