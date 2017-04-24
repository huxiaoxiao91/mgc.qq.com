package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	
	public class CEventVideoGuildChangeAnchorNotify extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildChangeAnchorNotify;
		}
		
		public function CEventVideoGuildChangeAnchorNotify()
		{
			registerField("old_anchor_id", "", Descriptor.Int64, 1);
			registerField("vgid", "", Descriptor.Int64, 2);
			registerField("player_id", "", Descriptor.Int64, 3);
			registerField("new_anchor_id", "", Descriptor.Int64, 4);
		}
		
		public var old_anchor_id : Int64;
		public var vgid : Int64;
		public var player_id : Int64;
		public var new_anchor_id : Int64;
	}
}
