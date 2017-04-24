/*
 * Created by ouyangtaili on 2015/9/24.
 * 主播名片信息
 * op_type :操作类型
 * 14 获取主播名片信息
 *
 */
//发送请求========================================

var MGC_anchorCardRequest={
	//拉取主播名片信息
    getAnchorCard: function (anchorId) {
        mgc.tools.EAS([{ 'e_c': 'mgc.showcard', 'c_t': 4 }]);
        window.mgc.callcenter.get_anchor_card_ranklist_info(anchorId, window.mgc.anchorCardRanklistResponse.showAnchorCardCallBack);
    }
};

var MGC_anchorCardResponse = {
    //展示主播名片
    showAnchorCardCallBack: function (obj) {
        MGC_anchorCardResponse._showAnchorCardCallBack(obj);
    },
	    //内部真实——展示主播名片
    _showAnchorCardCallBack: function(obj) {
        console.log("从服务器获得的主播名片：" + JSON.stringify(obj));
        //obj = JSON.stringify(obj);

        var anchorTip1Con = $('#ranklist_anchorTipTmpl');
        var anchorTip1Tmpl;
        var anchorTip1Container = $('#ranklist_anchorTipContainer');

        if (obj.succ) {
            var _anchorInfo = {};
            //主播小窝皮肤信息
            _anchorInfo.nest_skin_info = obj.data.nest_skin_info;
            //主播id
            _anchorInfo.anchorId = obj.data.basicData.anchorID;
            //是否关注--文字
            _anchorInfo.follow = !obj.isFollow ? "关 注" : "已关注";
            //是否关注--true,false
            _anchorInfo.isFollow = obj.isFollow ? 1 : 0;
            //照片
            _anchorInfo.imageUrl = obj.data.basicData.imageUrl;
            //照片2
            _anchorInfo.photoUrl = obj.data.basicData.photoUrl;
            //主播名
            _anchorInfo.name = obj.data.basicData.name;
            //主播等级
            _anchorInfo.anchor_level = obj.data.basicData.anchor_level;
            //籍贯
            _anchorInfo.from = obj.data.basicData.from;
            //积分
            _anchorInfo.anchor_score = obj.data.basicData.anchor_score;
            //人气
            _anchorInfo.popularity = obj.data.basicData.popularity;
            //星耀
            _anchorInfo.starlight = obj.data.basicData.starlight;
            //守护数量
            _anchorInfo.total_guard_cnt = obj.data.total_guard_cnt;
            //后援团数量
            _anchorInfo.vg_cnt = obj.data.vg_cnt;
            //个人简介
            _anchorInfo.intro = obj.data.basicData.intro; //这里重构设计有问题，接口是否会有换行符号发给我？
            //观众数量
            _anchorInfo.followedAudiences = obj.data.basicData.followedAudiences;
            
            _anchorInfo.anchor_level_temp = 0;


            _anchorInfo.anchor_level_temp = Math.floor(_anchorInfo.anchor_level / 10) + 1;
            if (_anchorInfo.anchor_level == 0) {
                _anchorInfo.anchor_level_temp = 0;
            }

            //去Ta的个人直播间判断是否显示按钮
            var selfRoomId = obj.data.nest_id;
            var reg = new RegExp("(^|&)" + "roomId" + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            var roomId = 0;
            if (r != null) {
                roomId = unescape(r[2]);
            }

            if (selfRoomId != roomId && selfRoomId > 0) {
                _anchorInfo.selfRoomId = selfRoomId;
                _anchorInfo.showSelfRoomLink = true;
            }
            //弹框-基本信息
           
            $('#anchor_loadding').hide();
            anchorTip1Container.children().remove();
            anchorTip1Tmpl = anchorTip1Con.tmpl(_anchorInfo);
            anchorTip1Tmpl.appendTo(anchorTip1Container);
            

            //绑定名片中的关注
            $('.btn_care').off('click').on('click', function () {
                if (window.mgc.account.checkLoginStatus()) {
                    return;
                } else {
                    var isFollow = $(this).attr('isFollow');
                    var name = $(this).attr('name');
                    var anchorId = $(this).attr('anchorId');
                    MGC_anchorCardResponse.followAnchorAction(1, anchorId, name, isFollow);
                }
            });

            $('.ellipsisSpan').css('display', 'none');
            $('.sus_anchor_tips_info .shuoming').css('display', 'block');

            var temp_desc = "";//存放截断字符串  
            var flagBr = 0;
            var dots = "...";

            for (var j = 0; j < _anchorInfo.intro.length; j++) {
                //desc是目标字符串，只能支持像素宽度为204的字符串  

                temp_desc += _anchorInfo.intro[j];
                $('#intro_one').html(temp_desc);

                if (_anchorInfo.intro[j].indexOf("\r") != -1 || _anchorInfo.intro[j].indexOf("\n") != -1 || _anchorInfo.intro[j].indexOf("\r\n") != -1) {
                    var totleText = _anchorInfo.intro.substring(j, _anchorInfo.intro.length);
                    totleText = totleText.substring(1, totleText.length);
                    if (j == 0) {
                        $('#intro_one').height(22);
                    }
                    $('#intro_two').html(totleText);
                    for (var ii = 0; ii < totleText.length; ii++) {
                        if (totleText[ii].indexOf("\r") != -1 || totleText[ii].indexOf("\n") != -1 || totleText[ii].indexOf("\r\n") != -1) {
                            flagBr++;
                            if (flagBr == 2) {
                                totleText = totleText.substring(0, ii);
                                $('#intro_two').html(totleText + dots);
                                break;
                            }
                        }
                    }
                    break;
                } else {

                    if ($('#intro_one').width() >= 203) {
                        if ($('#intro_one').width() == 203) {
                            j++;
                            temp_desc += _anchorInfo.intro[j];
                            $('#intro_one').html(temp_desc);
                            if ($('#intro_one').width() >= 205) {
                                temp_desc = temp_desc.substring(0, temp_desc.length - 1);
                                $('#intro_one').html(temp_desc);
                                var totleText = _anchorInfo.intro.substr(temp_desc.length, _anchorInfo.intro.length);
                                $('#intro_two').html(totleText);
                            }
                        } else if ($('#intro_one').width() >= 205) {
                            temp_desc = temp_desc.substring(0, temp_desc.length - 1);
                            $('#intro_one').html(temp_desc);
                            var totleText = _anchorInfo.intro.substr(temp_desc.length, _anchorInfo.intro.length);
                            $('#intro_two').html(totleText);
                        } else if ($('#intro_one').width() == 204) {
                            var totleText = _anchorInfo.intro.substr(j + 1, _anchorInfo.intro.length);
                            $('#intro_two').html(totleText);
                        } else {
                            var totleText = _anchorInfo.intro.substr(j - 1, _anchorInfo.intro.length);
                            $('#intro_two').html(totleText);
                        }
                        break;
                    }
                }
            }
            $('.shuoming').width(205);
            $('.shuoming').height(42);


            //是否已经关注主播            

            $('.sus_anchor_tips_info .btn_care').off("mouseover").on('mouseover', function (e) {                
                   
                if (($('.sus_anchor_tips_info .btn_care').html() == '关 注') || ($('.sus_anchor_tips_info .btn_care').html() == '关 注')) {
                } else {
                    $('.sus_anchor_tips_info .btn_care').text('取 消');
                }                
            });
            $('.sus_anchor_tips_info .btn_care').off('mouseout').on('mouseout', function (e) {
                if ($('.sus_anchor_tips_info .btn_care').text() == '取 消') {
                    $('.sus_anchor_tips_info .btn_care').text('已关注');
                }
                MGC.susStatepositionTips(e, 0);
            });
            anchorTip1Tmpl = null;
            anchorTip1Con = null;

        } else {
            $('#anchor_loadding').hide();
            $('#anchor_error').show();
        }
    },
	
		//是否关注的主播
    isFollowAnchorCallBack: function(obj) {
        console.log('ddddddddddddddddddd' + obj);
        obj = MGC_Comm.strToJson(obj);
        if (obj.res) {
            MGCData.difFollowAnchor[MGCData.isAnchorOrRoom].followAnchor = 1;
            //关注了
            $('.si_attention').text('已关注');
        } else {
            MGCData.difFollowAnchor[MGCData.isAnchorOrRoom].followAnchor = 0;
            //未关注
            $('.si_attention').html('关 注');
        }
    },
    isFull:false,
    //关注主播
    FollowAnchorActionCallBack: function(obj, anchor_id) {
        console.log("关注主播的返回" + obj);

        obj = MGC_Comm.strToJson(obj);
        var msg = "";
        switch (obj.res) {
            case 0:
                MGCData.difFollowAnchor[MGCData.isAnchorOrRoom].followAnchor = 1;
                break;
            case 1:
                msg = '土豪，您的关注达到上限啦~';
                MGCData.difFollowAnchor[MGCData.isAnchorOrRoom].followAnchor = 0;
                MGC_anchorCardResponse.IsMaxFollow();
        
                break;
            case 4:
                MGCData.difFollowAnchor[MGCData.isAnchorOrRoom].followAnchor = 1;
                break;
            case 9:
                msg = '土豪，您的关注达到上限啦~升级就能提高上限呢！';
                MGCData.difFollowAnchor[MGCData.isAnchorOrRoom].followAnchor = 0;
                MGC_anchorCardResponse.NotMaxFollow();
                break;
            
            default: break;
        }
        if (obj.res == 0 || obj.res == 4) {
            MGC_anchorCardResponse.refreshFollowInfo('add', anchor_id);
            /*var msg = "恭喜您，成功关注该主播";*/
        }
        //给flash下发
        response_as(obj);
        
    },

    //满级弹框
    IsMaxFollow: function(){
        var dialogStr = {};
        dialogStr.Title = '温馨提示';
        dialogStr.BtnName = '确定';
        dialogStr.BtnNum = 1;
        dialogStr.Note = '土豪，您的关注达到上限啦~';

        MGC_Comm.CommonDialog(dialogStr);
        $('#CommonDialog').css("top", "310px");
        $('#CommonDialog').find("#NoteP").css("textAlign", "left");
    },
    //未满级弹框
    NotMaxFollow: function(){
        var dialogStr = {};
        dialogStr.Title = '温馨提示';
        dialogStr.BtnName = '确定';
        dialogStr.BtnNum = 1;
        dialogStr.Note = '土豪，您的关注达到上限啦~升级就能提高上限呢！';

        MGC_Comm.CommonDialog(dialogStr);
        $('#CommonDialog').css("top", "310px");
        $('#CommonDialog').find("#NoteP").css("textAlign", "left");
    },

    //取消关注主播
    CancelFollowAnchorCallBack: function(obj, anchor_id) {
        console.log("取消关注主播的返回" + obj);        
        obj = MGC_Comm.strToJson(obj);
        var msg = "";
        switch (obj.res) {
            
            default:
            //msg = '取消关注主播失败，未知错误。';
                break;
        }
        if (obj.res == 0) {
            MGCData.difFollowAnchor[MGCData.isAnchorOrRoom].followAnchor = 0;
            MGC_anchorCardResponse.refreshFollowInfo('cancel', anchor_id);
        }
        //给flash下发
        response_as(obj);
        
    },
	//是否关注了主播 删除
    isFollowAnchor: function() {
        var _reqStr = "{\"op_type\": 117, \"AnchorId\":" + MGCData.anchorID + "}";
        MGC_Comm.sendMsg(_reqStr, "MGC_anchorCardResponse.isFollowAnchorCallBack");
    },

    //取消和关注主播
    followAnchorAction: function (type, anchorId, name, isFollow) {
        if (window.mgc.account.checkLoginStatus()) {
            console.log("屏蔽游客操作：取消和关注主播");
            return false;//游客身份下，屏蔽此操作
        }
        if (type == 0) {
            //本页主播的关注
            MGCData.isAnchorOrRoom = 0;
            var op_type = MGCData.difFollowAnchor[0].followAnchor == 0 ? 116 : 117;
            MGCData.difFollowAnchor[0].followAnchor = 1 - MGCData.difFollowAnchor[0].followAnchor;
            var anchor_id = MGCData.anchorID;
            var anchor_nick = '';
            if (typeof (MGCData.anchorName) != 'undefined') {
                anchor_nick = MGCData.anchorName;
            } else {
                anchor_nick = name;
            }
            
        } else {
            //不确定是否是本页主播的关注
            MGCData.isAnchorOrRoom = 1;
            var op_type = isFollow == 0 ? 116 : 117;
            MGCData.difFollowAnchor[1].followAnchor = 1 - isFollow;
            var anchor_id = anchorId;
            var anchor_nick = name;
        }
        var _reqStr = {
            "op_type": op_type,
            "anchor_id": anchor_id,
            "anchor_nick": anchor_nick
        };
        
        if (op_type == 116) {
            mgc.tools.EAS([{ 'e_c': 'mgc.attention', 'c_t': 4 }]);
            MGC_Comm.sendMsg(_reqStr, "MGC_anchorCardResponse.FollowAnchorActionCallBack", anchor_id);
        } else {
            mgc.tools.EAS([{ 'e_c': 'mgc.unattention', 'c_t': 4 }]);
            MGC_Comm.sendMsg(_reqStr, "MGC_anchorCardResponse.CancelFollowAnchorCallBack", anchor_id);
        }
    },
    //刷新我的关注信息
    refreshFollowInfo: function (type, anchor_id) {
        var fansNum = parseInt($('.si_fans_num').text()); //页面的
        var fansCardNum = parseInt($('.fans').text()); //card面板里面的
        if (type == 'add') {
            //关注--面板里面的肯定要变
            $('.btn_care').text('已关注');
            ++fansCardNum;
            $('.fans').text(fansCardNum);
            $('.btn_care').attr('isFollow', 1);
            if (anchor_id == MGCData.anchorID) {
                $('.si_attention').text('已关注');
                ++fansNum;
                $('.si_fans_num').text(fansNum + ' 位粉丝');
                MGCData.difFollowAnchor[0].followAnchor = 1;
            }
        } else {
            $('.btn_care').text('关 注');

            // if(type != 'over'){
            --fansCardNum;
            // }

            fansCardNum = fansCardNum <= 0 ? 0 : fansCardNum;
            $('.fans').text(fansCardNum);
            $('.btn_care').attr('isFollow', 0);
            if (anchor_id == MGCData.anchorID) {
                $('.si_attention').text('关 注');
                // if(type != 'over'){
                --fansNum;
                // }

                $('.si_fans_num').text(fansNum + ' 位粉丝');
                MGCData.difFollowAnchor[0].followAnchor = 0;
            }
        }
    }
};
window.mgc.anchorCardRanklistRequest = MGC_anchorCardRequest;
window.mgc.anchorCardRanklistResponse = MGC_anchorCardResponse;