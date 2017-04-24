package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	
	public class CEventVideoGuildChangeAnchor extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildChangeAnchor;
		}
		
		public function CEventVideoGuildChangeAnchor()
		{
			registerField("trans_id", "", Descriptor.Int64, 1);
			registerField("anchor_id", "", Descriptor.Int64, 2);
			registerField("vgid", "", Descriptor.Int64, 3);
			registerField("player_id", "", Descriptor.Int64, 4);
			registerField("anchor_nick", "", Descriptor.TypeString, 5);
		}
		
		public var trans_id : Int64  = new Int64();
		public var anchor_id : Int64  = new Int64(); 
		public var vgid : Int64  = new Int64();;
		public var player_id : Int64  = new Int64();;
		public var anchor_nick : String = "";
	}
}
