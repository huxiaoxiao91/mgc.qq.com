package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventStopTalentShowMatch extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventStopTalentShowMatch;
		}
		
		public function CEventStopTalentShowMatch()
		{
			registerField("op_player", "", Descriptor.Int64, 1);
			registerField("stop_res", "", Descriptor.Int32, 2);
		}
		
		public var op_player : Int64;
		public var stop_res : int;
	}
}
