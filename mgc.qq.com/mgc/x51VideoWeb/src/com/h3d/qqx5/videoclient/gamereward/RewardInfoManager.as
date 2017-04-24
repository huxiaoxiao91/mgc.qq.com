package com.h3d.qqx5.videoclient.gamereward
{
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.videoclient.data.ERewardType;
	import com.h3d.qqx5.videoclient.data.RewardForUI;
	import com.h3d.qqx5.videoclient.data.SignRewardForUI;
	
	import flash.utils.Dictionary;
	
	public class RewardInfoManager
	{
		public var dreamid1:int = 30;//荧光棒
		public var dreamid2:int = 31;//鼓掌
		public var dreamid3:int = 32;//v587
		
		public var dreamid4:int = 200;//贝壳
		public var dreamid5:int = 201;//音符
		public var dreamid6:int = 202;//棒棒糖
		
		public var vipid1:int=1;//：贵族 ：近卫贵族身份 
		public var vipid2:int=2;//：贵族 ：骑士贵族身份 
		public var vipid3:int=3;//：贵族 ：将军贵族身份 
		public var vipid4:int=4;//：贵族 ：亲王贵族身份 
		public var vipid5:int=5;//：贵族 ：皇帝贵族身份 
		
		private var ItemImgPath:String = "/items/item_";//页面奖励图标存放的相对路径
		private var m_rewardinfo:Dictionary = new Dictionary;// key是 type&id  value是RewardForUI  
		private var m_signreward:Dictionary = new Dictionary;// key是 type&level  value是RewardForUI  
		public function RewardInfoManager()
		{
			InitReward( );
		}

		//转换通用奖励信息
		public function RewardToRewardForUI(type:int, id:int, cnt:int):RewardForUI
		{
			//皮肤专属礼物类型为7
			if(id == 200 || id ==201 || id == 202)
			{
				type = 7;
			}
			
			var str:String         = type + "&" + id;
			var reward:RewardForUI = new RewardForUI;
			reward.type = type;
			reward.id = id;
			if (type == 0 && id == 0)
			{
				return reward;
			}
			
			if (m_rewardinfo[str] == null)
			{
				Globals.s_logger.error("RewardToRewardForUI error type: " + type + ",giftid:" + id);
				return reward;
			}
			reward.name = m_rewardinfo[str].name;
			reward.url = m_rewardinfo[str].url;
			reward.tips = m_rewardinfo[str].tips;
//			reward.count_desc = cnt.toString();
			if (type == ERewardType.R_VIP)
			{
				reward.count_desc = cnt.toString() + "天";
			}
			else
			{
				reward.count_desc = cnt.toString();
			}
			return reward;
		}
		//转换签到奖励信息
		public function RewardToSignRewardForUI( type:int ,id:int, cnt:int,level:int,multiply:int):SignRewardForUI
		{
			var reward:SignRewardForUI = new SignRewardForUI; 
			if( type ==0 && id == 0 )
				return reward;
			var str:String =  type+ "&" + id;
			if (m_rewardinfo[str] != null) {
				reward.name = m_rewardinfo[str].name;
				reward.url = m_rewardinfo[str].url;
				reward.tips = m_rewardinfo[str].tips;
			} else {
				reward.url = "error:" + str;
			}
			if(type == ERewardType.R_VIP)
				reward.count_desc = cnt.toString()+"天";
			else
				reward.count_desc = cnt.toString();

			reward.level = level;
			reward.multiply = multiply;
			
			return reward;
		}
		
		
		//游戏奖励 转换成 通用奖励信息
		public function GameRewardToSignRewardForUI( souinfo:GameRewardInfoForUI ):SignRewardForUI
		{			
			var reward:SignRewardForUI = new SignRewardForUI; 
			reward.count_desc = souinfo.count_desc;
			reward.name = souinfo.name;
			reward.tips = souinfo.tips;
			reward.url = souinfo.url;
			reward.channel = souinfo.channel;
			return reward;
		}
		
		//游戏奖励 转换成 通用奖励信息
		public function GameRewardToRewardForUI( souinfo:GameRewardInfoForUI):RewardForUI
		{			
			var reward:RewardForUI = new RewardForUI; 
			reward.count_desc = souinfo.count_desc;
			reward.name = souinfo.name;
			reward.tips = souinfo.tips;
			reward.url = souinfo.url;
			reward.channel = souinfo.channel;
			reward.rare = souinfo.rare;
//			reward.star_gift = false;
			return reward;
		}
		
		public function InitReward( ):void
		{
			var reward:RewardForUI = new RewardForUI; 
			reward.name = "经验";
			reward.url = ItemImgPath + "video_exp.png";
			reward.tips = "";
			var str:String = ERewardType.R_VideoExp +"&" +"0";
			m_rewardinfo[str] = reward;
			
			var reward1:RewardForUI = new RewardForUI; 
			reward1.name = "梦幻币";
			reward1.url = ItemImgPath + "video_money.png";
			reward1.tips = "通过签到、任务、等级成长等方式获得，可用来购买梦幻币礼物及贵族身份";
			var str1:String = ERewardType.R_VideoMoney +"&" +"0";
			m_rewardinfo[str1] = reward1;
			
			var reward2:RewardForUI = new RewardForUI; 
			reward2.name = "荧光棒";
			reward2.url = ItemImgPath + dreamid1 +".png";
			reward2.tips = "挥动手中的荧光棒，送给主播增加5点人气";
			var str2:String = ERewardType.R_DreamGift +"&" + dreamid1;
			m_rewardinfo[str2] = reward2;
			
			var reward3:RewardForUI = new RewardForUI; 
			reward3.name = "鼓掌";
			reward3.url = ItemImgPath + dreamid2 +".png";
			reward3.tips = "把你的掌声，送给主播增加10点人气";
			var str3:String = ERewardType.R_DreamGift +"&" + dreamid2;
			m_rewardinfo[str3] = reward3;
			
			var reward4:RewardForUI = new RewardForUI; 
			reward4.name = "v587";
			reward4.url = ItemImgPath + dreamid3 +".png";
			reward4.tips = "威武霸气，千秋万载，一统江湖，送给主播增加20点人气";
			var str4:String = ERewardType.R_DreamGift +"&" + dreamid3;
			m_rewardinfo[str4] = reward4;
			
			var reward4_1:RewardForUI = new RewardForUI; 
			reward4_1.name = "近卫贵族身份";
			reward4_1.url = ItemImgPath + "noble_" + vipid1 + ".png";
			reward4_1.tips = "";
			var str4_1:String = ERewardType.R_VIP +"&" +vipid1;
			m_rewardinfo[str4_1] = reward4_1;
			
			var reward5:RewardForUI = new RewardForUI; 
			reward5.name = "骑士贵族身份";
			reward5.url = ItemImgPath + "noble_" + vipid2 + ".png";
			reward5.tips = "";
			var str5:String = ERewardType.R_VIP +"&" +vipid2;
			m_rewardinfo[str5] = reward5;
			
			var reward6:RewardForUI = new RewardForUI; 
			reward6.name = "将军贵族身份";
			reward6.url = ItemImgPath + "noble_" + vipid3 + ".png";
			reward6.tips = "";
			var str6:String = ERewardType.R_VIP +"&" +vipid3;
			m_rewardinfo[str6] = reward6;
			
			var reward7:RewardForUI = new RewardForUI; 
			reward7.name = "亲王贵族身份";
			reward7.url = ItemImgPath + "noble_" + vipid4 + ".png";
			reward7.tips = "";
			var str7:String = ERewardType.R_VIP +"&" +vipid4;
			m_rewardinfo[str7] = reward7;
			
			var reward8:RewardForUI = new RewardForUI; 
			reward8.name = "皇帝贵族身份";
			reward8.url = ItemImgPath + "noble_" + vipid5 + ".png";
			reward8.tips = "";
			var str8:String = ERewardType.R_VIP +"&" +vipid5;
			m_rewardinfo[str8] = reward8;
			
			var reward9:RewardForUI = new RewardForUI; 
			reward9.name = "飞屏";
			reward9.url = ItemImgPath + "fly_1.png";
			reward9.tips = "当天使用有效的飞屏喇叭";//"领取当天使用有效的飞屏喇叭";
			var str9:String = ERewardType.R_Whiste +"&" +"0";
			m_rewardinfo[str9] = reward9;
			
			
			var reward10:RewardForUI = new RewardForUI; 
			reward10.name = "贝壳";
			reward10.url = ItemImgPath + dreamid4 +".png";
			reward10.tips = "【欢乐海洋主题专属】在海底主题皮肤下送出魅力值+6，其他主题下送出魅力值+3。";//"领取当天使用有效的飞屏喇叭";
			var str10:String = ERewardType.R_Skin +"&" + dreamid4;
			m_rewardinfo[str10] = reward10;
			
			var reward11:RewardForUI = new RewardForUI; 
			reward11.name = "音符";
			reward11.url = ItemImgPath + dreamid5 +".png";
			reward11.tips = "【星光舞台主题专属】在迷情舞台主题皮肤下送出魅力值+6，其他主题下送出魅力值+3。";//"领取当天使用有效的飞屏喇叭";
			var str11:String = ERewardType.R_Skin +"&" + dreamid5;
			m_rewardinfo[str11] = reward11;
			
			var reward12:RewardForUI = new RewardForUI; 
			reward12.name = "棒棒糖";
			reward12.url = ItemImgPath + dreamid6 +".png";
			reward12.tips = "【梦幻游乐场主题专属】在游乐园主题皮肤下送出魅力值+6，其他主题下送出魅力值+3。";//"领取当天使用有效的飞屏喇叭";
			var str12:String = ERewardType.R_Skin +"&" + dreamid6;
			m_rewardinfo[str12] = reward12;
			
			var rewardzhu:RewardForUI = new RewardForUI; 
			rewardzhu.name = "主播经验";
			rewardzhu.url = ItemImgPath + "300.png";
			rewardzhu.tips = "当前麦上主播经验值";
			var strzhu:String = ERewardType.R_ANCHOR_EXP +"&" +"300";
			m_rewardinfo[strzhu] = rewardzhu;
			
			var reward13:RewardForUI = new RewardForUI; 
			reward13.name = "弹幕";
			reward13.url = ItemImgPath + "danmu.png";
			reward13.tips = "仅能在炫舞梦工厂app中使用";//"领取当天使用有效的飞屏喇叭";
			var str13:String = "8" +"&" + "0";
			m_rewardinfo[str13] = reward13;
		}
		
		public function getCCY(type:int):String {
			if (type == ERewardType.R_DreamGift) {
				return "梦幻币";
			} else {
				return "炫豆";
			}
		}
	}
}