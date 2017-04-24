package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventRefuseVideoGuildJoinApplyNotify extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventRefuseVideoGuildJoinApplyNotify;
		}
		
		public function CEventRefuseVideoGuildJoinApplyNotify()
		{
			registerField("target_id", "", Descriptor.Int64, 1);
			registerField("vgid", "", Descriptor.Int64, 2);
			registerField("vg_name", "", Descriptor.TypeString, 3);
		}
		
		public var target_id : Int64;
		public var vgid : Int64;
		public var vg_name : String;
	}
}
