package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;

	public class CEventLoadVideoGuildLogRecord extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventLoadVideoGuildLogRecord;
		}
		
		public function CEventLoadVideoGuildLogRecord()
		{
			registerField("videoGuildId", "", Descriptor.Int64, 1);
			registerField("newestLogTime", "", Descriptor.Int32, 2);
			registerField("player_id", "", Descriptor.Int64, 3);
			registerField("room_id", "", Descriptor.Int32, 4);
			registerField("serial_id", "", Descriptor.Int32, 5);
		}
		
		public var videoGuildId : Int64  = new Int64();
		public var newestLogTime : int;
		public var player_id : Int64  = new Int64();
		public var room_id : int;
		public var serial_id : int;
	}
}
