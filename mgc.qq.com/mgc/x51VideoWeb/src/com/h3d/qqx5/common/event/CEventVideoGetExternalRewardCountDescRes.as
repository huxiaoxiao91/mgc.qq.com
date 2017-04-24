package com.h3d.qqx5.common.event
{	
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.videoclient.gamereward.RewardReqestWebCountRes;
	import com.h3d.qqx5.videoclient.gamereward.RewardReqestWebRes;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventVideoGetExternalRewardCountDescRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventVideoGetExternalRewardCountDescRes;
		}
		
		public function CEventVideoGetExternalRewardCountDescRes()
		{
			registerField("index", "", Descriptor.Int32, 1);
//			registerFieldForList("items",getQualifiedClassName( RewardReqestWebCountRes) , Descriptor.Compound, 2);
		}
		
		public var index : int;
//		public var items : Array = new Array;
	}
}