package com.h3d.qqx5.common.event {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoVersion;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	public class CEventVideoClientSigVerifyRes extends INetMessage {
		public override function CLSID():int {
			return EEventIDVideoVersion.CLSID_CEventVideoClientSigVerifyRes;
		}

		public function CEventVideoClientSigVerifyRes() {
			registerField("res", "", Descriptor.Int32, 1);
		}

		public var res:int;
	}
}
