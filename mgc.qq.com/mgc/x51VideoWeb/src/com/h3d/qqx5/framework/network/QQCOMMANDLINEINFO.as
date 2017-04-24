package com.h3d.qqx5.framework.network
{
	import flash.utils.ByteArray;

	/**
	 * @author Administrator
	 */
	public class QQCOMMANDLINEINFO
	{			
		public var nStructSize:int = 0;
		public var dwQQUin:int = 0;
		public var nSignatureLen:int = 0;
		public var arbySignature:ByteArray = new ByteArray;
		public var rsInfo :rs_login_info  = new rs_login_info();
		public var nIigwLen:int = 0;
		public var arbyIigw:ByteArray = new ByteArray;
		public var nqqloginkeyLen:int;
		public var arbyqqlogin:ByteArray = new ByteArray;
		public var nWebSignatureLen:int = 0;//web登陆签名长度
		public var arbyWebSignature:ByteArray = new ByteArray;//web登陆签名
		public var nWebGuestSignatureLen:int;		//WEB游客签名长度
		public var arbyWebGuestSignature:ByteArray = new ByteArray ;	//WEB游客签名
		public function QQCOMMANDLINEINFO()
		{
			for (var i: int = 0; i < 128; ++i)
				arbySignature.writeByte(0);
			for (var i1: int = 0; i1 < 512; ++i1)
				arbyIigw.writeByte(0);
			for (var i2: int = 0; i2 < 128; ++i2)
				arbyqqlogin.writeByte(0);
			for (var i3: int = 0; i3 < 128; ++i3)
				arbyWebSignature.writeByte(0);
			for (var i4: int = 0; i4 < 128; ++i4)
				arbyWebGuestSignature.writeByte(0);
		}
		
		public function serialize(b:NetBuffer):void 
		{
			b.putInt(nStructSize);
			b.putInt(dwQQUin);
			b.putInt(nSignatureLen);
			for (var i: int = 0; i < 128; ++i)
				b.putByte(arbySignature[i]);
			b.putInt(rsInfo.game_server_id);
			b.putInt(rsInfo.channel_id);
			b.putInt(rsInfo.channel_type);
			b.putInt(rsInfo.room_id);
			b.putInt(nIigwLen);
			for (var i1: int = 0; i1 < 512; ++i1)
				b.putByte(arbyIigw[i1]);
			b.putInt(nqqloginkeyLen);
			for (var i2: int = 0; i2 < 128; ++i2)
				b.putByte(arbyqqlogin[i2]);
			
			b.putInt(nWebSignatureLen);
			for (var i3: int = 0; i3 < 128; ++i3)
				b.putByte(arbyWebSignature[i3]);
			
			b.putInt(nWebGuestSignatureLen);
			for (var i4: int = 0; i4 < 128; ++i4)
				b.putByte(arbyWebGuestSignature[i4]);
		}
	}	
}
