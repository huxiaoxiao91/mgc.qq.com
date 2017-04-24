/*
 * Created by ouyangtaili on 2015/9/16.
 * 提供直播房间的信息
 * op_type :操作类型
 * 76 获取后援团名片信息
 *
 */
//发送请求========================================
var MGC_FansGuildCardRequest = {
    //拉取后援团名片信息
    getbackupGroupCard: function (vgId) {
        if (MGC_Comm.CheckGuestStatus()) {
            console.log("屏蔽游客操作：拉取主播名片信息");
            return false;//游客身份下，屏蔽此操作
        }
        mgc.tools.EAS([{ 'e_c': 'mgc.showcard', 'c_t': 4 }]);
        if (vgId) {
            var _reqStr = {
                "op_type": OpType.GetBackupGroupCardOpType,
                "vgid": ""+vgId
            };
        } else if (MGCData.vgid) {
            var _reqStr = {
                "op_type": OpType.GetBackupGroupCardOpType,
                "vgid": "" + MGCData.vgid
            };
        }
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.showBackupGroupCardCallBack");
    },	
};
var MGC_FansGuildCardResponse = {
    //展示后援团名片
    showBackupGroupCardCallBack: function (obj) {
        console.log("从服务器获得的主播名片：" + JSON.stringify(obj));
        obj = MGC_Comm.strToJson(obj);
        var res = obj.info.result;
        var _backupGroupInfo = {};
        //后援团id
        _backupGroupInfo.vgId = obj.info.vgid;        
        //后援团名
        _backupGroupInfo.vg_name = obj.info.vg_name;
        //总人数
        _backupGroupInfo.member_count = obj.info.member_count;
        //团员最大人数
        _backupGroupInfo.member_limit = obj.info.member_limit;
        //支持主播
        _backupGroupInfo.anchor_name = obj.info.anchor_name;
        //团内资产
        _backupGroupInfo.vg_wealth = obj.info.vg_wealth;
        //本月贡献
        _backupGroupInfo.anchor_cont_score = obj.info.anchor_cont_score;
        //本月活跃积分
        _backupGroupInfo.vg_score = obj.info.vg_score;
        //后援团总积分
        _backupGroupInfo.total_score = obj.info.total_score;
        //后援团简介
        _backupGroupInfo.vg_desc = obj.info.vg_desc;
        //支持的主播id
        _backupGroupInfo.anchor_pstid = obj.info.anchor_pstid;
        //后援团主播等级
        _backupGroupInfo.anchor_level = obj.info.anchor_level;
        _backupGroupInfo.myvgid = obj.myvgid;

        if (_backupGroupInfo.myvgid == 0) {
            _backupGroupInfo.myvgid = 0;
        } else if (_backupGroupInfo.myvgid == _backupGroupInfo.vgId) {
            _backupGroupInfo.myvgid = 1;
        } else{
            _backupGroupInfo.myvgid = 2;
        }

        _backupGroupInfo.anchor_level_temp = 0;
        _backupGroupInfo.anchor_level_temp = Math.floor(_backupGroupInfo.anchor_level / 10) + 1;
        if (_backupGroupInfo.anchor_level == 0) {
            _backupGroupInfo.anchor_level_temp = 0;
        }

        switch(res){
            case 0:
                //弹框-基本信息
                var backupGroupInfoCon = $m('#backupGroupInfoTmpl');
                var backupGroupInfoTmpl;
                var backupGroupTip1Container = $m('#backupGroupTip1Container');
                backupGroupTip1Container.children().remove();
                backupGroupInfoTmpl = backupGroupInfoCon.tmpl(_backupGroupInfo);
                backupGroupInfoTmpl.appendTo(backupGroupTip1Container);
                //绑定主播的弹框
                $m('.lv_links').off('click').on('click', function () {
                    MGC_CommRequest.getAnchorCard($m(this).attr('anchorId'));
                });

                //弹框-主播名片
                if ($m.cookie("mgc_invite_click") == 1) {
                    $m.cookie("mgc_invite_click", 2, {
                        path: '/',
                        domain: '.qq.com'
                    });
                }
                window.mgc.popmanager.layerControlShow($m("#pop15"), 4, 1, 2);
                $m('#pop15').centerDisp();
                $m('#pop15').find(".pop_close,.cancelBtn").off('click').on('click', function() {
                    window.mgc.popmanager.layerControlHide($m("#pop15"), 4, 1);
                });
                $m('#pop15').find(".applyBtn").off('click').on('click', function() {
                    MGC_FansGuildCardResponse.applyGroup(_backupGroupInfo.vgId);
                });
                //var anchorIcon=$m('#pop15').find(".anchor_icon_tips").find("i").get(0);
                //MGC.newTips(('主播等级:'+_backupGroupInfo.anchor_level), $m(anchorIcon),4,3);
                MGC.popTipss("anchor_icon_tips", "em", 4, 3);
                backupGroupInfoTmpl = null;
                backupGroupInfoCon = null;
                break;
            case 1:  //VGRC_Failed客户端请求无法送到server
                this.serverFaild();
                break;
            case 4:  //VGRC_Internal服务器之间通信有问题
                this.serverFaild();
                break;
            case 8:  //VGRC_NoAnchor没有找到主播信息
                this.serverFaild();
                break;
            case 26:  //VGRC_NullVideoGuild 找不到后援团
                this.serverFaild();
                break;
            case 27:  //VGRC_VideoGuildServerIniting 正在初始化
                this.serverFaild();
                break;
            default:
                break;
        }

    },
    serverFaild:function(){
        var dialogStr = {};
        dialogStr.Title = '提示';
        dialogStr.Note = '连接超时，请稍候再试！';
        MGC_Comm.CommonDialog(dialogStr);
    },
	//申请加入后援团
	applyGroup:function(VGID){	
	var _reqStr = {"op_type": OpType.getPlayerApplyGroupRequest,"vgid": VGID};
      
	MGC_Comm.sendMsg(_reqStr, "MGC_FansGuildCardResponse.applyGroupCardCallBack");
	},
	//申请加入后援团回调
	applyGroupCardCallBack:function(obj){
		
        var dialogStr = {};
        switch (parseInt(obj.result)) {
            case 14:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '您已经是后援团成员了。';
                break;
            case 21:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '您的申请正在审核中，请耐心等候！';
                break;
            case 20:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '该后援团拒绝所有人加入！';
                break;
            case 19:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '该后援团人数已满！';
                break;
            case 0:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '申请发送成功，请等待团内管理员的审批！';
                break;
            case 26:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '您申请的后援团不存在，或者已经解散！';
                break;
            case 28:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '对不起，该后援团的申请已达到上限，申请失败。';
                break;
            case 19:
                dialogStr.Title = '提示信息';
                dialogStr.Note = '后援团已经达到人数上限，无法加入。';
                break;
            default:
                break;
        }
        MGC_Comm.CommonDialog(dialogStr);
        $m('#CommonDialog').css("top", "310px");
        if (filename == "liveroom.shtml" || filename == "caveolaeroom.shtml" || filename == "nest.shtml") {
            $m('#ConfirmBtn').unbind('click').click(function() {
                $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
            });
        }
        else
        {
        	$m('#ConfirmBtn,#CloseBtn').unbind('click').click(function() {
                MGC_Comm.hideDialog(true);
                window.mgc.popmanager.layerControlHide($m("#pop15"), 4, 1);
            });
        }

    }
};
$m.extend(MGC_CommRequest, MGC_FansGuildCardRequest);
$m.extend(MGC_CommResponse, MGC_FansGuildCardResponse);