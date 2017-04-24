package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	public class TagInfo extends INetMessage
	{
		public function TagInfo()
		{
			registerField("tag_id","",Descriptor.Int32,1);
			registerField("tag_name","",Descriptor.TypeString,2);
			registerField("tag_url","",Descriptor.TypeString,3);
		}
		public var tag_id:int;
		public var tag_name:String = "";
		public var tag_url:String = "";
	}
}