package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.anchor_pk.share.AnchorPKGuildInfoForDB;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;

	public class CEventSaveAnchorPKGuildToDB extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventSaveAnchorPKGuildToDB;
		}
		
		public function CEventSaveAnchorPKGuildToDB()
		{
			registerField("activity_id", "", Descriptor.Int32, 1);
			registerField("anchor_qq_A", "", Descriptor.Int64, 2);
			registerFieldForDict("guild_info_A","",Descriptor.Int64, getQualifiedClassName(AnchorPKGuildInfoForDB), Descriptor.Compound,3);
			registerField("anchor_qq_B", "", Descriptor.Int64, 4);
			registerFieldForDict("guild_info_B","",Descriptor.Int64, getQualifiedClassName(AnchorPKGuildInfoForDB),Descriptor.Compound, 5);
		}
		
		public var activity_id : int;
		public var anchor_qq_A : Int64;
		public var guild_info_A : Dictionary = new Dictionary();
		public var anchor_qq_B : Int64;
		public var guild_info_B   : Dictionary = new Dictionary();
	}
}
