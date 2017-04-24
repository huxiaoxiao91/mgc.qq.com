package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.anchor_task.shared.event.AnchorTaskEventID;
	import com.h3d.qqx5.videoclient.data.CReward;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventQueryAnchorTaskNewRoleResWeb extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorTaskEventID.CLSID_CEventQueryAnchorTaskNewRoleResWeb;
		}
		public function CEventQueryAnchorTaskNewRoleResWeb()
		{
			registerField("stat", "", Descriptor.Int32, 1);
			registerField("description", "", Descriptor.TypeString, 2);
			registerFieldForList("rewards",getQualifiedClassName(CReward), Descriptor.Compound, 3);
			registerField("adv_guard_ratio", "", Descriptor.Int32, 4);
			registerField("buff_percent", "", Descriptor.Int32, 5);
		}
		public var stat:int;
		public var description:String = "";
		public var rewards:Array = new Array;
		public var adv_guard_ratio:int;//不大于1表示没有增加奖励倍数
		public var buff_percent:int;//主播等级给予的额外奖励
	}
}
