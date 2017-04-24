/**
 * Created by user on 2015/10/10.
 * 这里主要用来放各处界面用到的模板
 */
define(function () {
    var template = {};
    /*
    大区列表
    */
    template.get_login_old_role_zone_list_tmpl = function () {
        return '<a href="javascript:;" ><%=zonename%></a>';
    };
    /*
    玩家信息 header bar
    */
    template.get_playerinfo_header_bar_tmpl = function () {
        return '<div class="caifu_tips_login" style="top: 51px; left: 203px; z-index: 929004; display: none;">\
                财富值:<%=video_wealth%>\
            </div>\
            <div class="logined_name clearfix">\
                    <strong id="i_player_name"><%=nick %></strong>\
                    <div class="logined_status" style="<%=vip_level>0?\'\':\'display:none\'%>">\
                        <i></i>\
                        <%if(invisible){%>\
                        <strong class="icon1">隐身</strong>\
                        <ul>\
                            <li class="icon0">在线</li>\
                        </ul>\
                        <%}else{%>\
                        <strong class="icon0">在线</strong>\
                        <ul>\
                            <li class="icon1">隐身</li>\
                        </ul>\
                        <%}%>\
                    </div>\
                </div>\
                <div class="logined_info" id="i_card_info">\
                    <ul>\
                    <li>等级：LV<%=video_level%></li>\
                      <li class="r">\
                        梦幻币：<span><%=video_dream_money%></span><i class="icon_mhb"></i>\
                      </li>\
                      <li>\
                        财富：<strong class="icon_caifu">LV<%=wealth_level%><%if(wealth_level>0){%><i class="wealth_level_<%=wealth_level%>"></i><%}%></strong>\
                      </li>\
                      <li class="r">\
                        炫豆：<span class="mar1"><%=video_money_balance%></span><i class="icon_xd"></i>\
                      </li>\
                      <li>\
                        贵族：<%=vipLevelname%> <i class="icon_honor icon_honor<%=vip_level%>"></i>\
                      </li>\
                      <li class="r">大区：<span class="mar2"><%=zone_name = !"" ? (zone_name == "梦工厂"||zone_name.indexOf("QQ游戏")>=0 ? zone_name : "炫舞-" + zone_name) : ""%></span></li>\
                    </ul>\
                </div>\
                <div class="logined_btn">\
                    <a class="l open-vip-btn" href="javascript:mgc.tools.EAS([{\'e_c\': \'mgc.buyvip.1\',\'c_t\':4},{\'e_c\': \'mgc.buyvip\',\'c_t\':4}]);">开通贵族</a>\
                    <a class="r recharge-btn" href="http://pay.qq.com/ipay/index.shtml?c=qxwwqp" onclick="mgc.tools.EAS([{\'e_c\': \'mgc.charge\',\'c_t\':4}]);" target="_blank">充值</a>\
                </div>\
                <div class="logined_entrance clearfix">\
                    <a class="l" id="mgc_personal" href="personal.shtml" target="_blank">个人中心</a>\
                    <a class="r" href="javascript:;">我的粉丝团</a>\
                </div>\
                <a class="loginout" href="javascript:;">退出登录</a>';
    };
    /*
    玩家关注的主播
    */
    template.get_player_followed_tmpl = function () {
        return '<li onmouseover="$(this).find(\'span\').addClass(\'hover\')" onmouseout="$(this).find(\'span\').removeClass(\'hover\')">\
                    <a class="logined_head" <%if(m_status==2){%>onclick="mgc.tools.EAS([{\'e_c\': \'mgc.enterroom.3\',\'c_t\':4},{\'e_c\': \'mgc.enterroom\',\'c_t\':4}]);" href="transfer.shtml?roomId=<%=m_videoroom_id%>&source=7" target="_blank"<%}else{%>href="javascript:;"<%}%>>\
                        <img src="<%=m_photo_url%>" width="32" height="32">\
                        <span></span>\
                        <i class="icon_lv icon_lv<%=guard_level%>"></i>\
                    </a>\
                    <strong><%=m_anchor_nick%></strong>\
                    <%if(m_status == 2){%>\
                        <a class="logined_zb" onclick="mgc.tools.EAS([{\'e_c\': \'mgc.enterroom.3\',\'c_t\':4},{\'e_c\': \'mgc.enterroom\',\'c_t\':4}]);" href="transfer.shtml?roomId=<%=m_videoroom_id%>&source=7" target="_blank">正在直播</a>\
                    <%}else{%>\
                        <a class="logined_lx" href="javascript:;">离线</a>\
                    <%}%>\
                </li>';
    };
    /*
    顶条一级导航菜单
    */
    template.get_header_nav_menu_tmpl = function () {
        return '<a class="nav<%=tag_id%> <%=selected?"current":""%>" href="<%=tag_url%>" target="<%=target%>"><strong><%= tag_name%></strong><b class="icon-red-dot"></b></a>';
    }
    /*
    列表页tab标签模板
    */
    template.get_tab_pagetag_tmpl = function () {
        return '<a id="tag-<%= tag_id%>" tag_id="<%= tag_id%>" href="#<%= tag_id%>" class="<%=selected?"current":""%>" pageindex="<%= pageindex%>"><%= tag_name%></a>';
    }
    /*
    排行榜时间维度模板
    */
    template.get_tab_rank_tmpl = function () {
        return '<a tag_id="<%= tag_id%>" href="javascript:;" class="<%=selected?"current":""%>"><%= tag_name%></a>';
    }
    /*
    房间面板列表对象:常规
    */
    template.get_room_item_tmpl = function () {
        return '<span class="img">\
                <img src="<%= small_anchor_posing_url||roomLogoUrl||"http://ossweb-img.qq.com/images/mgc/css_img/common/mgc_auto.png?v=3_8_8_2016_15_4_final_3"%>" width="208" alt="<%=anchorName%>"></span>\
                <p class="show_name">\
                <% if(bSuperRoom){ %>\
                    <b class="s_label_0">演唱会</b>\
                <% }else if(star_anchor){ %>\
                    <b class="rc_star">星级</b>\
                <%}%>\
                <% if(status == 2){ %>\
                    <%= anchorName %>\
                <%}else{%>\
                    未开播\
                <%}%>\
                </p>\
                <p class="show_data"><span class="show_room">房间：<%= roomID %></span><span class="show_num"><%= playerCount %>人</span></p>\
                <a href="transfer.shtml?roomId=<%= roomID %>" onclick="mgc.tools.EAS([{\'e_c\': \'mgc.enterroom.1\',\'c_t\':4},{\'e_c\': \'mgc.enterroom\',\'c_t\':4}]);" class="allListA" target="_blank"><i></i></a>';
    }
    /*
    房间面板列表对象:大图
    */
    template.get_room_item_big_tmpl = function () {
        return '<span class="img">\
                <img src="<%= large_anchor_posing_url||roomLogoUrl||"http://ossweb-img.qq.com/images/mgc/css_img/common/mgc_auto.png?v=3_8_8_2016_15_4_final_3" %>" width="208" alt="<%= anchorName %>"></span>\
                <p class="rc_name">\
                <% if(bSuperRoom){ %>\
                    <b>演唱会</b>\
                <%}else if(star_anchor){%>\
                    <b class="rc_star">星级</b>\
                <%}%>\
                <a href="javascript:;">\
                <% if(status == 2){ %>\
                    <%=anchorName%>\
                <%}else{%>\
                    未开播\
                <%}%>\
                </a></p>\
                <p class="rc_data"><i class="rc_icon0"></i><span>房间：<%= roomID %></span><i class="rc_icon1"></i><span><%= playerCount %>人</span></p>\
                <a href="transfer.shtml?roomId=<%= roomID %>&source=5" onclick="mgc.tools.EAS([{\'e_c\': \'mgc.enterroom.1\',\'c_t\':4},{\'e_c\': \'mgc.enterroom\',\'c_t\':4}]);" class="r_pic_hover_A allListA" target="_blank"><i></i></a>';
    }
    /*
    房间面板列表对象:小图
    */
    template.get_room_item_small_tmpl = function () {
        return '<span class="img">\
                <img src="<%=small_anchor_posing_url||roomLogoUrl||"http://ossweb-img.qq.com/images/mgc/css_img/common/mgc_auto.png?v=3_8_8_2016_15_4_final_3"%>" width="208" alt="<%=anchorName%>"></span>\
                <p class="rc_name">\
                <% if(bSuperRoom){ %>\
                    <b>演唱会</b>\
                <%}else if(star_anchor){ %>\
                    <b class="rc_star">星级</b>\
                <% } %>\
                <% if(status == 2){ %>\
                    <%= anchorName %>\
                <% }else{ %>\
                    未开播\
                <%}%></p>\
                <p class="rc_data"><i class="rc_icon0"></i><span>房间：<%=roomID%></span><i class="rc_icon1"></i><span><%=playerCount%>人</span></p>\
                <a href="transfer.shtml?roomId=<%=roomID%>" onclick="mgc.tools.EAS([{\'e_c\': \'mgc.enterroom.1\',\'c_t\':4},{\'e_c\': \'mgc.enterroom\',\'c_t\':4}]);" class="anchor_links allListA" target="_blank"><i></i></a>';
    }
    /*
    广告banner图模板
    */
    template.get_banner_tmpl = function () {
        return '<a class="target-blank" href="<%= sAdUrl %>" onclick="mgc.tools.EAS([{\'e_c\': \'mgc.top.<%= sAdId %>\',\'c_t\':4}])"  target="_blank"><img src="<%= sImageUrl %>" alt="Json" error!!="" /></a>';
    }
    /*
    梦工厂快报
    */
    template.get_ad_tmpl = function () {
        return '<a class="s_advert target-blank" href="<%= sAdUrl %>" onclick="mgc.tools.EAS([{\'e_c\': \'mgc.quick.<%= iSeqId+1 %>\',\'c_t\':4}])" target="_blank"><img src="<%= sImageUrl %>" width="219" height="108" alt="<%= sDesc %>"></a>';
    }
    if (!window.mgc) {
        window.mgc = {};
    }
    mgc.templates = template;
    return template;
});