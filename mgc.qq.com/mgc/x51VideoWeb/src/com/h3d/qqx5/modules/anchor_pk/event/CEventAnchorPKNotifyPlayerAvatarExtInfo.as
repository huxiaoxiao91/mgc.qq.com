package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.anchor_pk.share.PlayerAvatarInfo;
	
	import flash.utils.getQualifiedClassName;
	public class CEventAnchorPKNotifyPlayerAvatarExtInfo extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventAnchorPKNotifyPlayerAvatarExtInfo;
		}
		
		public function CEventAnchorPKNotifyPlayerAvatarExtInfo()
		{
			registerField("avatarA", getQualifiedClassName(PlayerAvatarInfo), Descriptor.Compound, 1);
			registerField("avatarB", getQualifiedClassName(PlayerAvatarInfo), Descriptor.Compound, 2);
		}
		
		public var avatarA : PlayerAvatarInfo = new PlayerAvatarInfo;
		public var avatarB : PlayerAvatarInfo = new PlayerAvatarInfo;
	}
}
