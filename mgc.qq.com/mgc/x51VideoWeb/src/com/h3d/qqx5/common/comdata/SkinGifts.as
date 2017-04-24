package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	import flash.utils.Dictionary;
	
	/**
	 * 专属礼物信息
	 * @author gaolei
	 * 
	 */	
	public class SkinGifts extends ProtoBufSerializable
	{
		public function SkinGifts()
		{
			super();
			
			registerFieldForDict("skin_gift_map", "", Descriptor.Int32, "", Descriptor.Int32, 1);
		}
		
		public var skin_gift_map:Dictionary = new Dictionary()
	}
}