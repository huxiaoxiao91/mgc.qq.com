package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;

	public class AnchorGuild extends ProtoBufSerializable
	{
		
		public function AnchorGuild()
		{
			registerField("guild_id", "", Descriptor.Int64, 1);
			registerField("active_score", "", Descriptor.Int64, 2);
			registerField("contribution_last_month", "", Descriptor.Int64, 3);
			registerField("contribution_curr_month", "", Descriptor.Int64, 4);
			registerField("welfare_curr_month", "", Descriptor.Int64, 5);
			registerField("guild_name", "", Descriptor.TypeString, 6);
		}
		
		public var guild_id : Int64;
		public var active_score : Int64;
		public var contribution_last_month : Int64;
		public var contribution_curr_month : Int64;
		public var welfare_curr_month : Int64;
		public var guild_name : String = "";
	}
}
