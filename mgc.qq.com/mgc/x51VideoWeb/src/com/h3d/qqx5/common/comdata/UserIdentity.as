package com.h3d.qqx5.common.comdata {

	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	/**
	 * @author liuchui
	 */
	public class UserIdentity extends ProtoBufSerializable {
		public function UserIdentity() {
			registerField("account", "", Descriptor.Int64, 1);
			registerField("channel", "", Descriptor.Int32, 2);
			registerField("zoneid", "", Descriptor.Int32, 3);
		}

		public var account:Int64 = new Int64(0, 0);
		public var channel:int   = 0;
		public var zoneid:int    = 0;
	}
}
