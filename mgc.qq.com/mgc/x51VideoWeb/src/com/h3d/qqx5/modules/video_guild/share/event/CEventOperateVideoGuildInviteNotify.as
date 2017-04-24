package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	public class CEventOperateVideoGuildInviteNotify extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventOperateVideoGuildInviteNotify;
		}
		
		public function CEventOperateVideoGuildInviteNotify()
		{
			registerField("op_type", "", Descriptor.Int32, 1);
			registerField("target_name", "", Descriptor.TypeString, 2);
			registerField("target_zname", "", Descriptor.TypeString, 3);
		}
		
		public var op_type : int;
		public var target_name : String = "";
		public var target_zname : String = "";
	}
}
