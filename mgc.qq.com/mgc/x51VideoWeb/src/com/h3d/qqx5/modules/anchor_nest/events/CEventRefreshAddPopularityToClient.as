package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventRefreshAddPopularityToClient extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventRefreshAddPopularityToClient;
		}
		
		public function CEventRefreshAddPopularityToClient()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("add_popularity", "", Descriptor.Int32, 2);
			registerField("is_free_pop_limit", "", Descriptor.TypeBoolean, 3);
			registerField("is_hint", "", Descriptor.TypeBoolean, 4);
		}
		
		public var player_id : Int64 = new Int64(0,0);
		public var add_popularity : int;
		public var is_free_pop_limit:Boolean = false;
		public var is_hint:Boolean = false;
	}
}
