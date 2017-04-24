package com.h3d.qqx5.videoclient.main
{
	import com.h3d.qqx5.videoclient.data.CeremonyStartAnchorInfoForUI;
	import com.h3d.qqx5.videoclient.data.CeremonyStartInfoForUI;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientInternal;

	public class CVideoCeremonyClient
	{
		private var m_state:int;
		private var m_start_info : CeremonyStartInfoForUI;
		private var m_video_client : IVideoClientInternal;

		public function CVideoCeremonyClient()
		{
		}
		public function onLeaveRoom():void
		{
			
		}
		public function GetCeremonyState():int
		{
			return m_state;
		}
		
		public function GetCeremonyStartInfo():CeremonyStartInfoForUI
		{
			return m_start_info;
		}
		
		public function addSupportDegree(support_degree_add :int):void
		{
			for(var itr:Object in m_start_info.m_anchors);
			{
				if (itr.m_anchor_id == m_start_info.m_my_support_anchor)
				{
					itr.m_my_support_degree += support_degree_add;
				}
			}
			
			m_video_client.GetUICallback().onRefreshCeremonyStartInfo(m_start_info);
		}
	}
}