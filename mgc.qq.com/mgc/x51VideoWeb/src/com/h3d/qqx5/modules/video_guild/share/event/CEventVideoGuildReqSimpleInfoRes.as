package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventVideoGuildReqSimpleInfoRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildReqSimpleInfoRes;
		}
		
		public function CEventVideoGuildReqSimpleInfoRes()
		{
			registerField("anchor", "", Descriptor.Int64, 1);
			registerField("vg_name", "", Descriptor.TypeString, 2);
			registerField("player", "", Descriptor.Int64, 3);
		}
		
		public var anchor : Int64 = new Int64;
		public var vg_name : String = "";
		public var player : Int64 = new Int64;
	}
}
