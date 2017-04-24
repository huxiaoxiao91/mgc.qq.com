package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventTestPingRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventTestPingRes;
		}
		
		public function CEventTestPingRes()
		{
			registerField("to_server_id", "", Descriptor.Int32, 1);
			registerField("trans_id", "", Descriptor.Int64, 2);
		}
		
		public var to_server_id : int;
		public var trans_id : Int64;
	}
}
