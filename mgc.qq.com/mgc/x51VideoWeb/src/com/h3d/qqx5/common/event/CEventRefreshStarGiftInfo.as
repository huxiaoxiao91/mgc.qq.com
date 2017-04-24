package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.video_rank_server.shared.StarGiftChamName;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	public class CEventRefreshStarGiftInfo extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventRefreshStarGiftInfo;
		}
		
		public function CEventRefreshStarGiftInfo()
		{
			registerFieldForList("cur_star_gifts","", Descriptor.Int32, 1);
			registerFieldForDict("star_gift_champion","",Descriptor.Int32, getQualifiedClassName(StarGiftChamName), Descriptor.Compound, 2);
			
		}
		
		public var cur_star_gifts : Array = [];
		public var star_gift_champion : Dictionary = new Dictionary();
	}
}