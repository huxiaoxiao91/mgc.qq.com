package com.h3d.qqx5.common.comdata
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	public class FreeGiftInfo extends ProtoBufSerializable
	{
		public function FreeGiftInfo()
		{
			registerField("giftid", "", Descriptor.Int32, 1);
			registerField("giftcnt", "", Descriptor.Int32, 2);
			registerField("leftTime", "", Descriptor.Int32, 3);
		}
		public var giftid : int;
		public var giftcnt : int;
		public var leftTime : int;
	}
}
