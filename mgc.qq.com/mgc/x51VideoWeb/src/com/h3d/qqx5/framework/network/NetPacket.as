package com.h3d.qqx5.framework.network
{
	/**
	 * @author Administrator
	 */
	public class NetPacket
	{
		public var body_length : int = 0;
		
		public static const headerLength : int = 8;
		
		public function NetPacket()
		{
			m_header_buffer = new NetBuffer();
			m_body_buffer = new NetBuffer();
		}
		
		public function encode() : void
		{
			body_length = m_body_buffer.length();
			m_header_buffer.putInt(body_length);
			m_header_buffer.putInt(0);	
		}
		
		public function decode() : void
		{
			body_length = m_header_buffer.getInt();
		}	
		
		public function body_buffer() : NetBuffer
		{
			return m_body_buffer;
		}
		
		public function set_body_buffer(buff:NetBuffer ) : void
		{
			m_body_buffer = buff;
		}
		
		
		public function header_buffer() : NetBuffer
		{
			return m_header_buffer;
		}
		
		public function resetPostion():void
		{
			m_header_buffer.resetPosition();
			m_body_buffer.resetPosition();
		}
		
		private var m_header_buffer : NetBuffer;
		private var m_body_buffer : NetBuffer;
	}	
}
