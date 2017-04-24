/**
 * @Description:   梦工厂web-投票
 *
 * @author         Xu XiaoJing
 * @version        V1.0
 * @Date           2015/12/12
 * @Company        horizon3d
 */
//建立闭包
$m(function($) {

    var MGC_VoteRequest = {
        //获取投票信息 isT：是否是主动推送的
        getVoteInfo: function(isT) {
            if (MGC_Comm.CheckGuestStatus(isT)) {
                console.log("屏蔽游客操作：获取投票信息");
                return false;
                //游客身份下，屏蔽此操作
            }
            var _reqStr = "{\"op_type\":" + OpType.GetVoteInfoOpType + "}";
            MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.getVoteInfoCallBack");
        },
        //投票
        vote: function(voteArr) {
            var _reqStr = "{\"op_type\":" + OpType.VoteOpType + ", \"select\":[" + voteArr + "]}";
            MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.voteCallBack");
        },
        //查看我的投票状态
        checkMyVoteInfo: function() {
            var _reqStr = "{\"op_type\":" + OpType.CheckMyVoteOpType + "}";
            MGC_Comm.sendMsg(_reqStr, "MGC_CommResponse.checkMyVoteInfoCallBack");
        }
    };

    var MGC_VoteResponse = {
        //请求投票信息回调 noVote
        getVoteInfoCallBack: function(obj) {
            console.log("获取的投票信息回调：" + JSON.stringify(obj));
            obj = MGC_Comm.strToJson(obj);
            if (obj.ret == 0) {
                if (obj.errcode == 0 || obj.errcode == 1 || obj.errcode == 10) {
                    /*　　0,操作成功
                    1,投票活动已结束
                    2,重复投票
                    10,上次投票--认为是没投票
                    **/
                    //只有操作成功的时候，才显示有新投票
                    /*
                     if (obj.errcode == 0 && obj.select.length == 0) {
                     $('#newVote').show();
                     }*/
                    var _voteInfo = {};
                    _voteInfo.vote_topic = obj.vote_info.vote_topic;
                    _voteInfo.vote_maxShow = "";
                    if (obj.select.length > 0) {
                        _voteInfo.voteStatus = 'p_vote_ytp';
                    } else if (obj.errcode == 0) {
                        _voteInfo.voteStatus = 'p_vote_jxz';
                        _voteInfo.vote_maxShow = '最多选择' + obj.vote_info.optional_max_count + "项";
                    } else if (obj.errcode == 1 || obj.errcode == 10) {
                        _voteInfo.voteStatus = 'p_vote_js';
                    }
                    //我的投票信息
                    _voteInfo.voteSelect = '';
                    //总的投票信息
                    var _sumVote = 0;
                    $.each(obj.vote_info.vote_entries, function(k, v) {
                        _sumVote += v.curr_count;
                    });
                    $.each(obj.vote_info.vote_entries, function(k, v) {
                        var _newK = k + 1;
                        if (_sumVote == 0) {
                            var _perVote = 0.00;
                        } else {
                            var _perVote = (v.curr_count / _sumVote).toPercent(2);
                        }
                        var _liClass = "";
                        if (obj.errcode == 1 || obj.errcode == 10) {
                            //投票结束的，不显示玩家的投票信息
                        } else if (obj.select.indexOf(k) > -1) {
                            _liClass = "current current_ed";
                        }
                        _voteInfo.voteSelect += '<li class="' + _liClass + '" data-title="0" voteId="' + k + '">';
                        _voteInfo.voteSelect += '<a href="javascript:;"></a>';
                        _voteInfo.voteSelect += '<div class="pv_list_option">';
                        _voteInfo.voteSelect += '<p class="plo_top"><b>0' + _newK + '.</b>' + v.content + '<span><strong>' + _perVote + '</strong>(' + v.curr_count + ')</span></p>';
                        if (parseInt(_perVote) == 0) {
                            _voteInfo.voteSelect += '<p class="pd_progress"><span style="display:none;"></span></p>';
                        } else {
                            _voteInfo.voteSelect += '<p class="pd_progress"><span style="width:' + _perVote + '"></span></p>';
                        }
                        _voteInfo.voteSelect += '<ins></ins>';
                        _voteInfo.voteSelect += '</div>';
                        _voteInfo.voteSelect += '</li>';
                    });
                    _voteInfo.voteMax = obj.vote_info.optional_max_count;

                    var voteCon = $('#voteTmpl');
                    var voteTmpl;
                    var voteContainer = $('#voteContainer');
                    voteContainer.children().remove();
                    voteTmpl = voteCon.tmpl(_voteInfo);
                    voteTmpl.appendTo(voteContainer);
                    //节点出来，调用渲染效果
                    if (obj.errcode == 0 && obj.select.length == 0) {
                        MGC_VoteResponse.popVote(obj.vote_info.optional_max_count);
                        //绑定投票信息
                        $('#p_vote_btn').off('click').on('click', function() {
                            var _maxVote = $(this).attr('num');
                            var _liInfo = $('.pop_vote_con').find('li.current');
                            var _liL = _liInfo.length;
                            if (_liL == 0) {
                                //alert('很抱歉，请先选择投票信息');
                                return;
                            } else if (_liL > _maxVote) {
                                alert('很抱歉，最多只能投' + _maxVote + '票');
                                return;
                            } else {
                                //获得投票信息
                                var _voteArr = new Array();
                                $.each(_liInfo, function(k, v) {
                                    _voteArr.push(v.getAttribute('voteId'));
                                });
                                //发起请求啦
                                MGC_CommRequest.vote(_voteArr);
                            }
                        });
                    }
                    window.mgc.popmanager.layerControlShow($("#voteContainer"), 4, 1);
                    $('#voteContainer').centerDisp();
                    $('#voteContainer').find(".pop_close").off('click').on('click', function() {
                        window.mgc.popmanager.layerControlHide($("#voteContainer"), 4, 1);
                    });
                    voteTmpl = null;
                    voteCon = null;
                } else if (obj.errcode == 5 || obj.errcode == 13) {
                    window.mgc.popmanager.layerControlShow($("#noVote"), 4, 1);
                    $('#noVote').centerDisp();
                    $('#noVote').find(".pop_close").off('click').on('click', function() {
                        window.mgc.popmanager.layerControlHide($("#noVote"), 4, 1);
                    });
                    return;
                } else {//其他默认都认为没有投票
                    window.mgc.popmanager.layerControlShow($("#noVote"), 4, 1);
                    $('#noVote').centerDisp();
                    $('#noVote').find(".pop_close").off('click').on('click', function() {
                        window.mgc.popmanager.layerControlHide($("#noVote"), 4, 1);
                    });
                    return;
                }
            } else {
                alert('很抱歉，获取数据失败，请重试。');
            }
        },
        //投票回调
        voteCallBack: function(obj) {
            obj = MGC_Comm.strToJson(obj);
            if (obj.ret == 0) {
                if (obj.errcode == 0) {
                    var _msg = "恭喜你，投票成功。";
                } else if (obj.errcode == 1) {
                    var _msg = "对不起，本次投票活动已结束，投票失败。";
                } else if (obj.errcode == 2) {
                    var _msg = "对不起，您已经投过票，不能重复投票。";
                } else if (obj.errcode == 3) {
                    var _msg = "很抱歉，已失效的投票。";
                } else if (obj.errcode == 5) {
                    var _msg = "很抱歉，暂时未发起投票，投票失败。";
                } else if (obj.errcode == 6) {
                    var _msg = "很抱歉，不再直播中，不能投票。";
                } else {
                    var _msg = "很抱歉，投票失败。";
                }
                if (obj.errcode == 0) {
                    window.mgc.popmanager.layerControlHide($("#voteContainer"), 4, 1);
                    //刷新投票状态
                    //MGC_CommRequest.getVoteInfo();
                }
                alert(_msg);
            } else {
                alert('很抱歉，投票异常，请重试。');
            }
        },

        //自己是否投票的回调
        checkMyVoteInfoCallBack: function(obj) {
            MGC_Comm.log("自己是否投票通知：" + JSON.stringify(obj));
            if (!obj.res) {
                $('#newVote').show();
            } else {
                $('#newVote').hide();
            }
        },
        //关闭投票
        CloseVote: function(obj) {
            //$('#newVote').hide();
        },
        popVote: function(max) {
            var pvOption = $(".pop_vote_con"), pvArr = pvOption.find("li"), len = pvArr.length, pVoteBtn = $("#p_vote_btn"), num = 0;
            pvArr.each(function() {
                $(this).click(function() {
                    var nowNum = pvOption.find('.current').length;
                    if ($(this).attr("data-title") == 0 && nowNum < max) {
                        $(this).attr("data-title", 1).removeClass().addClass("current");
                    } else if ($(this).attr("class") == "current_ed") {
                        return false;
                    } else {
                        $(this).attr("data-title", 0).removeClass().addClass("");
                    }
                    nowNum = pvOption.find('.current').length;
                    if (nowNum > 0) {
                        pVoteBtn.removeClass().addClass("p_vote_btn");
                    } else {
                        pVoteBtn.removeClass().addClass("p_vote_btn_ed");
                    }
                });
            });
        },
    };
    $.extend(MGC_CommRequest, MGC_VoteRequest);
    $.extend(MGC_CommResponse, MGC_VoteResponse);
    $(function() {
        //投票
        $('.md_tp').off('click').on('click', function() {
            $('#newVote').hide();
            MGC_CommRequest.getVoteInfo();
        });
        $('.tp').off('click').on('click', function() {
            $('#newVote').hide();
            MGC_CommRequest.getVoteInfo();
        });
    });
});
