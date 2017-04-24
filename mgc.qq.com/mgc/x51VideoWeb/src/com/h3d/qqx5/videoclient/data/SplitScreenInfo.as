package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class SplitScreenInfo extends ProtoBufSerializable
	{
		public function SplitScreenInfo()
		{
			registerField("status", "", Descriptor.Int32, 1);
			registerField("vid", "", Descriptor.Int32, 2);
			registerField("anchorName", "", Descriptor.TypeString, 3);
			registerField("anchorId", "", Descriptor.Int64, 4);
		}
		public var status:int = SplitScreenStatus.SSS_Close;
		public var vid:int = 0;
		public var anchorName:String = "";
		public var anchorId:Int64 = new Int64();
	}
}