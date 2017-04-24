package com.h3d.qqx5.common.event
{
	import avmplus.getQualifiedClassName;
	
	import com.h3d.qqx5.common.event.eventid.PlaybackEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.common.comdata.ceremony.ConcertPlaybackRoomInfo;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventConcertPlaybackRoomGetRoomListRes extends INetMessage
	{
		public override function CLSID():int
		{
			return PlaybackEventID.CLSID_CEventConcertPlaybackRoomGetRoomListRes;
		}
		//下发宝箱开启的差值，活动标题和活动内容
		public function CEventConcertPlaybackRoomGetRoomListRes()
		{
			registerField("total_cnt", "", Descriptor.Int32, 1);//房间总数量
			registerFieldForList("rooms", getQualifiedClassName(ConcertPlaybackRoomInfo), Descriptor.Compound, 2);//房间列表
		}
		public var total_cnt:int;
		public var rooms : Array = new Array;
	}
}