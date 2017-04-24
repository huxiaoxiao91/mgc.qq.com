package com.h3d.qqx5.modules.dream_box.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventBroadcastAllRoomRocketGift extends INetMessage
	{
		public override function CLSID() : int
		{
			return DreamBoxEventID.CLSID_CEventBroadcastAllRoomRocketGift;
		}
		public function CEventBroadcastAllRoomRocketGift()
		{
			registerField("wealth_level", "", Descriptor.Int32, 1);
			registerField("guard_level", "", Descriptor.Int32, 2);
			registerField("vip_level", "", Descriptor.Int32, 3);
			registerField("player_name", "", Descriptor.TypeString, 4);
			registerField("player_zone", "", Descriptor.TypeString, 5);
			registerField("anchor_name", "", Descriptor.TypeString, 6);
			registerField("rocket_cnt", "", Descriptor.Int32, 7);
			registerField("room_id", "", Descriptor.Int32, 8);
			registerField("is_nest", "", Descriptor.TypeBoolean, 9);
			registerField("player_id","",Descriptor.Int64,10);//补刀王id
			registerField("invisible","",Descriptor.TypeBoolean,11);//是否隐身
		}
		public var wealth_level : int;
		public var guard_level : int;
		public var vip_level : int;
		public var player_name : String = "";
		public var player_zone : String = "";
		public var anchor_name : String = "";
		public var rocket_cnt : int;
		public var room_id : int;
		public var is_nest : Boolean;
		public var player_id: Int64;
		public var invisible : Boolean;
	}
}
