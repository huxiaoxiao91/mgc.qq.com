package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	
	public class CEventEditAnchorImpressRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventEditAnchorImpressRes;
		}
		
		public function CEventEditAnchorImpressRes()
		{
			registerField("proxy_id", "", Descriptor.Int32, 1);
			registerField("tunnel_id", "", Descriptor.Int32, 2);
			registerField("serial_id", "", Descriptor.Int32, 3);
			registerField("trans_id", "", Descriptor.Int64, 4);
			registerField("result", "", Descriptor.Int32, 5);
		}
		
		public var proxy_id : int;
		public var tunnel_id : int;
		public var serial_id : int;
		public var trans_id : Int64;
		public var result : int;
	}
}
