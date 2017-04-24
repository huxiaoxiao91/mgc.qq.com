package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventVideoGuildBroadcast extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildBroadcast;
		}
		
		public function CEventVideoGuildBroadcast()
		{
			registerField("vgid", "", Descriptor.Int64, 1);
			registerField("vgbt", "", Descriptor.Int32, 2);
			registerField("player_id_1", "", Descriptor.Int64, 101);
			registerField("player_id_2", "", Descriptor.Int64, 102);
			registerField("string_1", "", Descriptor.TypeString, 201);
			registerField("string_2", "", Descriptor.TypeString, 202);
			registerField("string_3", "", Descriptor.TypeString, 203);
			registerField("string_4", "", Descriptor.TypeString, 204);
			registerField("int_1", "", Descriptor.Int32, 301);
			registerField("int_2", "", Descriptor.Int32, 302);
		}
		
		public var vgid : Int64 = new Int64();
		public var vgbt : int = 0;
		public var player_id_1 : Int64 = new Int64();
		public var player_id_2 : Int64 = new Int64();
		public var string_1 : String = "";
		public var string_2 : String = "";
		public var string_3 : String = "";
		public var string_4 : String = "";
		public var int_1 : int = 0;
		public var int_2 : int = 0;
	}
}
