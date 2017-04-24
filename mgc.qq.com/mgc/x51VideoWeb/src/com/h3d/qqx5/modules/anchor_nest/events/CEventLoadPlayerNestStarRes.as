package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.anchor_nest.share.AnchorNestStarDBData;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;

	public class CEventLoadPlayerNestStarRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventLoadPlayerNestStarRes;
		}
		
		public function CEventLoadPlayerNestStarRes()
		{
			registerFieldForList("data_loaded", getQualifiedClassName(AnchorNestStarDBData), Descriptor.Compound, 1);
			registerField("trans_id", "", Descriptor.Int64, 2);
			registerField("result", "", Descriptor.Int32, 3);
			registerField("player_id", "", Descriptor.Int64, 4);
			registerField("nest_id", "", Descriptor.Int32, 5);
		}
		
		public var data_loaded : Array = new Array;
		public var trans_id : Int64;
		public var result :int;
		public var player_id : Int64;
		public var nest_id :int;
	}
}
