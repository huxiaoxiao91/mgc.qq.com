package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.NewGrowthEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventSyncPlayerDreamGiftAnchorExp extends INetMessage
	{
		public override function CLSID() : int
		{
			return NewGrowthEventID.CLSID_CEventSyncPlayerDreamGiftAnchorExp;
		}
		public function CEventSyncPlayerDreamGiftAnchorExp()
		{
			registerField("total_anchor_exp", "", Descriptor.Int32, 1);
			registerField("max_anchor_exp", "", Descriptor.Int32, 2);
		}
		public var total_anchor_exp:int;// 今天对当前主播通过送梦幻币礼物增加了多少经验值
		public var max_anchor_exp:int;// 每天通过送梦幻币礼物能够对主播增加的经验值上限
	}
}