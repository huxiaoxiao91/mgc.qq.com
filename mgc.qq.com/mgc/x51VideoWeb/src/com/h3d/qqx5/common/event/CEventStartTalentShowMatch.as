package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventStartTalentShowMatch extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventStartTalentShowMatch;
		}
		
		public function CEventStartTalentShowMatch()
		{
			registerField("op_player", "", Descriptor.Int64, 1);
			registerField("start_res", "", Descriptor.Int32, 2);
		}
		
		public var op_player : Int64;
		public var start_res : int;
	}
}
