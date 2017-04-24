package com.h3d.qqx5.common.comdata {

	public class VideoChannelType {
		public static const VCT_INVALID:int = -1;
		public static const VCT_X5:int      = 0; //炫舞一
		public static const VCT_GUEST:int   = 1; //游客
		public static const VCT_VIDEO:int   = 2; //视频
		public static const VCT_QGAME:int   = 3; //QGame
		public static const VCT_X52:int     = 4; //炫舞2

		//是否需要向server查询奖励
		public static function IsQueryReaward(channel:int):Boolean {
			if (channel == VideoChannelType.VCT_QGAME) {
				return true;
			} else if (channel == VideoChannelType.VCT_X5) {
				return true;
			} else if(channel == VideoChannelType.VCT_X52) {
				return true;
			} else {
				return false;
			}
		}
	}

}