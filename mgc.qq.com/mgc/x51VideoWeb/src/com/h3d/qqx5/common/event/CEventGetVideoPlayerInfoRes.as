package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.VideoCharInfo;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventGetVideoPlayerInfoRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventGetVideoPlayerInfoRes;
		}
		
		public function CEventGetVideoPlayerInfoRes()
		{
			registerField("char_info", getQualifiedClassName(VideoCharInfo), Descriptor.Compound, 1);
			registerFieldForList("followed_anchors", "", Descriptor.Int64, 2);
			registerField("succ", "", Descriptor.TypeBoolean, 3);
			registerField("transid", "", Descriptor.Int64, 4);
		}
		
		public var char_info :VideoCharInfo;
		public var followed_anchors : Array = new Array ;
		public var succ : Boolean;
		public var transid : Int64;
	}
}
