package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoOpenGiftPoolBox extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoOpenGiftPoolBox;
		}
		
		public function CEventVideoOpenGiftPoolBox()
		{
			registerField("sender_id", "", Descriptor.Int64, 1);
			registerField("sender_sex", "", Descriptor.Int32, 2);
			registerField("box_id", "", Descriptor.Int32, 3);
			registerField("room_id", "", Descriptor.Int32, 4);
			registerField("chooseIndex", "", Descriptor.Int32, 5);//为-1时 仅仅通知客户端播放开宝箱前的动画(并非真正开宝箱)
			registerField("is_auto", "", Descriptor.TypeBoolean, 6);//是否自动开宝箱--
			registerField("secret_code", "", Descriptor.TypeString, 7);//宝箱密令--
		}
		
		public var sender_id : Int64;
		public var sender_sex : int;
		public var box_id : int;
		public var room_id : int;
		public var chooseIndex : int;
		public var is_auto : Boolean;
		public var secret_code : String;
	}
}
