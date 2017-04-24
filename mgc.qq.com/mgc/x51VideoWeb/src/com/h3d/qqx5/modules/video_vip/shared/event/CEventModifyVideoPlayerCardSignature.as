package com.h3d.qqx5.modules.video_vip.shared.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventModifyVideoPlayerCardSignature extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoVipEventID.CLSID_CEventModifyVideoPlayerCardSignature;
		}
		
		public function CEventModifyVideoPlayerCardSignature()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("signature", "", Descriptor.TypeString, 2);
			registerField("video_room_id", "", Descriptor.Int32, 3);
		}
		
		public var player_id : Int64;
		public var signature : String;
		public var video_room_id : int;
	}
}
