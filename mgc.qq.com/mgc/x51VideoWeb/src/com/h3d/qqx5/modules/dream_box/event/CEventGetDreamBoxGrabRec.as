package com.h3d.qqx5.modules.dream_box.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventGetDreamBoxGrabRec extends INetMessage
	{
		public override function CLSID() : int
		{
			return DreamBoxEventID.CLSID_CEventGetDreamBoxGrabRec;
		}
		public function CEventGetDreamBoxGrabRec()
		{
			registerField("box_id", "", Descriptor.Int64, 1);
			registerField("begin_index", "", Descriptor.Int32, 2);
			registerField("end_index", "", Descriptor.Int32, 3);
		}
		public var box_id : Int64 = new Int64(0,0);
		public var begin_index : int;
		public var end_index : int;
	}
}
