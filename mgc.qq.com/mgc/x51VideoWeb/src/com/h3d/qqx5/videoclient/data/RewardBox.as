package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	public class RewardBox extends ProtoBufSerializable
	{
		public function RewardBox()
		{
			registerField("status", "", Descriptor.Int32, 1);
			registerFieldForList("rewards", getQualifiedClassName(CDailySiginReward),Descriptor.Compound, 2);
		}
		public var status:int;
		public var rewards:Array = new Array();
	}
}