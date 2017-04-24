package com.h3d.qqx5.videoclient.data
{
	import flash.utils.Dictionary;

	public class CeremonyRefreshInfoForUI
	{
		public var m_fans:Array;
		public var m_support_degrees:Dictionary;
		
		public function clear():void
		{
			m_support_degrees.clear();
			m_fans.clear();//待实现
		}
	}
}