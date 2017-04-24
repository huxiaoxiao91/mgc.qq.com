package com.h3d.qqx5.modules.dream_box.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.dream_box.data.DreamBoxGrabber;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventGetDreamBoxGrabRecRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return DreamBoxEventID.CLSID_CEventGetDreamBoxGrabRecRes;
		}
		public function CEventGetDreamBoxGrabRecRes()
		{
			registerField("box_id", "", Descriptor.Int64, 1);
			registerField("res", "", Descriptor.Int32, 2);
			registerField("total_size", "", Descriptor.Int32, 3);
			registerField("publisher_nick", "", Descriptor.TypeString, 4);
			registerField("total_money", "", Descriptor.Int32, 5);
			registerField("grab_count", "", Descriptor.Int32, 6);
			registerField("video_money_rate", "", Descriptor.Int32, 7);
			registerFieldForList("rec", getQualifiedClassName(DreamBoxGrabber), Descriptor.Compound, 8);
		}
		public var box_id : Int64 = new Int64(0,0);
		public var res : int;
		public var total_size : int;
		public var publisher_nick : String = "";
		public var total_money : int;
		public var grab_count : int;
		public var video_money_rate : int;
		public var rec : Array = new Array();
	}
}
