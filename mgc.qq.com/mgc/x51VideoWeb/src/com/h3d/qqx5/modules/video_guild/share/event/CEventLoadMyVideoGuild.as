package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class CEventLoadMyVideoGuild extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventLoadMyVideoGuild;
		}
		
		public function CEventLoadMyVideoGuild()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("game_transid", "", Descriptor.Int64, 2);
			registerField("room_id", "", Descriptor.Int32, 3);
			registerField("vg_id", "", Descriptor.Int64, 4);
			registerField("room_transid", "", Descriptor.Int64, 5);
			registerField("from_ui", "", Descriptor.TypeBoolean, 6);
			registerField("from_home", "", Descriptor.TypeBoolean, 7);
			
		}
		
		public var player_id : Int64 = new Int64();
		public var game_transid : Int64 = new Int64();
		public var room_id : int;
		public var vg_id : Int64 = new Int64();
		public var room_transid : Int64 = new Int64();
		public var from_ui : Boolean;
		public var from_home:Boolean;//是否是重首页点击
	}
}
