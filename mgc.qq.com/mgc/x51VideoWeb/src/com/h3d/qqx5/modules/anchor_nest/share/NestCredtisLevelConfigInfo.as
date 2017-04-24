package com.h3d.qqx5.modules.anchor_nest.share
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	public class NestCredtisLevelConfigInfo extends ProtoBufSerializable
	{
		public function NestCredtisLevelConfigInfo()
		{
			registerField("level", "", Descriptor.Int32, 1);
			registerField("credits", "", Descriptor.Int32, 2);
			registerField("percent", "", Descriptor.Int32, 3);
			registerField("expression_privilege", "", Descriptor.Int32, 4);
		}
		public var level : int;
		public var credits : int;
		public var percent : int;
		public var expression_privilege : int;
	}
}
