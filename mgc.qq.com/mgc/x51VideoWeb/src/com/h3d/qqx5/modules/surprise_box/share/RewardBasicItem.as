package com.h3d.qqx5.modules.surprise_box.share
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	public class RewardBasicItem extends ProtoBufSerializable
	{
		public function RewardBasicItem()
		{
			registerField("type", "", Descriptor.Int32, 1);
			registerField("flags", "", Descriptor.Int32, 2);
			registerField("para1", "", Descriptor.Int32, 3);
			registerField("para2", "", Descriptor.Int32, 4);
			registerField("para3", "", Descriptor.Int32, 5);
			registerField("broadcast", "", Descriptor.TypeBoolean, 6);
			registerField("board", "", Descriptor.TypeBoolean, 7);
			registerField("display_name", "", Descriptor.TypeString, 8);//在广播和公告中显示的物品名称
			registerField("item_channel", "", Descriptor.Int32, 9);//源 游戏礼物：VCT_X5 = 0; 视频礼物:VCT_VIDEO = 2
			registerField("send_anchor", "", Descriptor.Int32, 10);//是否发送热度宝箱奖励给主播端，1 发送，0不发送
			registerField("para4", "", Descriptor.Int32, 11);//密令奖励的数量,在幸运转盘中使用此作为稀有礼物标志
//			registerField("rare", "", Descriptor.TypeBoolean, 12);//是否稀有
//			registerField("star_gift", "", Descriptor.TypeBoolean, 13);//是否周星
		}
		
		public var type:int;//奖励类型：经验、G币、物品……
		public var flags:int;//扩展标志位 @see _REWARD_ITEM_FLAGS
		public var para1:int;//LotType_Item/LotType_Card：男性物品ID
		public var para2:int;//LotType_Item/LotType_Card：女性物品ID
		public var para3:int;//数量有效期
		public var broadcast:Boolean;//是否广播
		public var board:Boolean;//是否公告
		public var display_name:String ="";//在广播和公告中显示的物品名称
		public var item_channel:int ;//奖励来源
		public var send_anchor:int ;
		public var para4:int ;
//		public var rare:Boolean;
//		public var star_gift:Boolean;
	}
}
