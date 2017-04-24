package com.h3d.qqx5.framework.callcenter
{
	import com.h3d.qqx5.TimerBase;
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.common.event.CEventQueryVideoAccountInfo;
	import com.h3d.qqx5.common.event.CEventVideoClientSigVerify;
	import com.h3d.qqx5.framework.network.INetCallback;
	import com.h3d.qqx5.framework.network.INetConnection;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.MessageDispacher;
	import com.h3d.qqx5.framework.network.NetConnection;
	import com.h3d.qqx5.util.StringConverter;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * @author Administrator
	 */
	public class VersionCallCenter implements INetCallback
	{
		private var _dispacth:MessageDispacher;
		private var _netConnection:INetConnection;
		private var _ip:String ="";
		private var _port:int = 0;
		private var m_unTempQQ:uint = 0;
		private var m_strTempVerify:String = "";
		private var m_unTempAppid:uint = 0;
		private var m_strTempSkey:String = "";
		
		private var UPDATETIMESPAN:int = 20;
		private var updateTimer:TimerBase = new TimerBase(UPDATETIMESPAN, updateTimerHandler);
		private var externalXML:XML;
		private var loader:URLLoader = new URLLoader();
		private var _loadfinishcallback:Function = null;
		private var m_bReady:Boolean = false;
		
		//0拉取roomproxy  1续期
		public var connectType:int = 0;
		public function VersionCallCenter(loadfinishcallback:Function)
		{
			_dispacth = new MessageDispacher;
			_dispacth.setNetCallBack(this);
			
			_netConnection = new NetConnection(_dispacth);
			_loadfinishcallback = loadfinishcallback;
			
			//加载配置版
//			loadAutoPatchConfig();
			//写死配置版
			setPublishSettingVers();
			
			initUpdateTimer();
		}
		
		/**
		 * 设置发布版本配置
		 *
		 */
		private function setPublishSettingVers():void {
			//测试服
//			_ip = "111.161.57.18";
			
			switch(Globals.ipType)
			{
				case 0:
					//内部服
					_ip = "124.207.138.230";
					break;
				case 1:
					//内部服
					_ip = "111.161.57.18";
					break;
				case 2:
					//现网
					_ip = "vvs.mgc.qq.com";
					break;
			}
			
			_port = 9861;
			m_bReady = true;
			Globals.s_logger.info("read xml,version ip:" + _ip + ",version port:" + _port);
//			if (_loadfinishcallback != null) {
//				_loadfinishcallback();
//			}
		}
		
		public function add_message_handler(msgid:uint, msgname:String, func:Function):void
		{
			_dispacth.add_message_handler(msgid, msgname, func);
		}
		
		public function Ready():Boolean{
			return m_bReady;
		}
		
		public function onRawConnected():void
		{	
			Globals.s_logger.info("onVersionConnected");
			//ConnectVersion(m_unTempQQ,m_strTempVerify,m_unTempAppid,m_strTempSkey);
			if(connectType == 0)
			{
				QueryVideoAccountInfo(m_unTempQQ,m_strTempVerify,m_unTempAppid,m_strTempSkey);
			}
			else if(connectType == 1)
			{
				VideoClientSigVerify();
			}
		}
		public function initUpdateTimer():void
		{
			updateTimer.StartTimer();
		}
		
		private function updateTimerHandler():void
		{
			
			if(_netConnection != null)
			{
				_netConnection.update();
			}
		}
		
		private function onAutoPatchConfigLoaded(e:Event):void
		{
			try
			{
				externalXML = new XML(loader.data);
				readNodes(externalXML);    
			}
			catch (e:TypeError)
			{
				Globals.s_logger.error("parse the XML file fail!");
			}
		}
		
		private function readNodes(node:XML):void
		{
			_ip = node.auto_patch_client[0].version_servers[0].IDC[0].addr[0].@ip;
			_port = node.auto_patch_client[0].version_servers[0].IDC[0].addr[0].@port;
			m_bReady = true;
			Globals.s_logger.info("read xml,version ip:" + _ip + ",version port:" + _port);
			if(_loadfinishcallback != null)
			{
				_loadfinishcallback();
			}
		}
		
		private function loadAutoPatchConfig():void 
		{  			
			try
			{
				loader.load(new URLRequest(Globals.SwfFolderURL + "/config/auto_patch_client.xml")); 
			} 
			catch(error:Error) 
			{
				Globals.s_logger.error("read auto_patch_client_web.xml faile");
				return;
			}
			 
			loader.addEventListener(Event.COMPLETE, onAutoPatchConfigLoaded);  
			loader.addEventListener(IOErrorEvent.IO_ERROR, onAutoPatchConfigLoadError);  
			
//			_ip = "124.207.138.230";
//			_port = 9861;
//			_ip = "192.168.2.130";
//			_port = 9861;
//			_ip = "192.168.2.250";
//			_port = 9861;
//			_ip = "192.168.1.6";
//			_port = 9861;
		}  
		private function onAutoPatchConfigLoadError(event:IOErrorEvent):void
		{
			Globals.s_logger.error("Read xml error:" + event.toString());
		}

		public function onDispatchEvent(p:INetMessage, serialID:int):void
		{
			Globals.s_logger.info("onDispatchEvent");
		}
		
		public function onRawDisConnected(err:Event,isClose:Boolean=false):void
		{
			Globals.s_logger.info("onVersionDisConnected:" + err.toString());
			if(!isClose)
			{
				_netConnection.connectWithAccount(_ip, _port,Globals.cookieQQ,StringConverter.convertStringToByteArray(m_strTempVerify));
			}
		}
		
		public function Disconnect():void
		{
			_netConnection.close();
			//updateTimer.stop();
			Globals.s_logger.info("VersionDisConnectedByClient");
		}
		public function send_raw_message(msg:INetMessage):void
		{
			_netConnection.send_raw_message(msg);
		}
		public function ConnectVersion(qq:uint,verify:String,m_appid:uint,m_skey:String):void
		{
			m_unTempQQ = qq;
			
			if(verify == null)
			{
				m_strTempVerify = "";
			}
			m_strTempVerify = verify;
			
			Globals.s_logger.debug(" ConnectVersion type:" + Globals.deviceType);
			var evt:CEventQueryVideoAccountInfo = new CEventQueryVideoAccountInfo;
			evt.device_type = Globals.deviceType;//GlobalConfig.WebDeviceType;
			var time_stamp:Date = new Date();
			evt.time_stamp = time_stamp.time;
			
			m_unTempAppid = m_appid;
			evt.m_appid = m_appid;
			Globals.s_logger.debug("ConnectVersion() qq = " + qq + "   verify = " + verify + "  m_appid = " + m_appid  + "  m_skey = " + m_skey + "  _netConnection.is_connected() = " + _netConnection.is_connected() );
			if(m_skey && m_skey.length > 0)
			{
				m_strTempSkey = m_skey;
				evt.m_skey = m_skey;
			}
			else
			{
				m_strTempSkey = "";
				evt.m_skey = "";
			}

			if(_netConnection.is_connected())
			{
				Globals.s_logger.debug("ConnectVersion() send_raw_message");
				_netConnection.send_raw_message(evt);
			}
			else
			{
				Globals.s_logger.debug("ConnectVersion() connectWithAccount");
				_netConnection.connectWithAccount(_ip, _port,qq,StringConverter.convertStringToByteArray(verify));
			}
		}
		
		
		//拉取roomproxy地址
		private function QueryVideoAccountInfo(qq:uint,verify:String,m_appid:uint,m_skey:String):void
		{
			m_unTempQQ = qq;
			
			if(verify == null)
			{
				m_strTempVerify = "";
			}
			m_strTempVerify = verify;
			
			var evt:CEventQueryVideoAccountInfo = new CEventQueryVideoAccountInfo;
			evt.device_type = Globals.deviceType;
			var time_stamp:Date = new Date();
			evt.time_stamp = time_stamp.time;
			
			m_unTempAppid = m_appid;
			evt.m_appid = m_appid;
			if(m_skey && m_skey.length > 0)
			{
				m_strTempSkey = m_skey;
				evt.m_skey = m_skey;
			}
			else
			{
				m_strTempSkey = "";
				evt.m_skey = "";
			}
			
			if(_netConnection.is_connected())		
			{
				Globals.s_logger.debug("ConnectVersion() send_raw_message");
				_netConnection.send_raw_message(evt);
			}
		}
		
		//续期
		public function VideoClientSigVerify():void
		{
			var ev:CEventVideoClientSigVerify = new CEventVideoClientSigVerify();
			ev.appid = m_unTempAppid;
			ev.key = m_strTempSkey;
			_netConnection.send_raw_message(ev);
		}
		
		//此连接用于续期
		public function connect(appid:int,key:String):void
		{
			m_unTempAppid = appid;
			m_strTempSkey = key;
			connectType = 1;
			_netConnection.connectWithAccount(_ip, _port,Globals.cookieQQ,StringConverter.convertStringToByteArray(m_strTempVerify));
		}
		
		
		public function GetQQ():uint
		{
			return m_unTempQQ ;
		}
		
		public function GetVerify():String
		{
			return m_strTempVerify ;
		}
		
		public function GetAppid():int
		{
			return m_unTempAppid ;
		}
		
		public function GetSkey():String
		{
			return m_strTempSkey ;
		}
	}
}