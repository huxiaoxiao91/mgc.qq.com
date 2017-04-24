package com.h3d.qqx5.videoclient.data
{
	public class CeremonyStartAnchorInfoForUI
	{
		public function CeremonyStartAnchorInfoForUI()
		{
			 m_anchor_id = 0;
			 m_total_support_degree = 0;
			 m_my_support_degree = 0;
			 m_is_online = true;
		}
		
		public var m_name:String = "";
		public var m_anchor_id = Int64;
		public var m_total_support_degree:int;
		public var m_my_support_degree:int;
		public var m_is_online:Boolean;
	}
}