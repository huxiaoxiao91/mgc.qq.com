package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.AnchorFollower;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.VideoPersonalCardEventID;

	public class CEventGetAnchorFansRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoPersonalCardEventID.CLSID_CEventGetAnchorFansRes;
		}
		
		public function CEventGetAnchorFansRes()
		{
			registerField("trans_id", "", Descriptor.Int64, 1);
			registerFieldForList("followers", getQualifiedClassName(AnchorFollower), Descriptor.Compound, 2);
		}
		
		public var trans_id : Int64;
		public var followers : Array =new Array;
	}
}
