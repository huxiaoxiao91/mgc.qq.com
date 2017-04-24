package com.h3d.qqx5.video_service.serviceinf
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	public class VipPriceInfo extends ProtoBufSerializable
	{
		//protected var VipPricestruct:Vector.<SingleVipPrice>;
		public function VipPriceInfo()
		{
			registerFieldForDict("start_price_list","", Descriptor.Int32,getQualifiedClassName(VipPrice),Descriptor.Compound, 1);
			registerFieldForDict("renewal_price_list","", Descriptor.Int32, getQualifiedClassName(VipPrice),Descriptor.Compound , 2);
		}
		public var start_price_list :Dictionary = new Dictionary();
		public var renewal_price_list  :Dictionary = new Dictionary();
	}
}
