package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	public class CEventVideoGuildBuyFansBoard extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildBuyFansBoard;
		}
		
		public function CEventVideoGuildBuyFansBoard()
		{
			registerField("boardtype", "", Descriptor.Int32, 1);
			registerField("add_time", "", Descriptor.Int32, 2);
			registerField("serial_id", "", Descriptor.Int32, 3);
		}
		
		public var boardtype : int;
		public var add_time : int;
		public var serial_id : int;
	}
}
