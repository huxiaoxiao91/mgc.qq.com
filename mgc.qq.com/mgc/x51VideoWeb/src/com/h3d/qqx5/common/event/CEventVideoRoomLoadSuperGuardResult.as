package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.VideoRoomSuperGuard;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomLoadSuperGuardResult extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomLoadSuperGuardResult;
		}
		
		public function CEventVideoRoomLoadSuperGuardResult()
		{
			registerFieldForDict("super_guards", "",Descriptor.Int64,getQualifiedClassName(VideoRoomSuperGuard),Descriptor.Compound, 1);
			registerField("player_id", "", Descriptor.Int64, 2);
			registerFieldForDict("super_guards_new","",Descriptor.Int64, getQualifiedClassName(VideoRoomSuperGuard),Descriptor.Compound, 3);
		}
		public var super_guards :Dictionary = new Dictionary();
		public var player_id : Int64 = new Int64();
		public var super_guards_new :Dictionary = new Dictionary();
	}
}
