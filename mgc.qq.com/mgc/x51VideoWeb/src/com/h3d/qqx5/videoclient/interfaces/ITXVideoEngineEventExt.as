package com.h3d.qqx5.videoclient.interfaces
{
	public interface ITXVideoEngineEventExt
	{
		function OnPlay(nPlayType:int, cResult:int, nWidth:int, nHeight:int):void;
		function OnStop(nPlayType:int):void;
		function OnCommunicationClose(nErrCodeint:int):void;
		function OnCommunicationConnected():void;
	}
}