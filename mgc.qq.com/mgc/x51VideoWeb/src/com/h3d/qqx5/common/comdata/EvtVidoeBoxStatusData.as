package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	public class EvtVidoeBoxStatusData extends ProtoBufSerializable
	{
		
		public function EvtVidoeBoxStatusData()
		{
			registerField("boxID", "", Descriptor.Int32, 1);
			registerField("requireHeight", "", Descriptor.Int32, 2);
			registerField("hasBeenOpened", "", Descriptor.TypeBoolean, 3);
		}
		
		public var boxID : int;
		public var requireHeight : int;
		public var hasBeenOpened : Boolean;
	}
}
