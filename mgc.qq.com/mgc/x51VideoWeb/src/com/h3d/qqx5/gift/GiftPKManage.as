package com.h3d.qqx5.gift
{
	import com.h3d.qqx5.TimerBase;
	import com.h3d.qqx5.common.comdata.VideoPKGiftInfo;
	import com.h3d.qqx5.videoclient.interfaces.IUIAnchorNest;
	import com.h3d.qqx5.x51VideoWeb;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class GiftPKManage
	{
		private var timer:Timer = new Timer(1000);
		
		public var videoPKGiftInfoList:Array = [];
		
		private var _videoPKGiftInfoListForUI:Array = [];
		
		private var client:x51VideoWeb;
		
		public function GiftPKManage(_client:x51VideoWeb)
		{
			client = _client;
			
			timer.addEventListener(TimerEvent.TIMER,updata);
			timer.start();
		}

		private function updata(e:Event = null):void
		{
			var serverTime:int = client.m_videoClient.GetCX5VideoClient().GetServerTime();
			var tempArr:Array = _videoPKGiftInfoListForUI;
			_videoPKGiftInfoListForUI = [];
			
			for(var i:int = 0;i<videoPKGiftInfoList.length;i++)
			{
				var videoPKGiftInfo:VideoPKGiftInfo = videoPKGiftInfoList[i] as VideoPKGiftInfo;
				if((videoPKGiftInfo.begin_time <= serverTime) && (videoPKGiftInfo.end_time >= serverTime))
				{
					_videoPKGiftInfoListForUI.push(videoPKGiftInfo.gift_id);
				}
			}
			
			if(!judgeArr(tempArr,_videoPKGiftInfoListForUI))
			{
				client.onRefreshPkGiftForUI(_videoPKGiftInfoListForUI);
			}
		}
		
		public function get videoPKGiftInfoListForUI():Array
		{
			updata();
			return _videoPKGiftInfoListForUI;
		}
		
		/**
		 * 比较两个数组相等
		 */
		private function judgeArr(arr1:Array,arr2:Array):Boolean
		{
			var len1:int = arr1.length;
			var len2:int = arr2.length;
			if (len1!=len2)
			{
				return false;
			}
			else
			{
				for (var i:int=0; i<len1; i++)
				{	
					var len:int = arr1.indexOf(arr2[i]);
					if (len<0)
					{
						return false;
					}
					
				}
				return true;
			}
		}

	}
}