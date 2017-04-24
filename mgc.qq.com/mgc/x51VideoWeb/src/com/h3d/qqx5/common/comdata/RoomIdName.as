package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	import flash.utils.Dictionary;

	public class RoomIdName extends ProtoBufSerializable
	{
		public function RoomIdName()
		{
			registerFieldForDict("room_id_name","",Descriptor.Int32, "",Descriptor.TypeString,1);
		}
		override public function isPureContainerWrapper():Boolean
		{
			return true;
		}
		public var room_id_name : Dictionary = new Dictionary();
	}
}