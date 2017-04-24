package com.h3d.qqx5.modules.video_vip.shared.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventNotifyUploadVideoCardPortrait extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoVipEventID.CLSID_CEventNotifyUploadVideoCardPortrait;
		}
		
		public function CEventNotifyUploadVideoCardPortrait()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("room_id", "", Descriptor.Int32, 2);
		}
		
		public var player_id : Int64;
		public var room_id : int;
	}
}
