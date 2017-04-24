package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.ByteArray;

	public class GiftData
	{		
		public var giftItemID:int = 0;
		public var count:int = 0;
		public var popularityChange:int = 0;	// 增加的人气值，本次送礼总共增加量
		public var sender_channelid:int = 0;
		public var senderPlayerID:String = "";
		public var anchorID:String = "";
		public var senderName:String = "";
		public var anchorName:String = "";
		public var giftName:String = "";
		public var zoneName:String = "";	// 玩家所在的大区名字
		public var giftIcon:String = "";	// 礼物图标uir ID
		public var vip_level:int;		// 送礼玩家的贵族身份
		public var vipIcon:String = "";//// 送礼玩家的贵族身份图标
		public var guardIcon:String = "";//送礼玩家的守护身份图标
		public var ceremony:Boolean;//是否在盛典活动时送的 UI自己用 逻辑不用管
		public var occupyIndex:int;//霸屏礼物第几响的标记  UI自己用 逻辑不用管		
		public var male:Boolean = false;
		public var data:ByteArray = new ByteArray;		
		public var support_degree_add:int = 0;		
		public var invisible:Boolean = false;
		public var continuous_send_gift_times:int = 0;//连送次数
		public var anchor_exp:int;//本次送礼增加了多少主播经验值
		public var wealth_level:int;//财富等级
		/**
		 * 礼物来源。0-聊天发送；1-抽奖
		 */
		public var source:int;
		
		//VideoGiftSource
		public static const VGS_SEND:int       = 0;
		public static const VGS_LUCKY_DRAW:int = 1;
		
		
		public var m_level:int = 0;
		public var m_dice_val_1:int = 0;
		public var m_dice_val_2:int = 0;
		public var m_dice_val_3:int = 0;
	}
}