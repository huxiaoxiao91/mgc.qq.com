package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_guild.VideoGuildPositionInfo;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class CEventVideoGuildRefreshPosition extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildRefreshPosition;
		}
		
		public function CEventVideoGuildRefreshPosition()
		{
			registerFieldForDict("positions", "",Descriptor.Int32,getQualifiedClassName(VideoGuildPositionInfo), Descriptor.Compound, 1);
			registerField("player_id", "", Descriptor.Int64, 2);
			registerField("position_id", "", Descriptor.Int32, 3);
		}
		
		public var positions :VideoGuildPositionInfo = new VideoGuildPositionInfo;
		public var player_id : Int64;
		public var position_id : int;
	}
}
