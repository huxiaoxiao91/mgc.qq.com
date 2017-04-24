package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_activity.VideoActivityEventID;
	import com.h3d.qqx5.modules.video_activity.VideoActivityInfoToClient;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventNotifyRoomActivityComplete extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoActivityEventID.CLSID_CEventNotifyRoomActivityComplete;
		}
		public function CEventNotifyRoomActivityComplete()
		{
			registerField("activity", getQualifiedClassName(VideoActivityInfoToClient), Descriptor.Compound, 1);
			registerField("activity_category", "", Descriptor.Int32, 2);
			registerField("room_id", "", Descriptor.Int32, 3);
		}
		
		public var activity_category : int;
		public var room_id:int;
		public var activity : VideoActivityInfoToClient = new VideoActivityInfoToClient;
	}
}
