package com.h3d.qqx5.common.event
{
	
	import com.h3d.qqx5.common.comdata.TagInfo;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventGetAllTagsRes  extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt	.CLSID_CEventGetAllTagsRes;
		}
		
		public function CEventGetAllTagsRes()
		{
			registerField("status","",Descriptor.Int32,1);
			registerFieldForList("tags",getQualifiedClassName(TagInfo),Descriptor.Compound,2);
		}
		public var status:int;
		public var tags:Array = new Array;
	}
}