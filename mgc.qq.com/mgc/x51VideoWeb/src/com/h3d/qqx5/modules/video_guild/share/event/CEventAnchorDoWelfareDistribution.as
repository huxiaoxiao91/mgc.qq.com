package com.h3d.qqx5.modules.video_guild.share.event
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventAnchorDoWelfareDistribution extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventAnchorDoWelfareDistribution;
		}
		
		public function CEventAnchorDoWelfareDistribution()
		{
			registerField("anchorid", "", Descriptor.Int64, 1);
			registerField("guild_id", "", Descriptor.Int64, 2);
			registerField("video_room_trans_id", "", Descriptor.Int64, 3);
			registerField("welfare", "", Descriptor.Int32, 4);
		}
		
		public var anchorid : Int64  = new Int64();
		public var guild_id : Int64  = new Int64();
		public var video_room_trans_id : Int64  = new Int64();
		public var welfare : int;
	}
}
