package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.common.comdata.ChatBanPlayers;

	public class CEventSyncChatBannedPlayers extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventSyncChatBannedPlayers;
		}
		
		public function CEventSyncChatBannedPlayers()
		{
			registerFieldForList("chat_ban_players", getQualifiedClassName(ChatBanPlayers), Descriptor.Compound, 1);
			registerFieldForList("perpetual_banchat_players", getQualifiedClassName(ChatBanPlayers), Descriptor.Compound, 2);
			registerField("sync_type", "", Descriptor.Int32, 3);
		}
		
		public var chat_ban_players : Array = new Array;
		public var perpetual_banchat_players : Array = new Array;
		public var sync_type : int;
	}
}
