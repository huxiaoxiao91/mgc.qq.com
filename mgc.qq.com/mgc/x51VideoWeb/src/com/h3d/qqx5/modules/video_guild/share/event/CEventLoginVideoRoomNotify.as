package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventLoginVideoRoomNotify extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventLoginVideoRoomNotify;
		}
		
		public function CEventLoginVideoRoomNotify()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("vg_id", "", Descriptor.Int64, 2);
			registerField("type", "", Descriptor.Int32, 3);
			registerField("qq", "", Descriptor.Int64, 4);
			registerField("nick", "", Descriptor.TypeString, 5);
			registerField("vip_level", "", Descriptor.Int32, 6);
			registerField("daily_first", "", Descriptor.TypeBoolean, 7);
		}
		
		public var player_id : Int64;
		public var vg_id : Int64;
		public var type : int;
		public var qq : Int64;
		public var nick : String;
		public var vip_level : int;
		public var daily_first : Boolean;
	}
}
