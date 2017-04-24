package com.h3d.qqx5.common.event
{
	import avmplus.getQualifiedClassName;
	
	import com.h3d.qqx5.common.comdata.UserIdentity;
	import com.h3d.qqx5.common.event.eventid.VideoPersonalCardEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventVisitAnchor extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoPersonalCardEventID.CLSID_CEventVisitAnchor;
		}
		
		public function CEventVisitAnchor()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("anchor_id", "", Descriptor.Int64, 2);
			registerField("video_server_id", "", Descriptor.Int32, 3);
			registerField("trans_id", "", Descriptor.Int64, 4);
			registerField("proxy_id", "", Descriptor.Int32, 5);
			registerField("tunnel_id", "", Descriptor.Int32, 6);
			registerField("serialid", "", Descriptor.Int32, 7);
			registerField("userIdentity", getQualifiedClassName(UserIdentity), Descriptor.Compound, 8);
		}
		
		public var player_id : Int64 = new Int64();
		public var anchor_id : Int64  = new Int64();
		public var video_server_id : int;
		public var trans_id : Int64  = new Int64();
		public var proxy_id : int;
		public var tunnel_id : int;
		public var serialid : int;
		public var userIdentity:UserIdentity = new UserIdentity();
	}
}
