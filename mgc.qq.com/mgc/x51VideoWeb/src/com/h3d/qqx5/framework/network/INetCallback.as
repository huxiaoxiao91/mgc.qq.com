package com.h3d.qqx5.framework.network
{
	import flash.events.Event;

	/**
	 * @author liuchui
	 */
	public interface INetCallback
	{
		function onRawConnected():void;
		
		function onRawDisConnected(err:Event,isClose:Boolean=false):void;
		
		function onDispatchEvent(p:INetMessage, serialID:int):void;
	}	
}