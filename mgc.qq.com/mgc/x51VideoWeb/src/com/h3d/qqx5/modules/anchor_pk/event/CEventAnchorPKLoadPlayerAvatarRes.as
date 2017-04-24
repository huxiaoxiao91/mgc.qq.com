package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.NetBuffer;
	import com.h3d.qqx5.util.Int64;

	public class CEventAnchorPKLoadPlayerAvatarRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventAnchorPKLoadPlayerAvatarRes;
		}
		
		public function CEventAnchorPKLoadPlayerAvatarRes()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("avatar", "", Descriptor.TypeNetBuffer, 2);
			registerField("result", "", Descriptor.Int32, 3);
			registerField("trans_id", "", Descriptor.Int64, 4);
		}
		
		public var player_id : Int64;
		public var avatar :NetBuffer;
		public var result : int;
		public var trans_id : Int64;
	}
}
