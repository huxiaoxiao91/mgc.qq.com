package com.h3d.qqx5.modules.anchor_nest.share
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.Dictionary;

	public class RankNumberMap extends INetMessage
	{
		public function RankNumberMap()
		{
			registerFieldForDict("ranknum","",Descriptor.Int32,"",Descriptor.Int32,1);
		}
		override public function isPureContainerWrapper():Boolean	
		{
			return true;
		}
		public var ranknum :Dictionary = new Dictionary;
	}
}