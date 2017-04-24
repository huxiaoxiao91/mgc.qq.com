package com.h3d.qqx5.video_service.serviceinf
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.videoclient.data.SplitScreenInfo;
	import com.h3d.qqx5.videoclient.data.VideoResolution;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	public class VideoRoomLiveStatus extends ProtoBufSerializable
	{
		public function VideoRoomLiveStatus()
		{
			registerField("vid", "", Descriptor.Int32, 1);
			registerField("anchor_pstid", "", Descriptor.Int64, 2);
			registerField("start_time", "", Descriptor.Int32, 3);
			registerFieldForDict("extra_vid", "", Descriptor.Int32, "", Descriptor.Int32, 4);
			registerField("m_anchor_url", "", Descriptor.TypeString, 5);
			registerFieldForDict("vid_resolutions", "", Descriptor.Int32, getQualifiedClassName(VideoResolution), Descriptor.Compound, 6);
			registerField("fps", "", Descriptor.Int32, 7);
			registerField("anchor_device_type", "", Descriptor.Int32, 8);
			registerField("is_vertical_live", "", Descriptor.TypeBoolean, 9);
		}
		
		public var vid : int;
		public var anchor_pstid : Int64 = new Int64(0,0);
		public var start_time : int;
		public var extra_vid:Dictionary = new Dictionary;
		public var m_anchor_url:String = "";
		public var vid_resolutions:Dictionary;
		public var fps:int;
		/**
		 *  主播端类型
		 *  CDT_INVALID = -1,
		 *  CDT_PC = 0,
		 *  CDT_Android,
		 *	CDT_WEB,
		 *	CDT_SDK,
		 *	CDT_QGAME,
		 *	CDT_IFRAME,
		 *	CDT_X52,
		 *	CDT_IOS
		 */
		public var anchor_device_type:int = -1;
		//主播选择横屏还是竖屏
		public var is_vertical_live : Boolean = false;

		public function equal(other:VideoRoomLiveStatus):Boolean
		{
			return this.vid == other.vid && this.anchor_pstid.equal(other.anchor_pstid) && this.start_time == other.start_time;
		}
	}
}
