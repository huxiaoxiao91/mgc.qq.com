package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventVideoRoomGetRoomList extends INetMessage
	{
	  public override function CLSID() : int
	  {
	    return EEventIDVideoRoom.CLSID_CEventVideoRoomGetRoomList;
	  }
	
	  public function CEventVideoRoomGetRoomList()
	  {
	    registerField("from", "", Descriptor.Int32, 1);
	    registerField("subject", "", Descriptor.Int32, 2);
	    registerField("count", "", Descriptor.Int32, 3);
	    registerFieldForList("self_room", "", Descriptor.Int32, 4);
	    registerField("room_type", "", Descriptor.Int32, 5);
		registerField("tag", "", Descriptor.Int32, 6);
		registerField("position", "", Descriptor.Int32, 7);
		registerField("module_type", "", Descriptor.Int32, 8);
		registerField("source", "", Descriptor.Int32, 9);
		registerField("mobile_status", "", Descriptor.Int32, 10);
	  }
	
	  public var from:int;
	  public var subject:int;
	  public var count:int;
	  public var self_room:Array = new Array;
	  public var room_type:int;
	  public var tag:int;
	  public var position:int;
	  public var module_type:int;//0:模块1,1：模块2
	  public var source:int;// 拉取房间列表来源: 0 :默认来源    1:页签来源   2:刷新来源
	  public var mobile_status:int;// 移动端的请求状态 0 不处理 1 进入预览界面，处理周星赛通知
	}
}
