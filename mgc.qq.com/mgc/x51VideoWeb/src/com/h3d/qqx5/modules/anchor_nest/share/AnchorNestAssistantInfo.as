package com.h3d.qqx5.modules.anchor_nest.share
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class AnchorNestAssistantInfo extends ProtoBufSerializable
	{
		public function AnchorNestAssistantInfo()
		{
			registerField("qq", "", Descriptor.Int64, 6);
		}
		public var qq : Int64;
	}
}
