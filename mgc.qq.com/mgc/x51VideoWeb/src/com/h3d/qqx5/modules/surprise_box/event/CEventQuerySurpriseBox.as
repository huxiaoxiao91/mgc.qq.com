package com.h3d.qqx5.modules.surprise_box.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventQuerySurpriseBox extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoSurpriseBoxEventID.CLSID_CEventQuerySurpriseBox;
		}
		
		public function CEventQuerySurpriseBox()
		{
			registerField("roomid", "", Descriptor.Int32, 1);
			registerField("playerid", "", Descriptor.Int64, 2);
		}
		
		public var roomid : int;
		public var playerid : Int64 = new Int64();
	}
}
