package com.h3d.qqx5.modules.nest_task.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.videoclient.data.CReward;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventQueryNestTaskRewardNewRoleRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestTaskEventID.CLSID_CEventQueryNestTaskRewardNewRoleRes;
		}
		public function CEventQueryNestTaskRewardNewRoleRes()
		{
			registerField("index", "", Descriptor.Int32, 1);
			registerFieldForList("rewards", "", Descriptor.TypeString, 2);
			registerField("is_treasure_box", "", Descriptor.TypeBoolean, 3);
			registerFieldForList("rewards_web",  getQualifiedClassName(CReward),Descriptor.Compound, 4);
		}
		public var index:int;
		public var rewards:Array= new Array;
		public var is_treasure_box:Boolean;
		public var rewards_web:Array= new Array;
	}
}