package com.h3d.qqx5.common.comdata {

	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.videoclient.data.CreditsLevel;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	public class VideoCharInfo extends ProtoBufSerializable {
		public function VideoCharInfo() {
			super();
			
			registerField("pstid", "", Descriptor.Int64, 1);
			registerField("card_signature_str", "", Descriptor.TypeString, 2);
			registerField("last_logout_time", "", Descriptor.Int32, 3);
			registerField("last_login_time", "", Descriptor.Int32, 4);
			registerField("data_version", "", Descriptor.Int32, 5);
			registerField("have_portrait", "", Descriptor.Int32, 6);
			registerField("video_room_wealth", "", Descriptor.Int64, 7);
			registerField("nick_str", "", Descriptor.TypeString, 8);
			registerField("free_gift_count", "", Descriptor.Int32, 9);
			registerField("free_gift_gained", "", Descriptor.Int32, 10);
			registerField("daily_update_time", "", Descriptor.Int32, 11);
			registerField("gender", "", Descriptor.Int32, 12);
			registerField("money", "", Descriptor.Int32, 13);
			registerField("player_flags", "", Descriptor.UInt32, 14);
			registerField("vgid", "", Descriptor.Int64, 15);
			registerField("last_dianzan_t", "", Descriptor.Int32, 16);
			registerField("anchor_pk_activity_id", "", Descriptor.Int32, 17);
			registerField("anchor_pk_contribution", "", Descriptor.Int64, 18);
			registerFieldForList("finished_anchor_task_id", "", Descriptor.Int64, 20);
			registerField("forbid_talk_all_room", "", Descriptor.TypeBoolean, 21);
			registerFieldForList("normal_support_rooms", "", Descriptor.Int32, 22);
			registerFieldForDict("nest_task_state", "", Descriptor.Int32, getQualifiedClassName(NestTaskOnServerPlayer), Descriptor.Compound, 23);
			registerFieldForDict("impressions", "", Descriptor.Int64, "", Descriptor.Int64, 24);
			registerFieldForDict("nest_credits_levels", "", Descriptor.Int32, getQualifiedClassName(CreditsLevel), Descriptor.Compound, 25); // 各个小窝中的积分头衔
			
			registerFieldForDict("video_gifts","",Descriptor.Int32,"",Descriptor.Int32,30);
			
			registerField("skin_gifts", getQualifiedClassName(SkinGifts), Descriptor.Compound, 54);
		}

		public var pstid:Int64                    = new Int64();
		public var card_signature_str:String      = "";
		public var last_logout_time:int;
		public var last_login_time:int;
		public var data_version:int;
		public var have_portrait:int;
		public var video_room_wealth:Int64        = new Int64();
		public var nick_str:String                = "";
		public var free_gift_count:int;
		public var free_gift_gained:int;
		public var daily_update_time:int;
		public var gender:int;
		public var money:int;
		public var player_flags:uint;
		public var vgid:Int64                     = new Int64();
		public var last_dianzan_t:int;
		public var anchor_pk_activity_id:int;
		public var anchor_pk_contribution:Int64   = new Int64();
		public var finished_anchor_task_id:Array  = new Array;
		public var forbid_talk_all_room:Boolean;
		public var normal_support_rooms:Array     = new Array;
		public var nest_task_state:Dictionary     = new Dictionary;
		public var impressions:Dictionary         = new Dictionary;
		public var nest_credits_levels:Dictionary = new Dictionary();
		public var video_gifts:Dictionary = new Dictionary();

		public var skin_gifts:SkinGifts           = new SkinGifts();


		public function IsInvisible():Boolean {
			return (player_flags & 0x2) ? true : false;
		}

		public function SetInvisible(invisible:Boolean):void {
			if (invisible) {
				player_flags = (player_flags | 0x2);
			} else {
				player_flags = (player_flags & ~0x2);
			}
		}
	}
}
