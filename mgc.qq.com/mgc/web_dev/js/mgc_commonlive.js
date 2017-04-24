// VERSION: 0.1 LAST UPDATE: 28.08.2015
/*
* Made by 77, shixinqi@h3d.com.cn
* ����ֱ�������
* svn 1579 end
*/
// Documentation removed from script file (was kinda useless and outdated)

/*
��������
*/
var leftLiveRoomProTime = 120;
var mouseX;
var mouseY;
var heatCchestWidth = 0;
var tmpBx = 0;
var isLiveOpen = false; //ֱ������
var giftNum = 0;
var MGC_ANCHORIMPRESSION = {};
var wheelStop = true;//��ʶ�������Ƿ���ƶ�showLeftTime = 0;
var drawLeftTime = 0;
var hasTicket = 1;//�Ƿ�����Ʊ��Ĭ�����˶�����Ʊ 
var isOpen = false;//�ݳ����Ƿ�����Ĭ��δ��������ֱ��Ҳ����δ����
var isLiveOpen = false; //ֱ������
var mgc_bg_default = '/img/css-img/common/mgc_auto.png'; //�ݳ���Ĭ��ֱ��ͼƬ
MGCData.roomID = 0;

/*
* @object request����
*/
var MGC_SpecialRequest = {
    /*
    * @function ���뷿����������
    * @using ֱ���䡢С�ѡ��ݳ���
    * @param {roomId} int - ����id
    * @param {�Ƿ���Լ�������} int - �Ƿ���Լ�������
    * @return void
    */
    enter: function (roomId, special) {
        crowd = false;
        if (special) {
            crowd = true;
        }
        roomId = parseInt(roomId);
        if (roomId > 0) {
            //���뷿����ˢ����Ƶ�����  --- ���⴦��
            var _reqStr = { "op_type": OpType.RefreshPlayerOpType };
            console.log('���뷿��֮ǰ���ò���2_reqStr��' + JSON.stringify(_reqStr));
            MGC_Comm.sendMsg(_reqStr);
            var source = parseInt(MGC_Comm.getUrlParam('source'));
            source = source >= 0 ? source : 0;
            var module_type = window.mgc.tools.getUrlVars("module_type");
            var page_capacity = window.mgc.tools.getUrlVars("page_capacity");
            var room_list_pos = window.mgc.tools.getUrlVars("room_list_pos");
            _reqStr = { "op_type": OpType.EnterOpType, "roomID": roomId, "crowd_into": crowd, "invisible": false, "source": source, "module_type": module_type, "page_capacity": page_capacity, "room_list_pos": room_list_pos };
            console.log('���뷿��_reqStr��' + JSON.stringify(_reqStr));
            MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.EnterRoomCallBack");
        } else {
            window.location.href = window.mgc.tools.changeUrlToLivearea(home);
        }
    },
    /*
    * @function �����Ƽ�
    * @using ֱ���䡢С�ѡ��ݳ���
    * @param null
    * @return void
    */
    HotRecommRoom: function () {
        var _reqStr = { "op_type": OpType.HotRecommRoomOpType, "type": 0, "zoneid": 0, "category": 0, "beginIndex": 0, "requestNum": 8 };
        console.log('�Ƽ�����_reqStr��' + JSON.stringify(_reqStr));
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.HotRecommRoomCallBack");
    },
    /*
    * @function ��ȡ��ɫ�б���Ϣ
    * @using ֱ���䡢С��
    * @param null
    * @return void
    */
    getRoleList: function () {
        var _reqStr = { "op_type": OpType.GetRoleListOpType, "pageIndex": 0 };
        console.log('��ȡ��ɫ�б�_reqStr��' + JSON.stringify(_reqStr));
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.appendRoleList");
    },
    /*
    * @function ��ȡ������Ƭ��Ϣ
    * @using ֱ���䡢С�ѡ��ݳ���
    * @param {anchorId} ����id
    * @return void
    */
    getAnchorCard: function (anchorId) {
        EAS.SendClick({ 'e_c': 'mgc.showcard', 'c_t': 4 });
        if (anchorId) {
            var _reqStr = { "op_type": OpType.GetAnchorCardOpType, "anchorID": anchorId };
        } else if (MGCData.anchorID) {
            var _reqStr = { "op_type": OpType.GetAnchorCardOpType, "anchorID": +MGCData.anchorID };
        }
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.showAnchorCardCallBack");
    },
    /*
    * @function �ҹ�ע��������Ϣ
    * @using ֱ���䡢С��
    * @param null
    * @return void
    */
    getMyFollowAnchor: function () {
        var _reqStr = { "op_type": OpType.GetFollowAnchorCardOpType };
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.showFollowAnchorCallBack");
    },
    /*
    * @function ��ȡ�ȶȱ���
    * @using ֱ���䡢С��
    * @param null
    * @return void
    */
    getHotBox: function () {
        var _reqStr = { "op_type": OpType.GetHotBoxOpType, "roomID": MGCData.roomID };
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.getHotBoxCallBack");
    },
    /*
    * @function ���졢����
    * @using ֱ���䡢С��
    * @param null
    * @return void
    */
    SendMsgChat: function () {
        var MsgChat = $m('#SendMsgChatBox').val();
        var CheckFlag = MGC_Comm.ChenckMsgChat(MsgChat);
        if (CheckFlag) {
            var _reqStr = {
                "op_type": OpType.SendMsgChatOpType,
                "channelID": _MsgChannel,
                "receiverName": _receiverName,
                "receiverZoneName": _receiverZoneName,
                "msg": MsgChat
            };
            MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.SendMsgChatCallBack");
            //��������
            $m('#SendMsgChatBox').val("");
            console.log("���췢����Ϣ������" + new Date().format("yyyy-MM-dd hh:mm:ss.S"));
        };
    },
    /*
    * @function ���˽���б�
    * @using ֱ���䡢С��
    * @param null
    * @return void
    */
    GetPrivateMsgChatList: function () {
        var _reqStr = "{\"op_type\":" + OpType.GetPrivateMsgChatListOpType + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.GetPrivateMsgChatListCallBack");
        $m('#GetPrivateMsgChatListBtn').attr("onclick", "MGC_Comm.ClosePrivateMsgList();");
        MGC.controlCon('sc_role_out', true);
    },
    /*
    * @function ��ȡͶƱ��Ϣ
    * @using ֱ���䡢С�ѡ��ݳ���
    * @param null
    * @return void
    */
    getVoteInfo: function () {
        var _reqStr = "{\"op_type\":" + OpType.GetVoteInfoOpType + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.getVoteInfoCallBack");
    },
    /*
    * @function ��ȡ��������
    * @using ֱ���䡢С�ѡ��ݳ���
    * @param null
    * @return void
    */
    getTaskInfo: function () {
        var _reqStr = "{\"op_type\":" + OpType.GetTaskInfoOpType + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.getTaskInfoCallBack");
    },
    /*
    * @function ������������
    * @using ֱ���䡢С�ѡ��ݳ���
    * @param null
    * @return void
    */
    AcceptTask: function () {
        var _reqStr = "{\"op_type\":" + OpType.AcceptTaskOpType + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.AcceptTaskCallBack");
    },
    /*
    * @function ������������
    * @using ֱ���䡢С�ѡ��ݳ���
    * @param null
    * @return void
    */
    GiveUpTask: function () {
        var _reqStr = "{\"op_type\":" + OpType.GiveUpTaskOpType + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.GiveUpTaskCallBack");
    },
    /*
    * @function �������ߺ�������  ����
    * @using ֱ���䡢С�ѡ��ݳ���
    * @param null
    * @return void
    */
    setTaskInfo: function (id, is_daily) {
        MGC_Comm.sendMsg("{\"op_type\":" + OpType.GetActRewardsOpType + ",\"activity_id\":" + id + ",\"is_daily\":" + is_daily + "}", "MGC_SpecialRequest.GetActRewardsCallBack");
    },
    //���ߺ���������  ����
    GetActRewardsCallBack: function (responseStr) {
        var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
        if (obj.type == 0) {
            var dialogStr = {}; var n = 1;
            switch (parseInt(obj.res)) {
                case 1:
                    dialogStr.Title = '���ߺ���';
                    dialogStr.Note = '��ȡ�����ɹ���';
                    MGC_Comm.CommonDialog(dialogStr);
                    $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                    $m('#CommonDialog').css("top", "310px");
                    break;
                case 2: dialogStr.Title = '���ߺ���'; dialogStr.Note = '������ѹ��ڣ�'; MGC_Comm.CommonDialog(dialogStr); $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                    $m('#CommonDialog').css("top", "310px"); break;
                case 3: dialogStr.Title = '���ߺ���'; dialogStr.Note = '�������δ��ɣ�����Ŭ���ɣ�'; MGC_Comm.CommonDialog(dialogStr); $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                    $m('#CommonDialog').css("top", "310px"); break;
                case 4: dialogStr.Title = '���ߺ���'; dialogStr.Note = '���Ѿ���ȡ�����������'; MGC_Comm.CommonDialog(dialogStr); $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                    $m('#CommonDialog').css("top", "310px"); break;
                default: dialogStr.Title = '���ߺ���'; dialogStr.Note = '��ȡʧ�ܣ�'; MGC_Comm.CommonDialog(dialogStr); $m('#ConfirmBtn').attr("href", "javascript:MGC_Comm.hideDialog(true);");
                    $m('#CommonDialog').css("top", "310px"); break;
            }
            MGC_SpecialResponse.popId = false;
            MGC_SpecialResponse.chechNumShow();
        }
        //====horizon====//
        disabledBtn = false;
    },
    /*
    * @function ��ȡ��������ҡ�����Ա��Ϣ
    * @using ֱ���䡢С�ѡ��ݳ���
    * @param name(string):����ǳ�
    * @param area(string):��Ҵ���
    * @param x(int):�����X����
    * @param y(int):�����Y����
    * @return void
    */
    getPlayerInfo: function (name, area, x, y) {
        if (MGC_Comm.CheckGuestStatus()) {
            console.log("�����οͲ�������ȡ��������ҡ�����Ա��Ϣ");
            return false;//�ο�����£����δ˲���
        }
        if (x || y) {
            MGCData.eventInfo = undefined;
        }
        area = area.replace("����-", ""); //��������-  ��ֹ�������Ҳ�������
        var _reqStr = { "op_type": OpType.GetMemberInfoOpType, "name": name, "zoneName": area };
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.getPlayerInfoCallBack");
    },
    /*
    * @function ��ɫ�б�-������Ƭ
    * @using ֱ���䡢С�ѡ��ݳ���
    * @param name(string):����ǳ�
    * @param area(string):��Ҵ���
    * @return void
    */
    getListCardInfo: function (id, source) {
        var _reqStr = { "op_type": OpType.GetPlayerInfoOpType, "player_id": id, "source": source};
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.getListCardInfoCallBack");
    },
    /*
    * @function ��������-��˿����-������Ƭ
    * @using ֱ���䡢С�ѡ��ݳ���
    * @param name(string):����ǳ�
    * @param area(string):��Ҵ���
    * @return void
    */
    getFansCardInfo: function (id) {
        var _reqStr = { "op_type": OpType.GetPlayerInfoOpType, "player_id": id };
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.getListCardInfoCallBack");
    },
    /*
    * @function ͶƱ
    * @using ֱ���䡢С�ѡ��ݳ���
    * @param voteArr(Array):ͶƱ�������
    * @return void
    */
    vote: function (voteArr) {
        var _reqStr = "{\"op_type\":" + OpType.VoteOpType + ", \"select\":[" + voteArr + "]}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.voteCallBack");
    },
    /*
    * @function �ٱ�����
    * @using ֱ���䡢С��
    * @param type(int):�ٱ�����
    * @param content(string):�ٱ�����
    * @param anchorId(int):����ID
    * @param anchorName(string):������
    * @return void
    */
    reportAnchor: function (type, content, anchorId, anchorName) {
        //content���� @todo
        var _reqStr = "{\"op_type\":" + OpType.ReportAnchorOpType + ",\"type\":" + type + ",\"content\":\"" + content + "\",\"anchor\":" + anchorId + ",\"anchor_name\":\"" + anchorName + "\"}";
        MGC_Comm.sendMsg(_reqStr);
        alert('�ύ�ɹ�����л�����ĵľٱ������ǻᾡ�촦�����ľٱ���'); //û�лص�,ֱ�ӷ�����ҳɹ�
        //�������
        $m('#i_report_con').val('');
        $m('#icon_report').attr('data', '5').find('span').html('����');

    },
    /*
    * @function �༭����ӡ��
    * @using ֱ���䡢С�ѡ��ݳ���
    * @param _impressionArr(Array):ӡ����������
    * @param thisAnchorId(string):��ǰ����ID
    * @return void
    */
    editImpression: function (_impressionArr, thisAnchorId) {
        var _reqObj = {};
        _reqObj.op_type = OpType.EditImpressionOpType;
        if (thisAnchorId) {
            _reqObj.anchor_id = thisAnchorId;
        } else {
            _reqObj.anchor_id = MGCData.anchorID;
        }
        _reqObj.data = _impressionArr;
        var _reqStr = JSON.stringify(_reqObj);
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.editImpressionCallBack");
    },
    /*
    * @function ȡ���͹�ע����
    * @using ֱ���䡢С�ѡ��ݳ���
    * @param type(int):0����ҳ���а�ť���� / 1������Ƭ�а�ť����
    * @param anchorId(string):��ǰ����ID
    * @param name(string):��ǰ�����ǳ�
    * @param isFollow(int):0ȡ����ע/1��ע
    * @return void
    */
    followAnchorAction: function (type, anchorId, name, isFollow) {
        if (MGC_Comm.CheckGuestStatus()) {
            console.log("�����οͲ�����ȡ���͹�ע����");
            return false;//�ο�����£����δ˲���
        }
        if (type == 0) {
            //��ҳ�����Ĺ�ע
            var op_type = MGCData.followAnchor == 0 ? OpType.FollowAnchorActionOpType : OpType.CancelFollowAnchorOpType;
            var anchor_id = MGCData.anchorID;
            var anchor_nick = MGCData.anchorName;
        } else {
            //��ȷ���Ƿ��Ǳ�ҳ�����Ĺ�ע
            var op_type = isFollow == 0 ? OpType.FollowAnchorActionOpType : OpType.CancelFollowAnchorOpType;
            var anchor_id = anchorId;
            var anchor_nick = name;
        }
        var _reqStr = {
            "op_type": op_type,
            "anchor_id": anchor_id,
            "anchor_nick": anchor_nick
        };
        if (op_type == OpType.FollowAnchorActionOpType) {
            EAS.SendClick({
                'e_c': 'mgc.attention',
                'c_t': 4
            });
            MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.FollowAnchorActionCallBack", anchor_id);
        } else {
            EAS.SendClick({
                'e_c': 'mgc.unattention',
                'c_t': 4
            });
            MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.CancelFollowAnchorCallBack", anchor_id);
        }
    },
    /*
    * @function ��������ӡ��
    * @using ֱ���䡢С�ѡ��ݳ��� 
    * @param thisAnchorId(string):��ǰ����ID 
    * @return void
    */
    allImpressionInfo: function (thisAnchorId) {
        var _reqStr = "{\"op_type\":144}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.allImpressionInfoCallBack", thisAnchorId);
    },
    /*
    * @function �����������ӡ��
    * @using ֱ���䡢С�ѡ��ݳ��� 
    * @param thisAnchorId(string):��ǰ����ID 
    * @return void
    */
    myImpressionInfo: function (thisAnchorId) {
        var _reqStr = "{\"op_type\":" + OpType.MyImpressionOpType + ", \"anchor_id\":" + thisAnchorId + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.myImpressionInfoCallBack", thisAnchorId);
    },
    /*
    * @function ����������
    * @using ֱ���䡢С�ѡ��ݳ��� 
    * @param id(int):��ǰ�������
    * @return void
    */
    getBoxGift: function (id) {
        if (MGC_Comm.CheckGuestStatus()) {
            console.log("�����οͲ���������������");
            return false;//�ο�����£����δ˲���
        }
        var _reqStr = "{\"op_type\":" + OpType.GetBoxGiftOpType + ", \"box_id\":" + id + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.getBoxGiftCallBack");
    },
    /*
    * @function ���Ժ�ȡ������
    * @using ֱ���䡢С�ѡ��ݳ��� 
    * @param _name(string):�������
    * @param _area(string):��������
    * @param type(bool):true����/falseȡ������
    * @param always(bool):true���ý���/false�����ý���
    * @return void
    */
    forbidden: function(_pstid,_name, _area, type, always) {
        var _reqStr = { "op_type": OpType.ForbiddenOpType, "pstid":_pstid,"playerName": _name, "playerZoneName": _area, "ban": type, "perpetual": always };
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.forbiddenCallBack", type);
    },
    /*
    * @function ���κ�ȡ������
    * @using ֱ���䡢С�ѡ��ݳ��� 
    * @param _name(string):�������
    * @param _area(string):��������
    * @param _isIgnore(bool):falseȡ����true����
    * @return void
    */
    ignore: function (_playerId,_name, _area, _isIgnore) {
        var _reqStr = { "op_type": OpType.IgnoreOpType, "player_id":_playerId, "strNickName": _name, "strZoneName": _area, "bAdd": _isIgnore };
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.ignoreCallBack");
    },
    /*
    * @function ��ֱ�����鿴����Ĭ��ͼƬ
    * @using ֱ���䡢С��
    * @param roomId(int):����id
    * @return void
    */
    getRoomUrl: function (roomId) {
        var _reqStr = "{\"op_type\":" + OpType.GetRoomUrlOpType + ", \"roomid\":" + roomId + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.getRoomUrlCallBack");
    },
    /*
    * @function �鿴�ҵ�ͶƱ״̬
    * @using ֱ���䡢С�ѡ��ݳ���
    * @param roomId(int):����id
    * @return void
    */
    checkMyVoteInfo: function () {
        var _reqStr = "{\"op_type\":" + OpType.CheckMyVoteOpType + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.checkMyVoteInfoCallBack");
    }
}
/*
* @object response����
*/
var MGC_SpecialResponse = {

}