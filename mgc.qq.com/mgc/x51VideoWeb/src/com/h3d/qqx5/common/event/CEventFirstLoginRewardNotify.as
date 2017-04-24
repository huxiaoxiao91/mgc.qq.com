package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.videoclient.data.CReward;
	
	import flash.utils.getQualifiedClassName;
	
	//首登奖励的通知
	public class CEventFirstLoginRewardNotify extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventFirstLoginRewardNotify;
		}
		public function CEventFirstLoginRewardNotify()
		{
			registerField("status", "", Descriptor.Int32, 1);
			registerField("is_taken", "", Descriptor.TypeBoolean, 2);
			registerFieldForList("reward_list", getQualifiedClassName(CReward), Descriptor.Compound, 3);
		}
		
		public var status : int;
		public var is_taken : Boolean;
		public var reward_list : Array = new Array;
	}
}
