package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventSendVideoGuildJoinApply extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventSendVideoGuildJoinApply;
		}
		
		public function CEventSendVideoGuildJoinApply()
		{
			registerField("trans_id", "", Descriptor.Int64, 1);
			registerField("player_id", "", Descriptor.Int64, 2);
			registerField("vgid", "", Descriptor.Int64, 3);
			registerField("nick", "", Descriptor.TypeString, 4);
			registerField("zname", "", Descriptor.TypeString, 5);
			registerField("wealth", "", Descriptor.Int64, 6);
			registerField("vip_level", "", Descriptor.Int32, 7);
			registerField("sex", "", Descriptor.Int32, 8);
			registerField("qq", "", Descriptor.Int64, 9);
		}
		
		public var trans_id : Int64 = new Int64();
		public var player_id : Int64 = new Int64();
		public var vgid : Int64 = new Int64();
		public var nick : String = "";
		public var zname : String = "";
		public var wealth : Int64  = new Int64();
		public var vip_level : int = 0;
		public var sex : int = 0;
		public var qq : Int64  = new Int64();
	}
}
