package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class CEventLoadVideoGuildList extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventLoadVideoGuildList;
		}
		
		public function CEventLoadVideoGuildList()
		{
			registerField("page", "", Descriptor.Int32, 1);
			registerField("sort_type", "", Descriptor.Int32, 2);
			registerField("name", "", Descriptor.TypeString, 3);
			registerField("player_id", "", Descriptor.Int64, 4);
			registerField("game_transid", "", Descriptor.Int64, 5);
			registerField("room_id", "", Descriptor.Int32, 6);
			registerField("dev_type", "", Descriptor.Int32, 7);
		}
		
		public var page : int;
		public var sort_type : int;
		public var name : String = "";
		public var player_id : Int64 = new Int64();
		public var game_transid : Int64 = new Int64();
		public var room_id : int;
		public var dev_type : int;
	}
}
