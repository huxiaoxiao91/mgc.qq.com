package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.TalentShowJudgeInfo;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventSyncTalentShowJudge extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventSyncTalentShowJudge;
		}
		
		public function CEventSyncTalentShowJudge()
		{
			registerField("info", getQualifiedClassName(TalentShowJudgeInfo), Descriptor.Compound, 1);
			registerField("sync_type", "", Descriptor.Int32, 2);
		}
		
		public var info : TalentShowJudgeInfo = new TalentShowJudgeInfo;
		public var sync_type : int;
	}
}
