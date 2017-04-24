package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventScoreTalentShowRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventScoreTalentShowRes;
		}
		
		public function CEventScoreTalentShowRes()
		{
			registerField("res", "", Descriptor.Int32, 1);
			registerField("op_player", "", Descriptor.Int64, 2);
		}
		
		public var res : int;
		public var op_player : Int64;
	}
}
