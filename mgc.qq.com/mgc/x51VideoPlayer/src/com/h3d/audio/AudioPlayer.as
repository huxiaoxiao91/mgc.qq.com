package com.h3d.audio
{
	/*
	** 这段代码没用了
	*/
	import flash.net.NetStream;
	import flash.net.NetConnection;
	import flash.utils.Timer;
	import flash.events.NetStatusEvent;
	import flash.net.NetStreamAppendBytesAction;
	import flash.media.SoundTransform;
	import flash.utils.ByteArray;
	import com.h3d.flv.FlvWrapper;
	import com.h3d.util.Tracer;
	
	public class AudioPlayer
	{
		private static const LOGFILTER:String = "AudioPlayer: ";
		
		private var m_play_stream:NetStream = null;
		
		private var m_play_link:NetConnection = null;
		
		private var m_playing:Boolean = false;
		
		public function AudioPlayer()
		{
		}
		
		public function init() : void
		{
			this.m_play_link = new NetConnection();
			this.m_play_link.client = this;
			this.m_play_link.connect(null);
			this.m_play_stream = new NetStream(this.m_play_link);
			this.m_play_stream.addEventListener(NetStatusEvent.NET_STATUS,this.onPlayStreamStatus);
			this.m_play_stream.dataReliable = false;
			this.m_play_stream.bufferTime = 0;
			this.m_play_stream.client = this;
			this.m_play_stream.checkPolicyFile = false;
			this.m_play_stream.play(null);
			this.m_play_stream.appendBytes(FlvWrapper.getHeader());
			//this.m_play_stream.pause();
		}
		
		public function add_data(data:ByteArray) : void
		{
			this.m_play_stream.appendBytes(data);
		}
		
		
		public function getPlayTime() : Number
		{
			return this.m_play_stream.time;
		}
		
		public function getDelayTime() : uint
		{
			return 1200;
		}
		
		public function flush() : void
		{
			this.m_play_stream.seek(0);
			this.m_play_stream.appendBytesAction(NetStreamAppendBytesAction.RESET_SEEK);
		}
		
		public function adjustVolume(param1:Number) : void
		{
			var _loc2_:SoundTransform = this.m_play_stream.soundTransform;
			_loc2_.volume = param1;
			this.m_play_stream.soundTransform = _loc2_;
		}
		
		public function isPlaying() : Boolean
		{
			return this.m_playing;
		}
		
		public function close() : void
		{
			Tracer.error(LOGFILTER + "AudioPlayer.close");
			this.m_play_stream.close();
			this.m_play_link.close();
		}
		
		public function dispose() : void
		{
			Tracer.error(LOGFILTER + "AudioPlayer.dispose");
			this.m_play_stream.close();
			this.m_play_stream.removeEventListener(NetStatusEvent.NET_STATUS,this.onPlayStreamStatus);
			this.m_play_stream = null;
			this.m_play_link.close();
			this.m_play_link = null;
		}
		
		public function play() : void
		{
			if (!isPlaying())
				this.m_play_stream.resume();
			
		}
		
		public function reset() : void
		{
			this.m_play_stream.close();
			this.m_play_stream.play(null);
			this.m_play_stream.appendBytes(FlvWrapper.getHeader());
		}
		
		public function pause() : void
		{
			this.m_play_stream.pause();
		}
		
		public function resume() : void
		{
			this.m_play_stream.resume();
		}
		
		public function getPlayStream() : NetStream
		{
			return this.m_play_stream;
		}
		
		public function getBufLen() : Number
		{
			return this.m_play_stream.bufferLength;
		}
		
		public function clearPlayStream(param1:uint) : void
		{
			this.m_play_stream.close();
			this.m_play_stream.play(null);
			this.m_play_stream.appendBytes(FlvWrapper.getHeader());
			Tracer.error(LOGFILTER + "AudioPlayer.clearPlayStream, audio jitter buffer reset, uid=" + param1);
		}
		
		private function onPlayStreamStatus(param1:NetStatusEvent) : void
		{
			if(param1.info.level == "error")
			{
				Tracer.error(LOGFILTER + "AudioPlayer.onPlayStreamStatus info=" + param1.info.code);
			}
			switch(param1.info.code)
			{
				case "NetStream.Buffer.Empty":
					Tracer.log(LOGFILTER + "AudioPlayer empty buffer  time=" + this.m_play_stream.time + ", bufLen=" + this.m_play_stream.bufferLength);
					this.m_playing = false;
					break;
				case "NetStream.Buffer.Full":
					Tracer.log(LOGFILTER + "AudioPlayer full buffer time=" + this.m_play_stream.time + ", bufLen=" + this.m_play_stream.bufferLength);
					this.m_playing = true;
					break;
			}
		}
	}
}