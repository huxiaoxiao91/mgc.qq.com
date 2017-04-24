package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.videoclient.gamereward.RewardReqestWebRes;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventVideoGetExternalRewardDescRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventVideoGetExternalRewardDescRes;
		}
		public function CEventVideoGetExternalRewardDescRes()
		{
			registerField("index", "", Descriptor.Int32, 1);
			registerFieldForList("item_tips", getQualifiedClassName(RewardReqestWebRes), Descriptor.Compound , 2);
			registerFieldForList("item_cnts", getQualifiedClassName(RewardReqestWebRes), Descriptor.Compound , 3);
		}
		
		public var index : int;
		public var item_tips : Array = new Array;
		public var item_cnts : Array = new Array;
	}
}