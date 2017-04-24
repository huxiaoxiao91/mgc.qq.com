package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.anchor_task.shared.event.AnchorTaskEventID;
	import com.h3d.qqx5.videoclient.data.CReward;

	import flash.utils.getQualifiedClassName;

	public class CEventAnchorTaskRewardNotifyNewRoleWeb extends INetMessage
	{
		public override function CLSID():int
		{
			return AnchorTaskEventID.CLSID_CEventAnchorTaskRewardNotifyNewRoleWeb;
		}

		public function CEventAnchorTaskRewardNotifyNewRoleWeb()
		{
			registerField("task_type", "", Descriptor.Int32, 1);
			registerFieldForList("rewards", getQualifiedClassName(CReward), Descriptor.Compound, 2);
			registerField("adv_guard_ratio", "", Descriptor.Int32, 3);
			registerField("buff_percent", "", Descriptor.Int32, 4);
			registerField("m_is_reissue", "", Descriptor.TypeBoolean, 5);
			registerField("vip_level", "", Descriptor.Int32, 6);
		}

		public var task_type:int;
		public var rewards:Array = new Array;
		public var adv_guard_ratio:int; //不大于1表示没有增加奖励倍数
		public var buff_percent:int; //
		public var m_is_reissue:Boolean;
		public var vip_level:int;// qgame奖励补发 贵族时使用

	}
}
