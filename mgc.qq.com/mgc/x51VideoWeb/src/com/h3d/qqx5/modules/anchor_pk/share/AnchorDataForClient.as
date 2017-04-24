package com.h3d.qqx5.modules.anchor_pk.share
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.video_service.serviceinf.AnchorImpressionDataServer;
	
	import flash.utils.getQualifiedClassName;

	public class AnchorDataForClient extends ProtoBufSerializable
	{
		
		public function AnchorDataForClient()
		{
			registerField("male", "", Descriptor.TypeBoolean, 1);
			registerField("followedAudiences", "", Descriptor.Int32, 2);
			registerField("anchorID", "", Descriptor.Int64, 3);
			registerField("anchorQQ", "", Descriptor.Int64, 4);
			registerField("gameID", "", Descriptor.Int64, 5);
			registerField("popularity", "", Descriptor.Int64, 6);
			registerField("starlight", "", Descriptor.Int64, 7);
			registerField("intro", "", Descriptor.TypeString, 8);
			registerField("name", "", Descriptor.TypeString, 9);
			registerField("from", "", Descriptor.TypeString, 10);
			registerField("photoUrl", "", Descriptor.TypeString, 11);
			registerField("imageUrl", "", Descriptor.TypeString, 12);
			registerField("deputy_name", "", Descriptor.TypeString, 13);
			registerField("deputy_zone_name", "", Descriptor.TypeString, 14);
			registerField("talent_show_rank", "", Descriptor.Int32, 15);
			registerField("star_anchor", "", Descriptor.TypeBoolean, 16);
			registerField("anchor_score", "", Descriptor.Int32, 17);
			registerField("pk_anchor_winner_order", "", Descriptor.Int32, 18);
			registerField("impression", getQualifiedClassName(AnchorImpressionDataServer), Descriptor.Compound, 19);
		}
		
		public var male : Boolean;
		public var followedAudiences : int;
		public var anchorID : Int64;
		public var anchorQQ : Int64;
		public var gameID : Int64;
		public var popularity : Int64;
		public var starlight : Int64;
		public var intro : String ="";
		public var name : String ="";
		public var from : String ="";
		public var photoUrl : String="";
		public var imageUrl : String ="";
		public var deputy_name : String="";
		public var deputy_zone_name : String="";
		public var talent_show_rank : int;
		public var star_anchor : Boolean;
		public var anchor_score : int;
		public var pk_anchor_winner_order : int;
		public var impression : AnchorImpressionDataServer = new AnchorImpressionDataServer;
	}
}
