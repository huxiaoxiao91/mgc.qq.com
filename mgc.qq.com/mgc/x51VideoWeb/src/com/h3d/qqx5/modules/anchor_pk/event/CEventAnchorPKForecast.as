package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	public class CEventAnchorPKForecast extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventAnchorPKForecast;
		}
		
		public function CEventAnchorPKForecast()
		{
			registerField("minutes", "", Descriptor.Int32, 1);
			registerField("room_id", "", Descriptor.Int32, 2);
			registerField("anchorA", "", Descriptor.TypeString, 3);
			registerField("anchorB", "", Descriptor.TypeString, 4);
			registerField("room_name", "", Descriptor.TypeString, 5);
		}
		
		public var minutes : int;
		public var room_id : int;
		public var anchorA : String ="";
		public var anchorB : String = "";
		public var room_name : String = "";
	}
}
