package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.AnchorData2;
	import com.h3d.qqx5.common.comdata.DiceGiftExtInfo;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.NetBuffer;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;

	public class CEventVideoSendGiftResult extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoSendGiftResult;
		}
		
		public function CEventVideoSendGiftResult()
		{
			registerField("result", "", Descriptor.Int32, 1);
			registerField("sender_id", "", Descriptor.Int64, 2);
			registerField("gift_id", "", Descriptor.Int32, 3);
			registerField("gift_count", "", Descriptor.Int32, 4);
//			registerField("room_id", "", Descriptor.Int32, 5);
//			registerField("zone_id", "", Descriptor.Int32, 6);
//			registerField("sender_qq", "", Descriptor.Int64, 7);			
			registerField("anchor_qq", "", Descriptor.Int64, 8);
			registerField("zone_name", "", Descriptor.TypeString, 9);
			registerField("sender_name", "", Descriptor.TypeString, 10);
//			registerField("sender_ip", "", Descriptor.TypeString, 11);
			registerField("anchor_name", "", Descriptor.TypeString, 12);
//			registerField("avatar", "", Descriptor.TypeNetBuffer, 13, function(obj:Object):Boolean{return obj.has_avatar;});
//			registerField("sender_sex", "", Descriptor.Int32, 14);
//			registerField("sender_level", "", Descriptor.Int32, 15);	
//			registerField("has_avatar", "", Descriptor.TypeBoolean, 16);
			registerField("anchor_data", getQualifiedClassName(AnchorData2), Descriptor.Compound, 17);
			registerField("gift_name", "", Descriptor.TypeString, 18);
//			registerField("videoguild_id", "", Descriptor.Int64, 19);
//			registerField("cost_member_score", "", Descriptor.Int32, 20);
//			registerField("price", "", Descriptor.Int32, 21);
//			registerField("starlight", "", Descriptor.Int32, 22);
			registerField("vip_level", "", Descriptor.Int32, 23);
			registerField("trans_id", "", Descriptor.Int64, 24);
			registerField("diamond_balance", "", Descriptor.Int32, 25);
			registerField("res_ext", "", Descriptor.Int32, 26);
			registerField("reason_ext", "", Descriptor.TypeString, 27);
			registerField("support_degree_add", "", Descriptor.Int32, 28);
			registerField("invisible", "", Descriptor.TypeBoolean, 29);
			registerField("video_money", "", Descriptor.Int32, 30);
			registerField("guard_level", "", Descriptor.Int32, 31);
			registerField("nest_credit_level", "", Descriptor.Int32, 32);
			registerField("continuous_send_gift_times", "", Descriptor.Int32, 33);
			registerField("anchor_exp", "", Descriptor.Int32, 34);
			registerField("wealth_level", "", Descriptor.Int32, 35);
			
			registerField("m_gift_ext_info","", Descriptor.TypeNetBuffer, 36);
			registerField("source", "", Descriptor.Int32, 37);
		}
		
		public var result : int;
		public var sender_id : Int64;
		public var gift_id : int;
		public var gift_count : int;
//		public var room_id : int;
//		public var zone_id : int;
//		public var sender_qq : Int64;
		public var anchor_qq : Int64;
		public var zone_name : String = "";
		public var sender_name : String = "";
//		public var sender_ip : String;
		public var anchor_name : String = "";
//		public var avatar :NetBuffer;
//		public var sender_sex : int;
//		public var sender_level : int;
//		public var has_avatar : Boolean;
		public var anchor_data : AnchorData2 = new AnchorData2;
		public var gift_name : String = "";
//		public var videoguild_id : Int64;
//		public var cost_member_score : int;
//		public var price : int;
//		public var starlight : int;
		public var trans_id : Int64;
		public var diamond_balance : int;
		public var vip_level : int;
		public var res_ext : int;
		public var reason_ext : String = "";
		public var support_degree_add : int;
		public var invisible : Boolean;
		public var video_money:int ;//梦幻币
		public var guard_level:int ;//送礼者贵族等级
		public var nest_credit_level:int;//小窝头衔等级
		public var continuous_send_gift_times:int;//连送次数
		public var anchor_exp:int;//本次送礼增加了多少主播经验值
		public var wealth_level:int;//财富等级
		public var m_gift_ext_info:NetBuffer;
		/**
		 * 礼物来源
		 */
		public var source:int;

		//VideoGiftSource
		public static const VGS_SEND:int       = 0;
		public static const VGS_LUCKY_DRAW:int = 1;
	}
}
