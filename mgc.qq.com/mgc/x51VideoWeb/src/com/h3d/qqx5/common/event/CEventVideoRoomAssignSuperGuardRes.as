package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomAssignSuperGuardRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomAssignSuperGuardRes;
		}
		
		public function CEventVideoRoomAssignSuperGuardRes()
		{
			registerField("op_player_id", "", Descriptor.Int64, 1);
			registerField("target_zoneName", "", Descriptor.TypeString, 2);
			registerField("target_nickName", "", Descriptor.TypeString, 3);
			registerField("result", "", Descriptor.Int32, 4);
		}
		
		public var op_player_id : Int64 = new Int64;
		public var target_zoneName : String = "";
		public var target_nickName : String =  "" ;
		public var result : int;
	}
}
