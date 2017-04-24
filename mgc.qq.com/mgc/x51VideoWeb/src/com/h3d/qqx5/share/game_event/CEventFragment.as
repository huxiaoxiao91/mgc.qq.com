package com.h3d.qqx5.share.game_event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.NetBuffer;
	
	public class CEventFragment extends INetMessage
	{
		public override function CLSID() : int
		{
			return EventFragmentID.CLSID_CEventFragment;
		}
		
		public function CEventFragment()
		{
			registerField("clsid", "", Descriptor.Int32, 1);
			registerField("frag_count", "", Descriptor.Int32, 2);
			registerField("index", "", Descriptor.Int32, 3);
			registerField("buf", "", Descriptor.TypeNetBuffer, 4);
		}
		
		public var clsid : int;
		public var frag_count : int;
		public var index : int;
		public var buf :NetBuffer =new NetBuffer;
	}
}
