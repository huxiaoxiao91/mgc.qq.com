package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventAnchorRequestWelfareDistribution extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventAnchorRequestWelfareDistribution;
		}
		
		public function CEventAnchorRequestWelfareDistribution()
		{
			registerField("anchor_id", "", Descriptor.Int64, 1);
			registerField("sort_type", "", Descriptor.Int32, 2);
			registerField("page", "", Descriptor.Int32, 3);
			registerField("first_req", "", Descriptor.TypeBoolean, 4);
		}
		
		public var anchor_id : Int64  = new Int64();
		public var sort_type : int;
		public var page : int;
		public var first_req : Boolean;
	}
}
