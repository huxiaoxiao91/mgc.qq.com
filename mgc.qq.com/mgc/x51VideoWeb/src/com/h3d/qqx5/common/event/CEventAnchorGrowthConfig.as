package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.BottleneckInfo;
	import com.h3d.qqx5.common.comdata.LevelInfo;
	import com.h3d.qqx5.common.event.eventid.EventNewGrowthID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	public class CEventAnchorGrowthConfig extends INetMessage
	{
		public override function CLSID() : int
		{
			return EventNewGrowthID.CLSID_CEventAnchorGrowthConfig;
		}
		
		public function CEventAnchorGrowthConfig()
		{
		
			registerFieldForList("level_info", getQualifiedClassName(LevelInfo), Descriptor.Compound, 1);
			registerFieldForDict("bottleneck_info", "", Descriptor.Int32, getQualifiedClassName(BottleneckInfo), Descriptor.Compound, 2);
		}
		
		public var level_info:Array;
		public var bottleneck_info:Dictionary;
	}
}