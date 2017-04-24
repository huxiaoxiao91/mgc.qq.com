package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.common.comdata.UserIdentity;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class CEventSendVideoGuildSignIn extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventSendVideoGuildSignIn;
		}
		
		public function CEventSendVideoGuildSignIn()
		{
			registerField("game_transid", "", Descriptor.Int64, 1);
			registerField("vgid", "", Descriptor.Int64, 2);
			registerField("sender_id", "", Descriptor.Int64, 3);
			registerField("room_id", "", Descriptor.Int32, 4);
			registerField("slef_score_add", "", Descriptor.Int32, 5);
			registerField("vg_wealth_add", "", Descriptor.Int32, 6);
			registerField("result", "", Descriptor.Int32, 7);
			registerField("cur_vg_wealth", "", Descriptor.Int32, 8);
			registerField("serial_id", "", Descriptor.Int32, 9);
			registerField("proxy_id", "", Descriptor.Int32, 10);
			registerField("tunnel_id", "", Descriptor.Int32, 11);
			registerField("uid", getQualifiedClassName(UserIdentity), Descriptor.Compound, 12);
			registerField("device_type", "", Descriptor.Int32, 13);
		}
		
		public var game_transid : Int64  = new Int64(); ;
		public var vgid : Int64  = new Int64();;
		public var sender_id : Int64  = new Int64();;
		public var room_id : int;
		public var slef_score_add : int;
		public var vg_wealth_add : int;
		public var result : int;
		public var cur_vg_wealth : int;
		public var serial_id : int;
		public var proxy_id : int;
		public var tunnel_id : int;
		public var uid :UserIdentity = new UserIdentity;
		public var device_type : int;
	}
}
