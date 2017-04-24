package com.h3d.qqx5.modules.red_envelope.share
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class CEventLoadRedEnvelopeRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoRedEnvelopeEventId.CLSID_CEventLoadRedEnvelopeRes;
		}
		
		public function CEventLoadRedEnvelopeRes()
		{
			registerField("result", "", Descriptor.Int32, 1);
			registerField("red_id", "", Descriptor.Int64, 2);
			registerField("redenvelope_info", getQualifiedClassName(RedEnvelopeInfo), Descriptor.Compound, 3);
		}
		
		public var result : int;
		public var red_id : Int64 = new Int64();
		public var redenvelope_info : RedEnvelopeInfo = new RedEnvelopeInfo;
	}
}
