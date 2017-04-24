package com.h3d.qqx5.common.event.roomskin {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	/**
	 * 刷新房间魅力榜
	 * @author gaolei
	 *
	 */
	public class CEventRefreshRoomCharmRank extends INetMessage {
		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventRefreshRoomCharmRank;
		}

		public function CEventRefreshRoomCharmRank() {
			super();
			
			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("rank_timedimension", "", Descriptor.Int32, 2);
			registerField("succ", "", Descriptor.Int32, 3);
			registerField("req_rank_player", "", Descriptor.Int64, 4);
			registerFieldForList("ranks", getQualifiedClassName(VideoRoomCharmRank), Descriptor.Compound, 5);
			registerField("total_size", "", Descriptor.Int32, 6);
		}
		
		public var room_id:int;
		
		public var rank_timedimension:int;
		
		public var succ:int;
		
		public var req_rank_player:Int64 = new Int64();
		
		public var ranks:Array = [];
		
		public var total_size:int;
	}
}
