package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.VideoVoteEvent;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventEnterRoomNotifyVoteInfo extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoVoteEvent.CLSID_CEventEnterRoomNotifyVoteInfo;
		}
		public function CEventEnterRoomNotifyVoteInfo()
		{
			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("player_id", "", Descriptor.Int64, 2);
			registerField("vote_id", "", Descriptor.Int64, 3);
			registerFieldForList("selects", "", Descriptor.Int32, 4);
		}
		public var room_id:int;
		public var player_id:Int64 = new Int64(0,0);
		public var vote_id:Int64 = new Int64(0,0);
		public var selects:Array = new Array;
	}
}