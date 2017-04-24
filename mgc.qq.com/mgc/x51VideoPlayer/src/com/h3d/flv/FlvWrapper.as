package com.h3d.flv {

	import com.h3d.video.VideoFrame;
	
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.utils.getTimer;
	
	public class FlvWrapper {
		public static const FLV_HEADER_FLAG_HASVIDEO:int = 1;
		public static const FLV_HEADER_FLAG_HASAUDIO:int = 4;
		
		public static const FLV_TAG_TYPE_AUDIO:int = 0x08;
		public static const FLV_TAG_TYPE_VIDEO:int = 0x09;
		public static const FLV_TAG_TYPE_META:int = 0x12;
		
		public static const FLV_VIDEO_FRAMETYPE_OFFSET:int = 4;
		
		public static const FLV_FRAME_KEY:int   = 1 << FLV_VIDEO_FRAMETYPE_OFFSET | 7;
		public static const FLV_FRAME_INTER:int = 2 << FLV_VIDEO_FRAMETYPE_OFFSET | 7;
		
		public function FlvWrapper() {
			
		}
		
		
		/**
		 * 
		 * 封装flv视频头数据
		 * 
		 */
		public static function getHeader(): ByteArray {
			var header:ByteArray = new ByteArray();
			header.endian = Endian.BIG_ENDIAN;
			header.writeByte(70); // UI8, Signature byte always 'F' (0x46)
			header.writeByte(76); // UI8, Signature byte always 'L' (0x4C)
			header.writeByte(86); // UI8, Signature byte always 'V' (0x56)
			header.writeByte(1);  // UI8, File version (for example, 0x01 for FLV version 1)
			header.writeByte(FLV_HEADER_FLAG_HASVIDEO | FLV_HEADER_FLAG_HASAUDIO);  // 00000101, Audio & Video tags are present
			header.writeByte(0);  // UI32, Offset in bytes from start of file to start of body (that is, size of header)
			header.writeByte(0);
			header.writeByte(0);
			header.writeByte(9);
			header.writeByte(0);  // UI32, PreviousTagSize0, Always 0
			header.writeByte(0);
			header.writeByte(0);
			header.writeByte(0);
			header.position = 0;
			return header;
		}
		
		/**
		 * 
		 * 封装flv Tag头数据
		 * 
		 */
		public static function getVideoHeaderTag(header:Object):ByteArray {
			var tag:ByteArray = new ByteArray();
			tag.endian = Endian.BIG_ENDIAN;
			
			if (header == null) {
				return tag;
			}
			
			// TagType, Video tag
			tag.writeByte(FLV_TAG_TYPE_VIDEO);
			
			// DataSize, rewrite later
			tag.writeByte(0);
			tag.writeByte(0);
			tag.writeByte(0);
			
			// Timestamp
			tag.writeByte(0);
			tag.writeByte(0);
			tag.writeByte(0);
			
			// TimestampExtended
			tag.writeByte(0);
			
			// StreamID
			tag.writeByte(0);
			tag.writeByte(0);
			tag.writeByte(0);
			
			var start:uint = tag.position;
			
			// FrameType:4 | CodecID:4
			tag.writeByte(FLV_FRAME_KEY);
			
			// AVCPacketType, 0: AVC sequence header
			tag.writeByte(0);
			
			// CompositionTime
			tag.writeByte(0);
			tag.writeByte(0);
			tag.writeByte(0);
			
			// AVCDecoderConfigurationRecord
			tag.writeByte(1); // version
			tag.writeByte(header.profile1); // profile
			tag.writeByte(header.profile2); // profile
			tag.writeByte(header.level); // level
			tag.writeByte(0xff); // 6 bits reserved (111111) + 2 bits nal size length - 1 (11)
			tag.writeByte(0xe1); // 3 bits reserved (111) + 5 bits number of sps (00001)
			var spsLen:uint = header.sps.length;
			tag.writeByte(spsLen >> 8); // sps size
			tag.writeByte(spsLen);
			tag.writeBytes(header.sps); // sps
			tag.writeByte(1); // num of pps
			var ppsLen:uint = header.pps.length;
			tag.writeByte(ppsLen >> 8); // pps size
			tag.writeByte(ppsLen); 
			tag.writeBytes(header.pps); // pps
			
			// rewrite data length info
			var pos_restore:uint = tag.position;
			var length:uint = tag.position - start;
			tag.position = start - 10;
			tag.writeByte(length >> 16);
			tag.writeByte(length >> 8);
			tag.writeByte(length);
			
			// last tag size
			tag.position = pos_restore;
			tag.writeUnsignedInt(tag.length); 
			
			return tag;
		}
		
		/**
		 * 
		 * 封装flv tag数据
		 * 
		 */		
		public static function getVideoTag(data:ByteArray, key:Boolean, timestamp:int):ByteArray {
			
			var tag:ByteArray = new ByteArray();
			tag.endian = Endian.BIG_ENDIAN;
			
			// TagType, Video tag
			tag.writeByte(FLV_TAG_TYPE_VIDEO);
			
			// DataSize, rewrite later
			tag.writeByte(0);
			tag.writeByte(0);
			tag.writeByte(0);
			
			// Timestamp
			tag.writeByte(timestamp >> 16);
			tag.writeByte(timestamp >> 8);
			tag.writeByte(timestamp);
			
			// TimestampExtended
			tag.writeByte(timestamp >> 24);

			// StreamID
			tag.writeByte(0);
			tag.writeByte(0);
			tag.writeByte(0);
			
			var start:uint = tag.position;
			
			// FrameType:4 | CodecID:4
			tag.writeByte(key ? FLV_FRAME_KEY : FLV_FRAME_INTER);
			// AVC NALU
			tag.writeByte(1);
			// offset ???
			tag.writeByte(0);
			tag.writeByte(0);
			tag.writeByte(0);
			
			// frame data
			if (data != null)
				tag.writeBytes(data);
			
			// rewrite data length info
			var pos_restore:uint = tag.position;
			var length:uint = tag.position - start;
			tag.position = start - 10;
			tag.writeByte(length >> 16);
			tag.writeByte(length >> 8);
			tag.writeByte(length);
			
			// last tag size
			tag.position = pos_restore;
			tag.writeUnsignedInt(tag.length); 
			return tag;
		}
		
		public static function getAudioTag(pcm_data:ByteArray, timestampe:uint) : ByteArray {
			var flv_data:ByteArray = new ByteArray();
			
			var data_size:uint = 0;
			if (pcm_data != null)
				data_size = pcm_data.length + 1;
			
			flv_data.writeByte(FLV_TAG_TYPE_AUDIO);
			flv_data.writeByte(data_size >> 16 & 255);
			flv_data.writeByte(data_size >> 8 & 255);
			flv_data.writeByte(data_size & 255);
			flv_data.writeByte(timestampe >> 16 & 255);
			flv_data.writeByte(timestampe >> 8 & 255);
			flv_data.writeByte(timestampe & 255);
			flv_data.writeByte(timestampe >> 24 & 255);
			flv_data.writeByte(0);
			flv_data.writeByte(0);
			flv_data.writeByte(0);
			flv_data.writeByte(62);
			
			if (pcm_data != null)
				flv_data.writeBytes(pcm_data,0,pcm_data.length);
			
			flv_data.writeByte(data_size + 11 >> 24 & 255);
			flv_data.writeByte(data_size + 11 >> 16 & 255);
			flv_data.writeByte(data_size + 11 >> 8 & 255);
			flv_data.writeByte(data_size + 11 & 255);
			return flv_data;
		}
	}
}