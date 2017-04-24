package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.anchor_nest.share.AnchorNestAdvSupport;
	import com.h3d.qqx5.modules.nest_task.shared.NestTaskInfo;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	public class CEventAnchorNestGetSupportUIInfoRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventAnchorNestGetSupportUIInfoRes;
		}
		
		public function CEventAnchorNestGetSupportUIInfoRes()
		{
			registerField("result", "", Descriptor.Int32, 1);
			registerField("popularity", "", Descriptor.Int64, 2);
			registerField("num", "", Descriptor.Int32, 3);
			registerField("gap", "", Descriptor.Int64, 4);
			registerField("daily_reduce", "", Descriptor.Int32, 5);
			registerField("owner_qq", "", Descriptor.Int64, 6);
			registerField("player_id", "", Descriptor.Int64, 7);
			registerField("star", "", Descriptor.Int64, 8);
			registerFieldForDict("adv_logs", "",Descriptor.Int64, getQualifiedClassName(AnchorNestAdvSupport),Descriptor.Compound, 9);
			registerField("normal_support_today", "", Descriptor.TypeBoolean, 10);
			registerField("is_publish_nest_task", "", Descriptor.TypeBoolean, 11);
			registerFieldForList("task_list", getQualifiedClassName(NestTaskInfo), Descriptor.Compound, 12);
			registerField("load_adv_rank", "", Descriptor.TypeBoolean, 13);
		}
		
		public var result :int;
		public var popularity : Int64 = new Int64(0,0);
		public var num : int;
		public var gap : Int64= new Int64(0,0);
		public var daily_reduce : int;
		public var owner_qq : Int64= new Int64(0,0);
		public var player_id : Int64= new Int64(0,0);
		public var star : Int64= new Int64(0,0);
		public var adv_logs :Dictionary = new Dictionary();
		public var normal_support_today : Boolean;
		public var is_publish_nest_task : Boolean;
		public var task_list :Array = new Array();
		public var load_adv_rank : Boolean;
	}
}
