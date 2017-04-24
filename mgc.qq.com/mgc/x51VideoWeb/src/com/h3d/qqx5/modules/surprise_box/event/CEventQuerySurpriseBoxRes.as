package com.h3d.qqx5.modules.surprise_box.event
{
	import com.h3d.qqx5.modules.surprise_box.share.RewardBasicItem;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;

	public class CEventQuerySurpriseBoxRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoSurpriseBoxEventID.CLSID_CEventQuerySurpriseBoxRes;
		}
		
		public function CEventQuerySurpriseBoxRes()
		{
			registerField("error", "", Descriptor.Int32, 1);
			registerFieldForList("reward", getQualifiedClassName(RewardBasicItem), Descriptor.Compound, 2);
		}
		
		public var error : int;
		public var reward : Array = new Array();
	}
}
