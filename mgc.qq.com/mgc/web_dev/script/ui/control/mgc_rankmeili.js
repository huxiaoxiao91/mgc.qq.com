/**
 * @Description:   梦工厂web-控制-房间内魅力榜
 *
 * @author         Xu XiaoJing
 * @version        V1.0
 * @Date           2016/03/29
 * @Company        horizon3d
 */
define(['jquery', 'mgc_callcenter', 'mgc_luckydraw_view', 'mgc_luckydraw_model', 'mgc_tool', 'mgc_consts', 'mgc_popmanager', 'mgc_account', 'mgc_tips', 'mgc_dialog'], function(jquery, callcenter, mgc_luckydraw_view, mgc_luckydraw_model, tool, consts, mgc_popmanager, mgc_account, mgc_tips, mgc_dialog) {
    $(function() {
        var topPos = 257;
        var leftPos = 69;
        function setMeiliDivPos() {
            var left = $(".layer-mission").offset().left;
            var top = $(".layer-mission").offset().top;
            $("#meili_div").css({
                "top": top + topPos,
                "left": left + leftPos
            });
        }
        setTimeout(function() {
            setMeiliDivPos();
        }, 1500);

        $('body').on('click', '.meili_btn span', function() {
            //homepage拉取成功之前，禁用此事件
            if (isLoginCallback) {
                meili_request.getMeiliRank();
                setMeiliDivPos();
                window.mgc.popmanager.layerControlShow($m("#meili_div"), 3, 1);
            }
        });
        $('#meili_close').off('click').on('click', function() {
            window.mgc.popmanager.layerControlHide($m("#meili_div"), 3, 1);
        });

        $m('#meili_con').jScrollPane({
            autoReinitialise: true,
            animateScroll: true
        });

        //发送请求========================================
        var meili_request = {
            getMeiliRank: function() {
                var reqParams = {
                    begin_index: 0,
                    end_index: 10,
                    timedimension: 3
                };
                callcenter.callbackStr_req("GET_ANCHOR_MEILI_RANK", meili_callBack.getMeiliRankCallBack, "meili_callBack.getMeiliRankCallBack", reqParams);
            }
        };
        var $scrollAPI = $m('#meili_con').data('jsp');
        var meili_callBack = {
            getMeiliRankCallBack: function(obj) {
                console.log("收到房间内魅力榜信息：" + JSON.stringify(obj));
                var _rankData = obj.ranks;
                var rankLength = _rankData.length;
                if (rankLength > 0) {

                    $.each(_rankData, function(k, v) {
                        if (k == 0) {
                            v.liClass = "sr_first";
                        } else if (k == 1) {
                            v.liClass = "sr_second";
                        } else if (k == 2) {
                            v.liClass = "sr_third";
                        } else {
                            v.liClass = "";
                        }
                        v.liNum = k + 1;
                        //v.photo_url = "http://113.108.77.71:80/qdancersec/ajNVdqHZLLB3gcomwOlCF0ddHjc5KTHiaXZXqN6Ew2hrRIYEPFbUBLl36FibN5eGC5Mc0wZjngovA/0?v=528392830";
                    });

                    var meiliCon = $('#meiliTmpl');
                    var meiliTmpl;
                    var meiliContainer = $m('#meiliContainer');
                    meiliContainer.children().remove();
                    meiliTmpl = meiliCon.tmpl(_rankData);
                    meiliTmpl.appendTo(meiliContainer);
                    $m("#meiliContainer").find("li b").eq(9).css("text-indent", "-4px");

                    meiliContainer.find("i").off("mouseover,mouseout").on("mouseover", function(){
                        var guardLevel = $(this).attr("mgc_guardlevel");
                        var vipName = $(this).attr("mgc_vipName");
                        if (guardLevel) {
                            MGC.jiangLiTips(this, 1, guardLevel);
                        } else if (vipName) {
                            MGC.jiangLiTips(this, 1, vipName);
                        }
                    }).on("mouseout", function(){
                        MGC.jiangLiTips(this, 0);
                    });
                    meiliTmpl = null;
                    meiliCon = null;
                } else {
                    $('#meiliContainer').html('<div class="bg_meili"><p class="bg_meili_txt">暂时没有房间上榜</p></div>');
                }
                //重绘滚动条
                if ($scrollAPI)
                    $scrollAPI.initScroll();
            }
        };
    });
});
