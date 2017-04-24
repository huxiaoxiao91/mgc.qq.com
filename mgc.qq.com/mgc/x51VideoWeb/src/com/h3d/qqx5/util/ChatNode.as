package com.h3d.qqx5.util
{
	/**
	 * @author liuchui
	 */
	public class ChatNode
	{
		public function ChatNode()
		{
			
		}
		
		public static const TEXT:int = 0;
		public static const IMAGE:int = 1;
		
		public var nodeType:int;
		public var content:String = "";
	}	
}