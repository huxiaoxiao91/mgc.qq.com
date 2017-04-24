package com.h3d.audio
{
	import com.h3d.audio.AudioTrack;
	import com.h3d.util.Tracer;
	import com.h3d.video.VideoMgr;
	import com.junkbyte.console.Cc;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/*
	** 音频对VideoEngine提供的接口
	*/
	public class AudioEngine
	{
		private var m_audio_track:AudioTrack = null;
		
		private static const CT_SINGER:uint = 0;
		private static const CT_SPEAKER:uint = 1;
		
		public function AudioEngine()
		{
			m_audio_track = new AudioTrack();
		}
		
		public function getDataTimestamp():int
		{
			return m_audio_track.getDataTimestamp();
		}
		
		public function update():void 
		{
			//m_audio_track.playAudio();
		}
		
		public function QuickPlay(time:int):void
		{
			m_audio_track.QuickPlay(time);
		}
		
		public function popFrontBlock():ByteArray {
			return m_audio_track.GetPcmBlock();
		}
		
		/**
		 *
		 * 获取音频缓存的帧数 
		 * @return 
		 * 
		 */		
		public function GetBlockCount():uint {
			return m_audio_track.GetPcmBlockCount();
		}
		
		public function SetBeginTime(tm:int):void {
			m_audio_track.SetBeginTime(tm);
		}
		
		public function GetBuffInterval():int {
			return m_audio_track.getBuffInterval();
		}
		
		public function ReceiveData(data:ByteArray):void
		{
			data.endian = Endian.LITTLE_ENDIAN;
			var data_type:uint = data.readUnsignedInt();
			if (data_type == CT_SINGER)
			{
				m_audio_track.ReceiveData(data);
			}
			else if (data_type == CT_SPEAKER)
			{
				// 副麦	
			}
			
			//Tracer.log("AudioEngine receive data");
			//Cc.log("获取音频",(new Date).time);
		}
	}
}