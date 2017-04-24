package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventDelDBVideoGuildMember extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventDelDBVideoGuildMember;
		}
		
		public function CEventDelDBVideoGuildMember()
		{
			registerField("vg_id", "", Descriptor.Int64, 1);
			registerField("member_id", "", Descriptor.Int64, 2);
			registerField("del_type", "", Descriptor.Int32, 3);
		}
		
		public var vg_id : Int64;
		public var member_id : Int64;
		public var del_type : int;
	}
}
