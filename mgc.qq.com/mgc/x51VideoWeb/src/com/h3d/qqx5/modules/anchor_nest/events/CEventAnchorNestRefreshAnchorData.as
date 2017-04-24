package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.common.comdata.AnchorData;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.video_service.serviceinf.AnchorImpressionDataServer;
	
	import flash.utils.getQualifiedClassName;
	public class CEventAnchorNestRefreshAnchorData extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventAnchorNestRefreshAnchorData;
		}
		
		public function CEventAnchorNestRefreshAnchorData()
		{
			registerField("anchor_data", getQualifiedClassName(AnchorData), Descriptor.Compound, 1);
			registerField("anchor_intro", "", Descriptor.TypeString, 2);
			registerField("anchor_ipr", getQualifiedClassName(AnchorImpressionDataServer), Descriptor.Compound, 3);
			registerField("anchor_name", "", Descriptor.TypeString, 4);
			registerField("is_with_dance_mark", "", Descriptor.TypeBoolean, 5);
			registerField("is_anchor_pk_anchor", "", Descriptor.TypeBoolean, 6);
			registerField("botteneck_gift_id", "", Descriptor.Int32, 7);
			registerField("bottleneck_need_count", "", Descriptor.Int32, 8);
			registerField("levelup_need_exp", "", Descriptor.Int32, 9);
			registerField("starlight_rest_exp_today", "", Descriptor.Int32, 10);
			registerField("dream_gift_rest_exp_today", "", Descriptor.Int32, 11);
			registerField("anchor_badge", "", Descriptor.Int32,12);
			registerField("lucky_draw_rest_exp_today", "", Descriptor.Int32,13);
		}
		
		public var anchor_data :AnchorData = new AnchorData;
		public var anchor_intro : String = "";
		public var anchor_ipr : AnchorImpressionDataServer = new AnchorImpressionDataServer;
		public var anchor_name : String = "" ;
		public var is_with_dance_mark : Boolean = false;
		public var is_anchor_pk_anchor:Boolean;
		public var botteneck_gift_id:int;//瓶颈需要的礼物id
		public var bottleneck_need_count:int;//瓶颈需要的礼物id数量
		public var levelup_need_exp:int;//为-1表示满级
		public var dream_gift_rest_exp_today:int;//今日收梦幻币礼物还可增加的主播经验值
		public var starlight_rest_exp_today:int;//今日通过涨星耀值还可增加的主播经验值
		public var anchor_badge:int;
		public var lucky_draw_rest_exp_today:int;
	}
}
