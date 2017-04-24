package com.h3d.qqx5.modules.red_envelope.share
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventChatIgnoreListOperate extends INetMessage
	{
		public override function CLSID():int
		{
			return VideoRedEnvelopeEventId.CLSID_CEventChatIgnoreListOperate;
		}
		
		public function CEventChatIgnoreListOperate()
		{
			registerField("operate", "", Descriptor.Int32, 1);
			registerField("player_id","",Descriptor.Int64,2);
//			registerField("nick", "", Descriptor.TypeString, 2);
//			registerField("zone", "", Descriptor.TypeString, 3);
		}
		
		public var operate:int;
		public var player_id : Int64 ;
//		public var nick:String = "";
//		public var zone:String = "";
	}
}
