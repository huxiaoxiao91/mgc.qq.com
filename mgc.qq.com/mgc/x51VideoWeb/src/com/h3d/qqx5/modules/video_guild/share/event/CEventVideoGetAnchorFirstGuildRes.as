package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventVideoGetAnchorFirstGuildRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGetAnchorFirstGuildRes;
		}
		
		public function CEventVideoGetAnchorFirstGuildRes()
		{
			registerField("anchor_qq", "", Descriptor.Int64, 1);
			registerField("first_vg_id", "", Descriptor.Int64, 2);
			registerField("room_id", "", Descriptor.Int32, 3);
		}
		
		public var anchor_qq : Int64;
		public var first_vg_id : Int64;
		public var room_id : int;
	}
}
