package com.h3d.qqx5.common.comdata
{
	public class CBasicStreamBuf
	{
		public function CBasicStreamBuf()
		{
			m_maxlen = 1;
			m_bytes = "";
			m_deflen = 0;
		}
		protected var	m_bytes:String;
		protected var	m_maxlen:uint;
		protected var	m_deflen:uint;
		
		public function GetBytes():String
		{
			return m_bytes;
		}
		public function Size():uint
		{
			return m_deflen;
		}
		public function Capacity():uint
		{
			return m_maxlen;
		}
		public function SpaceLeft():uint
		{
			return m_maxlen - m_deflen;
		}
		
		public function Clear():void
		{
			m_deflen=0;
		}
		public function GetBufRange( pos:uint, n:uint):String
		{
			var np:uint = pos + n;
			if((pos > m_deflen) || (n > m_deflen) || (np > m_deflen))
			{
				return 0;
			}
			else
			{
				return m_bytes+pos;
			}
		}
		
		function ReAlloc(size:uint):void = 0;
		function Free():void = 0;
		
		public function ExpandTo( size:uint):uint
		{
			if(size > m_maxlen)
			{
				ReAlloc(size);
			}
			
			if(m_deflen < size)
				m_deflen = size;
			
			return size;
		}
		
		public function ChangeSize(size:uint):uint	//反外挂解密之后长度可能变小，不敢改ExpandTo的实现，新搞一个ChangeSize
		{
			if(size >= m_deflen)
				ExpandTo(size);
			else
				m_deflen = size;
		}
		
		public function Get(p:String, pos:uint, n:uint ):String
		{
			if(n>m_deflen-pos)
			{
				throw Error("SEC_OUT_OF_RANGE");
			}
			p =  m_bytes.slice(pos) + n;
			return p;
		}
		public function GetNoThrow(p:String, pos:uint, n:uint ):String
		{
			if(n>m_deflen-pos)
			{
				n = m_deflen-pos;
			}
			p =  m_bytes.slice(pos) + n;
			return p;
		}
		public function Put(p:String, pos:uint, n:uint ):String
		{
			var total:uint = pos+n;
			ExpandTo(total);
			m_bytes = m_bytes.slice(0,pos) + p.slice(0,n);
			//memcpy(m_bytes+pos, p, n);			
			return p;
		}
		
		public function CopyFrom( src:CBasicStreamBuf):CBasicStreamBuf
		{
			if(this == src)
				return;
			
			Clear();
			Put(src.GetBytes(), 0, src.Size());
		}
		
		public function ( buf:CBasicStreamBuf):CBasicStreamBuf
		{
			CopyFrom(buf);
			return buf;
		}
		
		public function Seek(pos:uint):Boolean
		{
			if(pos <= m_maxlen)
			{
				m_deflen = pos;
				return true ;
			}
			return false ;
		}
		
	}
}