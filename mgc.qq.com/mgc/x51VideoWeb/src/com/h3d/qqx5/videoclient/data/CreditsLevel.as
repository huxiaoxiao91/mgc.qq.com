package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	public class CreditsLevel	 extends ProtoBufSerializable
	{
		public function CreditsLevel()
		{
			registerField("ceatit", "", Descriptor.Int32, 1);
			registerField("level", "", Descriptor.Int32, 2);
		}
		
		override public function isPureContainerWrapper():Boolean
		{
			return true;
		}
		
		override public  function isPureContainChar():Boolean
		{
			return true;
		}
		
		public var ceatit : int;
		public var level : int;
	}
}