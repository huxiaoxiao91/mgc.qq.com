package com.h3d.qqx5.modules.red_envelope.share
{
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;

	public class RedEnvelopeGrabberInfo extends ProtoBufSerializable
	{
		public function RedEnvelopeGrabberInfo()
		{
			registerField("grabber", "", Descriptor.Int64, 1);// 抢红包的人id
			registerField("nick", "", Descriptor.TypeString, 2);// 昵称
			registerField("zone", "", Descriptor.TypeString, 3);// 大区名
			registerField("grab_count", "", Descriptor.Int32, 4);// 抢到的数量
		}
		
		public var grabber : Int64 = new Int64();
		public var nick : String = "";
		public var zone : String = "";
		public var grab_count : int;
	}
}