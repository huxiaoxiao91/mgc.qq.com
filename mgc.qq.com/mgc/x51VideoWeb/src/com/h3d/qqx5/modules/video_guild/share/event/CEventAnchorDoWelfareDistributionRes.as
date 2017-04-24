package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventAnchorDoWelfareDistributionRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventAnchorDoWelfareDistributionRes;
		}
		
		public function CEventAnchorDoWelfareDistributionRes()
		{
			registerField("anchor_id", "", Descriptor.Int64, 1);
			registerField("welfare", "", Descriptor.Int32, 2);
			registerField("guild_id", "", Descriptor.Int64, 3);
			registerField("guild_curr_welfare", "", Descriptor.Int32, 4);
			registerField("err_code", "", Descriptor.Int32, 5);
		}
		
		public var anchor_id : Int64;
		public var welfare : int;
		public var guild_id : Int64;
		public var guild_curr_welfare : int;
		public var err_code : int;
	}
}
