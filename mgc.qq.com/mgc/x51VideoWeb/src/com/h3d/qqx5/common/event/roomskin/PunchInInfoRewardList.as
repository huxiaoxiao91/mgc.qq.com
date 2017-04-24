package com.h3d.qqx5.common.event.roomskin {

	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.videoclient.data.CReward;

	import flash.utils.getQualifiedClassName;

	public class PunchInInfoRewardList extends ProtoBufSerializable {
		public function PunchInInfoRewardList() {
			super();
			registerFieldForList("rewards", getQualifiedClassName(CReward), Descriptor.Compound, 1);
		}

		override public function isPureContainerWrapper():Boolean {
			return true;
		}

		public var rewards:Array = new Array();
	}
}
