package com.h3d.qqx5.framework.network
{
	import com.h3d.qqx5.common.GlobalConfig;
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.common.SingletonMgr;
	import com.h3d.qqx5.common.comdata.CFragFunResult;
	import com.h3d.qqx5.common.event.CEventFragmentManager;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.common.specialevent.CEventVideoSendGiftResultForWeb;
	import com.h3d.qqx5.common.specialevent.CEventVideoToClientChatMessageForWeb;
	import com.h3d.qqx5.enum.VideoResultType;
	import com.h3d.qqx5.util.Cookie;
	import com.h3d.qqx5.util.SHA256;
	
	import flash.errors.IOError;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import flash.utils.getTimer;
	
	public class NetConnection implements INetConnection
	{
		private var _socket:Socket;
		private var _read_packet:NetPacket;
		private var _msg_dispatcher:MessageDispacher;
		private var _body_read:uint = 0;
		private var _head_read:uint = 0;


		private var m_last_time:int;
		private var m_callcnt:int;
		private var m_maxCall:int = 5;

		private static const CS_INVALID:int              = 0;
		private static const CS_FRESH_PUNCH:int          = 1;
		private static const CS_FRESH_EXCH_DATA:int      = 2;
		private static const CS_FRESH:int                = 3;
		private static const CS_PUZZLE_SOLVING:int       = 4;
		private static const CS_PUZZLE_RESULT:int        = 5;
		private static const CS_ACCOUNT:int              = 6;
		private static const CS_WAIT_PASSWD:int          = 7;
		private static const CS_PASSWD_VERIFY:int        = 8;
		private static const CS_FAIL_PUNISH:int          = 9;
		private static const CS_ESTABLISHED:int          = 10;
		private static const CS_CLOSING:int              = 11;
		private static const CS_CLOSED:int               = 12;

		private var _state:int = CS_FRESH_PUNCH;
		private var _ip:String;
		private var _port:int;
		private var _account:uint;
		private var _ticket:ByteArray;
		private var _socketData:Array = new Array;

		private static const TRY_RECONNECT_MAX_TIMES:int = 3;
		private var connectFaultCount:int = 0;

		private var time:int = 0;
		
		//分包
		private var  m_frag_mng:CEventFragmentManager = new CEventFragmentManager;
		public function NetConnection(dispatcher:MessageDispacher) 
		{
			_socket = new Socket();
			_socket.endian = Endian.LITTLE_ENDIAN;
			
			_msg_dispatcher = dispatcher;			
			_read_packet = new NetPacket();
		}

		public function connectWithAccount(ip:String, port:int, account:uint, ticket:ByteArray):void {
			try {
				//如果当前是连接完成状态，需要清理一些现有的所有数据。
//				if (established()) {
//					if (_socketData.length > 0) {
//						//处理当前所有数据。
//						_socketData = [];
//					}
//				}

				if (_socket) {
					close();
				}

				_ip = ip;
				_port = port;
				_account = account;
				_ticket = ticket;

				addEvent(_socket);
				_socket.connect(ip, port);
//				Globals.s_logger.test("Raw connectWithAccount,qq:" + account + ",ip:" + ip + ",port:" + port);

				time = (new Date()).time;
			} catch (err:Error) {
//				Globals.s_logger.test("connectWithAccount()");
				_msg_dispatcher.dispatch_error(new ErrorEvent(err.name, false, false, err.message, err.errorID));
			}
		}

		public function send_raw_message(msg:INetMessage):void 
		{
			if (msg == null) {
				Globals.s_logger.error("send_raw_message null");
				return;
			}
			if(!is_connected())
			{
				Globals.s_logger.error("send_raw_message is_connected false");
				return;
			}
			//发消息分包
			var frags:Array  = new Array;
			frags = m_frag_mng.SliceEvent(msg);
			if( frags.length !=0 )
			{
				for( var idx:int = 0; idx< frags.length; idx++ )
				{
					var fragp:NetPacket = new NetPacket();
					
					fragp.body_buffer().putInt(frags[idx].CLSID());
					ProtoBufSerializer.ToStream(frags[idx],fragp.body_buffer()) ;
					send_packet(fragp);
//					if (frags[idx] is INetMessage) {
//						(frags[idx] as INetMessage).clearData();
//					}
				}
//				frags = null;
			}
			// 发消息分包 end
			else
			{
				Globals.s_logger.info("send_raw_message:" + msg.CLSID());
				var p:NetPacket = new NetPacket();
				
				p.body_buffer().putInt(msg.CLSID());
				ProtoBufSerializer.ToStream(msg,p.body_buffer()) ;
				send_packet(p);
//				msg.clearData();
//				msg = null;
				Globals.s_logger.debug("send_raw_message  success ");
			}
		}
		
		public function send_message(msg : INetMessage, serialID:int) : void
		{
			if(msg == null)
			{
				Globals.s_logger.error("send_message null");
				return;
			}
			if(!is_connected())
			{
				Globals.s_logger.error("send_message is_connected false");
				return;
			}
			
			var wrapEvt:CEventRoomProxyWrapEvent = new CEventRoomProxyWrapEvent();
			wrapEvt.serialID = serialID;
			wrapEvt.client_version = GlobalConfig.Client_Version;
			wrapEvt.payload.putInt(msg.CLSID());
			wrapEvt.clsid = msg.CLSID();
			ProtoBufSerializer.ToStream(msg,wrapEvt.payload);
			
			send_raw_message(wrapEvt);
//			msg.clearData();
		}
		
		public function update():void
		{
//			Globals.s_logger.test("update()11");
			if(_socketData.length <= 0)
			{
				return;
			}
			
			var read_len:int = 0;
			//Globals.s_logger.log("now time : " + flash.utils.getTimer() + "begin update");
			while(_socketData.length > 0)
			{
				var data:ByteArray = _socketData.shift() as ByteArray;
				try
				{
					// 刷新分包
					m_frag_mng.Update();
					//刷新分包 end
					while(data.bytesAvailable > 0)
					{
						if(_read_packet.header_buffer().length() == NetPacket.headerLength)//body
						{
							read_len = _read_packet.body_length - _body_read;
							
							if(data.bytesAvailable < read_len)
								read_len = data.bytesAvailable;
							
							//Globals.s_logger.log("data.readBytes body pre, data.bytesAvailable:" + data.bytesAvailable + " read_len:" + read_len+ " _read_packet.body_length:" + _read_packet.body_length + " _body_read:" + _body_read);
							data.readBytes(_read_packet.body_buffer().buffer(), _body_read, read_len);
							//Globals.s_logger.log("data.readBytes body after, data.bytesAvailable:" + data.bytesAvailable + " read_len:" + read_len);
							_body_read += read_len;
							
							if(_body_read == _read_packet.body_length)
							{
//								Globals.s_logger.test("update() handlePacket");
								this.handlePacket(_read_packet);
								//Tag clear memory
//								_read_packet = null;
								_read_packet = new NetPacket();
								_body_read = 0;
								_head_read = 0;
							}
						}
						else//header
						{
							read_len = NetPacket.headerLength - _head_read;
							
							if(data.bytesAvailable < read_len)
								read_len = data.bytesAvailable;
							
							//Globals.s_logger.log("data.readBytes head pre, data.bytesAvailable:" + data.bytesAvailable + " read_len:" + read_len + " _head_read:" + _head_read);
							data.readBytes(_read_packet.header_buffer().buffer(), _head_read, read_len);	
							//Globals.s_logger.log("data.readBytes head after, data.bytesAvailable:" + data.bytesAvailable + " read_len:" + read_len);
							_head_read += read_len;
							
							if(_head_read == NetPacket.headerLength)
							{
								_read_packet.decode();
								_head_read = 0;
								_body_read = 0;
							}
						}
					}
				}
				catch(err:Error)
				{
					if(err.message == ESTABLISH_VERIFY_ERROR){
						
					}
					Globals.s_logger.error("NetConnection update error " + err);
				}
			}	
			
//			Globals.s_logger.test("update() end");
			//Globals.s_logger.log("now time : " + flash.utils.getTimer() + "end update ");
		}
		
		private function addEvent(socket:Socket):void
		{
			socket.addEventListener(Event.CONNECT, this.handleConnect);
			socket.addEventListener(Event.CLOSE, this.handleClose);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, handleIncoming);
			socket.addEventListener(IOErrorEvent.IO_ERROR, handleIoError);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,handleIoError);
		}
		
		private function removeEvent(socket:Socket):void
		{
			socket.removeEventListener(Event.CONNECT, this.handleConnect);
			socket.removeEventListener(Event.CLOSE, this.handleClose);
			socket.removeEventListener(ProgressEvent.SOCKET_DATA, handleIncoming);
			socket.removeEventListener(IOErrorEvent.IO_ERROR, handleIoError);
			socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,handleIoError);
		}
		
		public function is_connected():Boolean
		{
			return _socket && _socket.connected && established();
		}
		
		private function send_packet(pkg:NetPacket):void
		{
			pkg.encode();
			
			try
			{
				_socket.writeBytes( pkg.header_buffer().buffer(), 0, NetPacket.headerLength);
				_socket.writeBytes( pkg.body_buffer().buffer(), 0, pkg.body_length);
				_socket.flush();
			}
			catch(err:Error)
			{
				//Globals.s_logger.error("NetConnection send_packet error " + err);
				Globals.s_logger.error("NetConnection send_packet error " + err);
			}
		}		
		
		public function close():void
		{
//			Globals.s_logger.test("socket close -> {ip:" + _ip + ", port:" + _port + "}");
			removeEvent( _socket );
			if( _socket.connected )
			{
				Globals.s_logger.test("_socket.close()1");
				_socket.close();
			}
			setState(CS_FRESH_PUNCH);
		}
		
		private function handleConnect(event : Event) : void 
		{
//			Globals.s_logger.test("socket connect success -> {ip:" + _ip + ", port:" + _port + "}");
			//Globals.s_logger.debug("now time handleConnect,selfEstablishClient,debugTime:" + flash.utils.getTimer());
			selfEstablishClient(null);
			connectFaultCount = 0;
		}
		
		/**
		 * 主动关闭会先移除事件，然后关闭socket，不会触发此事件。
		 * 所以如果接收到此事件，则代表真的断开了链接。
		 * @param event
		 * 
		 */		
		private function handleClose(event : Event) : void 
		{			
			try
			{
				Globals.s_logger.debug("handleClose()");
				removeEvent(_socket);
				_msg_dispatcher.dispatch_close(event);
//				setState(CS_FRESH_PUNCH);
			}
			catch(e:Error)
			{
				Globals.s_logger.error(e.getStackTrace());
			}
		}
		
		private function handleIoError(event :ErrorEvent) : void 
		{
			try
			{
				removeEvent(_socket);
				_msg_dispatcher.dispatch_error(event);
			}
			catch(e:Error)
			{
				Globals.s_logger.error(e.getStackTrace());
			}
			
			//尝试异常重连机制
//			connectFaultCount++;
//			if (connectFaultCount > TRY_RECONNECT_MAX_TIMES) {
//				try {
//					Globals.s_logger.debug("handleIoError()");
//					removeEvent(_socket);
//					connectFaultCount = 0;
//					_msg_dispatcher.dispatch_error(event);
//				} catch (e:Error) {
//					Globals.s_logger.error(e.getStackTrace());
//				}
//			} else {
//				removeEvent(_socket);
//				_socket.close();
//				addEvent(_socket);
//				_socket.connect(_ip, _port);
//				Globals.s_logger.info("reconnect With ip:" + _ip + ", port:" + _port);
//			}
		}

		private function MaskSpecEvent(clsid:int):Boolean {
			////1s内超过次数限制就不再发送
			if(clsid == 39713 || clsid == 39894 || clsid == 39731|| clsid == 39736|| clsid == 39971)
				//public static const CLSID_CEventVideoRoomVipSeatsInfo:int = 39713;
				//public static const CLSID_CEventVideoRoomLoadSuperGuardResult:int = 39894;
				//public static const CLSID_CEventNotifySendLotsOfGifts:int = 39731;
				//public static const CLSID_CEventVideoGiftPoolHeightChange:int = 39736;
				//public static const CLSID_CEventVideoRoomEnterRoomBroadcastAllRoom:int = 39971;
				//public static const CLSID_CEventVideoToClientChatMessage:int = 39717;
				//public static const CLSID_CEventVideoSendGiftResult:int = 39730;
			{
				var tmptime:int = flash.utils.getTimer();
				Globals.s_logger.debug("MaskSpecEvent " +tmptime + "m_last_time"+m_last_time + "m_callcnt"+m_callcnt +"m_maxCall"+ m_maxCall);
				
				if( (tmptime- m_last_time)< 1000 && m_callcnt > m_maxCall)
					return true;		
				
				if( (tmptime- m_last_time)> 1000 )
				{
					m_last_time = tmptime;
					m_callcnt = 0;
				}
				m_callcnt++;
			}
			return false;
			//////1s内超过次数限制就不再发送 end
		}
		
		private function handleIncoming(event:ProgressEvent):void
		{
			//Globals.s_logger.log("now time : " + flash.utils.getTimer() + "begin handleIncoming");
			if(_socket.bytesAvailable <= 0)
			{
				return;
			}
			
			var data:ByteArray = new ByteArray;
			var read_len:int = _socket.bytesAvailable;
			_socket.readBytes(data, 0, read_len);
//			Globals.s_logger.log("handleIncoming _socket.bytesAvailable:" + _socket.bytesAvailable + " read_len:" + read_len);
			data.position = 0;
			
			_socketData.push(data);
			//update();
			//Globals.s_logger.log("now time : " + flash.utils.getTimer() + "handleIncoming end");
		}
		private function clearPacketCache():void
		{
			//_read_packet = new NetPacket();
			//_body_read = 0;
			//_head_read = 0;
		}
		private function handlePacket(p:NetPacket):void
		{
//			Globals.s_logger.debug("now time : " + flash.utils.getTimer() + "begin handlePacket");
			p.resetPostion();
			if(!established())
			{
				selfEstablishClient(p);
				clearPacketCache();
				return;	
			}
			var clsid:int = p.body_buffer().getInt();
			if(clsid == EEventIDVideoRoomExt.CLSID_CEventVideoToClientChatMessageForWeb)
			{
				var msg:CEventVideoToClientChatMessageForWeb = new CEventVideoToClientChatMessageForWeb();
				msg.LoadStream(p.body_buffer());
				_msg_dispatcher.dispatch(VideoResultType.VREST_Normal, msg, serialID);
				return;
			}
			if(clsid == EEventIDVideoRoomExt.CLSID_CEventVideoSendGiftResultForWeb)
			{
				var gift_msg:CEventVideoSendGiftResultForWeb = new CEventVideoSendGiftResultForWeb();
				gift_msg.LoadStream(p.body_buffer());
				_msg_dispatcher.dispatch(VideoResultType.VREST_Normal, gift_msg, serialID);
				return;
			}
			/*
			if(clsid == 39717)
			{
				var dispatchMsg2:CEventVideoToClientChatMessage = new CEventVideoToClientChatMessage();
				dispatchMsg2.message = new VideoToClientChatMessage();
				dispatchMsg2.message.sender_ID = Int64.fromNumber(0);
				dispatchMsg2.message.receiver_ID = Int64.fromNumber(0);
				dispatchMsg2.message.sender_name = "zhangqing";
				dispatchMsg2.message.recver_name = "yangyongxin";
				dispatchMsg2.message.sender_zoneName = "test";
				dispatchMsg2.message.recver_zoneName + "test";
				dispatchMsg2.message.message = "wawawawa";
				dispatchMsg2.message.type = 0
				//		public var is_purple : int;
				dispatchMsg2.message.in_vip_seat = 0;
				dispatchMsg2.message.sender_type = 0;
				dispatchMsg2.message.receiver_type = 0;
				//		public var roomid : int;
				dispatchMsg2.message.sender_jacket = 0;
				//		public var guard_level : int;
				dispatchMsg2.message.vip_level = 0;
				dispatchMsg2.message.is_free_whistle = false;
				dispatchMsg2.message.judge_type = 0;
				dispatchMsg2.message.videoguild_id = Int64.fromNumber(0);
				dispatchMsg2.message.sender_device_type = 0;
				dispatchMsg2.message.guard_level_new = 0;
				dispatchMsg2.message.invisible = false;
				dispatchMsg2.message.forbid_talk_all_room = false;
				dispatchMsg2.message.nest_assistant = false;
				dispatchMsg2.anchor_id = Int64.fromNumber(0);
				dispatchMsg2.popularity = 0;
				dispatchMsg2.starlight = 0;
				_msg_dispatcher.dispatch(VideoResultType.VREST_Normal, dispatchMsg2, serialID);
				return;
			}
			*/
			
			
			
			var m:INetMessage = SingletonMgr.Instance().GetMsgFactory().CreateMessage(clsid);
			if(m == null)
			{
				Globals.s_logger.error("handlePacket unknown clsid:" + clsid);
				clearPacketCache();
				return;
			}
			//Globals.s_logger.log("now time : " + flash.utils.getTimer() + "begin handlePacket.FromStream");
			try
			{
				 ProtoBufSerializer.FromStream(m, p.body_buffer());
			}
			catch(err:Error)
			{
				clearPacketCache();
				Globals.s_logger.log("handlePacket ProtoBufSerializer.FromStream error:" + err + ",clsid:" + clsid);
			}
			//Globals.s_logger.log("now time : " + flash.utils.getTimer() + "begin handlePacket.FromStream ok");
			//收消息分包
			var fragres :CFragFunResult = m_frag_mng.SpliceEvent(m);
			if( fragres.fragevt != null  )
			{
				m = fragres.fragevt ;
			}
			else if( fragres.result == true)
			{
				clearPacketCache();
				return ;
			}
			//分包结束。
			var dispatchMsg:INetMessage = m;
			var serialID:int = 0;
			if (m.CLSID() == MessageID.CLSID_CEventRoomProxyWrapEvent)
			{
				var w:CEventRoomProxyWrapEvent = m as CEventRoomProxyWrapEvent;
				var nested_clsid:int = w.payload.getInt();
				/*
				if(nested_clsid == 39717)
				{
					var dispatchMsg2:CEventVideoToClientChatMessage = new CEventVideoToClientChatMessage();
					dispatchMsg2.message = new VideoToClientChatMessage();
					dispatchMsg2.message.sender_ID = Int64.fromNumber(0);
					dispatchMsg2.message.receiver_ID = Int64.fromNumber(0);
					dispatchMsg2.message.sender_name = "zhangqing";
					dispatchMsg2.message.recver_name = "yangyongxin";
					dispatchMsg2.message.sender_zoneName = "test";
					dispatchMsg2.message.recver_zoneName + "test";
					dispatchMsg2.message.message = "wawawawa";
					dispatchMsg2.message.type = 0
					//		public var is_purple : int;
					dispatchMsg2.message.in_vip_seat = 0;
					dispatchMsg2.message.sender_type = 0;
					dispatchMsg2.message.receiver_type = 0;
					//		public var roomid : int;
					dispatchMsg2.message.sender_jacket = 0;
					//		public var guard_level : int;
					dispatchMsg2.message.vip_level = 0;
					dispatchMsg2.message.is_free_whistle = false;
					dispatchMsg2.message.judge_type = 0;
					dispatchMsg2.message.videoguild_id = Int64.fromNumber(0);
					dispatchMsg2.message.sender_device_type = 0;
					dispatchMsg2.message.guard_level_new = 0;
					dispatchMsg2.message.invisible = false;
					dispatchMsg2.message.forbid_talk_all_room = false;
					dispatchMsg2.message.nest_assistant = false;
					dispatchMsg2.anchor_id = Int64.fromNumber(0);
					dispatchMsg2.popularity = 0;
					dispatchMsg2.starlight = 0;
					_msg_dispatcher.dispatch(VideoResultType.VREST_Normal, dispatchMsg, serialID);
					return;
				}
				*/
				
				if (MaskSpecEvent(nested_clsid))
					return ;
				if( !Globals.isCancelOpeLog &&( clsid != 39713 || clsid != 39894 || clsid != 39731|| clsid != 39736|| clsid != 39971) )
					Globals.s_logger.log("handlePacket createMessage nest clsid:" + nested_clsid);
				var nested_m:INetMessage  = SingletonMgr.Instance().GetMsgFactory().CreateMessage(nested_clsid);
				if(nested_m == null)
				{		
					Globals.s_logger.error("handlePacket unknown nest clsid:" + nested_clsid);
					clearPacketCache();
					return;
				}
				try
				{
					ProtoBufSerializer.FromStream(nested_m, w.payload);
				}
				catch(err:Error)
				{
					Globals.s_logger.error("handlePacket ProtoBufSerializer.FromStream error:" + err + ",nested_clsid:" + nested_clsid);
				}
				dispatchMsg = nested_m;
				serialID = w.serialID;
			}
			//Globals.s_logger.log("now time : " + flash.utils.getTimer() + "begin handlePacket.dispatch");
			try
			{
				//要在界面线程之前清掉数据，否则在显示界面的时候新的消息会过来并触发这里的handlePacket。读取出来的还是上一次的packet。
				clearPacketCache();
				_msg_dispatcher.dispatch(VideoResultType.VREST_Normal, dispatchMsg, serialID);
				//Tag Clear memory
//				dispatchMsg.clearData();
			}
			catch(err:Error)
			{	
				Globals.s_logger.error("handlePacket:" + err.getStackTrace());
			}
		//	Globals.s_logger.log("now time : " + flash.utils.getTimer() + "end handlePacket");
		}
		
		public function dispose():void
		{
			if(_socket && _socket.connected)
			{
//				Globals.s_logger.test("_socket.close()2");
				_socket.close();
			}
			removeEvent(_socket);
			_socket = null;
		}
		
		private function established() : Boolean
		{
			return _state == CS_ESTABLISHED;
		}
		
		private function getState() : int
		{
			return _state;	
		}
		
		private function setState(val:int) : void
		{
			_state = val;
			
			Globals.s_logger.test("setState " + _state);
			if(established())
			{
				try
				{
//					Globals.s_logger.test("_msg_dispatcher.dispatch_connectted()");
					_msg_dispatcher.dispatch_connectted();	
				}
				catch(e:Error)
				{
//					Globals.s_logger.test(e.getStackTrace());
				}
			}
		}
		
		private function array_eq(ob1:ByteArray, ob2:ByteArray) : Boolean
		{
			if (ob1.length != ob2.length)
			{
				return false;
			}
			
			for(var i:int = 0; i < ob1.length; ++i)
			{
				if(ob1[i] != ob2[i])
				{
					return false;
				}
			}
			
			return true;
		}
		
		private function solvePuzzle(start:uint, end:uint, high:int, hash:ByteArray) : uint
		{	
			for (var i:uint = start; i <= end; ++i)
			{
				var b:NetBuffer = new NetBuffer;
				b.buffer().writeUnsignedInt(i);
				b.buffer().writeInt(high);
				b.resetPosition();
				SHA256.hashBytes(b.buffer());			
				
				if (array_eq(hash, SHA256.digest))
				{
					return i;
				}
			}
			
			throw new IOError("protocol error");
		}				
		
		private function selfEstablishClient(pkg:NetPacket) : void
		{
			//Globals.s_logger.log("now time : " + flash.utils.getTimer() + "begin selfEstablishClient");
			
			var cookie:Cookie = new Cookie("x51webGuest");
			var qq:uint = cookie.getData("guest_qq");
			var is_guest:Boolean = false;
			if( _account !=0 && _account == qq)
				is_guest = true;
			
			Globals.s_logger.debug( " selfEstablishClient.is_guest:" + is_guest + ".guest:" +qq + ".account:" + _account + "   pkg = " + pkg);
			
			var _time:int = (new Date()).time;
			
			if(getState() == CS_FRESH_PUNCH)
			{
				Globals.s_logger.debug("selfEstablishClient,Confirm CS_FRESH_PUNCH data,debugTime:" + flash.utils.getTimer());
				
				if (pkg != null) {
					trace("第一次握手异常：（pkg != null）");
					return;
				}
				trace("第一次握手时间：" + (_time - time).toString());

				var account:NetPacket = new NetPacket();
				var b:NetBuffer = account.body_buffer();
				b = account.body_buffer();
				b.putInt(5);// CCMD_ACCOUNT
				b.putString(_account.toString(10));
				send_packet(account);
				
				// --------割一刀-----------
				var passwd:NetPacket = new NetPacket();
				b = passwd.body_buffer();
				b.putInt(6);// CCMD_PASSWD
				b.putInt(200);// LOGIN_USE_TCLS
				var qqinfo:QQCOMMANDLINEINFO = new QQCOMMANDLINEINFO();
				qqinfo.dwQQUin = _account;
				if(_ticket != null)
				{
					if(! is_guest )
					{
						for(var i1:int = 0; i1 < _ticket.length; ++i1)
						{
							qqinfo.arbyWebSignature[i1] = _ticket[i1];	
						}
						qqinfo.nWebSignatureLen = _ticket.length;
					}
					else
					{
						for(var iguest:int = 0; iguest < _ticket.length; ++iguest)
						{
							qqinfo.arbyWebGuestSignature[iguest] = _ticket[iguest];	
						}
						qqinfo.nWebGuestSignatureLen = _ticket.length;
					}
				}
				qqinfo.serialize(b);
				send_packet(passwd);
				Globals.s_logger.debug("CS_ACCOUNT");
				setState(CS_ACCOUNT);
			}
			else if(getState() == CS_ACCOUNT)
			{
				trace("第二次握手时间：" + (_time - time).toString());
				
				var cmd3:int = pkg.body_buffer().getInt();
				// CCMD_PASSWD_OK
				if (cmd3 != 7) {
					Globals.s_logger.error("CS_ACCOUNT ret=" + cmd3);
					throw new IOError(ESTABLISH_VERIFY_ERROR);
				}
				Globals.s_logger.debug("CS_ESTABLISHED");
				setState(CS_ESTABLISHED);
			}
			
			time = _time;
			
		//	Globals.s_logger.log("now time : " + flash.utils.getTimer() + "begin selfEstablishClient.ok");
		}
		
		private static const ESTABLISH_VERIFY_ERROR:String = "verify_error";
		private static const ESTABLISH_FAIL_MAX_COUNT:int = 1;
		private var establishFailCount:int = 0;
	}
}
