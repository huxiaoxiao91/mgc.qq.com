package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	
	public class CEventLoadAnchorImpressForPlayerRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventLoadAnchorImpressForPlayerRes;
		}
		
		public function CEventLoadAnchorImpressForPlayerRes()
		{
			registerField("impressiondata", "", Descriptor.Int64, 1);
			registerField("proxy_id", "", Descriptor.Int32, 2);
			registerField("tunnel_id", "", Descriptor.Int32, 3);
			registerField("serial_id", "", Descriptor.Int32, 4);
			registerField("trans_id", "", Descriptor.Int64, 5);
			registerField("anchor_id", "", Descriptor.Int64, 6);
			registerField("m_status", "", Descriptor.Int32, 7);
		}
		
		public var impressiondata : Int64;
		public var proxy_id : int;
		public var tunnel_id : int;
		public var serial_id : int;
		public var trans_id : Int64;
		public var anchor_id : Int64;
		public var m_status : int;
	}
}
