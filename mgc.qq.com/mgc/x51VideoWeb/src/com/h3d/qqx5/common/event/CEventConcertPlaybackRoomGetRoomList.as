package com.h3d.qqx5.common.event
{
	import avmplus.getQualifiedClassName;
	
	import com.h3d.qqx5.common.event.eventid.PlaybackEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventConcertPlaybackRoomGetRoomList extends INetMessage
	{
		public override function CLSID():int
		{
			return PlaybackEventID.CLSID_CEventConcertPlaybackRoomGetRoomList;
		}
		//下发宝箱开启的差值，活动标题和活动内容
		public function CEventConcertPlaybackRoomGetRoomList()
		{
			registerField("from", "", Descriptor.Int32, 1);//房间索引从哪个位置开始请求
			registerField("req_count", "", Descriptor.Int32, 2);//请求数量
		}
		public var from:int;
		public var req_count:int;
	}
}