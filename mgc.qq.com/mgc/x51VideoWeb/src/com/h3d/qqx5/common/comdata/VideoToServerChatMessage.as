package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class VideoToServerChatMessage extends ProtoBufSerializable
	{
		
		public function VideoToServerChatMessage()
		{
			registerField("sender_ID", "", Descriptor.Int64, 1);
			registerField("recver_id","",Descriptor.Int64, 2);
			registerField("message", "", Descriptor.TypeString, 3);
			registerField("type", "", Descriptor.Int32, 4);
			registerField("roomid", "", Descriptor.Int32, 5);
			registerField("serial_id", "", Descriptor.Int32, 6);
			registerField("videoguild_id", "", Descriptor.Int64, 7);
			registerField("open_id", "", Descriptor.TypeString, 8);
			registerField("open_key", "", Descriptor.TypeString, 9);
			registerField("pay_token", "", Descriptor.TypeString, 10);
			registerField("pf", "", Descriptor.TypeString, 11);
			registerField("pf_key", "", Descriptor.TypeString, 12);
			registerField("price", "", Descriptor.Int32, 13);//弹幕价格
			registerField("recver_zoneName", "", Descriptor.TypeString, 14);//接收者大区名，只pc手动输入昵称时使用
			registerField("recver_name", "", Descriptor.TypeString, 15);//接收者昵称，只pc手动输入昵称时使用
		}
		
		public var sender_ID : Int64 = new Int64(0,0);
		public var recver_id : Int64 = new Int64(0,0);
		public var message : String ="";
		public var type : int;
		public var roomid : int;
		public var serial_id : int;
		public var videoguild_id : Int64 = new Int64(0,0);
		public var open_id : String = "";
		public var open_key : String ="";
		public var pay_token : String ="";
		public var pf : String ="";
		public var pf_key : String ="";
		public var price : int;
		public var recver_zoneName : String="";
		public var recver_name : String ="" ;
	}
}
