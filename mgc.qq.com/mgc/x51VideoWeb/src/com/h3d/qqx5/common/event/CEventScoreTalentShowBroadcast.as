package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.TalentShowJudgeScore;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventScoreTalentShowBroadcast extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventScoreTalentShowBroadcast;
		}
		
		public function CEventScoreTalentShowBroadcast()
		{
			registerFieldForList("score", getQualifiedClassName(TalentShowJudgeScore), Descriptor.Compound, 1);
			registerFieldForList("guard_level", "", Descriptor.Int32, 2);
			registerFieldForList("vip_level", "", Descriptor.Int32, 3);
		}
		
		public var score : Array = new Array;
		public var guard_level : Array = new Array;
		public var vip_level : Array = new Array;
	}
}
