package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventOperateVideoGuildInvite extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventOperateVideoGuildInvite;
		}
		
		public function CEventOperateVideoGuildInvite()
		{
			registerField("vgid", "", Descriptor.Int64, 1);
			registerField("op_type", "", Descriptor.Int32, 2);
			registerField("trans_id", "", Descriptor.Int64, 3);
			registerField("player_id", "", Descriptor.Int64, 4);
			registerField("inviter_id", "", Descriptor.Int64, 5);
			registerField("vip_level", "", Descriptor.Int32, 6);
			registerField("sex", "", Descriptor.Int32, 7);
			registerField("name", "", Descriptor.TypeString, 8);
			registerField("zname", "", Descriptor.TypeString, 9);
			registerField("player_qq", "", Descriptor.Int64, 10);
		}
		
		public var vgid : Int64 = new Int64();
		public var op_type : int;
		public var trans_id : Int64  = new Int64();;
		public var player_id : Int64  = new Int64();;
		public var inviter_id : Int64  = new Int64();;
		public var vip_level : int;
		public var sex : int;
		public var name : String = "";
		public var zname : String = "";
		public var player_qq : Int64  = new Int64();;
		
		public static const OVGI_Ignore:int = 0;//忽略掉，没有同意或者拒绝
		public static const OVGI_Accept:int = 1;  //同意
		public static const OVGI_Refuse:int = 2;  //拒绝
	}
}
