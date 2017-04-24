package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.VideoBoxItem;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import flash.utils.getQualifiedClassName;
	
	public class CEventLoadPreviewVideoTreasureBoxNewRoleRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventLoadPreviewVideoTreasureBoxNewRoleRes;
		}
		public function CEventLoadPreviewVideoTreasureBoxNewRoleRes()
		{
			registerField("box_id", "", Descriptor.Int32, 1);
			registerFieldForList("box_items", getQualifiedClassName(VideoBoxItem), Descriptor.Compound, 2);
			registerField("buff_percent", "", Descriptor.Int32, 3);
		}
		public var box_id : int;
		public var box_items :Array = new Array();
		public var buff_percent:int;//主播等级的额外加成
	}
}
