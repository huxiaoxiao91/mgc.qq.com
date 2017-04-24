package com.h3d.qqx5.videoclient.data
{
	public class CeremonyStartInfoForUI
	{
		public var m_anchors:Array = new Array;
		public var m_fans:Array = new Array;
		public var m_my_support_anchor:int = 0;// 我支持的主播
		
		public function clear():void
		{
			m_my_support_anchor = 0;
			m_anchors.splice(0);
			m_fans.splice(0);
		}
	}
}