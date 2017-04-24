<div id="seattemp">
	<div class="seattop">
		<span class="seatname">守护宝座</span>
		<a class="seattipbtn"></a>
		<a class="seatintrobtn" href="http://x5.qq.com/act/a20140306mar/page04.htm#1" target="_blank"></a>
	</div>
	<div class="seatlist">
		<ul></ul>
	</div>
</div>
<div id="seatListTip1" style="display: none;">
		超凡守护和天尊守护并且日财富值达到5000的玩家才能落座,当座位为空时可以花费炫豆抢座
</div>
<div id="seatListTip2" style="display: none;"></div>
<div id="viptemp">
	<h2>嘉宾席</h2>
	<div class="sv_list">
		<ul class="clearfix" id="vipContainer"></ul>
	</div>
</div>
<div class="sus_tips_LvList"></div>
<div id="ranktemp">
	<div id="sr_tab" class="sr_tab">
		<ul class="clearfix">
			<li class="pop_tips" style="position: static;">
				<a href="javascript:;" id="cjfs_li" onclick="MGC.tabCut('sr_tab','sr_con',0);" class="current">超级粉丝</a><i class="sr_r_tips">超级粉丝榜：显示7天内主播亲密度</i>
			</li>
			<li class="pop_tips" style="position: static;">
				<a href="javascript:;" id="sh_li" onclick="MGC.tabCut('sr_tab','sr_con',1);">守护</a><i class="sr_l_tips">守护榜：
				<br />
				显示主播所有的天使及以上级别的守护的前10名，以及总亲密度</i>
			</li>
		</ul>
	</div>
	<div id="sr_con" class="sr_con s_con_card">
		<!--超级粉丝-->
		<div class="sus_tips_list2"></div>
		<div class="sus_tips_short"></div>
		<ul style="display: block" id="fansContainer"></ul>
		<!--守护-->
		<ul id="guardContainer"></ul>
	</div>
</div>

<!--守护宝座列表模版-->
<script id="seatTmpl" type="text/x-jquery-tmpl">
	<li data-seatid="${m_seat_id}">
	<img src="${m_pic_url}">
	<i class="{{if canseat}}canseat{{/if}}"></i>
	{{if m_take_cost < 0}}
	<span>${m_nick}</span>
	{{/if}}
	<a style="{{if m_player_id == '0'}}cursor: auto; {{/if}}" class="userbtn" data-picurl="${m_pic_url}" data-playerid="${m_player_id}" data-seatid="${m_seat_id}" data-cost="${m_take_cost}" data-name="${m_nick}" data-zone="${m_zone}" data-sex="${m_gender}" data-inroom="${m_in_room}" data-viplevel="${m_vip_level}" data-guardlevel="${m_guard_level}"></a>
	{{if canseat}}
	<a class="seatbtn" data-playerid="${m_player_id}" data-seatid="${m_seat_id}" data-cost="${m_take_cost}"></a>
	{{/if}}
	</li>
</script>

<!--守护宝座用户TIP模版-->
<script id="seatUserTipTmpl" type="text/x-jquery-tmpl">
	<ul>
	{{if m_player_id != "0"}}
	<li><span>
	{{if m_take_cost > 0}}名字{{else}}${guardName}{{/if}}：${m_nick}
	</span></li>
	<li><span>身份：</span>
	{{if m_guard_level == 0 && m_vip_level == 0}}无{{/if}}
	{{if m_guard_level != 0}}<i class="icon_lv icon_lv${m_guard_level}"></i>{{/if}}
	{{if m_vip_level != 0}}<i class="icon_honor icon_honor_${m_vip_level}" {{if m_vip_level == 0}} style="display:none;" {{else}} style="background:url('http://ossweb-img.qq.com/images/mgc/css_img/common/nobility/${m_vip_level}.png?v=3_8_8_2016_15_4_final_3') no-repeat; display:inline-block;"{{/if}}></i>{{/if}}
	</li>
	<li><span>等级：${m_level}</span></li>
	<li><span>财富等级：${m_wealth_level}</span></li>
	{{if m_take_cost <= 0}}
	<li><span>日亲密度：${m_affinity}</span></li>
	<li><span>日财富值：${m_wealth}</span></li>
	{{/if}}
	{{/if}}
	{{if m_take_cost > 0}}
	<li><span class="cost">${m_take_cost}炫豆抢宝座</span></li>
	{{/if}}
	</ul>
</script>

<!-- 贵宾席START-->
<script id="vipTmpl" type="text/x-jquery-tmpl">
	<li class="${liClass}">
	<img src="${portraitUrl||'http://ossweb-img.qq.com/images/mgc/css_img/headicon/default_head_null.png?v=3_8_8_2016_15_4_final_3'}" width="56" height="56" alt="">
	<p zonename="${zoneName}" name="${playerName||'占位'}" class="${vipP} vipPopClass" style="${vipIclass}; margin: -5px 0 0 0">${playerName||'占位'}</p>
	<i class="${vipI} vipPopClass" zonename="${zoneName}" name="${playerName||'占位'}" style="${vipIclass}" mgc_vip_info="${video_level}|@abc${wealth_level}|@abc${wealth}|@abc${vipName}|@abc${num}|@abc${nickColor}|@abc${zoneName}"></i>
	<!--div>
	<p>名字：<strong style="color: ${nickColor}">${playerName}</strong></p>
	<p>等级：LV${video_level}</p>
	<p>来源：${zoneName}</p>
	<p>财富值：${wealth}</p>
	<p>贵族身份：${vipName}</p>
	</div-->
	</li>
</script>
<!-- 贵宾席END-->

<!-- 超级粉丝START-->
<script id="fansTmpl" type="text/x-jquery-tmpl">
	<li class="li_sz_room" playerid="${playerID}" name="${playerName}" area="${zoneName}">
	<b class="${liClass}">${liNum}</b>
	<div class="sc_zone_info">
	<p class="sz_room"><span style="color: ${nickColor}">${playerName} [${zoneName}]</span></p>
	<p class="sz_fans">${affinity}</p>
	<p class="sz_icon">
	<i class="${guardlevelClass}" onmouseover="MGC.susStateTips2(event,1,'${guard_levelShow}');" onmouseout="MGC.susStateTips2(event,0);"></i>
	<i class="${viplevelClass}" onmouseover="MGC.susStateTipsShort(event,1,'${vipName}');" onmouseout="MGC.susStateTipsShort(event,0);"></i>
	</p>
	</div>
	</li>
</script>
<!-- 超级粉丝END-->

<!-- 守护START-->
<script id="guardTmpl" type="text/x-jquery-tmpl">
	<li class="li_sz_room" playerid="${playerID}" name="${playerName}" area="${zoneName}">
	<b class="${liClass}">${liNum}</b>
	<div class="sc_zone_info">
	<p class="sz_room"><span style="color: ${nickColor}">${playerName} [${zoneName}]</span></p>
	<p class="sz_fans">${total_affinity}</p>
	<p class="sz_icon"><i class="${guardlevelClass}" onmouseover="MGC.susStateTips2(event,1,'${guard_levelShow}');" onmouseout="MGC.susStateTips2(event,0);"></i><i class="${viplevelClass}" onmouseover="MGC.susStateTipsShort(event,1,'${vipName}');" onmouseout="MGC.susStateTipsShort(event,0);"></i></p>
	</div>
	</li>
</script>
<!-- 守护END-->