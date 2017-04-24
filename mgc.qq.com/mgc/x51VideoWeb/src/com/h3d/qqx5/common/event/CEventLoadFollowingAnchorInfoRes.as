package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.video_service.serviceinf.AnchorInfoOnDataServer;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventLoadFollowingAnchorInfoRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventLoadFollowingAnchorInfoRes;
		}
		
		public function CEventLoadFollowingAnchorInfoRes()
		{
			registerFieldForList("anchors_info", getQualifiedClassName(AnchorInfoOnDataServer), Descriptor.Compound, 1);
			registerField("proxy_id", "", Descriptor.Int32, 2);
			registerField("tunnel_id", "", Descriptor.Int32, 3);
			registerField("serial_id", "", Descriptor.Int32, 4);
			registerField("trans_id", "", Descriptor.Int64, 5);
			registerField("from", "", Descriptor.Int32, 6);
		}
		
		public var anchors_info : Array;
		public var proxy_id : int;
		public var tunnel_id : int;
		public var serial_id : int;
		public var trans_id : Int64;
		public var from : int;
	}
}
