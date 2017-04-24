package com.h3d.video
{
	/*
	** 这段代码没用了
	*/
	import com.h3d.audio.AudioEngine;
	
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	import com.h3d.util.Tracer;
	
	
	/**
	 * 
	 * 废弃
	 * 
	 */	
	public class SyncAudioVideo
	{
		private var _syncTimer:Timer;
		private var _stop:Boolean;
		private var _videoMgr:VideoMgr;
		private var _audioEngine:AudioEngine;
		
		private var _lastForceSyncTime:int;
		private var _lastCleanTime:int;
		
		private static const INTERNAL_TIME:int = 1*1*250;
		private static const TIME_ACC:int = 20;
		private static const SYNC_CLEANTIME:int = 5*1000;
		public static const SLOW_ACC:int = TIME_ACC/4;
		private static const FORCE_SYNC_TIME:int = 2*60*1000;
		
		public static const INTER_AS_SAME:int = 100;
		private static const INTER_INVALID:int = 3*60*1000;
		private static const INTER_FIRST_SYNC:int = 100;
		
		public function SyncAudioVideo()
		{
			_syncTimer = new Timer(1000);
			//_syncTimer.addEventListener(TimerEvent.TIMER, InternalSync);
			//_syncTimer.start();
			
			_stop = false;
			_lastForceSyncTime = 0;
			_lastCleanTime = 0;
		}
		
		public function init(videoMgr:VideoMgr, audioEngine:AudioEngine):Boolean {
			_videoMgr = videoMgr;
			_audioEngine = audioEngine;
			return true;
		}
		
		public function Stop():void {
			_syncTimer.stop();
			_syncTimer.removeEventListener(TimerEvent.TIMER, InternalSync);
		}
		
		private function InternalSync(param1:TimerEvent):void {
			//Tracer.log("SyncAudioVideo.InternalSync");
			
			return;
			
			var videoTimestamp:uint = getVideoDataTimestamp();
			var audioTimestamp:uint = getAudioDataTimestamp();
			
			if (videoTimestamp == 0 || audioTimestamp == 0) {
				return;
			}
			
			var diffTime:int = videoTimestamp - audioTimestamp;
			Tracer.log("InternalSync, diffTime:" + diffTime
				+ ", videoTimestamp:" + videoTimestamp
				+ ", audioTimestamp:" + audioTimestamp
				+ ", frameCount:" + _videoMgr.getFrameCount());
			
			//_videoMgr.setInterFrameInterTime(diffTime);
			
			// 正值为加速播放，负值为减速播放
			var actTime:int = 0;
			
			if (getTimer() - _lastForceSyncTime > FORCE_SYNC_TIME) {
				// 每2分钟强制同步一次
				// 此时，如果视频比音频快，把音频缓存的部分过时数据清理一下，不再播放过时数据，重新开始播
				if (diffTime > 0) {
					SetClearAudioData(diffTime);
				}
				
				_lastForceSyncTime = getTimer();
			}
			// 时间戳相差3分钟以上，可以视为无效时间戳，不做同步
			else if (diffTime > INTER_INVALID || diffTime < -INTER_INVALID) {
				//_videoMgr.setActTime(0);
				Tracer.log("actTime 0");
			}
			// 视频比音频快2s~3m
			else if (diffTime > INTER_AS_SAME * 20) {
				if (getTimer() - _lastCleanTime > SYNC_CLEANTIME) {
					SetClearAudioData(diffTime);
					_lastCleanTime = getTimer();
				}
			}
			// 视频比音频慢100ms以上
			else if (diffTime < -INTER_AS_SAME) {
				actTime = TIME_ACC+TIME_ACC*(-diffTime)/1000;
				//_videoMgr.setActTime(actTime);
				Tracer.log("actTime 1, " + actTime);
			}
			// 视频比音频快100ms以上（到2s）
			else if(diffTime > INTER_AS_SAME) {
				// 视频快500ms
				if (diffTime >= 2*INTERNAL_TIME && getTimer() - _lastCleanTime > SYNC_CLEANTIME*2) {
					if (_videoMgr.getFrameCount() > 20) {
						SetClearAudioData(diffTime);
					}
					_lastCleanTime = getTimer();
				}
				else if (diffTime >= 2*INTERNAL_TIME && getTimer() - _lastCleanTime > SYNC_CLEANTIME) {
					if (_videoMgr.getFrameCount() > 48) {
						SetClearAudioData(diffTime);
					}
					_lastCleanTime = getTimer();
				}
				
				// 视频慢播
				actTime = -TIME_ACC-TIME_ACC*diffTime/1000;
				//_videoMgr.setActTime(actTime);
				Tracer.log("actTime 2, " + actTime);
			}
			// 视频比音频慢100ms以内，时间相差在100ms以内视为时间上同步
			else if (diffTime >= -INTER_AS_SAME && diffTime <= 0) {
				//_videoMgr.setActTime(0);
				Tracer.log("actTime 3");
			}
		}
		
		private function getVideoDataTimestamp():uint {
			return _videoMgr.getDataTimestamp();
		}
		
		private function getAudioDataTimestamp():uint {
			return _audioEngine.getDataTimestamp();
		}
		
		private function SetClearAudioData(diffTime:int):void {
			_audioEngine.QuickPlay(diffTime);
		}
	}
}