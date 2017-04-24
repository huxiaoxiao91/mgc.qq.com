package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.LuckyPlayer;
	import com.h3d.qqx5.common.event.eventid.RaffleEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventLuckPlayerListIncrement extends INetMessage
	{
		public override function CLSID() : int
		{
			return RaffleEventID.CLSID_CEventLuckPlayerListIncrement;
		}
		public function CEventLuckPlayerListIncrement()
		{
			registerFieldForList("player_list", getQualifiedClassName(LuckyPlayer), Descriptor.Compound, 1);
			registerField("room_id", "", Descriptor.Int32, 2);
			registerField("notify_client", "", Descriptor.TypeBoolean, 3);
			registerField("is_all", "", Descriptor.TypeBoolean, 4);
		}
		public var player_list : Array = new Array;
		public var room_id : int;
		public var notify_client : Boolean;
		public var is_all : Boolean;
	}
}
