package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_guild.VideoGuildInfo;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class CEventVideoGuildInfoSaveToDBRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildInfoSaveToDBRes;
		}
		
		public function CEventVideoGuildInfoSaveToDBRes()
		{
			registerField("trans_id", "", Descriptor.Int64, 1);
			registerField("save_res", "", Descriptor.Int32, 2);
			registerField("room_server_id", "", Descriptor.Int32, 3);
			registerField("reason", "", Descriptor.Int32, 4);
			registerField("vg_info", getQualifiedClassName(VideoGuildInfo), Descriptor.Compound, 5);
			registerField("chief_sex", "", Descriptor.Int32, 6);
			registerField("chief_vip_level", "", Descriptor.Int32, 7);
			registerField("anchor_nick", "", Descriptor.TypeString, 8);
		}
		
		public var trans_id : Int64;
		public var save_res : int;
		public var room_server_id : int;
		public var reason : int;
		public var vg_info :VideoGuildInfo = new VideoGuildInfo;
		public var chief_sex : int;
		public var chief_vip_level : int;
		public var anchor_nick : String = "";
	}
}
