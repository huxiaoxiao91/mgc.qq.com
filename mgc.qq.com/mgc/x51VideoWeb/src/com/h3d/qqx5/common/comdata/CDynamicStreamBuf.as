package com.h3d.qqx5.common.comdata
{
	import flash.display.Loader;
	import flash.net.URLRequest;

	public class CDynamicStreamBuf extends CBasicStreamBuf
	{
		public function CDynamicStreamBuf( n:uint =128)
		{
			if(n<16)
				n=16;
			ReAlloc(n);
		}
		
		public function (input:CDynamicStreamBuf):CDynamicStreamBuf
		{
			ReAlloc(input.Capacity());
			Put(input.GetBytes(), 0, input.Size());
		}
		public function equal ( buf:CDynamicStreamBuf):CDynamicStreamBuf
			{
				CopyFrom(buf);
				return *this;
			}
		public function equalbasic( buf:CBasicStreamBuf):CBasicStreamBuf
			{
				CopyFrom(buf);
				return buf;
			}
//			virtual ~CDynamicStreamBuf()
//		{
//			Free();
//		}
		public function ReAlloc(size:uint):void
		{
			if(size <= m_maxlen)
				return;
			
			var oldlen:uint  = m_maxlen;
			do
			{
				m_maxlen <<= 1;
			}while(size > m_maxlen);
			var nbuf:String = "";
			if(m_bytes)
			{
				nbuf = m_bytes.slice(0,oldlen);
				delete []m_bytes;
			}
			m_bytes = nbuf;
		}


		public function Swap(rhs:CDynamicStreamBuf ):CDynamicStreamBuf
		{
			var tmp:String = m_bytes;
			rhs.m_bytes = m_bytes;
			m_bytes = tmp;
			
			var itmp:uint = m_deflen;
			rhs.m_deflen = m_deflen;
			m_deflen = itmp;
			
			itmp = m_maxlen;
			rhs.m_maxlen = m_maxlen;
			m_maxlen = itmp;
		}
//		public function WriteToFile( file_name:String ):Boolean
//		{
//			if( !file_name )
//				return false;
//			
//			var writer:URLRequest = new URLRequest(file_name);
//			if( writer != null )
//				return false;
//			var wcb = fwrite( m_bytes, 1, m_deflen, fh );
//			writer.
//			if( wcb != m_deflen )
//			{
//				fclose(fh);
//				return false;
//			}
//			fclose(fh);
//			return true;
//		}
//		bool ReadFromFile( const char* file_name )
//		{
//			FILE* fh = fopen( file_name, "r+b" );
//			if( !fh )
//				return false;
//			if( fseek( fh, 0, SEEK_END ) != 0 )
//			{
//				fclose(fh);
//				return false;
//			}
//			uint file_size = ftell( fh );
//			ExpandTo( file_size );
//			m_deflen = file_size;
//			if( fseek( fh, 0, SEEK_SET ) != 0 )
//			{
//				fclose(fh);
//				return false;
//			}
//			uint rcb = fread( m_bytes, 1, file_size, fh );
//			if( rcb != file_size )
//			{
//				fclose(fh);
//				return false;
//			}
//			fclose(fh);
//			return true;
//		}
	}
}