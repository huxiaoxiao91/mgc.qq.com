package com.h3d.qqx5.modules.red_envelope.share
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventPublishRedEnvelope extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoRedEnvelopeEventId.CLSID_CEventPublishRedEnvelope;
		}
		
		public function CEventPublishRedEnvelope()
		{
			registerField("publisher", "", Descriptor.Int64, 1);
			registerField("nick", "", Descriptor.TypeString, 2);
			registerField("zone", "", Descriptor.TypeString, 3);
			registerField("total_money", "", Descriptor.Int32, 4);
			registerField("divide_count", "", Descriptor.Int32, 5);
			registerField("red_id", "", Descriptor.Int64, 6);
			registerField("room_audience_count", "", Descriptor.Int32, 7);
			registerField("delay_audience_count", "", Descriptor.Int32, 8);
			registerField("red_envelope_duration", "", Descriptor.Int32, 9);
			registerField("small_red_envelope_duration", "", Descriptor.Int32, 10);
		}
		
		public var publisher : Int64 = new Int64();
		public var nick : String = "";
		public var zone : String = "";
		public var total_money : int;
		public var divide_count : int;
		public var red_id : Int64 = new Int64();
		public var room_audience_count : int;//房间内人数
		public var delay_audience_count : int;//延迟策略人数
		public var red_envelope_duration:int;//标识大红包持续时间，单位为秒。
		public var small_red_envelope_duration:int;//标识小红包持续时间，单位为秒。
	}
}
