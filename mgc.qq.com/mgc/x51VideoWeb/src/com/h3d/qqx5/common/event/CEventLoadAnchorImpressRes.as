package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.video_service.serviceinf.AnchorImpressionDataServer;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import flash.sampler.NewObjectSample;
	import flash.utils.getQualifiedClassName;

	public class CEventLoadAnchorImpressRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventLoadAnchorImpressRes;
		}
		
		public function CEventLoadAnchorImpressRes()
		{
			registerField("impressiondata",getQualifiedClassName(AnchorImpressionDataServer), Descriptor.Compound, 1);
			registerField("proxy_id", "", Descriptor.Int32, 2);
			registerField("tunnel_id", "", Descriptor.Int32, 3);
			registerField("serial_id", "", Descriptor.Int32, 4);
			registerField("trans_id", "", Descriptor.Int64, 5);
			registerField("player_id", "", Descriptor.Int64, 6);
		}
		
		public var impressiondata : AnchorImpressionDataServer = new AnchorImpressionDataServer;
		public var proxy_id : int;
		public var tunnel_id : int;
		public var serial_id : int;
		public var trans_id : Int64;
		public var player_id : Int64;
	}
}
