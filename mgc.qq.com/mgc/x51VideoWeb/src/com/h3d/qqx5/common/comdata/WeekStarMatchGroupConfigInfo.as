package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class WeekStarMatchGroupConfigInfo extends ProtoBufSerializable
	{
		public function WeekStarMatchGroupConfigInfo()
		{
			registerField("group_id", "", Descriptor.Int64, 1);//分组id
			registerField("group_name", "", Descriptor.TypeString, 2);//分组名
		}
		public var group_id : Int64;
		public var group_name : String = "";
	}
}
