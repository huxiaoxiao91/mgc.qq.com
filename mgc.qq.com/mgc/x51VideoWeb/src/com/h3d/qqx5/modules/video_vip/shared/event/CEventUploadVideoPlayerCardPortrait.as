package com.h3d.qqx5.modules.video_vip.shared.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.NetBuffer;
	import com.h3d.qqx5.util.Int64;

	public class CEventUploadVideoPlayerCardPortrait extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoVipEventID.CLSID_CEventUploadVideoPlayerCardPortrait;
		}
		
		public function CEventUploadVideoPlayerCardPortrait()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("upload_path", "", Descriptor.TypeString, 2);
			registerField("pic_content", "", Descriptor.TypeNetBuffer, 3);
			registerField("serial_id", "", Descriptor.Int32, 5);
		}
		
		public var player_id : Int64;
		public var upload_path : String ="";
		public var pic_content :NetBuffer = new NetBuffer;
		public var serial_id : int;
	}
}
