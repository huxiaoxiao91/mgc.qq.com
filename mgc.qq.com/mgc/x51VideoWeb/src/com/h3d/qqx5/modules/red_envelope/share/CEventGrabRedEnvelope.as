package com.h3d.qqx5.modules.red_envelope.share
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;

	public class CEventGrabRedEnvelope extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoRedEnvelopeEventId.CLSID_CEventGrabRedEnvelope;
		}
		
		public function CEventGrabRedEnvelope()
		{
			registerField("red_id", "", Descriptor.Int64, 1);
		}
		
		public var red_id : Int64 = new Int64();
	}
}
