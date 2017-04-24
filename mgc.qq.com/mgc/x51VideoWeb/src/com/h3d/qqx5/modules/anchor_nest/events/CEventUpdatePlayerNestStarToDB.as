package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventUpdatePlayerNestStarToDB extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventUpdatePlayerNestStarToDB;
		}
		
		public function CEventUpdatePlayerNestStarToDB()
		{
			registerField("nest_id", "", Descriptor.Int32, 1);
			registerField("player_id", "", Descriptor.Int64, 2);
			registerField("day_seq", "", Descriptor.Int32, 3);
			registerField("add_star", "", Descriptor.Int32, 4);
			registerField("total_add_star", "", Descriptor.Int64, 5);
		}
		
		public var nest_id : int;
		public var player_id : Int64;
		public var day_seq : int;
		public var add_star : int;
		public var total_add_star : Int64;
	}
}
