package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.videoclient.gamereward.RewardReqestWeb;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventVideoGetExternalRewardDesc extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventVideoGetExternalRewardDesc;
		}
		
		public function CEventVideoGetExternalRewardDesc()
		{
			registerField("index", "", Descriptor.Int32, 1);
			registerFieldForList("item_tips", getQualifiedClassName(RewardReqestWeb), Descriptor.Compound, 2);
			registerFieldForList("item_cnts", getQualifiedClassName(RewardReqestWeb), Descriptor.Compound, 3);
		}
		
		public var index : int;
		public var item_tips : Array = new Array;
		public var item_cnts : Array = new Array;
	}
}