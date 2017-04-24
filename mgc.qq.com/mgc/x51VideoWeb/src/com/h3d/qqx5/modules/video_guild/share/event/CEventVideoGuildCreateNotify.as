package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;

	public class CEventVideoGuildCreateNotify extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildCreateNotify;
		}
		
		public function CEventVideoGuildCreateNotify()
		{
			registerField("vgid", "", Descriptor.Int64, 1);
			registerField("anchor_id", "", Descriptor.Int64, 2);
			registerField("vg_name", "", Descriptor.TypeString, 3);
			registerField("vg_desc", "", Descriptor.TypeString, 4);
			registerField("player_id", "", Descriptor.Int64, 5);
			registerField("chief_name", "", Descriptor.TypeString, 6);
			registerField("chief_zname", "", Descriptor.TypeString, 7);
			registerField("trans_id", "", Descriptor.Int64, 8);
			registerField("sex", "", Descriptor.Int32, 9);
			registerField("vip_level", "", Descriptor.Int32, 10);
			registerField("chief_qq", "", Descriptor.Int64, 11);
		}
		
		public var vgid : Int64;
		public var anchor_id : Int64;
		public var vg_name : String;
		public var vg_desc : String;
		public var player_id : Int64;
		public var chief_name : String;
		public var chief_zname : String;
		public var trans_id : Int64;
		public var sex : int;
		public var vip_level : int;
		public var chief_qq : Int64;
	}
}
