package com.h3d.qqx5.videoclient.data
{
	import flash.utils.Dictionary;

	public class VipPriceInfoForUI
	{
		public var start_price_list:Dictionary = new Dictionary;
		public var renewal_price_list:Dictionary = new Dictionary;
		
		public function clear():void
		{
			start_price_list = new Dictionary;
			renewal_price_list = new Dictionary;
		}
	}
}