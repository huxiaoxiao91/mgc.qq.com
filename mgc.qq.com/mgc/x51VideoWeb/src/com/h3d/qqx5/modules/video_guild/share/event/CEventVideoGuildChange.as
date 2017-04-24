package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventVideoGuildChange extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildChange;
		}
		
		public function CEventVideoGuildChange()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("type", "", Descriptor.Int32, 2);
			registerField("string1", "", Descriptor.TypeString, 3);
			registerField("string2", "", Descriptor.TypeString, 4);
		}
		
		public var player_id : Int64 = new Int64();
		public var type : int;
		public var string1 : String = "";//被传位时，表示老团长昵称，被踢出时 表示团名 传位时表示新团长昵称
		public var string2 : String = "";//被传位时  表示老团账所在大区，穿卫视表示新团长所在大区名
		
		public static const BeKicked:int = 0;//被踢
		public static const Demise:int = 1;//传位操作
		public static const BeDismissed:int = 2;//被传位
		public static const Disbanded:int = 3;//团解散
	}
}
