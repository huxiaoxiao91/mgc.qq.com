package com.h3d.qqx5.modules.anchor_nest.share
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class NestInfoLogicData extends ProtoBufSerializable
	{
		public function NestInfoLogicData()
		{
			registerField("nest_id","",Descriptor.Int32,1);
			registerField("nest_name","",Descriptor.TypeString,2);
			registerField("on_line_count","",Descriptor.Int32,3);
			registerField("nest_popularity", "", Descriptor.Int64, 4);
			registerField("is_live", "", Descriptor.Int32, 5);
			registerField("nest_owner", "", Descriptor.Int64, 6);
			registerField("anchor_name", "", Descriptor.TypeString, 7);
			registerField("anchor_posing_url","",Descriptor.TypeString,8);
			registerField("anchor_level", "", Descriptor.Int32, 9);
		}
		public var nest_id:int;
		public var nest_name:String = "";
		public var on_line_count:int;
		public var nest_popularity : Int64 = new Int64(0,0);
		public var is_live : int;
		public var nest_owner : Int64 = new Int64(0,0);
		public var anchor_name : String ="";
		public var anchor_posing_url : String ="";
		public var anchor_level:int;//主播等级
	}
}
