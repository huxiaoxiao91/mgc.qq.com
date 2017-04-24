package com.h3d.qqx5.common.comdata {

	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;

	import flash.utils.getQualifiedClassName;

	/**
	 * 房间列表数据
	 * @author gaolei
	 *
	 */
	public class RoomProxyInfo extends ProtoBufSerializable {
		public function RoomProxyInfo() {
			registerField("name", "", Descriptor.TypeString, 1);
			registerField("provider", "", Descriptor.TypeString, 2);
			registerField("group", "", Descriptor.TypeString, 3);
			registerField("recommend", "", Descriptor.TypeBoolean, 4);
			registerField("zoneid", "", Descriptor.Int32, 5);
			registerFieldForList("addresses", getQualifiedClassName(RoomProxyAddress), Descriptor.Compound, 6);
			registerField("channel", "", Descriptor.Int32, 7);
		}

		public var name:String     = "";
		public var provider:String = "";
		public var group:String    = "";
		public var recommend:Boolean;
		public var zoneid:int;
		public var addresses:Array = [];
		public var channel:int;
	}
}
