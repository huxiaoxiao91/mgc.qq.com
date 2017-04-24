package com.h3d.qqx5.modules.video_activity
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	public class ProgressToClient extends ProtoBufSerializable
	{
		public function ProgressToClient()
		{
			registerField("need_progress", "", Descriptor.Int64, 1);
			registerField("cur_progress", "", Descriptor.Int64, 2);
		}
		public var need_progress:Int64 = new Int64();
		public var cur_progress:Int64 = new Int64();
	}
}
