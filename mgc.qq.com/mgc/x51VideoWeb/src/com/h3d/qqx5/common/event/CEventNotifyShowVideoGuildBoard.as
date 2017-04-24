package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_guild.VideoGuildBoardRenderInfo;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventNotifyShowVideoGuildBoard extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventNotifyShowVideoGuildBoard;
		}
		
		public function CEventNotifyShowVideoGuildBoard()
		{
			registerField("sender_id", "", Descriptor.Int64, 1);
			registerField("room_id", "", Descriptor.Int32, 2);
			registerField("board", getQualifiedClassName(VideoGuildBoardRenderInfo), Descriptor.Compound, 3);
			registerField("videoguild_id", "", Descriptor.Int64, 4);
			registerField("firstvg_board_change", "", Descriptor.TypeBoolean, 5);
		}
		
		public var sender_id : Int64;
		public var room_id : int;
		public var board :VideoGuildBoardRenderInfo = new VideoGuildBoardRenderInfo;
		public var videoguild_id : Int64;
		public var firstvg_board_change : Boolean;
	}
}
