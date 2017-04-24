package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventAssignTalentJudge extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventAssignTalentJudge;
		}
		
		public function CEventAssignTalentJudge()
		{
			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("player_name", "", Descriptor.TypeString, 2);
			registerField("zone_name", "", Descriptor.TypeString, 3);
			registerField("judge_type", "", Descriptor.Int32, 4);
			registerField("anchor_id", "", Descriptor.Int64, 5);
		}
		
		public var room_id : int;
		public var player_name : String;
		public var zone_name : String;
		public var judge_type : int;
		public var anchor_id : Int64;
	}
}
