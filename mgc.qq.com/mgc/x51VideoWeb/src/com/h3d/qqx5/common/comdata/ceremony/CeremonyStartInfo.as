package com.h3d.qqx5.common.comdata.ceremony
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class CeremonyStartInfo extends ProtoBufSerializable
	{
		
		public function CeremonyStartInfo()
		{
			registerFieldForList("anchors", getQualifiedClassName(CeremonyStartAnchorInfo), Descriptor.Compound, 1);
			registerField("my_support_anchor", "", Descriptor.Int64, 2);
			registerFieldForList("fans", getQualifiedClassName(CeremonyFansInfo), Descriptor.Compound, 3);
		}
		
		public var anchors :Array = new Array;
		public var my_support_anchor : Int64;
		public var fans : Array = new Array;
	}
}
