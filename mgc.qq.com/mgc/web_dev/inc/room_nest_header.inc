<?xml version="1.0" encoding="utf-8"?>
<div class="header" id="header">
  <div class="h-logo">
    <a href="index.shtml"></a>
  </div>
  <div class="h-middle">
    <div class="h-player" id="loginbar">
      <div id="logined" style="display: none;">
        <a class="h_user_pic logined" href="javascript:;">
          <img class="login-qq-face" id="login_qq_face" src="http://q1.qlogo.cn/g?b=qq&k=20tsLBhL5mwhvUYhI58icYQ&s=100&t=0"/>
          <!--玩家信息-->
          <div class="logined_con logined-con-playerinfo" id="logined-con-playerinfo_box" >
            <div class="logined_status" id="logined_status" style="display:none">
              <i></i>
              <strong id="icon1" class="icon1">隐身</strong>
              <ul id="userStatus">
                <li id="icon0" class="icon0">在线</li>
              </ul>
            </div>
            <div id="logined-con-playerinfo">
              
            </div>
          </div>
        </a>
        <!--<div class="h-open-vip">
          <a class="icon-open-vip" href="javascript:mgc.tools.EAS([{'e_c': 'mgc.buyvip.1','c_t':4},{'e_c': 'mgc.buyvip','c_t':4}]);">贵族</a>
        </div>-->
      </div>
      <div id="unlogin" class="unlogin" style="display:none;">
        <a class="s_login" id="login-bar-btn" href="javascript:;">QQ登录</a>
        <a class="s_register" href="http://zc.qq.com/" target="_blank">注册</a>
      </div>
      <!--玩家关注的主播信息-->
      <div class="logined_con logined-con-follow" id="logined-con-follow">
        <div class="logined_list">
          <ul id="followedContainer">
          </ul>
          <p class="logined_tips">当前没有关注的主播哦。快快扩充你的关注列表吧！</p>
        </div>
      </div>
    </div>
    <ul class="h-nav clearfix" id="h-nav">
      <li>
        <a class="nav2 " href="ranklist.shtml">
          <strong>排行榜</strong>
        </a>
      </li>
      <li>
        <a class="nav3 " href="http://mgc.qq.com/cp/a20151231music/index.htm" target="_blank">
          <strong>活动</strong>
        </a>
      </li>
    </ul>
    <div id="flashContent"></div>
    <div class="reminder" id="reminder">
      <span class="close"></span>
      <div class="reminder_tips">
        <p>
          少年，<strong>点击这里</strong>
        </p>
        <p>
          完成任务，<strong>
            福利<i class="gift"></i>
          </strong>拿到手软！
        </p>
      </div>
    </div>
  </div>
  <div class="h-footer"></div>
</div>
<div class="mhb_tips_login" style="top: 27px; left: 236px; z-index: 929004; display: none;">
  梦幻币<br/>通过签到、任务、等级成长等方式获得，可用来购买梦幻币礼物及贵族身份。
</div>
<div class="xd_tips_login" style="top: 51px; left: 203px; z-index: 929004; display: none;">
  炫豆<br/>通过充值获得，可用来购买付费礼物、贵族身份等，消费炫豆还能够增加财富值哦！
</div>
<script id="logined-con-playerinfo-tmpl" type="text/x-jquery-tmpl">
  <div class="caifu_tips_login" style="top: 51px; left: 203px; z-index: 929004; display: none;">
    财富值:${video_wealth}
  </div>
  <div class="logined_name clearfix">
    <strong id="i_player_name">${nick}</strong>
  </div>
  <div class="logined_info" id="i_card_info">
    <ul>
      <li>等级：LV${video_level}</li>
      <li class="r">
        梦幻币：<span>${video_dream_money}</span><i class="icon_mhb" style="background:url('http://ossweb-img.qq.com/images/mgc/css_img/common/cash_classify/dream_money.png?v=3_8_8_2016_15_4_final_3') no-repeat"></i>
      </li>
      <li>
        财富：<strong class="icon_caifu">
          LV${wealth_level}{{if wealth_level>0}}<i class="wealth_level_${wealth_level}" style="background:url('http://ossweb-img.qq.com/images/mgc/css_img/common/wealth_level/${wealth_level}.png?v=3_8_8_2016_15_4_final_3') no-repeat"></i>{{/if}}
        </strong>
      </li>
      <li class="r">
        炫豆：<span class="mar1">${video_money_balance}</span><i class="icon_xd" style="background:url('http://ossweb-img.qq.com/images/mgc/css_img/common/cash_classify/money_balance.png?v=3_8_8_2016_15_4_final_3') no-repeat"></i>
      </li>
      <li class="l">
        <span class="vip">
          贵族：<i class="icon_honor icon_honor${vip_level}" {{if vip_level == 0}} style="display:none;" {{else}} style="background:url('http://ossweb-img.qq.com/images/mgc/css_img/common/nobility/${vip_level}.png?v=3_8_8_2016_15_4_final_3') no-repeat; display:inline-block;"{{/if}}></i> ${vipLevelname}
        </span>
        <span class="anchor-name">
          {{if vip_level>0}}
          {{if vip_anchor_name!=""}}
          （<span>${vip_anchor_name}</span>）
          {{/if}}
          {{/if}}
        </span>
      </li>
      <li class="l">
        大区：<span class="mar2">${mgc.tools.myZoneName(zone_name)}</span>
      </li>
    </ul>
  </div>
  <div class="logined_btn">
    <a class="r recharge-btn" href="http://pay.qq.com/ipay/index.shtml?c=qxwwqp" onclick="mgc.tools.EAS([{'e_c': 'mgc.charge','c_t':4}])" target="_blank">充值</a>
  </div>
  <div class="logined_entrance clearfix">
    <a class="l" id="mgc_personal" href="personal.shtml" target="_blank">个人中心</a>
    <a class="r" href="javascript:;">我的粉丝团</a>
  </div>
  <div class="logined_entrance clearfix" style="{{if is_show_week_star_url==false}}display:none;{{/if}}">
    <a class="star_week_url" id="mgc_personal" href="${player_url}" target="_blank"><i></i>周星赛详情</a>
  </div>
  <a class="loginout" href="javascript:;">退出登录</a>
</script>
<script id="followedTmpl" type="text/x-jquery-tmpl">
  <li onmouseover="$(this).find('span').addClass('hover')" onmouseout="$(this).find('span').removeClass('hover')">
    {{if m_status == 2}}
    <a class="logined_head" onclick="mgc.tools.EAS([{'e_c': 'mgc.enterroom.3','c_t':4},{'e_c': 'mgc.enterroom','c_t':4}])" href="transfer.shtml?roomId=${m_videoroom_id}&source=7&module_type=0&page_capacity=30&room_list_pos=0" target="_blank">
      {{else}}
      <a class="logined_head" href="javascript:;">
        {{/if}}
        <img src="${m_photo_url}" width="32" height="32">
          <span></span>
          <i class="icon_lv icon_lv${guard_level}" style="background:url('http://ossweb-img.qq.com/images/mgc/css_img/common/guard/${guard_level}.png?v=3_8_8_2016_15_4_final_3') no-repeat; "></i>
      </a><!--class="icon_lv icon_lv1" icon_lv1初级守护icon_lv2中级守护icon_lv3高级守护icon_lv4天使守护icon_lv5灵魂守护icon_lv6至尊守护-->
      <strong>${m_anchor_nick}</strong>
      {{if m_status == 2}}<a class="logined_zb" onclick="mgc.tools.EAS([{'e_c': 'mgc.enterroom.3','c_t':4},{'e_c': 'mgc.enterroom','c_t':4}])" href="transfer.shtml?roomId=${m_videoroom_id}&source=7&module_type=0&page_capacity=30&room_list_pos=0" target="_blank">正在直播</a>{{else}}<a class="logined_lx" href="javascript:;">离线</a>{{/if}}
    </li>
</script>