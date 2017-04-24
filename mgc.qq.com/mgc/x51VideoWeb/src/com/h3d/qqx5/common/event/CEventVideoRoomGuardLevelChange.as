package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventVideoRoomGuardLevelChange extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomGuardLevelChange;
		}
		
		public function CEventVideoRoomGuardLevelChange()
		{
			registerField("anchor_name", "", Descriptor.TypeString, 1);
			registerField("player_name", "", Descriptor.TypeString, 2);
			registerField("player_zone", "", Descriptor.TypeString, 3);
			registerField("new_guard_level", "", Descriptor.Int32, 4);
			registerField("player_id", "", Descriptor.Int64, 5);
			registerField("condition_type", "", Descriptor.Int32, 6);
			registerField("old_guard_level", "", Descriptor.Int32, 7);
			registerField("vip_level", "", Descriptor.Int32, 8);
		}
		
		public var anchor_name : String;
		public var player_name : String;
		public var player_zone : String;
		public var new_guard_level : int;
		public var player_id : Int64;
		public var condition_type : int;
		public var old_guard_level:int = 0;
		public var vip_level:int = 0;
	}
}
