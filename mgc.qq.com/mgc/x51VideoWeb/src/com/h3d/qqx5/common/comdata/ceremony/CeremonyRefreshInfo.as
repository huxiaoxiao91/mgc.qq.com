package com.h3d.qqx5.common.comdata.ceremony
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	public class CeremonyRefreshInfo extends ProtoBufSerializable
	{
		
		public function CeremonyRefreshInfo()
		{
			
			registerFieldForDict("support_degrees","", Descriptor.Int64, "",Descriptor.Int32, 1);
			registerFieldForList("fans", getQualifiedClassName(CeremonyFansInfo), Descriptor.Compound, 2);
		}
		
		public var support_degrees :Dictionary = new Dictionary;
		public var fans : Array = new Array;
	}
}
