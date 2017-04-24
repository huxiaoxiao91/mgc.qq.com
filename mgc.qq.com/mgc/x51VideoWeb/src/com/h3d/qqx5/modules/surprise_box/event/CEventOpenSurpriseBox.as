package com.h3d.qqx5.modules.surprise_box.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;

	public class CEventOpenSurpriseBox extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoSurpriseBoxEventID.CLSID_CEventOpenSurpriseBox;
		}
		
		public function CEventOpenSurpriseBox()
		{
			registerField("trans_id", "", Descriptor.Int64, 1);
			registerField("room_id", "", Descriptor.Int32, 2);
			registerField("player_id", "", Descriptor.Int64, 3);
		}
		
		public var trans_id : Int64 = new Int64();
		public var room_id : int;
		public var player_id : Int64 = new Int64();
	}
}
