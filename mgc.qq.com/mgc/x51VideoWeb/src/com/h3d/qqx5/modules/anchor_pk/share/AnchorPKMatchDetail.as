package com.h3d.qqx5.modules.anchor_pk.share
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;

	public class AnchorPKMatchDetail extends ProtoBufSerializable
	{		
		public function AnchorPKMatchDetail()
		{
			registerField("anchor_qq", "", Descriptor.Int64, 1);
			registerField("score", "", Descriptor.Int32, 2);
			registerFieldForList("guilds", getQualifiedClassName(AnchorPKDefGuildInfo), Descriptor.Compound, 3);
			registerFieldForList("players", getQualifiedClassName(AnchorPKPlayerInfo), Descriptor.Compound, 4);
			registerField("anchor_name", "", Descriptor.TypeString, 5);
		}
		
		public var anchor_qq : Int64;
		public var score :int;
		public var guilds :Array = new Array();
		public var players : Array = new Array();
		public var anchor_name : String ="";
	}
}
