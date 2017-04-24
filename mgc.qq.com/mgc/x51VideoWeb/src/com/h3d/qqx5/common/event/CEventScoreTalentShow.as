package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.TalentShowJudgeScore;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventScoreTalentShow extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventScoreTalentShow;
		}
		
		public function CEventScoreTalentShow()
		{
			registerFieldForList("scores", getQualifiedClassName(TalentShowJudgeScore ), Descriptor.Compound, 1);
			registerField("op_player", "", Descriptor.Int64, 2);
		}
		
		public var scores : Array = new Array;
		public var op_player : Int64;
	}
}
