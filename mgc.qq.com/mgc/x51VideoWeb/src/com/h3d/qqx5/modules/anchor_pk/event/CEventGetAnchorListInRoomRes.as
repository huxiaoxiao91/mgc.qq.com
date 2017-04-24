package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.common.comdata.SimpleAnchor;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;

	public class CEventGetAnchorListInRoomRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventGetAnchorListInRoomRes;
		}
		
		public function CEventGetAnchorListInRoomRes()
		{
			registerField("operator", "", Descriptor.Int64, 1);
			registerFieldForList("anchors", getQualifiedClassName(SimpleAnchor), Descriptor.Compound, 2);
		}
		
		public var operator : Int64;
		public var anchors : Array = new Array();
	}
}
