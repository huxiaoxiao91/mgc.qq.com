package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;

	public class RedEnvelopePublicInfo extends ProtoBufSerializable
	{
		public function RedEnvelopePublicInfo()
		{
			registerField("red_envelope_duration", "", Descriptor.Int32, 1);
			registerField("small_red_envelope_duration", "", Descriptor.Int32, 2);
		}
		public var red_envelope_duration:int;//大红包持续时间
		public var small_red_envelope_duration:int;//小红包持续时间
	}
}