package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventBroadcastAssignTalentJudgeMsg extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventBroadcastAssignTalentJudgeMsg;
		}
		
		public function CEventBroadcastAssignTalentJudgeMsg()
		{
			registerField("pre_judge_type", "", Descriptor.Int32, 1);
			registerField("cur_judge_type", "", Descriptor.Int32, 2);
			registerField("player_name", "", Descriptor.TypeString, 3);
			registerField("zone_name", "", Descriptor.TypeString, 4);
			registerField("op_name", "", Descriptor.TypeString, 5);
		}
		
		public var pre_judge_type : int;
		public var cur_judge_type : int;
		public var player_name : String;
		public var zone_name : String;
		public var op_name : String;
	}
}
