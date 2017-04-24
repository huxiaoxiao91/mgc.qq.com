package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.common.comdata.SimpleAnchor;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;

	public class CEventAnchorPKSyncInfoEnterRoom extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventAnchorPKSyncInfoEnterRoom;
		}
		
		public function CEventAnchorPKSyncInfoEnterRoom()
		{
			registerField("activity_status", "", Descriptor.Int32, 1);
			registerField("match_status", "", Descriptor.Int32, 2);
			registerFieldForList("rooms", "", Descriptor.Int32, 3);
			registerField("status_seconds", "", Descriptor.Int32, 4);
			registerField("anchorA", getQualifiedClassName(SimpleAnchor), Descriptor.Compound, 5);
			registerField("anchorB", getQualifiedClassName(SimpleAnchor), Descriptor.Compound, 6);
			registerField("extra_data", "", Descriptor.Int32, 7);
		}
		
		public var activity_status : int;
		public var match_status : int;
		public var rooms : Array =new Array();
		public var status_seconds : int;
		public var anchorA :SimpleAnchor = new SimpleAnchor();
		public var anchorB :SimpleAnchor = new SimpleAnchor();
		public var extra_data : int;
	}
}
