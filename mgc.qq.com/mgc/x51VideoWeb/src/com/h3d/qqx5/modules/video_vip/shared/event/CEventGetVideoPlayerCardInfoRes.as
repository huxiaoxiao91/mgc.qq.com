package com.h3d.qqx5.modules.video_vip.shared.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.video_service.serviceinf.VideoVipPlayerCardInfo;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;

	public class CEventGetVideoPlayerCardInfoRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoVipEventID.CLSID_CEventGetVideoPlayerCardInfoRes;
		}
		
		public function CEventGetVideoPlayerCardInfoRes()
		{
			registerField("ret", "", Descriptor.Int32, 1);
			registerField("trans_id", "", Descriptor.Int64, 2);
			registerField("player_id", "", Descriptor.Int64, 3);
			registerField("card_info", getQualifiedClassName(VideoVipPlayerCardInfo), Descriptor.Compound, 4);
			registerField("is_self", "", Descriptor.TypeBoolean, 5);
		}		
		public var ret : int;
		public var trans_id : Int64;
		public var player_id : Int64;
		public var card_info :VideoVipPlayerCardInfo = new VideoVipPlayerCardInfo;
		public var is_self:Boolean;//
	}
}
