package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.surprise_box.share.RewardBasicItem;

	import flash.utils.getQualifiedClassName;

	public class CEventBatchVideoTreasureBoxRewardNewRoleWeb extends INetMessage
	{
		public override function CLSID():int
		{
			return EEventIDVideoRoomExt.CLSID_CEventBatchVideoTreasureBoxRewardNewRoleWeb;
		}

		public function CEventBatchVideoTreasureBoxRewardNewRoleWeb()
		{
			registerField("res", "", Descriptor.Int32, 1);
			registerFieldForList("rewards", getQualifiedClassName(RewardBasicItem), Descriptor.Compound, 2);
			registerField("buff_percent", "", Descriptor.Int32, 3);
			registerField("anchor_level", "", Descriptor.Int32, 4);
			registerField("m_is_reissue", "", Descriptor.TypeBoolean, 5);
			registerField("vip_level", "", Descriptor.Int32, 6);
			registerFieldForList("last_hit_player_names", "", Descriptor.TypeString, 7);//补刀王昵称
			registerFieldForList("last_hit_player_ids","",Descriptor.Int64,8);//补刀王id数组，和奖励数组索引对应
			registerFieldForList("last_hit_player_invisibles","",Descriptor.TypeBoolean,9);//补刀王是否隐身数组，和奖励数组索引对应
		}

		public var res:int;
		public var rewards:Array;
		public var buff_percent:int;
		public var anchor_level:int;
		public var m_is_reissue:Boolean;
		public var vip_level:int; // qgame奖励补发 贵族时使用
		public var last_hit_player_names:Array;
		public var last_hit_player_ids:Array;
		public var last_hit_player_invisibles:Array;
	}
}
