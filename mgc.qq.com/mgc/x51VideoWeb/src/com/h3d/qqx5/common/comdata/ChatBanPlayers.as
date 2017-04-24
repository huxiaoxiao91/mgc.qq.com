package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import flash.utils.Dictionary;

	public class ChatBanPlayers extends ProtoBufSerializable
	{
		public function ChatBanPlayers()
		{	
			registerField("zonename","",Descriptor.TypeString,1);
			registerField("nick","",Descriptor.TypeString,2);
		}
		override public function isPureContainerWrapper():Boolean
		{
			return true;
		}
		public var zonename : String = "";
		public var nick : String = "";
	}
}