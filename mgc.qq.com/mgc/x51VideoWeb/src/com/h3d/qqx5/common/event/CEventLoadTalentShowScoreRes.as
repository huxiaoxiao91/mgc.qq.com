package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.TalentShowJudgeScore;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventLoadTalentShowScoreRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventLoadTalentShowScoreRes;
		}
		
		public function CEventLoadTalentShowScoreRes()
		{
			registerFieldForList("score_loaded", getQualifiedClassName( TalentShowJudgeScore), Descriptor.Compound, 1);
			registerField("result", "", Descriptor.Int32, 2);
			registerField("vote_cnt", "", Descriptor.Int32, 3);
		}
		
		public var score_loaded : Array = new Array;
		public var result : int;
		public var vote_cnt : int;
	}
}
