package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;

	public class CEventVideoGuildCreate extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildCreate;
		}
		
		public function CEventVideoGuildCreate()
		{
			registerField("vg_name", "", Descriptor.TypeString, 1);
			registerField("vg_desc", "", Descriptor.TypeString, 2);
			registerField("anchor_id", "", Descriptor.Int64, 3);
			registerField("player_id", "", Descriptor.Int64, 4);
			registerField("trans_id", "", Descriptor.Int64, 5);
		}
		
		public var vg_name : String = "";
		public var vg_desc : String = "";
		public var anchor_id : Int64 = new Int64();
		public var player_id : Int64  = new Int64();
		public var trans_id : Int64  = new Int64();
	}
}
