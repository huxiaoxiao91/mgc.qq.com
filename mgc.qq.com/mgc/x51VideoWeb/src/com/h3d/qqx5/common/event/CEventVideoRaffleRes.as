package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.RaffleRewardInfo;
	import com.h3d.qqx5.common.event.eventid.RaffleEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventVideoRaffleRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return RaffleEventID.CLSID_CEventVideoRaffleRes;
		}
		public function CEventVideoRaffleRes()
		{
			registerField("res", "", Descriptor.Int32, 1);
			registerField("reward", getQualifiedClassName(RaffleRewardInfo), Descriptor.Compound, 2);
			registerField("player_id", "", Descriptor.Int64, 3);
			registerField("room_id", "", Descriptor.Int32, 4);
			registerField("is_lucky", "", Descriptor.TypeBoolean, 5);
			registerField("serial_id", "", Descriptor.Int32, 6);
		}
		public var res : int;
		public var reward : RaffleRewardInfo = new RaffleRewardInfo;
		public var player_id : Int64;
		public var room_id : int;
		public var is_lucky : Boolean;
		public var serial_id:int;
	}
}
