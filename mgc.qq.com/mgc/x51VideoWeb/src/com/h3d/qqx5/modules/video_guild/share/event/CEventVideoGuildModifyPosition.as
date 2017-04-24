package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_guild.VideoGuildPositionInfo;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class CEventVideoGuildModifyPosition extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildModifyPosition;
		}
		
		public function CEventVideoGuildModifyPosition()
		{
			registerField("position_info", getQualifiedClassName(VideoGuildPositionInfo), Descriptor.Compound, 1);
			registerField("player_id", "", Descriptor.Int64, 2);
			registerField("result", "", Descriptor.Int32, 3);
			registerField("vg_id", "", Descriptor.Int64, 4);
			registerField("serial_id", "", Descriptor.Int32, 5);
		}
		
		public var position_info :VideoGuildPositionInfo = new VideoGuildPositionInfo;
		public var player_id : Int64  = new Int64();
		public var result : int;
		public var vg_id : Int64  = new Int64();
		public var serial_id : int;
	}
}
