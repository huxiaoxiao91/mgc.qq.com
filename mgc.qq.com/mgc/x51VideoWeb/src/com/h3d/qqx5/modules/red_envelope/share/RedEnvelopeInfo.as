package com.h3d.qqx5.modules.red_envelope.share
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class RedEnvelopeInfo extends ProtoBufSerializable
	{
		public function RedEnvelopeInfo()
		{
			registerField("publisher", "", Descriptor.Int64, 1);// 发红包的人
			registerField("nick", "", Descriptor.TypeString, 2);// 昵称
			registerField("zone", "", Descriptor.TypeString, 3);// 大区名
			registerField("publish_time", "", Descriptor.Int32, 4);// 发红包时间
			registerField("total_money", "", Descriptor.Int32, 5);// 红包总额度
			registerField("remain_money", "", Descriptor.Int32, 6);// 红包剩余钱数
			registerField("divide_count", "", Descriptor.Int32, 7);// 红包分发数量
			registerFieldForList("grabbers", getQualifiedClassName(RedEnvelopeGrabberInfo), Descriptor.Compound, 8);// 抢红包记录
			registerField("red_id", "", Descriptor.Int64, 9);// 红包id
		}

		public var publisher:Int64 = new Int64();
		public var nick:String ="";
		public var zone:String ="";
		public var publish_time :int;
		public var total_money:int;
		public var remain_money:int;
		public var divide_count:int;
		public var grabbers:Array = new Array();
		public var red_id:Int64  = new Int64();
	}
}
