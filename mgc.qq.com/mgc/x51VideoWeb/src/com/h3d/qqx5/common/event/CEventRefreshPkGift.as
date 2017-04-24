package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.VideoAnchorPKRank;
	import com.h3d.qqx5.common.comdata.VideoPKGiftInfo;
	import com.h3d.qqx5.common.event.eventid.AnchorPKEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	//刷新pk礼物，pk的角标
	public class CEventRefreshPkGift extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorPKEventID.CLSID_CEventRefreshPkGift;
		}
		public function CEventRefreshPkGift()
		{
			registerFieldForList("gift_list", getQualifiedClassName(VideoPKGiftInfo), Descriptor.Compound, 1);
		}
		
		public var gift_list:Array;
	}
}
