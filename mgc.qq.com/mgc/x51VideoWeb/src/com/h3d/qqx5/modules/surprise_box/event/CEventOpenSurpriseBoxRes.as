package com.h3d.qqx5.modules.surprise_box.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.surprise_box.share.RewardBasicItem;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class CEventOpenSurpriseBoxRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoSurpriseBoxEventID.CLSID_CEventOpenSurpriseBoxRes;
		}
		
		public function CEventOpenSurpriseBoxRes()
		{
			registerField("error", "", Descriptor.Int32, 1);
			registerField("reward", getQualifiedClassName(RewardBasicItem), Descriptor.Compound, 2);
			registerField("trans_id", "", Descriptor.Int64, 3);
		}
		
		public var error : int;
		public var reward :RewardBasicItem = new RewardBasicItem;
		public var trans_id : Int64 = new Int64();
	}
}
