/**
 * Created by 77 on 2015/10/8.
 */
/**
 * Todo:1.处理排行榜一逻辑
 */
define(['mgc_callcenter', 'mgc_ranklist_model', 'mgc_ranklist_coll', 'mgc_ranklist_view', 'mgc_show_coll', 'mgc_show_view', 'mgc_tool', 'mgc_tips', 'mgc_account', 'mgc_consts'], function(callcenter, ranklist_model, ranklist_coll, ranklist_view, show_coll, show_view, tool, mgc_tips, mgc_account, consts) {
    var common = {};
    var weekStarRes = 0;
    var isFinished = false;
    var currentTimedimension;
    common.InitRanks = {
        tabArr: [{ "tag_id": 0, "tag_name": "日榜" }, { "tag_id": 1, "tag_name": "周榜" }, { "tag_id": 2, "tag_name": "月榜" }, { "tag_id": 3, "tag_name": "总榜" }],
        weekstarTabArr: [{"tag_id": 0, "tag_name": "总榜"}],
        PageArr: {},
        //初始化所有榜单
        Init: function(type) {
            console.log("排行榜切换：" + type);
            if (type == 1) {
                //周星榜分页
                if(isFinished){
                    common.InitRanks.PageArr.WeekStar = new common.InitRanks.Pages('week_star_page', common.MGC_RankListRequest.QueryWeekStarRank);
                    common.InitRanks.InitRankTab(common.InitRanks.weekstarTabArr, 'anchor_week_star', common.MGC_RankListRequest.QueryWeekStarRank);
                } 
            }else if (type == 2) {
                //主播榜
                //魅力榜分页
                common.InitRanks.PageArr.AnchorMeili = new common.InitRanks.Pages('meili_page', common.MGC_RankListRequest.QueryAnchorMeiliRank);
                //主播榜-魅力榜-时间维度tab
                common.InitRanks.InitRankTab(common.InitRanks.tabArr, 'anchor_meili', common.MGC_RankListRequest.QueryAnchorMeiliRank);
                //主播榜-星耀榜-时间维度tab
                common.InitRanks.InitRankTab(common.InitRanks.tabArr, 'anchor_xingyao', common.MGC_RankListRequest.QueryAnchorXingyaoRank);
                //主播榜-积分榜-时间维度tab
                //common.InitRanks.InitRankTab(common.InitRanks.tabArr.slice(0, 3), 'anchor_jifen', common.MGC_RankListRequest.QueryAnchorJifenRank);
                //主播榜-等级榜
                common.MGC_RankListRequest.QueryAnchorDengjiRank();
            } else if (type == 3) {
                //粉丝榜
                //财富榜分页
                common.InitRanks.PageArr.FansCaifu = new common.InitRanks.Pages('wealth_page', common.MGC_RankListRequest.QueryFansCaifuRank);
                //贵族榜分页
                common.InitRanks.PageArr.FansGuizu = new common.InitRanks.Pages('vip_page', common.MGC_RankListRequest.QueryFansGuizuRank);
                //等级榜分页
                common.InitRanks.PageArr.FansDengji = new common.InitRanks.Pages('lv_page', common.MGC_RankListRequest.QueryFansDengjiRank);
                //粉丝榜-财富榜-时间维度tab
                common.InitRanks.InitRankTab(common.InitRanks.tabArr, 'fans_caifu', common.MGC_RankListRequest.QueryFansCaifuRank);
                //粉丝榜-贵族榜
                common.MGC_RankListRequest.QueryFansGuizuRank(null, 1);
                //粉丝榜-后援团榜
                common.MGC_RankListRequest.QueryFansHouyuanRank();
                //粉丝榜-等级榜
                //common.MGC_RankListRequest.QueryFansDengjiRank(null, 1);
                //粉丝榜-亲密度榜-时间维度tab
                common.InitRanks.InitRankTab(common.InitRanks.tabArr, 'anchor_qinmidu', common.MGC_RankListRequest.QueryAnchorQinmiduRank);
            } else {
                //周星礼物榜
                common.MGC_RankListRequest.getWeekGiftRank();
                //周星冠军榜
                common.MGC_RankListRequest.getFirstListRank();
            }

            $('body').on('mouseover', '.icon_how', function(e) {
                $(this).parent().find('.pop_tips').show();
            });

            $('body').on('mouseout', '.icon_how', function(e) {
                $(this).parent().find('.pop_tips').hide();
            });

            $('body').on('mouseover', 'a[class^="i_anchor_level"]', function(e) {
                var level = $(this).html();
                mgc_tips.susTipsHtml(e, 1, '主播等级：' + level);
            });

            $('body').on('mouseout', 'a[class^="i_anchor_level"]', function(e) {
                mgc_tips.susTipsHtml(e, 0);
            });

            $('body').on('mouseover', 'span[class^="i_rich_level"]', function(e) {
                var level = $(this).attr("mgc_rich_level");
                var value = $(this).attr("mgc_rich_value");
                if (level > 0) {
                    mgc_tips.susTipsHtml(e, 1, '财富值：' + value);
                }
            });

            $('body').on('mouseout', 'span[class^="i_rich_level"]', function(e) {
                mgc_tips.susTipsHtml(e, 0);
            });


        },
        //初始化排行榜时间维度tab
        InitRankTab: function(data, id, callback) {
            var tab_hover_coll = new show_coll.TabColl();
            tab_hover_coll.reset(data);
            new show_view.RankTabView(id, tab_hover_coll, 0, callback);
        },
        //格式化榜单数据
        FromatRankData: function() {

        },
        //初始化视图
        InitView: function(_id, _rankData, _max_len, _begin_index) {
            var rank_item_coll = new ranklist_coll.RankItemColl();
            rank_item_coll.reset_rank_list(_rankData, _max_len, _begin_index);
            var rank_list_view = new ranklist_view.RankContainerView(_id, rank_item_coll);
        },
        //分页组件
        Pages: function(container, requestFunc) {
            this.container = container;
            this.currentPage = 1;
            this.timedimension = 0;
            this.totalPage;
            this.requestFunc = requestFunc;
            this.initPage = function() {
                var _this = this, _html = '';
                if (this.totalPage == 1) {
                    _html += '<a href="javascript:;" class="un_homepage">后退十页</a>';
                    _html += '<a href="javascript:;" class="un_prev">上一页</a>';
                    _html += '<span>' + this.currentPage + '/' + this.totalPage + '</span>';
                    _html += '<a href="javascript:;" class="un_next">下一页</a>';
                    _html += '<a href="javascript:;" class="un_lastpage">前进十页</a>';
                } else {
                    if (this.currentPage == 1) {
                        _html += '<a href="javascript:;" class="un_homepage">后退十页</a>';
                        _html += '<a href="javascript:;" class="un_prev">上一页</a>';
                        _html += '<span>' + this.currentPage + '/' + this.totalPage + '</span>';
                        _html += '<a href="javascript:;" class="next">下一页</a>';
                        _html += '<a href="javascript:;" class="lastpage">前进十页</a>';
                    } else if (this.currentPage == this.totalPage) {
                        _html += '<a href="javascript:;" class="homepage">后退十页</a>';
                        _html += '<a href="javascript:;" class="prev">上一页</a>';
                        _html += '<span>' + this.currentPage + '/' + this.totalPage + '</span>';
                        _html += '<a href="javascript:;" class="un_next">下一页</a>';
                        _html += '<a href="javascript:;" class="un_lastpage">前进十页</a>';
                    } else {
                        _html += '<a href="javascript:;" class="homepage">后退十页</a>';
                        _html += '<a href="javascript:;" class="prev">上一页</a>';
                        _html += '<span>' + this.currentPage + '/' + this.totalPage + '</span>';
                        _html += '<a href="javascript:;" class="next">下一页</a>';
                        _html += '<a href="javascript:;" class="lastpage">前进十页</a>';
                    }
                }
                $('#' + this.container).html(_html);
                var aClicks = $('#' + this.container + ' a');
                aClicks.eq(0).on('click', function() { _this.goToFirstTen(); });
                aClicks.eq(1).on('click', function() { _this.goToPrev(); });
                aClicks.eq(2).on('click', function() { _this.goToNext(); });
                aClicks.eq(3).on('click', function() { _this.goToLastTen(); });
            };
            this.goToFirstTen = function() {
                if (this.currentPage == 1) return;
                if (this.currentPage - 10 > 0) {
                    this.currentPage = this.currentPage - 10;
                } else {
                    this.currentPage = 1;
                }
                if(this.requestFunc.name == "QueryWeekStarRank"){
                    this.timedimension = common.InitRanks.Pages.timedimension;
                }
                this.requestFunc(this.timedimension, this.currentPage);
            };
            this.goToLastTen = function() {
                if (this.currentPage >= this.totalPage) return;
                if (this.currentPage + 10 < this.totalPage) {
                    this.currentPage = this.currentPage + 10;
                } else {
                    this.currentPage = this.totalPage;
                }
                if(this.requestFunc.name == "QueryWeekStarRank"){
                    this.timedimension = common.InitRanks.Pages.timedimension;
                }
                this.requestFunc(this.timedimension, this.currentPage);
            };
            this.goToPrev = function() {
                if (this.currentPage == 1) return;
                this.currentPage--;
                if(this.requestFunc.name == "QueryWeekStarRank"){
                    this.timedimension = common.InitRanks.Pages.timedimension;
                }
                this.requestFunc(this.timedimension, this.currentPage);
            };
            this.goToNext = function() {
                if (this.currentPage >= this.totalPage) return;
                this.currentPage++;
                if(this.requestFunc.name == "QueryWeekStarRank"){
                    this.timedimension = common.InitRanks.Pages.timedimension;
                }
                this.requestFunc(this.timedimension, this.currentPage);
            };
        }
    };
    //请求
    common.MGC_RankListRequest = {
        // =============周星榜（读配置的分组）==============
        QueryWeekStarRank: function(timedimension, pageindex) {
            common.InitRanks.Pages.timedimension = timedimension;
            var cacheData = $('#anchor_week_star_container').data('showlist' + timedimension);
            if (typeof cacheData == 'undefined' || pageindex > 1) {
                var pageSize = 10;
                var begin_index = (pageindex - 1) * pageSize;
                var end_index = pageindex * pageSize;
                // callcenter.query_anchor_meili_rank(begin_index, end_index, timedimension, common.MGC_RankListResponse.QueryWeekStarRankCallback);
                callcenter.query_weekstar_ranklist(timedimension, begin_index, end_index, common.MGC_RankListResponse.QueryWeekStarRankCallback);
                currentTimedimension = timedimension;
                
            } else {
                common.MGC_RankListResponse.QueryWeekStarRankCallback(cacheData);
            }
        },
    	//=============房间魅力榜（日周月总）==============
        QueryAnchorMeiliRank: function(timedimension, pageindex) {
            var cacheData = $('#anchor_meili_container').data('showlist' + timedimension);
            if (typeof cacheData == 'undefined' || pageindex > 1) {
                var pageSize = 10;
                var begin_index = (pageindex - 1) * pageSize;
                var end_index = pageindex * pageSize;
                callcenter.query_anchor_meili_rank(begin_index, end_index, timedimension, common.MGC_RankListResponse.QueryAnchorMeiliRankCallback);
            } else {
                common.MGC_RankListResponse.QueryAnchorMeiliRankCallback(cacheData);
            }
        },
        //=============主播等级榜==============
        QueryAnchorDengjiRank: function() {
            callcenter.query_anchor_dengji_rank(common.MGC_RankListResponse.QueryAnchorDengjiRankCallback);
        },
        //=============主播积分榜（日周月）==============
        QueryAnchorJifenRank: function(timedimension) {
            var cacheData = $('#anchor_jifen_container').data('showlist' + timedimension);
            if (typeof cacheData == 'undefined') {
                callcenter.query_anchor_jifen_rank(timedimension, common.MGC_RankListResponse.QueryAnchorJifenRankCallback);
            } else {
                common.MGC_RankListResponse.QueryAnchorJifenRankCallback(cacheData);
            }
        },
        //=============主播星耀榜（日周月总）==============
        QueryAnchorXingyaoRank: function(timedimension) {
            var cacheData = $('#anchor_xingyao_container').data('showlist' + timedimension);
            if (typeof cacheData == 'undefined') {
                callcenter.query_anchor_xingyao_rank(timedimension, common.MGC_RankListResponse.QueryAnchorXingyaoRankCallback);
            } else {
                common.MGC_RankListResponse.QueryAnchorXingyaoRankCallback(cacheData);
            }
        },
        //=============主播亲密度榜（日周月总）==============
        QueryAnchorQinmiduRank: function(timedimension) {
            var cacheData = $('#anchor_qinmidu_container').data('showlist' + timedimension);
            if (typeof cacheData == 'undefined') {
                callcenter.query_anchor_qinmidu_rank(timedimension, common.MGC_RankListResponse.QueryAnchorQinmiduRankCallback);
            } else {
                common.MGC_RankListResponse.QueryAnchorQinmiduRankCallback(cacheData);
            }
        },
        //=============粉丝财富榜（日周月总）==============
        QueryFansCaifuRank: function(timedimension, pageindex) {
            var cacheData = $('#fans_caifu_container').data('showlist' + timedimension);
            if ((typeof cacheData == 'undefined') || pageindex > 1) {
                var pageSize = 10;
                var begin_index = (pageindex - 1) * pageSize;
                var end_index = pageindex * pageSize;
                callcenter.query_fans_caifu_rank(begin_index, end_index, timedimension, common.MGC_RankListResponse.QueryFansCaifuRankCallback);
            } else {
                common.MGC_RankListResponse.QueryFansCaifuRankCallback(cacheData);
            }
        },
        //=============粉丝贵族榜==============
        QueryFansGuizuRank: function(timedimension, pageindex) {
            var pageSize = 10;
            var begin_index = (pageindex - 1) * pageSize;
            var end_index = pageindex * pageSize;
            callcenter.query_fans_guizu_rank(begin_index, end_index, common.MGC_RankListResponse.QueryFansGuizuRankCallback);
        },
        //=============粉丝后援团榜==============
        QueryFansHouyuanRank: function() {
            callcenter.query_fans_houyuan_rank(common.MGC_RankListResponse.QueryFansHouyuanRankCallback);
        },
        //=============粉丝等级榜==============
        QueryFansDengjiRank: function(timedimension, pageindex) {
            var pageSize = 10;
            var begin_index = (pageindex - 1) * pageSize;
            var end_index = pageindex * pageSize;
            callcenter.query_fans_dengji_rank(begin_index, end_index, common.MGC_RankListResponse.QueryFansDengjiRankCallback);
        },

        //周星礼物榜
        getWeekGiftRank: function() {
            callcenter.getWeekGiftRank(common.MGC_RankListResponse.getWeekGiftRankCallBack);
        },

        //周星冠军榜
        getFirstListRank: function() {
            callcenter.getFirstListRank(common.MGC_RankListResponse.getFirstListRankCallBack);
        }

    };
    //响应
    common.MGC_RankListResponse = {
        firstWeekstarNotStartEmptyHtml: '<div class="bg_none"><p class="bg_none_img"></p><p class="bg_none_txt">赛季未开启，敬请期待</p></div>',
        firstWeekstarInEmptyHtml: '<div class="bg_none"><p class="bg_nodata_img"></p><p class="bg_none_txt">赛季已开启，快来角逐王者桂冠</p></div>',
        anchorEmptyHtml: '<div class="bg_none"><p class="bg_none_img"></p><p class="bg_none_txt">主播排队中，快去支持喜爱的主播吧</p></div>',
        meiliEmptyHtml: '<div class="bg_none"><p class="bg_none_img"></p><p class="bg_none_txt">暂时没有房间上榜</p></div>',
        fansEmptyHtml: '<div class="bg_none"><p class="bg_none_img"></p><p class="bg_none_txt">虚位以待，等你来战！！！</p></div>',
        //=============周星榜==============
        QueryWeekStarRankCallback: function(resp, params) {
            $('.rc_week_star').find('.icon_card,.icon_card_img').off("mouseenter");
            $('.rc_week_star').find('.icon_card,.icon_card_img').off("mouseleave");
            console.log("QueryWeekStarRankCallback start");
            var _id = "anchor_week_star";
            var _container = $("#" + _id + "_container");         
            var _rankData = resp.rank;
            console.log("QueryWeekStarRankCallback res = " + JSON.stringify(resp));
            $("#anchor_week_star_tab").hide();
            $("#week_star_con .tips").hide();
            if(resp.res == 0 || resp.res == 2 || resp.res == 5){//成功
                $("#anchor_week_star_tab").show();
                $("#week_star_con .tips").show();
                if (common.InitRanks.PageArr.WeekStar.timedimension != currentTimedimension) {
                    common.InitRanks.PageArr.WeekStar.currentPage = 1;
                }
                if(resp.res == 5){
                    $("#week_star_con .tips").html("该赛季结束于<span class='date'></span>");
                }
                $("#week_star_con .tips .date").html(new Date(resp.settle_time*1000).format("yyyy/MM/dd"));
                $.each(_rankData, function(i, o) {
                    o.rank_icon = o.order_change > 0 ? "up" : o.order_change == 0 ? "nor" : o.order_change < 0 ? "down" : "nor";
                    o.m_order_change_abs = (o.order_change == 0 ? "" : Math.abs(o.order_change));
                });
                if(resp.rank.length>0){
                    resp.rank[0].player_nick = resp.contribute_player.player_nick;
                    resp.rank[0].player_anchor_id = resp.contribute_player.anchor_id;
                    resp.rank[0].player_psid = resp.contribute_player.player_pstid;
                    resp.rank[0].have_portrait = resp.contribute_player.have_portrait;
                    resp.rank[0].session = resp.contribute_player.session;
                    resp.rank[0].contribution = resp.contribute_player.player_contribution;
                }
                
                for(var i=0, n=resp.rank.length; i<n; i++){
                    if(resp.rank[i].sub_level>=10){
                        resp.rank[i].num = 2;
                        resp.rank[i].sub_level1 = parseInt(resp.rank[i].sub_level / 10);
                        resp.rank[i].sub_level2 = resp.rank[i].sub_level % 10;
                    } else{
                        resp.rank[i].num = 1;
                    }
                }
                var _max_len = 10;                                                  //每页条数
                var _total = resp.total_size;                                       //总条数
                var _total_page = Math.ceil(_total / _max_len);                     //总页数
                _total_page = _total_page > 0 ? _total_page : 1;
                var _curPage = common.InitRanks.PageArr.WeekStar.currentPage;      //当前页码
                var _begin_index = (_curPage - 1) * _max_len;                       //当前开始序列

                //初始化view
                common.InitRanks.InitView(_id, _rankData, _max_len, _begin_index);
                // common.InitRanks.PageArr.WeekStar.currentPage += 1;
                // common.InitRanks.PageArr.WeekStar.timedimension = common.InitRanks.PageArr.WeekStar.currentPage + 1;
                if(_total_page > 100){
                    _total_page = 100;
                }
                $("#week_star_page span").html(_curPage + "/" + _total_page);
                common.InitRanks.PageArr.WeekStar.totalPage = _total_page;
                common.InitRanks.PageArr.WeekStar.initPage();
            } else if(resp.res == 1){//比赛未开始
                $('#week_star_page').children().remove();
                _container.html(common.MGC_RankListResponse.firstWeekstarNotStartEmptyHtml);
            } else if(resp.res == 3){//开赛第一周，榜上无数据
                $('#week_star_page').children().remove();
                _container.html(common.MGC_RankListResponse.firstWeekstarInEmptyHtml);
            }        

            $('.rc_week_star').find('.icon_card,.icon_card_img').on("mouseenter", function (e) {
                //var mouse_enter_info = "e{clientX:" + e.clientX + ", clientY:" + e.clientY + ", pageX:" + e.pageX + ", pageY:" + e.pageY + ", offsetX:" + e.offsetX + ", offsetY:" + e.offsetY + "}"
                  //  + "<br/>this.offset{offset.left:" + $(this).offset().left+ ", offset.top:" + $(this).offset().top + "}";//", pageXOffset:" + this.pageXOffset + ", pageYOffset:" + this.pageYOffset + "}";
                //console.log("mouse_enter_info:" + mouse_enter_info);
                //alert(mouse_enter_info);                
                var z = 0;              
                var x = 0, y = 0;
                var yRanklistName = $(this)[0].parentNode.parentNode.parentNode.className;
                if ($(this).hasClass('icon_card')) {
                    if (yRanklistName == "first" || yRanklistName == "second" || yRanklistName == "third") {
                        y += -6-e.offsetY;
                    } else {
                        y += -e.offsetY;
                    }
                    x += - e.offsetX;
                    z = 25;
                } else if ($(this).hasClass('icon_card_img')) {
                    x += 35 - e.offsetX;
                    y += -13 - e.offsetY;
                    z = 63;
                }                
                var hostId = $(this).attr('hostId');
                window.mgc.common_contral.anchorTips.doShow(hostId, x, y + z, e);                      
            });
            $('.rc_week_star').find('.icon_card,.icon_card_img').on("mouseleave", function (e) {                
                window.mgc.common_contral.anchorTips.doHide();
            });
            console.log("QueryWeekStarRankCallback end");
        },
        //=============房间魅力榜（日周月总）==============
        QueryAnchorMeiliRankCallback: function (resp, params) {
            $('.rc_meili').find('.icon_card,.icon_card_img').off("mouseenter");
            $('.rc_meili').find('.icon_card,.icon_card_img').off("mouseleave");
            console.log("QueryAnchorMeiliRankCallback start");
            var _id = "anchor_meili";
            var _container = $("#" + _id + "_container");            
            var _rankData = resp.ranks;
            if (_rankData.length > 0) {
                if (common.InitRanks.PageArr.AnchorMeili.timedimension != resp.timedimension) {
                    common.InitRanks.PageArr.AnchorMeili.currentPage = 1;
                }
                $.each(_rankData, function(i, o) {
                    o.rank_icon = o.order_change > 0 ? "up" : o.order_change == 0 ? "nor" : o.order_change < 0 ? "down" : "nor";
                    o.m_order_change_abs = (o.order_change == 0 ? "" : Math.abs(o.order_change));
                });
                var _max_len = 10;                                                  //每页条数
                var _total = resp.total_size;                                       //总条数
                var _total_page = Math.ceil(_total / _max_len);                     //总页数
                var _curPage = common.InitRanks.PageArr.AnchorMeili.currentPage;      //当前页码
                var _begin_index = (_curPage - 1) * _max_len;                       //当前开始序列
                //初始化view
                common.InitRanks.InitView(_id, _rankData, _max_len, _begin_index);

                common.InitRanks.PageArr.AnchorMeili.timedimension = resp.timedimension;
                common.InitRanks.PageArr.AnchorMeili.totalPage = _total_page;
                common.InitRanks.PageArr.AnchorMeili.initPage();
            }
            else {
            	$('#meili_page').children().remove();
                _container.html(common.MGC_RankListResponse.meiliEmptyHtml);
            }           

            $('.rc_meili').find('.icon_card,.icon_card_img').on("mouseenter", function (e) {
                //var mouse_enter_info = "e{clientX:" + e.clientX + ", clientY:" + e.clientY + ", pageX:" + e.pageX + ", pageY:" + e.pageY + ", offsetX:" + e.offsetX + ", offsetY:" + e.offsetY + "}"
                  //  + "<br/>this.offset{offset.left:" + $(this).offset().left+ ", offset.top:" + $(this).offset().top + "}";//", pageXOffset:" + this.pageXOffset + ", pageYOffset:" + this.pageYOffset + "}";
                //console.log("mouse_enter_info:" + mouse_enter_info);
                //alert(mouse_enter_info);                
                var z = 0;              
                var x = 0, y = 0;
                var yRanklistName = $(this)[0].parentNode.parentNode.parentNode.className;
                if ($(this).hasClass('icon_card')) {
                    if (yRanklistName == "first" || yRanklistName == "second" || yRanklistName == "third") {
                        y += -6-e.offsetY;
                    } else {
                        y += -e.offsetY;
                    }
                    x += - e.offsetX;
                    z = 25;
                } else if ($(this).hasClass('icon_card_img')) {
                    x += 35 - e.offsetX;
                    y += -13 - e.offsetY;
                    z = 63;
                }                
                var hostId = $(this).attr('hostId');
                window.mgc.common_contral.anchorTips.doShow(hostId, x, y + z, e);                      
            });
            $('.rc_meili').find('.icon_card,.icon_card_img').on("mouseleave", function (e) {                
                window.mgc.common_contral.anchorTips.doHide();
            });
            console.log("QueryAnchorMeiliRankCallback end");
        },
        //=============主播等级榜==============
        QueryAnchorDengjiRankCallback: function (resp, params) {

            console.log("QueryAnchorDengjiRankCallback");
            $('.rc_dengji').find('.icon_card,.icon_card_img').off("mouseenter");
            $('.rc_dengji').find('.icon_card,.icon_card_img').off("mouseleave");
            var _id = "anchor_dengji";
            var _container = $("#" + _id + "_container");
            var _rankData = resp.anchorRank;
            if (_rankData.length > 0) {
                var _max_len = 12;//每页条数
                var _begin_index = 0;//当前开始序列
                //初始化view
                common.InitRanks.InitView(_id, _rankData, _max_len, _begin_index);
            }
            else {
                _container.html(common.MGC_RankListResponse.anchorEmptyHtml);
            }
            $('.rc_dengji').find('.icon_card,.icon_card_img').on("mouseenter", function (e) {
                var z = 0;
                var x = 0, y = 0;
                var yRanklistName = $(this)[0].parentNode.parentNode.parentNode.className;
                if ($(this).hasClass('icon_card')) {
                    if (yRanklistName == "first" || yRanklistName == "second" || yRanklistName == "third") {
                        y += -6 - e.offsetY;
                    } else {
                        y += -e.offsetY;
                    }
                    x += - e.offsetX;                    
                    z = 25;
                } else if ($(this).hasClass('icon_card_img')) {
                    x += 35 - e.offsetX;
                    y += -13 - e.offsetY;
                    z = 63;
                }
                var hostId = $(this).attr('hostId');
                window.mgc.common_contral.anchorTips.doShow(hostId, x, y + z, e);                
            });
            $('.rc_dengji').find('.icon_card,.icon_card_img').on("mouseleave", function (e) {
                window.mgc.common_contral.anchorTips.doHide();
            });
        },
        //=============主播积分榜（日周月）==============
        QueryAnchorJifenRankCallback: function(resp, params) {
            console.log("QueryAnchorJifenRankCallback:" + resp.timedimension);
            $('.rc_jifen').find('.icon_card,.icon_card_img').off("mouseenter");
            $('.rc_jifen').find('.icon_card,.icon_card_img').off("mouseleave");
            var _id = "anchor_jifen";
            var _container = $("#" + _id + "_container");
            var _rankData = resp.rank;
            if (_rankData.length > 0) {
                var _max_len = 12;//每页条数
                var _begin_index = 0;//当前开始序列
                if (typeof _container.data('showlist' + resp.timedimension) == 'undefined') {
                    _container.data('showlist' + resp.timedimension, resp);//缓存
                }
                $.each(_rankData, function(i, o) {
                    o.rank_icon = o.m_order_change > 0 ? "up" : o.m_order_change == 0 ? "nor" : o.m_order_change < 0 ? "down" : "nor";
                    o.m_order_change_abs = (o.m_order_change == 0 ? "" : Math.abs(o.m_order_change));
                });
                //初始化view
                common.InitRanks.InitView(_id, _rankData, _max_len, _begin_index);
            }
            else {
                _container.html(common.MGC_RankListResponse.anchorEmptyHtml);
            }
            $('.rc_jifen').find('.icon_card,.icon_card_img').on("mouseenter", function (e) {
                var z = 0;
                var x = 0, y = 0;
                var yRanklistName = $(this)[0].parentNode.parentNode.parentNode.className;
                if ($(this).hasClass('icon_card')) {
                    if (yRanklistName == "first" || yRanklistName == "second" || yRanklistName == "third") {
                        y += -6 - e.offsetY;
                    } else {
                        y += -e.offsetY;
                    }
                    x += - e.offsetX;                    
                    z = 25;
                } else if ($(this).hasClass('icon_card_img')) {
                    x += 35 - e.offsetX;
                    y += -13 - e.offsetY;
                    z = 63;
                }
                var hostId = $(this).attr('hostId');
                window.mgc.common_contral.anchorTips.doShow(hostId, x, y + z, e);                
            });
            $('.rc_jifen').find('.icon_card,.icon_card_img').on("mouseleave", function (e) {
                window.mgc.common_contral.anchorTips.doHide();
            });
        },
        //=============主播星耀榜（日周月总）==============
        QueryAnchorXingyaoRankCallback: function(resp, params) {
            console.log("QueryAnchorXingyaoRankCallback:" + resp.timedimension);
            $('.rc_xy').find('.icon_card,.icon_card_img').off("mouseenter");
            $('.rc_xy').find('.icon_card,.icon_card_img').off("mouseleave");
            var _id = "anchor_xingyao";
            var _container = $("#" + _id + "_container");
            var _rankData = resp.rank.anchorRank;
            if (_rankData.length > 0) {
                var _max_len = 12;//每页条数
                var _begin_index = 0;//当前开始序列
                if (typeof _container.data('showlist' + resp.timedimension) == 'undefined') {
                    _container.data('showlist' + resp.timedimension, resp);//缓存
                }
                $.each(_rankData, function(i, o) {
                    o.m_anchor_status = o.status;
                    o.m_anchor_name = o.name;
                    o.m_room_id = o.room_id;
                    o.rank_icon = o.order_change > 0 ? "up" : o.order_change == 0 ? "nor" : o.order_change < 0 ? "down" : "nor";
                    o.m_order_change_abs = (o.order_change == 0 ? "" : Math.abs(o.order_change));
                    o.m_score = o.starlight;
                    o.m_anchor_portrait_url = o.photoUrl;
                });
                //初始化view
                common.InitRanks.InitView(_id, _rankData, _max_len, _begin_index);
            }
            else {
                _container.html(common.MGC_RankListResponse.anchorEmptyHtml);
            }
            $('.rc_xy').find('.icon_card,.icon_card_img').on("mouseenter", function (e) {
                var z = 0;
                var x = 0, y = 0;
                var yRanklistName = $(this)[0].parentNode.parentNode.parentNode.className;
                if ($(this).hasClass('icon_card')) {
                    if (yRanklistName == "first" || yRanklistName == "second" || yRanklistName == "third") {
                        y += -6 - e.offsetY;
                    } else {
                        y += -e.offsetY;
                    }
                    x += - e.offsetX;                    
                    z = 25;
                } else if ($(this).hasClass('icon_card_img')) {
                    x += 35 - e.offsetX;
                    y += -13 - e.offsetY;
                    z = 63;
                }
                var hostId = $(this).attr('hostId');
                window.mgc.common_contral.anchorTips.doShow(hostId, x, y + z, e);                
            });
            $('.rc_xy').find('.icon_card,.icon_card_img').on("mouseleave", function (e) {
                window.mgc.common_contral.anchorTips.doHide();
            });
        },
        //=============主播亲密度榜（日周月总）==============
        QueryAnchorQinmiduRankCallback: function(resp, params) {
            console.log("QueryAnchorQinmiduRankCallback:" + resp.timedimension);
            $('.rc_qmd').find('.icon_card,.icon_card_img').off("mouseenter");
            $('.rc_qmd').find('.icon_card,.icon_card_img').off("mouseleave");
            var _id = "anchor_qinmidu";
            var _container = $("#" + _id + "_container");
            var _rankData = resp.rank;
            if (_rankData.length > 0) {
                var _max_len = 12;//每页条数
                var _begin_index = 0;//当前开始序列
                if (typeof _container.data('showlist' + resp.timedimension) == 'undefined') {
                    _container.data('showlist' + resp.timedimension, resp);//缓存
                }
                $.each(_rankData, function(i, o) {
                    o.rank_icon = o.order_change > 0 ? "up" : o.order_change == 0 ? "nor" : o.order_change < 0 ? "down" : "nor";
                    o.m_order_change_abs = (o.order_change == 0 ? "" : Math.abs(o.order_change));
                    if (o.m_has_portrait) {
                        o.playerphoto = o.playerPhotoUrl;
                    } else {
                        if (o.playerGender == 1) {
                            o.playerphoto = consts.filePath.DEFAULT_MALE;
                        } else {
                            o.playerphoto = consts.filePath.DEFAULT_FEMALE;
                        }
                    }
                });
                //初始化view
                common.InitRanks.InitView(_id, _rankData, _max_len, _begin_index);
            }
            else {
                _container.html(common.MGC_RankListResponse.anchorEmptyHtml);
            }
            $('.rc_qmd').find('.icon_card,.icon_card_img').on("mouseenter", function (e) {
                var z = 0;
                var x = 0, y = 0;
                var yRanklistName = $(this)[0].parentNode.parentNode.className;
                if ($(this).hasClass('icon_card')) {
                    if (yRanklistName == "first" || yRanklistName == "second" || yRanklistName == "third") {
                        y += 15 - e.offsetY;
                        x += 11 - e.offsetX;
                    } else {
                        y += - e.offsetY;
                        x += 5 - e.offsetX;
                    }
                                 
                    z = 25;
                } else if ($(this).hasClass('icon_card_img')) {
                    x += 35 - e.offsetX;
                    y += -13 - e.offsetY;
                    z = 63;
                }
                var hostId = $(this).attr('hostId');
                window.mgc.common_contral.anchorTips.doShow(hostId, x, y + z, e);                
            });
            $('.rc_qmd').find('.icon_card,.icon_card_img').on("mouseleave", function (e) {
                window.mgc.common_contral.anchorTips.doHide();
            });
        },
        //=============粉丝财富榜（日周月总）==============
        QueryFansCaifuRankCallback: function(resp, params) {
            console.log("QueryFansCaifuRankCallback start");
            var _id = "fans_caifu";
            var _container = $("#" + _id + "_container");
            var _rankData = resp.rank;
            if (_rankData.length > 0) {

                if (common.InitRanks.PageArr.FansCaifu.timedimension != resp.timedimension) {
                    common.InitRanks.PageArr.FansCaifu.currentPage = 1;
                }
                //有分页的tab页不缓存了
                $.each(_rankData, function(i, o) {
                    o.rank_icon = o.m_order_change > 0 ? "up" : o.m_order_change == 0 ? "nor" : o.m_order_change < 0 ? "down" : "nor";
                    o.m_order_change_abs = (o.m_order_change == 0 ? "" : Math.abs(o.m_order_change));
                    o.m_score = o.m_video_wealth;
                });
                var _max_len = 10;                                                  //每页条数
                var _total = resp.total_size;                                       //总条数
                var _total_page = Math.ceil(_total / _max_len);                     //总页数
                var _curPage = common.InitRanks.PageArr.FansCaifu.currentPage;      //当前页码
                var _begin_index = (_curPage - 1) * _max_len;                       //当前开始序列
                //初始化view
                common.InitRanks.InitView(_id, _rankData, _max_len, _begin_index);

                common.InitRanks.PageArr.FansCaifu.timedimension = resp.timedimension;
                common.InitRanks.PageArr.FansCaifu.totalPage = _total_page;
                common.InitRanks.PageArr.FansCaifu.initPage();
                mgc_account.checkLogin(function() {
                    var _myRank = resp.my_rank;
                    var tipstr = '';
                    if (_myRank > 1000 || _myRank <= 0) {
                        tipstr = '您暂未上榜！';
                    } else {
                        tipstr = '您的排名：<strong>' + _myRank + '</strong>名';
                    }
                    $('#wealth_tips').html(tipstr);
                }, function() {
                    $('#wealth_tips').html('您尚未登录，无法查看本人排名');
                }, true);
            }
            else {
            	$('#wealth_tips').children().remove();
            	$('#wealth_page').children().remove();
                _container.html(common.MGC_RankListResponse.fansEmptyHtml);
            }
            console.log("QueryFansCaifuRankCallback end");
        },
        //=============粉丝贵族榜==============
        QueryFansGuizuRankCallback: function(resp, params) {
            console.log("QueryFansGuizuRankCallback");
            var _id = "fans_guizu";
            var _container = $("#" + _id + "_container");
            var _rankData = resp.rank;
            if (_rankData.length > 0) {
                var _max_len = 10;                                                  //每页条数
                var _total = resp.total_size;                                       //总条数
                var _total_page = Math.ceil(_total / _max_len);                     //总页数
                var _curPage = common.InitRanks.PageArr.FansGuizu.currentPage;      //当前页码
                var _begin_index = (_curPage - 1) * _max_len;                       //当前开始序列
                $.each(_rankData, function(i, o) {
                    o.m_vip_name = consts.vipLevelTab[o.m_vip_level];
                });
                //初始化view
                common.InitRanks.InitView(_id, _rankData, _max_len, _begin_index);
                common.InitRanks.PageArr.FansGuizu.totalPage = _total_page;
                common.InitRanks.PageArr.FansGuizu.initPage();
                mgc_account.checkLogin(function() {
                    var _myRank = resp.my_rank;
                    var tipstr = '';
                    if (_myRank > 1000 || _myRank <= 0) {
                        tipstr = '您暂未上榜！';
                    } else {
                        tipstr = '您的排名：<strong>' + _myRank + '</strong>名';
                    }
                    $('#vip_tips').html(tipstr);
                }, function() {
                    $('#vip_tips').html('您尚未登录，无法查看本人排名');
                }, true);
            }
            else {
                _container.html(common.MGC_RankListResponse.fansEmptyHtml);
            }
        },
        //=============粉丝后援团榜==============
        QueryFansHouyuanRankCallback: function(resp, params) {
            console.log("QueryFansHouyuanRankCallback");
            $('.rc_hyt').find('.icon_card,.icon_card_img').off("mouseenter");
            $('.rc_hyt').find('.icon_card,.icon_card_img').off("mouseleave");
            var _id = "fans_houyuan";
            var _container = $("#" + _id + "_container");
            var _rankData = resp.rank;
            if (_rankData.length > 0) {
                var _max_len = 12;//每页条数
                var _begin_index = 0;//当前开始序列
                //初始化view
                common.InitRanks.InitView(_id, _rankData, _max_len, _begin_index);
            }
            else {
                _container.html(common.MGC_RankListResponse.fansEmptyHtml);
            }
            $('.rc_hyt').find('.icon_card,.icon_card_img').on("mouseenter", function (e) {
                var z = 0;
                var x = 0, y = 0;
                var yRanklistName = $(this)[0].parentNode.parentNode.className;
                if ($(this).hasClass('icon_card')) {
                    if (yRanklistName == "first" || yRanklistName == "second" || yRanklistName == "third") {
                        y += 15- e.offsetY;
                    } else {
                        y += - e.offsetY;
                    }
                    x += 10- e.offsetX;
                    z = 25;                    
                } else if ($(this).hasClass('icon_card_img')) {
                    x += 35 - e.offsetX;
                    y += -13 - e.offsetY;
                    z = 63;
                }
                var hostId = $(this).attr('hostId');
                window.mgc.common_contral.anchorTips.doShow(hostId, x, y + z, e);                
            });
            $('.rc_hyt').find('.icon_card,.icon_card_img').on("mouseleave", function (e) {
                window.mgc.common_contral.anchorTips.doHide();
            });
        },
        //=============粉丝等级榜==============
        QueryFansDengjiRankCallback: function(resp, params) {
            console.log("QueryFansDengjiRankCallback");
            var _id = "fans_dengji";
            var _container = $("#" + _id + "_container");
            var _rankData = resp.rank;
            if (_rankData.length > 0) {
                var _max_len = 10;                                                  //每页条数
                var _total = resp.total_size;                                       //总条数
                var _total_page = Math.ceil(_total / _max_len);                     //总页数
                var _curPage = common.InitRanks.PageArr.FansDengji.currentPage;      //当前页码
                var _begin_index = (_curPage - 1) * _max_len;                       //当前开始序列
                //初始化view
                common.InitRanks.InitView(_id, _rankData, _max_len, _begin_index);
                common.InitRanks.PageArr.FansDengji.totalPage = _total_page;
                common.InitRanks.PageArr.FansDengji.initPage();
                mgc_account.checkLogin(function() {
                    var _myRank = resp.my_rank;
                    var tipstr = '';
                    if (_myRank > 1000 || _myRank <= 0) {
                        tipstr = '您暂未上榜！';
                    } else {
                        tipstr = '您的排名：<strong>' + _myRank + '</strong>名';
                    }
                    $('#lv_tips').html(tipstr);
                }, function() {
                    $('#lv_tips').html('您尚未登录，无法查看本人排名');
                }, true);
            }
            else {
                _container.html(common.MGC_RankListResponse.fansEmptyHtml);
            }
        },

        //周星礼物榜
        getWeekGiftRankCallBack: function(responseStr) {
            var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);

            //下周礼物
            var $giftnoticeContainer = $(".giftnotice ul");
            var nextweeklistCon = $('#nextweeklistTmpl');
            var nextweeklistTmpl;
            $giftnoticeContainer.children().remove();
            nextweeklistTmpl = nextweeklistCon.tmpl(obj.next_star_gifts);
            nextweeklistTmpl.appendTo($giftnoticeContainer);
            $(".nextweek .date span").html(obj.next_time);


            //周星礼物榜
            var giftListContainer = $(".giftlist ul");
            if (obj.rank_ui.length == 0)//无配置时
            {
                var nonegiftlistCon = $('#nonegiftlistTmpl');
                var nonegiftlistTmpl;
                giftListContainer.children().remove();
                nonegiftlistTmpl = nonegiftlistCon.tmpl([{}]);
                nonegiftlistTmpl.appendTo(giftListContainer);
                nonegiftlistCon = null;
                nonegiftlistTmpl = null;
            }
            else {
                var giftlistCon = $('#giftlistTmpl');
                var giftlistTmpl;
                giftListContainer.children().remove();
                giftlistTmpl = giftlistCon.tmpl(responseStr.rank_ui);
                giftlistTmpl.appendTo(giftListContainer);
                giftlistCon = null;
                giftlistTmpl = null;
            }

            //主播 粉丝榜
            $(".giftlist .center").each(function(index) {

                //主播等级图标
                $.each(responseStr.rank_ui[index].anchor_rank, function(k, v) {
                    v.anchor_level_temp = Math.floor(v.anchor_level / 10) + 1;
                    if (v.anchor_level == 0) {
                        v.anchor_level_temp = 0;
                    }
                });

                //名次 上升下降
                $.each(responseStr.rank_ui[index].anchor_rank, function(index, value) {
                    value.rank = index + 1;

                    var icon = value.order_change > 0 ? "up" : value.order_change == 0 ? "nor" : value.order_change < 0 ? "down" : "nor";
                    value.icon = icon;

                    var order_change = Math.abs(value.order_change);
                    value.order_change = order_change;
                    if (order_change > 99) {
                        value.order_change = "99+";
                    }
                });

                $.each(responseStr.rank_ui[index].player_rank, function(index, value) {
                    value.rank = index + 1;

                    var icon = value.order_change > 0 ? "up" : value.order_change == 0 ? "nor" : value.order_change < 0 ? "down" : "nor";
                    value.icon = icon;

                    var order_change = Math.abs(value.order_change);
                    value.order_change = order_change;
                    if (order_change > 99) {
                        value.order_change = "99+";
                    }
                });


                //主播榜
                var anchor_rank = responseStr.rank_ui[index].anchor_rank;
                var $anchorlistcontainer = $(this).find(".anchorlistcontainer ul").eq(0);
                var giftAnchorlistCon = $('#giftAnchorlistTmpl');
                var giftAnchorlistTmpl;
                $anchorlistcontainer.children().remove();
                giftAnchorlistTmpl = giftAnchorlistCon.tmpl(anchor_rank);
                giftAnchorlistTmpl.appendTo($anchorlistcontainer);


                $('.anchorlist').find('.icon_card,.icon_card_img').on("mouseenter", function (e) {
                    var z = 0;
                    var x = 0, y = 0;
                    var yRanklistName = $(this)[0].parentNode.parentNode.parentNode.className;
                    if ($(this).hasClass('icon_card')) {
                        if (yRanklistName == "first" || yRanklistName == "second" || yRanklistName == "third") {
                            y += -6 - e.offsetY;
                        } else {
                            y +=8 -e.offsetY;
                        }
                        x += -e.offsetX;
                        z = 25;                        
                    } else if ($(this).hasClass('icon_card_img')) {
                        x += 35 - e.offsetX;
                        y += -13 - e.offsetY;
                        z = 63;
                    }
                    var hostId = $(this).attr('hostId');
                    window.mgc.common_contral.anchorTips.doShow(hostId, x, y + z, e);                    
                });
                $('.anchorlist').find('.icon_card,.icon_card_img').on("mouseleave", function (e) {
                    window.mgc.common_contral.anchorTips.doHide();
                });
                //粉丝榜
                var player_rank = responseStr.rank_ui[index].player_rank;

                //粉丝默认头像
                $m.each(player_rank, function(k, v) {
                    if (v.player_id != 0) {
                        if (v.portrait_url == '') {
                            if (v.sex == 1) {
                                v.portrait_url = HeadImgPath + "default_male.png?v=3_8_8_2016_15_4_final_3";
                            } else if (v.sex == 0) {
                                v.portrait_url = HeadImgPath + "default_female.png?v=3_8_8_2016_15_4_final_3";
                            }
                        }
                    } else {
                        v.portrait_url = '';
                    }
                });

                var $fanslistcontainer = $(this).find(".anchorlistcontainer ul").eq(1);
                var giftFanslistCon = $('#giftFanslistTmpl');
                var giftFanslistTmpl;
                $fanslistcontainer.children().remove();
                giftFanslistTmpl = giftFanslistCon.tmpl(player_rank);
                giftFanslistTmpl.appendTo($fanslistcontainer);

                //粉丝财富等级tip
                $fanslistcontainer.find(".i_rich_level").mouseenter(function(e) {
                    var level = $(this).data("wealth_level");
                    if (level > 0) {
                        mgc_tips.susTipsHtml(e, 1, '财富等级：' + level);
                    }
                });
                $fanslistcontainer.find(".i_rich_level").mouseout(function(e) {
                    mgc_tips.susTipsHtml(e, 0);
                });

                //是否有榜
                var anchorlength = anchor_rank.length;
                if (anchorlength == 0) {
                    $(this).find(".anchorlistcontainer .bg_1").eq(0).show();
                }
                else {
                    $(this).find(".anchorlistcontainer .bg_1").eq(0).hide();

                    //补足5行
                    for (var i = anchorlength + 1; i <= 5; i++) {
                        $anchorlistcontainer.append('<li class="li_' + i + '"></li>');
                    }
                }

                var playerlength = player_rank.length;
                if (playerlength == 0) {
                    $(this).find(".anchorlistcontainer .bg_1").eq(1).show();
                }
                else {
                    $(this).find(".anchorlistcontainer .bg_1").eq(1).hide();

                    //补足5行
                    for (var i = playerlength + 1; i <= 5; i++) {
                        $fanslistcontainer.append('<li class="li_' + i + '"></li>');
                    }
                }
                giftFanslistTmpl = null;
                giftFanslistCon = null;
                giftAnchorlistTmpl = null;
                giftAnchorlistCon = null;
            });
            nextweeklistTmpl = null;
            nextweeklistCon = null;
        },

        //周星冠军榜
        getFirstListRankCallBack: function(responseStr) {
            var obj = typeof responseStr == 'object' ? responseStr : MGC_Comm.strToJson(responseStr);
            //rank_player冠军粉丝榜，rank_anchor冠军主播榜
            //主播等级图标
            $.each(obj.rank_anchor, function(k, v) {
                v.anchor_level_temp = Math.floor(v.anchor_level / 10) + 1;
                if (v.anchor_level == 0) {
                    v.anchor_level_temp = 0;
                }
            });

            //冠军主播榜
            console.log("冠军主播榜："+JSON.stringify(obj.rank_anchor));
            var $anchorlistcontainer = $(".firstlist").find(".anchorlistcontainer ul").eq(0);
            var firstAnchorlistCon = $('#firstAnchorlistTmpl');
            var firstAnchorlistTmpl;
            $anchorlistcontainer.children().remove();
            firstAnchorlistTmpl = firstAnchorlistCon.tmpl(obj.rank_anchor);
            firstAnchorlistTmpl.appendTo($anchorlistcontainer);

            $('.anchorlist').find('.icon_card,.icon_card_img').off("mouseenter");
            $('.anchorlist').find('.icon_card,.icon_card_img').off("mouseleave");


            $('.anchorlist').find('.icon_card,.icon_card_img').on("mouseenter", function (e) {
                var z = 0;
                var x = 0, y = 0;
                var yRanklistName = $(this)[0].parentNode.parentNode.parentNode.className;
                if ($(this).hasClass('icon_card')) {
                    if (yRanklistName == "first" || yRanklistName == "second" || yRanklistName == "third") {
                        y += 8 - e.offsetY;
                    } else {
                        y += 8 - e.offsetY;
                    }
                    x += -e.offsetX;
                    z = 25;
                } else if ($(this).hasClass('icon_card_img')) {
                    x += 35 - e.offsetX;
                    y += -13 - e.offsetY;
                    z = 63;
                }
                var hostId = $(this).attr('hostId');
                window.mgc.common_contral.anchorTips.doShow(hostId, x, y + z, e);                
            });
            $('.anchorlist').find('.icon_card,.icon_card_img').on("mouseleave", function (e) {
                window.mgc.common_contral.anchorTips.doHide();
            });

            //粉丝默认头像
            $m.each(obj.rank_player, function(k, v) {
                if (v.player_id != 0) {
                    if (v.portrait_url == '') {
                        if (v.sex == 1) {
                            v.portrait_url = HeadImgPath + "default_male.png?v=3_8_8_2016_15_4_final_3";
                        } else if (v.sex == 0) {
                            v.portrait_url = HeadImgPath + "default_female.png?v=3_8_8_2016_15_4_final_3";
                        }
                    }
                } else {
                    v.portrait_url = '';
                }
            });

            //冠军粉丝榜
            var $fanslistcontainer = $(".firstlist").find(".anchorlistcontainer ul").eq(1);
            var firstFanslistCon = $('#firstFanslistTmpl');
            var firstFanslistTmpl;
            $fanslistcontainer.children().remove();
            firstFanslistTmpl = firstFanslistCon.tmpl(obj.rank_player);
            firstFanslistTmpl.appendTo($fanslistcontainer);

            //粉丝财富等级tip
            $fanslistcontainer.find(".i_rich_level").mouseenter(function(e) {
                var level = $(this).data("wealth_level");
                if (level > 0) {
                    mgc_tips.susTipsHtml(e, 1, '财富等级：' + level);
                }
            });
            $fanslistcontainer.find(".i_rich_level").mouseout(function(e) {
                mgc_tips.susTipsHtml(e, 0);
            });

            //是否有榜
            if (obj.rank_anchor.length == 0) {
                $(".firstlist .anchorlistcontainer .bg_1").eq(0).show();
            }
            else {
                $(".firstlist .anchorlistcontainer .bg_1").eq(0).hide();

                //补足5行
                for (var i = obj.rank_anchor.length + 1; i <= 5; i++) {
                    $anchorlistcontainer.append('<li class="li_' + i + '"></li>');
                }
            }

            if (obj.rank_player.length == 0) {
                $(".firstlist .anchorlistcontainer .bg_1").eq(1).show();
            }
            else {
                $(".firstlist .anchorlistcontainer .bg_1").eq(1).hide();

                //补足5行
                for (var i = obj.rank_player.length + 1; i <= 5; i++) {
                    $fanslistcontainer.append('<li class="li_' + i + '"></li>');
                }
            }
            firstAnchorlistTmpl = null;
            firstAnchorlistCon = null;
            firstFanslistTmpl = null;
            firstFanslistCon = null;
        }
    };

    common.getWeekstarArr = function(resp, params){
        var groups = resp.groups;
        isFinished = true;
        weekStarRes = resp.res;
        $("#anchor_week_star_tab").hide();
        $("#week_star_con .tips").hide();
        for(var i=0, n=groups.length; i<n; i++){
            common.InitRanks.weekstarTabArr[i+1] = {};
            common.InitRanks.weekstarTabArr[i+1].tag_id = groups[i].group_id;
            common.InitRanks.weekstarTabArr[i+1].tag_name = groups[i].group_name;
        }   
        if(weekStarRes == 0 || weekStarRes == 2){//成功或者主播未参赛
            $("#anchor_week_star_tab").show();
            $("#week_star_con .tips").show();
            common.InitRanks.InitRankTab(common.InitRanks.weekstarTabArr, 'anchor_week_star', common.MGC_RankListRequest.QueryWeekStarRank); 
        
        } else if(weekStarRes == 1){//比赛未开始
            $('#week_star_page').children().remove();
            $("#anchor_week_star_container").html(common.MGC_RankListResponse.firstWeekstarNotStartEmptyHtml);
        } else if(weekStarRes == 3){//开赛第一周，榜上无数据
            $('#week_star_page').children().remove();
            $("#anchor_week_star_container").html(common.MGC_RankListResponse.firstWeekstarInEmptyHtml);
        } else if(weekStarRes == 4){//分组不对，配置读取失败等

        }

        common.InitRanks.PageArr.WeekStar = new common.InitRanks.Pages('week_star_page', common.MGC_RankListRequest.QueryWeekStarRank);
    }
    return common;
});