package com.h3d.qqx5.video_service.serviceinf
{
	import com.h3d.qqx5.common.comdata.AnchorImpressionData;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	import flash.utils.getQualifiedClassName;

	public class AnchorImpressionDataServer extends ProtoBufSerializable
	{
		
		public function AnchorImpressionDataServer()
		{
			registerFieldForList("impressions", getQualifiedClassName(AnchorImpressionData), Descriptor.Compound, 1);
			registerField("total_count", "", Descriptor.Int32, 2);
			registerField("player_count", "", Descriptor.Int32, 3);
		}
		
		public var impressions :Array = new Array;
		public var total_count : int;
		public var player_count : int;
	}
}
