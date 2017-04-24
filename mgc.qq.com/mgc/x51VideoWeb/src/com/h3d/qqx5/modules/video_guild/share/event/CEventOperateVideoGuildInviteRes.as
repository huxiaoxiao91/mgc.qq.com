package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_guild.VideoGuildInfo;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class CEventOperateVideoGuildInviteRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventOperateVideoGuildInviteRes;
		}
		
		public function CEventOperateVideoGuildInviteRes()
		{
			registerField("vgid", "", Descriptor.Int64, 1);
			registerField("op_type", "", Descriptor.Int32, 2);
			registerField("trans_id", "", Descriptor.Int64, 3);
			registerField("result", "", Descriptor.Int32, 4);
			registerField("vg_name", "", Descriptor.TypeString, 5);
			registerField("vg_info", getQualifiedClassName(VideoGuildInfo), Descriptor.Compound, 6);
		}
		
		public var vgid : Int64;
		public var op_type : int;
		public var trans_id : Int64;
		public var result : int;
		public var vg_name : String;
		public var vg_info :VideoGuildInfo = new VideoGuildInfo;
	}
}
