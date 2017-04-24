package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	// 星耀榜变化时的走马灯消息。
	public class CEventVideoRankChangeBroadcastAllPlayer extends INetMessage
	{
		public override function CLSID() : int
		{
			
			return EEventIDVideoRoomExt.CLSID_CEventVideoRankChangeBroadcastAllPlayer;
		}
		
		public function CEventVideoRankChangeBroadcastAllPlayer()
		{
			registerField("m_rank_move", "", Descriptor.Int32, 1);
			registerField("m_player_name", "", Descriptor.TypeString, 2);
			registerField("m_enScrollType", "", Descriptor.Int32, 3);
			registerField("m_timedimension", "", Descriptor.Int32, 4);
			registerField("video_rank_type", "", Descriptor.Int32, 5);
			registerField("level", "", Descriptor.Int32, 6);
			registerField("gift_id", "", Descriptor.Int32, 7);
			registerField("stargift_player_nick", "", Descriptor.TypeString, 8);
		}
		
		public var m_rank_move:int = 0;
		public var m_player_name:String = "";
		public var m_enScrollType:int = 0; 
		public var m_timedimension:int = 0;
		public var video_rank_type:int = 0;
		public var level:int = 0;
		public var gift_id:int = 0;
		public var stargift_player_nick:String = "";
	}
}