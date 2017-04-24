package com.h3d.qqx5.modules.video_vip.shared.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventModifyVideoPlayerCardSignatureRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoVipEventID.CLSID_CEventModifyVideoPlayerCardSignatureRes;
		}
		
		public function CEventModifyVideoPlayerCardSignatureRes()
		{
			registerField("ret", "", Descriptor.Int32, 1);
			registerField("player_id", "", Descriptor.Int64, 2);
			registerField("signature", "", Descriptor.TypeString, 3);
		}
		
		public var ret : int;
		public var player_id : Int64;
		public var signature : String;
	}
}
