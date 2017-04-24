package com.h3d.audio
{
	import com.h3d.audio.AudioPlayer;
	import com.h3d.flv.FlvWrapper;
	import com.h3d.util.Log;
	import com.h3d.util.Tracer;
	import com.h3d.video.VideoMgr;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.utils.getTimer;
	
	import h3d.x51.web.ogg_decoder.*;
	
	import org.osmf.traits.TimeTrait;
	
	/*
	** 音频数据缓存管理
	*/
	public class AudioTrack
	{
		private var m_decoder:uint;
		private var m_ogg_C_buffer:int = 0;
		private var m_ogg_C_buffer_size:int = 1000;
		private var m_pcm_C_buffer:int = 0;
		private var m_pcm_C_buffer_size:int = 88200;
		//private var m_audio_player:AudioPlayer = null;
		private var m_begin_samples:int = -1;

		private static const FRAME_PER_SECOND:int = 4;
		private static const MICPHONE_SAMPLERATE:int = 44100;
		private static const VOICE_SAMPLES_PER_MILISECOND:Number = 44.1;
		private static const CHAR_PER_SAMPLE:int = 2; // 每个采样的字节数
		private static const PCM_BUFFER_MAX_LEN:int = MICPHONE_SAMPLERATE * 2;
		//快播时，缓存的PCM Block数量
		private static const BUFFER_BLOCKS_ON_QUICK_PLAY:int = 6;
		
		private var m_samples_per_frame:int;
		private var m_pcm_buffer:ByteArray;
		private var m_PCM_blocks:Array;
		
		private var m_filled_samples:int;

		private var m_frameInterval:int;
		private var m_playBlockPos:int;
		private var m_dataTimestamp:int;
		private var m_currSamples:int;
		private var m_lastSkipTime:int;
		private var m_quickPlayBlockCount:int;
		private var m_firstPlay:Boolean;
		private var m_video_begin_time:int = -1;
		private var m_need_delete_samples:int = 0;
		
		public function AudioTrack()
		{
			m_decoder = CreateCppOggDecoder(x51VideoPlayer.IS_CONCERT);
			m_ogg_C_buffer = CModule.malloc(m_ogg_C_buffer_size);
			m_pcm_C_buffer = CModule.malloc(m_pcm_C_buffer_size);
			/*m_audio_player = new AudioPlayer();
			m_audio_player.init();*/
			m_pcm_buffer = new ByteArray();
			m_PCM_blocks = new Array();
			
			m_samples_per_frame = MICPHONE_SAMPLERATE / FRAME_PER_SECOND;
			
			m_filled_samples = 0;
			
			m_frameInterval = 1000 / FRAME_PER_SECOND;
			m_playBlockPos = 0;
			m_dataTimestamp = 0;
			m_currSamples = 0;
			m_lastSkipTime = 0;
			m_quickPlayBlockCount = 0;
			m_firstPlay = true;
		}
		
		public function getDataTimestamp():int
		{
			return 0;
		}
		
		public function getBuffInterval():int {
			return m_frameInterval;
		}
		
		public function QuickPlay(time:int):void
		{

		}
		
		public function appendBytes(ba:ByteArray, v:int, count:int):void
		{
			//ba.position = ba.length;
			while (count > 0)
			{
				ba.writeByte(v);
				count--;
			}
		}
		
		private function FillPCMBlock():void
		{
			var blockSize:int = m_samples_per_frame * CHAR_PER_SAMPLE;
			
			//Tracer.log("m_pcm_buffer  : " + m_pcm_buffer.position);
			var pcm_buffer_len:uint = m_pcm_buffer.position;
			m_pcm_buffer.position = 0;
			while (pcm_buffer_len >= blockSize)
			{
				var block_data:ByteArray = new ByteArray();
				block_data.endian = Endian.LITTLE_ENDIAN;
				block_data.writeBytes(m_pcm_buffer, m_pcm_buffer.position, blockSize);
				block_data.position = 0;
				
				m_PCM_blocks.push(block_data);
				
				m_pcm_buffer.position += blockSize;
				pcm_buffer_len -= blockSize;
			}
			
			//var dataLeft:uint = m_pcm_buffer.bytesAvailable;
			var pos:uint = m_pcm_buffer.position;
			m_pcm_buffer.position = 0;
			if(pcm_buffer_len > 0)
			{
				m_pcm_buffer.writeBytes(m_pcm_buffer, pos, pcm_buffer_len);
			}
			//m_pcm_buffer.length = dataLeft;
			Log.log("left pcm_buffer_len:" +　pcm_buffer_len);
			return;
		}
		
		public function ReceiveData(data:ByteArray):void
		{
			//Tracer.log("AudioTrack data len : " + data.length);
			if (data.length > m_ogg_C_buffer_size)
			{
				CModule.free(m_ogg_C_buffer);
				m_ogg_C_buffer_size *= 2;
				m_ogg_C_buffer = CModule.malloc(m_pcm_C_buffer_size);
			}
			
			data.endian = Endian.LITTLE_ENDIAN;
			
			var size:uint = data.readUnsignedInt();
			var start_samples:uint = data.readUnsignedInt();
			var packet_samples:uint = data.readUnsignedInt();
			Tracer.log("synctest audio time :" + start_samples/44.1);
			if (m_begin_samples == -1)
			{
				m_begin_samples = start_samples;
				m_filled_samples = start_samples;
				m_currSamples = start_samples;
				
				//m_dataTimestamp = m_begin_samples / VOICE_SAMPLES_PER_MILISECOND;
				
				//Tracer.log("m_begin_samples:" + m_begin_samples
				//	+ ", m_begin_timestamp:" + m_begin_timestamp);
			}

			// 有些数据还没过来，填一些空白数据
			if (m_filled_samples < start_samples)
			{
				var diff:int = start_samples - m_filled_samples;
				
				Log.log("填一些空白数据:" + "m_filled_samples < start_samples "
					+ ", m_filled_samples:" + m_filled_samples
					+ ", start_samples:" + start_samples + ", diff : " + diff);
				
				appendBytes(m_pcm_buffer, 0, diff * CHAR_PER_SAMPLE);
				m_filled_samples = start_samples;
				FillPCMBlock();	
			}
			// 有些数据来晚了，丢掉
			else if (m_filled_samples > start_samples)
			{
				Log.log("m_filled_samples > start_samples "
					+ ", m_filled_samples:" + m_filled_samples
					+ ", start_samples:" + start_samples);
				return;
			}
			
			//Tracer.log("m_filled_samples == start_samples "
			//	+ ", m_filled_samples:" + m_filled_samples
			//	+ ", start_samples:" + start_samples);
			
			// 包过大时，忽略
			var leftSpace:int = (PCM_BUFFER_MAX_LEN - m_pcm_buffer.position) / CHAR_PER_SAMPLE;
			if (packet_samples > leftSpace)
			{
				Log.log("包过大时，忽略:" + packet_samples + ", left:" + leftSpace);
				//return;	
			}
			
			//var timestamp:uint = (start_samples - m_begin_samples) / 44.1;//todo

			//Tracer.log("AudioTrack receive data start samples : " + start_samples);
			data.position -= 12;
			//Tracer.log("AudioTrack receive data size : " + size + " len : " + data.bytesAvailable);
			var temp_array:ByteArray = new ByteArray();
			temp_array.endian = Endian.LITTLE_ENDIAN;
			temp_array.writeBytes(data, data.position, data.bytesAvailable);
			temp_array.position = 0;
			
			//data.readBytes(temp_array, data.position, data.length - data.position);
			CModule.writeBytes(m_ogg_C_buffer, size, temp_array);
			var pcm_len:int = 0;
			pcm_len = Ogg2Pcm(m_decoder, m_ogg_C_buffer, size, m_pcm_C_buffer);
			//Tracer.log("AudioTrack pcm len : " + pcm_len);
			if (pcm_len == 0)
				return;
			
			var pcm_data:ByteArray = new ByteArray();
			CModule.readBytes(m_pcm_C_buffer, pcm_len, pcm_data);
			
			Log.log("AudioTrack pcm_data len : " + pcm_data.position);
			//m_pcm_buffer.position += m_pcm_buffer.bytesAvailable;
			m_pcm_buffer.writeBytes(pcm_data);
			m_filled_samples += packet_samples;
			
			if (m_video_begin_time != -1)
			{
				SetBeginTime(m_video_begin_time);
			}
			
			if (m_need_delete_samples > 0)
			{
				if (m_need_delete_samples > m_pcm_buffer.position / CHAR_PER_SAMPLE)
				{
					return;
				}
				else
				{
					var pcm_buffer_len:int = m_pcm_buffer.position - m_need_delete_samples * CHAR_PER_SAMPLE;
					m_pcm_buffer.position = 0;
					m_pcm_buffer.writeBytes(m_pcm_buffer, m_need_delete_samples * CHAR_PER_SAMPLE, pcm_buffer_len);
					m_need_delete_samples = 0;
				}
			}
			
			FillPCMBlock();
			
			return;
		}
		
		public function SetBeginTime(begin_time:int):void
		{
			if (m_begin_samples == -1)
			{
				m_video_begin_time = begin_time;
			}
			else
			{
				var diff:int = begin_time * 44.1 - m_begin_samples;
				if (diff > 0)
				{
					if (m_pcm_buffer.position < diff * CHAR_PER_SAMPLE)
					{
						m_need_delete_samples = diff - m_pcm_buffer.position / CHAR_PER_SAMPLE;
						m_pcm_buffer.position = 0;
					}
					else
					{
						var pcm_buffer_len:int = m_pcm_buffer.position - diff * CHAR_PER_SAMPLE;
						m_pcm_buffer.position = 0;
						m_pcm_buffer.writeBytes(m_pcm_buffer, diff * CHAR_PER_SAMPLE, pcm_buffer_len);
					}
				}
				else if (diff < 0)
				{
					var temp_array:ByteArray = new ByteArray();
					temp_array.endian = Endian.LITTLE_ENDIAN;
					
					diff = -diff * CHAR_PER_SAMPLE;
					appendBytes(temp_array, 0, diff);
					temp_array.writeBytes(m_pcm_buffer, 0, m_pcm_buffer.position);
					m_pcm_buffer = temp_array;
				}
				
				m_video_begin_time = -1;
			}
		}
		
		public function GetPcmBlock():ByteArray
		{
			if (m_PCM_blocks.length == 0)
				return null;
			
			var p:ByteArray = m_PCM_blocks[0];
			m_PCM_blocks.splice(0,1);
			return p;
		}
		
		public function GetPcmBlockCount():uint {
			return m_PCM_blocks.length;
		}
	}
}