package com.h3d.qqx5.common.event
{
	import avmplus.getQualifiedClassName;
	
	import com.h3d.qqx5.common.event.eventid.PlaybackEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventStartConcertPlaybackRes extends INetMessage
	{
		public override function CLSID():int
		{
			return PlaybackEventID.CLSID_CEventStartConcertPlaybackRes;
		}
		//下发宝箱开启的差值，活动标题和活动内容
		public function CEventStartConcertPlaybackRes()
		{
			registerField("error_code", "", Descriptor.Int32,  1);//错误码
			registerField("concert_id", "", Descriptor.Int32, 2);//演唱会id
			registerField("video_url", "", Descriptor.TypeString, 3);//视频地址
		}
		public var error_code : int;
		public var concert_id : int;
		public var video_url : String;
	}
}