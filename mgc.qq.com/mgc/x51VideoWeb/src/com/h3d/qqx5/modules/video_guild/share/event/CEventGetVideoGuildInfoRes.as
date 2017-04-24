package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_guild.VideoGuildInfo;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class CEventGetVideoGuildInfoRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventGetVideoGuildInfoRes;
		}
		
		public function CEventGetVideoGuildInfoRes()
		{
			registerField("trans_id", "", Descriptor.Int64, 1);
			registerField("player_id", "", Descriptor.Int64, 2);
			registerField("vg_info", getQualifiedClassName(VideoGuildInfo), Descriptor.Compound, 3);
			registerField("result", "", Descriptor.Int32, 4);
			registerField("anchor_level", "", Descriptor.Int32, 5);
		}
		
		public var trans_id : Int64 = new Int64();
		public var player_id : Int64 = new Int64();
		public var vg_info :VideoGuildInfo = new VideoGuildInfo;
		public var result : int;
		public var anchor_level:int;//主播等级
	}
}
