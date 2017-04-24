package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.VideoBoxItem;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.surprise_box.share.RewardBasicItem;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class CEventVideoTreasureBoxRewardNewRoleWeb extends INetMessage
	{
		public override function CLSID():int
		{
			return EEventIDVideoRoomExt.CLSID_CEventVideoTreasureBoxRewardNewRoleWeb;
		}

		public function CEventVideoTreasureBoxRewardNewRoleWeb()
		{
			registerField("box_id", "", Descriptor.Int32, 1);
			registerField("choose_idx", "", Descriptor.Int32, 2);
			registerField("res", "", Descriptor.Int32, 3);
			registerFieldForList("rewards", getQualifiedClassName(RewardBasicItem), Descriptor.Compound, 4);
			registerFieldForList("box_items", getQualifiedClassName(VideoBoxItem), Descriptor.Compound, 5);
			registerField("buff_percent", "", Descriptor.Int32, 6);
			registerField("m_is_reissue", "", Descriptor.TypeBoolean, 7);
			registerField("vip_level", "", Descriptor.Int32, 8);
			registerField("last_hit_player_name", "", Descriptor.TypeString, 9);//补刀王昵称
			registerField("last_hit_player_id", "", Descriptor.Int64, 10);
			registerField("last_hit_player_invisible", "", Descriptor.TypeBoolean, 11);
		}

		public var box_id:int;
		public var choose_idx:int;
		public var res:int; //VideoBoxErrorCode 0 成功  8;热度宝箱冷却状态（玩家进入视频房间不超过5分钟） 9;热度宝箱解除冷却状态（玩家进入视频房间超过5分钟）
		public var rewards:Array;
		public var box_items:Array;
		public var buff_percent:int;
		public var m_is_reissue:Boolean;
		public var vip_level:int; // qgame奖励补发 贵族时使用

		public var anchor_level:int = 0; //主播等级
		public var online:Boolean   = true; //true 主播在线
		public var last_hit_player_name:String;
		
		public var last_hit_player_id:Int64; //补刀王id
		public var last_hit_player_invisible:Boolean; //补刀王是否隐身
	}
}
