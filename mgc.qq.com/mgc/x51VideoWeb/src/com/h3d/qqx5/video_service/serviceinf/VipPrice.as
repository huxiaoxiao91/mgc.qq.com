package com.h3d.qqx5.video_service.serviceinf
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	import flash.utils.getQualifiedClassName;

	public class VipPrice extends ProtoBufSerializable
	{
		public function VipPrice()
		{
			registerFieldForList("price_list", getQualifiedClassName(SingleVipPrice),Descriptor.Compound,1);
		}
		
		override public function isPureContainerWrapper():Boolean	
		{
			return true;
		}
		public var price_list :Array = new Array();
	}
}