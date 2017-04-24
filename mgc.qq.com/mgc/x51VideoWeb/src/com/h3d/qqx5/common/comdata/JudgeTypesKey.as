package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	import flash.utils.Dictionary;
	
	public class JudgeTypesKey extends ProtoBufSerializable
	{
		public function JudgeTypesKey()
		{
			registerField("pair1", "", Descriptor.TypeString, 1);
			registerField("pair2", "", Descriptor.TypeString, 2);
		}
		
		override public function isPureContainerWrapper():Boolean	
		{
			return true;
		}
		public var pair1 :String ="";
		public var pair2 : String = "";
	}
}