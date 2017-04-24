package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.common.comdata.SimpleAnchor;
	import flash.utils.getQualifiedClassName;
	public class CEventAnchorPKStartMatchNotify extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventAnchorPKStartMatchNotify;
		}
		
		public function CEventAnchorPKStartMatchNotify()
		{
			registerField("pk_anchorA", getQualifiedClassName(SimpleAnchor), Descriptor.Compound, 1);
			registerField("pk_anchorB", getQualifiedClassName(SimpleAnchor), Descriptor.Compound, 2);
		}
		
		public var pk_anchorA : SimpleAnchor = new SimpleAnchor;
		public var pk_anchorB : SimpleAnchor = new SimpleAnchor;
	}
}
