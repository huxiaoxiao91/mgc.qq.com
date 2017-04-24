package com.h3d.qqx5.framework.network
{
	import flash.utils.ByteArray;

	/**
	 * @author liuchui
	 */
	public interface INetConnection
	{
		function is_connected() : Boolean;
		
		function connectWithAccount(host : String, port : int, account : uint, ticket : ByteArray) : void;
		
		function send_raw_message(msg : INetMessage) : void;
		
		function send_message(msg : INetMessage, serialID:int) : void;
		
		function close() : void;
		
		function update() : void;
	}
}
