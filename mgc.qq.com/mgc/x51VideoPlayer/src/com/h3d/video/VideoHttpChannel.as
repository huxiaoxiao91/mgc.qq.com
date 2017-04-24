package com.h3d.video
{
	import com.h3d.util.Log;
	import com.h3d.util.Tracer;
	import com.h3d.video.FLVFrame;
	import com.h3d.video.VideoDataRevSink;
	import com.junkbyte.console.Cc;
	
	import flash.errors.*;
	import flash.events.*;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Endian;


	/*
	** 主要功能：
	** 1.下载音、视频数据
	** 2.断线时，通知VideoEngine（未实现）
	*/
	public class VideoHttpChannel {
		
		/**
		 * HTTP状态 200为成功
		 */
		private var _responseCode:uint;
		private var _tryConnCnt:int;
		private var _cdnUrl:String;
		private var _cdnIp:String;
		private var _cdnPort:int;
		private var _socket:Socket;
		private var _readBuffer:ByteArray;
		private var _writeOffset:int;
		
		/**
		 * 当前解析的状态
		 */
		private var _httpParserStatus:int;
		private var _chunkEncoding:Boolean;
		private var _chunkSize:int;
		private var _frameParserStatus:int;
		private var _headerBuf:ByteArray;
		private var _flvFrame:FLVFrame;
		private var _dataRecvCallback:VideoDataRevSink;
		
		public static const CDNDataTypeAudio:int = 1;
		public static const CDNDataTypeVideo:int = 2;
		
		/*
		** 网络连接相关的错误处理
		*/
		// 数据接收超时，重新连接
		public static const RETRY_CODE:int = 1000;
		// 对端关闭连接时，重新连接当前正用的CDN
		public static const RETRY_BE_CLOSED_CODE:int = 1001;
		// CDN无法连接，或http响应不是200时，尝试连接列表中下一个CDN
		public static const ERROR:int = 0;
		// 对一个CDN地址尝试重连的次数，超过最大次数时，就不再连接这个CDN地址，
		public static const RETRY_CDN_CNT:int = 10;
		// 数据接收超时时间
		public static const NO_DATA_INTER:int = 10000; // 毫秒
		
		//上一次接收数据的时间  毫秒
		private var lastTime:Number;
		
		//
		// TODO(zhou):
		//    超过4秒没收到数据时，重新连接
		//    对端关闭连接...
		
		
		private static const LOGFILTER:String = "CDNFrame: ";
		
		private static const kStartLine:int = 0;
		private static const kHeaders:int = 1;
		private static const kContentBody:int = 2;
		private static const kChunkedStartLine:int = 3;
		private static const kChunkedContinuing:int = 4;
		private static const kCompletion:int = 5;
		
		private static const STATUS_TX_HEADER:int = 0;
		private static const STATUS_DATA:int = 1;
		
		private static const CRLF:String = "\r\n";
		
		private static const TX_HEADER_SIZE:uint = 26;
		
		private static const HT_HEADER:int = 1; // flv header
		private static const HT_DATA:int = 2; // data frame
		
		public function VideoHttpChannel(dataRecvCallback:VideoDataRevSink) {
			_httpParserStatus = kStartLine;
			_frameParserStatus = STATUS_TX_HEADER;
			_responseCode = 0;
			_chunkSize = 0;
			_writeOffset = 0;
			
			_readBuffer = new ByteArray();
			_readBuffer.endian = Endian.LITTLE_ENDIAN;
			
			_socket = new Socket();
			_socket.endian = Endian.LITTLE_ENDIAN;
			
			_dataRecvCallback = dataRecvCallback;
			
			_headerBuf = new ByteArray();
			_headerBuf.endian = Endian.LITTLE_ENDIAN;
			
			configureListeners();
		}
		
		public function setUrl(url:String, tryCdnCnt:int):Boolean {
			do {
				if (url.length == 0)
					break;
				
				_cdnUrl = url;
				
				var start:int = url.indexOf("//");
				if (start == -1)
					break;
				
				start += "//".length;
				
				var end:int = url.indexOf("/", start);
				if (end == -1)
					break;
				
				var addrStr:String = url.substring(start, end)
				if (addrStr.length == 0)
					break;
				
				var result:Array = addrStr.split(":", 2);
				if (result.length != 2)
					break;
				
				_cdnIp = result[0];
				_cdnPort = int(result[1]);
				
				if (_cdnIp.length == 0)
					break;
				if (_cdnPort == 0)
					break;
				
				_tryConnCnt = tryCdnCnt;
				
				Tracer.log(LOGFILTER +
					"success to parse url [" + _cdnIp + "]" +
					", port[" + _cdnPort + "]" +
					", Try count:" + _tryConnCnt);
				
				return true;
				
			}while(0);
			
			Tracer.log(LOGFILTER + "failed to parse url[" + url + "]");
			
			return false;
		}
		
		public function connect(url:String, retryCount:int):void {
			if (!setUrl(url, retryCount)) {
				return;
			}
			
			Log.showLog("连接ip",_cdnIp,"端口",_cdnPort);
			Log.formatLogMsg(0,"连接ip" + _cdnIp + "端口" + _cdnPort);
			
			_socket.connect(_cdnIp, _cdnPort);
		}
		
		public function stop():void {
			if(_socket.connected)
			{
				_socket.close();
			}
			
			reset();
		}
		
		private function reset():void 
		{
			_httpParserStatus = kStartLine;
			_frameParserStatus = STATUS_TX_HEADER;
			_responseCode = 0;
			_chunkSize = 0;
			_writeOffset = 0;
			
			_readBuffer = new ByteArray();
			_readBuffer.endian = Endian.LITTLE_ENDIAN;
			
			_headerBuf = new ByteArray();
			_headerBuf.endian = Endian.LITTLE_ENDIAN;
		}
		
		private function configureListeners():void {
			_socket.addEventListener(Event.CLOSE, closeHandler);
			_socket.addEventListener(Event.CONNECT, connectHandler);
			_socket.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
		}
		
		private function writeln(str:String):void {
			str += CRLF;
			try {
				_socket.writeUTFBytes(str);
			}
			catch(e:IOError) {
				Tracer.log(e.toString());
			}
		}
		
		private function bytesArrayReadLine(buf:ByteArray):String {
			var oldPos:uint = buf.position;
			var str:String = new String();
			while (buf.bytesAvailable > 0) {
				str += buf.readUTFBytes(1);
				if (str.lastIndexOf(CRLF) != -1)
					return str;
			}
			
			buf.position = oldPos;
			return "";
		}
		
		private function sendRequest():void {
			Tracer.log("sendRequest");
			writeln("GET " + _cdnUrl + " HTTP/1.1");
			writeln("Host: " + _cdnIp + ":" + _cdnPort);
			writeln("Accept: */*");
			writeln("Connection: Keep-Alive");
			writeln("");
			_socket.flush();
		}
		
		/**
		 * 
		 * 对服务器返回数据进行解析
		 * 
		 */		
		private function ParseHttpMsg(buf:ByteArray):int {
			var dataLeft:uint = buf.bytesAvailable;
			var ok:Boolean = true;
			
			/*Tracer.log("ParseHttpMsg, _httpParserStatus:" + _httpParserStatus +
					", buf.position:" + buf.position +
					", buf.bytesAvailable:" + buf.bytesAvailable);*/
			
			do {
				switch (_httpParserStatus) {
					
					//获取HTTP头信息 HTTP/1.1 200 OK
					case kStartLine: {
						ok = ParseHttpStartLine(buf);
						Log.formatLogMsg(0,"连接服务器成功");
						break;
					}
					
					//又一个头信息 Server: qqlive_stream
					case kHeaders: {
						ok = ParseHttpHeader(buf);
						break;
					}
					
					//解析视频音频数据
					case kContentBody: {
						ok = ParseHttpContentBody(buf);
						break;
					}
						
					case kChunkedStartLine: {
						ok = ParseChunkedStartLine(buf);
						break;
					}
						
					case kChunkedContinuing: {
						ok = ParseChunkedData(buf);
						break;
					}
						
					case kCompletion: {
						break;
					}
				}
				
			}while(ok && buf.bytesAvailable > 0);
			
			return buf.bytesAvailable;
		}
		
		/**
		 * 
		 * 获取HTTP头信息
		 * 
		 */		
		private function ParseHttpStartLine(buf:ByteArray):Boolean {
			var start:uint = buf.position;
			
			var startLine:String = bytesArrayReadLine(buf);
			
			if (startLine.length == 0)
				return false;
			
			//startLine格式 :HTTP/1.1 200 OK
			if (startLine.indexOf("HTTP/1.0") != -1 || startLine.indexOf("HTTP/1.1") != -1) {
				_httpParserStatus = kHeaders;
				
				var b:int = startLine.indexOf(" ");
				var e:int = startLine.indexOf(" ", b + 1);
				if (b != -1 && e != -1) {
					_responseCode = uint(startLine.substring(b + 1, e));
				}
				
				if (_responseCode != 200) {
					_dataRecvCallback.OnClose(ERROR, "http res != 200");
					Tracer.log("error http response:" + _responseCode);
				} else {
					Tracer.log("http response ok:" + _responseCode);
				}
			}
			
			//Tracer.log("ParseHttpStartLine: comsume," + (buf.position - start));
			//Tracer.log("ParseHttpStartLine, " +
			//	", buf.position:" + buf.position +
			//	", buf.bytesAvailable:" + buf.bytesAvailable);
			return true;
		}
		
		private function ParseHttpHeader(buf:ByteArray):Boolean {
			var start:uint = buf.position;
			//格式:Server: qqlive_stream
			var headerLine:String = bytesArrayReadLine(buf);
			if (headerLine.length == 0)
				return false;
			
			if (headerLine.indexOf(CRLF) == 0) { // http协议首部读完了
				if (_chunkEncoding) {
					_httpParserStatus = kChunkedStartLine
				} else {
					_httpParserStatus = kContentBody
				}
			} else {
				if (headerLine.indexOf("Transfer-Encoding") != -1) {
					_chunkEncoding = true;
				}
			}
			
			//Tracer.log("ParseHttpHeader: comsume," + (buf.position - start));
			//Tracer.log("ParseHttpHeader, " +
			//	", buf.position:" + buf.position +
			//	", buf.bytesAvailable:" + buf.bytesAvailable);
			return true;
		}
		
		private function ParseHttpContentBody(buf:ByteArray):Boolean {
			var start:uint = buf.position;
			OnHttpDataRecv(buf);
			//Tracer.log("ParseHttpContentBody: comsume," + (buf.position - start));
			//Tracer.log("ParseHttpContentBody, " +
			//	", buf.position:" + buf.position +
			//	", buf.bytesAvailable:" + buf.bytesAvailable);
			return true;
		}
		
		private function ParseChunkedStartLine(buf:ByteArray):Boolean {
			var chunkedLine:String = bytesArrayReadLine(buf);
			if (chunkedLine.length == 0)
				return false;
			
			var e:int = chunkedLine.indexOf(CRLF);
			if (e != -1) {
				_chunkSize = int(chunkedLine.substring(0, e));
			}
			
			if (_chunkSize == 0) {
				_httpParserStatus = kCompletion
			} else {
				_httpParserStatus = kChunkedContinuing;
			}
			return true;
		}
		
		private function ParseChunkedData(buf:ByteArray):Boolean {
			
			return true;
		}
		
		/**
		 * 
		 * 解析一次视频头  再解析一次数据 依次循环
		 * 
		 */		
		private function OnHttpDataRecv(buf:ByteArray):void {
			if (_responseCode != 200)
				return;
			
			do {
				switch (_frameParserStatus) {
					case STATUS_TX_HEADER: {
						ParseHeader(buf);
						break;
					}
						
					case STATUS_DATA: {
						ParseData(buf);
					}
				}
			} while (buf.bytesAvailable > 0);
			
			/*if(_flvFrame)
			{
				Cc.log("frameSeq:",_flvFrame._frameSeq,"dataSize:",_flvFrame._dataSize,"timestamp:",_flvFrame._timestamp);
			}*/
		}
		
		/**
		 * 
		 * 解析腾讯协议视频头
		 * 
		 */		
		private function ParseHeader(buf:ByteArray):void {
			var start:uint = buf.position;
			var remainSize:uint = TX_HEADER_SIZE - _headerBuf.position;
			if (remainSize <= buf.bytesAvailable) {
				buf.readBytes(_headerBuf, _headerBuf.position, remainSize);
				
				_headerBuf.position = 0;
				
				_flvFrame = new FLVFrame();
				_flvFrame._dataSize = _headerBuf.readUnsignedInt();
				_flvFrame._headerSize = _headerBuf.readUnsignedShort();
				_flvFrame._version = _headerBuf.readUnsignedShort();
				_flvFrame._type = _headerBuf.readByte();
				_flvFrame._keyFrame = _headerBuf.readByte();
				_flvFrame._timestamp = _headerBuf.readUnsignedInt();
				_flvFrame._frameSeq = _headerBuf.readUnsignedInt();
				_flvFrame._segId = _headerBuf.readUnsignedInt();
				_flvFrame._checksum = _headerBuf.readUnsignedInt();
				
				_headerBuf.position = 0;
				
				
				
//				Tracer.log("_flvFrame: " +
//					", _flvFrame._dataSize:" + _flvFrame._dataSize +
//					", _flvFrame._headerSize:" + _flvFrame._headerSize +
//					", _flvFrame._version:" + _flvFrame._version +
//					", _flvFrame._type:" + _flvFrame._type +
//					", _flvFrame._keyFrame:" + _flvFrame._keyFrame +
//					", _flvFrame._timestamp:" + _flvFrame._timestamp +
//					", _flvFrame._frameSeq:" + _flvFrame._frameSeq +
//					", _flvFrame._segId:" + _flvFrame._segId +
//					", _flvFrame._checksum:" + _flvFrame._checksum);
				
				if (_flvFrame._headerSize == TX_HEADER_SIZE && _flvFrame._dataSize <= 1024 * 1024) {
					_frameParserStatus = STATUS_DATA;
					_flvFrame._data = new ByteArray();
					_flvFrame._data.endian = Endian.LITTLE_ENDIAN;
				} else {
					Tracer.log("recv exception data, ignore it." +
						" headerSize:" + _flvFrame._headerSize +
						" dataSize:" + _flvFrame._dataSize);
				}
				
			} else {
				var len:uint = buf.bytesAvailable;
				buf.readBytes(_headerBuf, _headerBuf.position, buf.bytesAvailable);
				_headerBuf.position += len;
			}
			
			//Tracer.log("ParseHeader, comsume, " + (buf.position - start));
			//Tracer.log("ParseHeader, " +
			//	", buf.position:" + buf.position +
			//	", buf.bytesAvailable:" + buf.bytesAvailable);
		}
		
		/**
		 * 
		 * 解析视频数据
		 * 第一次为视频头数据
		 * 
		 */		
		private function ParseData(buf:ByteArray):void {
			var start:uint = buf.position;
			var remainSize:uint = _flvFrame._dataSize - _flvFrame._data.position;
			if (remainSize <= buf.bytesAvailable) {
				buf.readBytes(_flvFrame._data, _flvFrame._data.position, remainSize);
				_flvFrame._data.position = 0;
				
				//Tracer.log("ParseData ok. bytesAvailable: " + _flvFrame._data.bytesAvailable);
				//视频数据
				if (_flvFrame._type == HT_DATA) {
					if (_dataRecvCallback != null) {
						_dataRecvCallback.OnHttpDataRecv(_flvFrame);
					}
				} 
				//flv视频头
				else if (_flvFrame._type == HT_HEADER) {
					if (_dataRecvCallback != null) {
						_dataRecvCallback.OnMediaTypeRecv(_flvFrame._data);
					}
				}
				
				//Cc.log("解析FLVFrame,seq:",_flvFrame._frameSeq," ",(new Date).time);
				
				_frameParserStatus = STATUS_TX_HEADER;
				_flvFrame = null;
			} else {
				//Tracer.log("ParseData:" + buf.bytesAvailable);
				var len:uint = buf.bytesAvailable;
				buf.readBytes(_flvFrame._data, _flvFrame._data.position, buf.bytesAvailable);
				_flvFrame._data.position += len;
			}
			//Tracer.log("ParseData, comsume, " + (buf.position - start));
			//Tracer.log("ParseData, " +
			//	", buf.position:" + buf.position +
			//	", buf.bytesAvailable:" + buf.bytesAvailable);
		}
		
		private function closeHandler(event:Event):void {
			var errmsg:String = String("closeHandler: ") + event
			Tracer.log(errmsg);
			_dataRecvCallback.OnClose(RETRY_BE_CLOSED_CODE, errmsg);
		}
		
		private function connectHandler(event:Event):void {
			Tracer.log("connectHandler: " + event);
			sendRequest();
			_dataRecvCallback.OnConnect();
			
			lastTime = (new Date()).time;
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void {
			var errmsg:String = String("ioErrorHandler: ") + event
			Tracer.log(errmsg);
			_dataRecvCallback.OnClose(ERROR, errmsg);
		}
		
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			var errmsg:String = String("securityErrorHandler: ") + event
			Tracer.log(errmsg);
			_dataRecvCallback.OnClose(ERROR, errmsg);
		}
		
		/**
		 * 
		 * socket收到数据后回调
		 * 
		 */		
		private function socketDataHandler(event:ProgressEvent):void {
			if (_socket.bytesAvailable <= 0)
				return;

			var len:int = _socket.bytesAvailable;
			//Cc.error("接收数据包:",_socket.bytesAvailable,Log.getTimeString());
			_socket.readBytes(_readBuffer, _readBuffer.length, _socket.bytesAvailable);
			//t = gettimer
			_readBuffer.position = 0;
			//Tracer.log("_readBuffer bytesAvailable: " + _readBuffer.bytesAvailable);
			//解析之后剩余的字节数
			var dataLeft:int = ParseHttpMsg(_readBuffer);
			//Tracer.log("dataLeft: " +  dataLeft);
			//解析完的数据删除 保留剩余数据
			_readBuffer.position = 0;
			_readBuffer.writeBytes(_readBuffer, _readBuffer.length - dataLeft, dataLeft);
			_readBuffer.length = dataLeft;
			
			lastTime = (new Date()).time;

		}
		
		public function update():void 
		{
			var nowTime:Number = (new Date()).time;
			if(nowTime - lastTime > NO_DATA_INTER)
			{
				//_dataRecvCallback.OnClose(RETRY_CODE, "超时");
			}
		}
	}
}