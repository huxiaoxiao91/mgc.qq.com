package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.JudgeTypesKey;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventGetJudgeTypes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventGetJudgeTypes;
		}
		
		public function CEventGetJudgeTypes()
		{
			registerFieldForDict("judge_types",getQualifiedClassName(JudgeTypesKey),Descriptor.Compound, "",Descriptor.Int32, 1);
		}
		
		public var judge_types:Dictionary = new Dictionary;
	}
}
