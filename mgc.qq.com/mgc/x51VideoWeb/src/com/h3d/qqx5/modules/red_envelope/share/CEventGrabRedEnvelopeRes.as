package com.h3d.qqx5.modules.red_envelope.share
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class CEventGrabRedEnvelopeRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoRedEnvelopeEventId.CLSID_CEventGrabRedEnvelopeRes;
		}
		
		public function CEventGrabRedEnvelopeRes()
		{
			registerField("result", "", Descriptor.Int32, 1);
			registerField("red_id", "", Descriptor.Int64, 2);
			registerField("grabber", "", Descriptor.Int64, 3);
			registerField("grab_count", "", Descriptor.Int32, 4);
			registerField("redenvelope_info", getQualifiedClassName(RedEnvelopeInfo), Descriptor.Compound, 5);
			registerField("grab_count_value", "", Descriptor.Int32, 6);
		}
		
		public var result : int;
		public var red_id : Int64;
		public var grabber : Int64;
		public var grab_count : int;
		public var redenvelope_info : RedEnvelopeInfo = new RedEnvelopeInfo;
		public var grab_count_value:int = 0;//新角色换算成的梦幻币数量
	}
}
