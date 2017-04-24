<link href="../css/indexGuide.css?v=3_8_8_2016_15_4_final_3" rel="stylesheet" />
<!--首页引导-UI-->
<div id="pop_guide" class="pop_index pop_guide">
  <a id="guideBtn_room_a" href="javascript:;" class="pop_close">关闭</a>
  <div class="bg">
    <div id="signContainer" class="clearfix signContainer">
      <div class="guideBtn">
        <div class="center">
          <a id="guideBtn_room" href=''>马上进入</a>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- -template-->
<script type="text/x-jquery-tmpl" id="signTmpl">

</script>
<script type="text/x-jquery-tmpl" id="sign_rewards_list_tmpl">

</script>
<script type="text/x-jquery-tmpl" id="sign_opt_rewards_tmpl">

</script>
<script type="text/x-jquery-tmpl" id="sign_opt_rewards_li_tmpl">

</script>
<!--奖励结果-->
<div id="signRewardsContainer" class="pop">
</div>
<!-- 奖励结果数据START-->
<script id="signRewardsTmpl" type="text/x-jquery-tmpl">
  <a href="javascript:;" class="pop_close">关闭</a>
  <p class="pop_title">${title}</p>
  <div class="pop_sign_prize">
    <p class="txt">
      ${showTips}<span>${showTips_game}</span>
    </p>
    <div class="list_signprize">
      <div class="susw_tips"></div>
      <div class="sign_list">
        <ul class="clearfix">
          {{tmpl(rws) "#signRewardsImageTmpl"}}
        </ul>
      </div>
    </div>
    <!-- //list -->
  </div>
  <div class="pop_btn_box clearfix">
    <a class="btn_open" href="javascript:;">确定</a>
  </div>
</script>
<!-- 奖励礼物结果数据START-->
<script id="signRewardsImageTmpl" type="text/x-jquery-tmpl">
  <li>
    <span onmouseover='MGC.suswTips2(event,1,"${name}","${tips}");' onmouseout="MGC.suswTips2(event,0);" style="background:url(${url}) no-repeat 0 0 #eadef9;" width="90" height="90" alt="" />
    </span>
    <p>${count_desc}</p>
  </li>
</script>

<!-- template-goodFriendPay -->
<div id="goodFriendPay" class="pop pop_goodFriendPay">
  <a id="closeBtn2" class="pop_close">关闭</a>
  <p class="pop_title">获得赠送礼物</p>

  <ul id="goodFriendPayContainer"></ul>

  <div class="pop_btn_box clearfix">
    <a id="confirmBtn2" class="btn_open" href="javascript:;">确定</a>
  </div>
</div>



<script id="goodFriendPayTmpl" type="text/x-jquery-tmpl">

  <div class="pop_tip_">恭喜您，收到来自好友（${qq}）【${nick}】的礼物</div>
  <div class="pop_tip_txt">
    <li class="title">物品：</li>
    <li class="gift">
      <div class="susw_tips"></div>
      <img onmouseover='window.mgc_tips.suswTips2(event,1,"炫豆","通过充值获得，可用来购买付费礼物、贵族身份等，消费炫豆还能够增加财富值哦！");' onmouseout="window.mgc_tips.suswTips2(event,0);" src="http://ossweb-img.qq.com/images/mgc/css_img/items/item_money.png?v=3_8_8_2016_15_4_final_3" width="68" height="68" alt="" />      
      <p>${amount}</p>
    </li>
  </div>


</script>


