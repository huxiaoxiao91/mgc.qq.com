package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.RaffleRewardInfo;
	import com.h3d.qqx5.common.event.eventid.RaffleEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventNotifyRaffleState extends INetMessage
	{
		public override function CLSID() : int
		{
			return RaffleEventID.CLSID_CEventNotifyRaffleState;
		}
		public function CEventNotifyRaffleState()
		{
			registerField("state", "", Descriptor.Int32, 1);
			registerField("time_to_count_down", "", Descriptor.Int32, 2);
			registerFieldForList("reward_list", getQualifiedClassName(RaffleRewardInfo), Descriptor.Compound, 3);
			registerFieldForList("exclude_number", "", Descriptor.Int32, 4);
			registerField("raffle_id", "", Descriptor.Int64, 5);
			registerField("need_notify_client", "", Descriptor.TypeBoolean, 6);
			registerField("room_id", "", Descriptor.Int32, 7);
			registerField("anchor_qq", "", Descriptor.Int64, 8);
		}
		public var state : int;
		public var time_to_count_down : int;
		public var reward_list : Array = new Array;
		public var exclude_number : Array = new Array;
		public var raffle_id : Int64;
		public var need_notify_client : Boolean;
		public var room_id : int;
		public var anchor_qq : Int64= new Int64(0,0);
	}
}
