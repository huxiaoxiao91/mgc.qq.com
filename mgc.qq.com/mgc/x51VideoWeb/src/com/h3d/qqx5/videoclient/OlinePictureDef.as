package com.h3d.qqx5.videoclient
{
	/**
	 * @author liuchui
	 */
	public class OlinePictureDef
	{
		private static const OLINE_PICTURE_BUSINESS_ID:String = "qdancer";
		private static const ADDITION_VALUE:int = 150064760;
		private static const OriginalPicSizeSubpath:String = "0";
		
		private static function GetZoneStr(zoneid:int):String
		{
			return "zone_" + zoneid;
		}
		
		public static function GetVideoRoomSnapShotUrl(domain:String, zoneid:int, roomid_as_qq:Number):String
		{
			return domain + "/" + 
				OLINE_PICTURE_BUSINESS_ID + "/" + 
				(roomid_as_qq + ADDITION_VALUE) + "/" + 
				GetVideoRoomSnapShotFileName(zoneid, roomid_as_qq + ADDITION_VALUE) + "/" +
				OriginalPicSizeSubpath;
		}
		
		public static function GetVideoRoomPictureDownloadUrl(domain:String, zoneid:int, roomid_as_qq:Number, pic_index:int):String
		{
			return domain + "/" + 
				OLINE_PICTURE_BUSINESS_ID + "/" + 
				roomid_as_qq + "/" + 
				GetVideoRoomPictureFileName(zoneid, roomid_as_qq, pic_index) + "/" +
				OriginalPicSizeSubpath;
		}
		
		public static function GetVideoAnchorImageDownloadUrl(domain:String, zoneid:int, qq:Number):String
		{
			return domain + "/" + 
				OLINE_PICTURE_BUSINESS_ID + "/" + 
				qq + "/" + 
				GetVideoAnchorImageFileName(zoneid, qq) + "/" +
				OriginalPicSizeSubpath;
		}
		
		public static function GetVideoPlayerCardPortraitUrl(domain:String, zoneid:int, qq:Number):String
		{
			return domain + "/" + 
				OLINE_PICTURE_BUSINESS_ID + "/" + 
				qq + "/" + 
				GetVideoPlayerCardPortraitFileName(zoneid, qq) + "/" +
				OriginalPicSizeSubpath;
		}
		
		public static function GetVideoAnchorPortraitDownloadUrl(domain:String, zoneid:int, qq:Number):String
		{
			return domain + "/" + 
				OLINE_PICTURE_BUSINESS_ID + "/" + 
				qq + "/" + 
				GetVideoAnchorPortraitFileName(zoneid, qq) + "/" +
				OriginalPicSizeSubpath;
		}
		
		private static function GetVideoRoomSnapShotFileName(zoneid:int, roomid_as_qq:Number):String
		{
			return (GetZoneStr(zoneid) +  // zone_0(视频区的zoneid目前==0)
				"_room_snapshot_" +       
				roomid_as_qq +"_0"+            // 3
				".jpg"            
			);
		}
		
		private static function GetVideoRoomPictureFileName(zoneid:int, roomid_as_qq:Number, pic_index:int):String
		{
			return ( GetZoneStr(zoneid) +  // zone_1111
				"_room_picture_" +       
				roomid_as_qq +                 // 12345
				"_" + 
				pic_index +
				".jpg"            
			);
		}
		
		private static function GetVideoAnchorImageFileName(zoneid:int, qq:Number):String
		{
			return (GetZoneStr(zoneid) +
				"_anchor_image_" +       
				qq + 
				".jpg"            
			);
		}
		
		private static function GetVideoPlayerCardPortraitFileName(zoneid:int, qq:Number):String
		{
			return (GetZoneStr(zoneid) +
				"_pcp_" +       
				qq + 
				".jpg"            
			);
		}
		
		private static function GetVideoAnchorPortraitFileName(zoneid:int, qq:Number):String
		{
			return (GetZoneStr(zoneid) +
				"_anchor_portrait_" +       
				qq + 
				".jpg"            
			);
		}
	}	
}