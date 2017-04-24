package com.h3d.qqx5.common.event
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	
	public class CEventVideoTreasureBoxRewardNewRole extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventVideoTreasureBoxRewardNewRole;
		}
		public function CEventVideoTreasureBoxRewardNewRole()
		{
			registerField("box_id", "", Descriptor.Int32, 1);
			registerField("reward_type", "", Descriptor.Int32, 2)
			registerField("reward_id", "", Descriptor.Int32, 3);
			registerField("reward_cnt", "", Descriptor.Int32, 4);
			
			registerField("buff_percent", "", Descriptor.Int32, 5);
			registerField("state", "", Descriptor.Int32, 6)
			registerField("reward_channel", "", Descriptor.Int32, 7);
			registerField("last_hit_player_name", "", Descriptor.TypeString, 8);
			registerField("last_hit_player_id", "", Descriptor.Int64, 9);
			registerField("last_hit_player_invisible", "", Descriptor.TypeBoolean, 10)
		}
		public var box_id:int;
		public var reward_type:int;
		public var reward_id:int;
		public var reward_cnt:int;
		
		public var buff_percent:int;
		public var state:int;
		public var reward_channel:int;
		public var last_hit_player_name:String;
		public var last_hit_player_id:int;
		public var last_hit_player_invisible:Boolean;
	}
}
