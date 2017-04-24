package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.common.comdata.AnchorGuild;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;

	public class CEventAnchorRequestWelfareDistributionRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventAnchorRequestWelfareDistributionRes;
		}
		
		public function CEventAnchorRequestWelfareDistributionRes()
		{
			registerField("anchor_id", "", Descriptor.Int64, 1);
			registerField("welfare", "", Descriptor.Int32, 2);
			registerFieldForList("guilds", getQualifiedClassName(AnchorGuild), Descriptor.Compound, 3);
			registerField("errcode", "", Descriptor.Int32, 4);
		}
		
		public var anchor_id : Int64;
		public var welfare : int;
		public var guilds : Array = new Array();
		public var errcode : int;
	}
}
