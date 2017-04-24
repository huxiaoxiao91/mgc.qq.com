package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_activity.VideoActivityEventID;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventGetActivityCompletedCountRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoActivityEventID.CLSID_CEventGetActivityCompletedCountRes;
		}
			
		public function CEventGetActivityCompletedCountRes()
		{
			registerField("completed_cnt", "", Descriptor.Int32, 1);
			registerField("has_taken_wage_today", "", Descriptor.TypeBoolean, 2);
			registerField("m_status", "", Descriptor.Int32, 3);
		}
		
		public var completed_cnt:int;
		public var has_taken_wage_today:Boolean;
		public var m_status : int;
	}
}