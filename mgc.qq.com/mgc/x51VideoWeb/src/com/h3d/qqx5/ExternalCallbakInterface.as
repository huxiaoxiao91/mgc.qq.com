package com.h3d.qqx5
{
	import com.h3d.qqx5.common.Globals;
	
	import flash.external.ExternalInterface;
	import flash.utils.Dictionary;

	public class ExternalCallbakInterface
	{
		public function ExternalCallbakInterface()
		{
		}
		private var m_funcQueue:Dictionary = new Dictionary();
		
		public function RegisterFunc(op_type:int,  jsonparam:Object,callback:String, ...args):void
		{
			// 给回调函数 添加任意个参数
			var obj:CallBackFunc = null ;
			if( callback != null )
			{	
				obj = new CallBackFunc;
				obj.func = callback;
				obj.jsonparam = jsonparam;
				for( var index:int= 0; index<args[0].length ; ++index)
					obj.params.push(args[0][index]);
			}
			//把当前操作码和回调函数加入回调函数列表
			if ( m_funcQueue[op_type] != null )
			{
				var list :Array = m_funcQueue[op_type];
				list.push(obj);
				m_funcQueue[op_type] = list;
			}
			else
			{
				var list2:Array = new Array;
				list2.push(obj);
				m_funcQueue[op_type] = list2;
			}
		}
		
		private function DelFunc(op_type:int, callback:String):void
		{
			//从函数列表中剔除当前操作码对应记录
			if ( m_funcQueue[op_type].length >0 )
			{
				var list :Array = m_funcQueue[op_type];
				for(var index:int = 0; index < list.length ;  ++index)
				{
					if (list[index].func == callback)
					{
						list.splice(index,1);
						break;
					}
				}
				m_funcQueue[op_type] = list;
			}
		}
		public  function Apply(op_type:int, jsonparam:Object,useStr:Boolean = true,isNewInterface:Boolean = false):void
		{
			//var o:Object = JSON.decode(jsonparam, false);
			if(Globals.isDubug)
			{
				Globals.s_logger.debug("返回页面串：" + JSON.stringify(jsonparam));
			}
			else
			{
				Globals.s_logger.debug("返回页面串：op_type:" + jsonparam.op_type);
				Globals.s_logger.debug("返回页面串：jsonparam:" + JSON.stringify(jsonparam));
			}
			//根据操作码，查询应该回调的函数
			if ( m_funcQueue[op_type] ==null || m_funcQueue[op_type].length == 0 || m_funcQueue[op_type][0] == null ) 
			{
				Globals.s_logger.debug("Apply ExternalInterface.available:" + ExternalInterface.available + " useStr:" + useStr);
				if(useStr)
				{
					if (ExternalInterface.available) {
						try {
							var strJson:String = JSON.stringify(jsonparam);
							if(isNewInterface)
							{
								Globals.s_logger.debug("    str====>mgc.network.recvMsg");
								ExternalInterface.call("mgc.network.recvMsg",strJson);
							}
							else
							{
								if(x51VideoWeb.isOldFrame)
								{
									Globals.s_logger.debug("    str====>response_as");
									ExternalInterface.call("response_as",strJson);
								}
								else
								{
									Globals.s_logger.debug("    str====>mgc.network.recvMsg(2)");
									ExternalInterface.call("mgc.network.recvMsg",strJson);
								}
							}
							strJson = null;
						} catch (error:SecurityError) {
							Globals.s_logger.info("SecurityError:" + error.message);
						} catch (error:Error) {
							Globals.s_logger.info("Error:" + error.message);
						}
					}
				}
				else
				{
					if (ExternalInterface.available) {
						try {
							if(isNewInterface)
							{
								Globals.s_logger.debug("    obj====>mgc.network.recvMsg");
								ExternalInterface.call("mgc.network.recvMsg",jsonparam);
//								Globals.s_logger.debug("======>返回页面调用：[no fun, 1, useObj] mgc.network.recvMsg");
							}
							else
							{
								if(x51VideoWeb.isOldFrame)
								{
									Globals.s_logger.debug("    obj====>response_as");
									ExternalInterface.call("response_as",jsonparam);
//									Globals.s_logger.debug("======>返回页面调用：[no fun, 2, useObj] response_as2");
								}
								else
								{
									Globals.s_logger.debug("    obj====>mgc.network.recvMsg(2)");
									ExternalInterface.call("mgc.network.recvMsg",jsonparam);
//									Globals.s_logger.debug("======>返回页面调用：[no fun, 3, useObj] mgc.network.recvMsg");
								}
							}
						} catch (error:SecurityError) {
							Globals.s_logger.info("SecurityError:" + error.message);
						} catch (error:Error) {
							Globals.s_logger.info("Error:" + error.message);
						}
					}
				}
			}
			else
			{
				Globals.s_logger.debug("Apply useFunc ExternalInterface.available:" + ExternalInterface.available + " useStr:" + useStr);
				//obj.jsonparam
				var queueIndex:int = 0;
				//-2请求的监听函数可能会被替换，返回的时候需要找到查询时使用的监听函数
				if (op_type == -2 && jsonparam.hasOwnProperty("qq")) {
					for (var i:int = 0; i < m_funcQueue[op_type].length; i++) {
						if ((m_funcQueue[op_type][i]).hasOwnProperty("jsonparam")
							&& m_funcQueue[op_type][i].jsonparam != null) {
							if (m_funcQueue[op_type][i].jsonparam.qq == jsonparam.qq) {
								queueIndex = i;
								if (i != 0) {
									Globals.s_logger.debug("-2 找到对应的返回函数（有多个情况）index=" + i);
								}
								break;
							}
						}
					}
				}
				var func :String = m_funcQueue[op_type][queueIndex].func; //插入的时候会是不同的名称吗，删除的时候 只删除第一个？
//				Globals.s_logger.info("AS Callback to webpage:回调是" + func);

				if (useStr) 
				{
					m_funcQueue[op_type][queueIndex].params.unshift(JSON.stringify(jsonparam));
				}
				else 
				{
					m_funcQueue[op_type][queueIndex].params.unshift(jsonparam);
				}
				//m_funcQueue[op_type][0].params.unshift(func);
				//ExternalInterface.call.apply(null, m_funcQueue[op_type][0].params);
				// 不定长参数 传出去的时候要传[0]出去
//				Globals.s_logger.info("AS Callback to webpage22:" + strJson);
				Globals.s_logger.debug("======>返回页面调用：functionName = " + func);
				callFunc(func,m_funcQueue[op_type][queueIndex].params);
				DelFunc(op_type,func);
			}
			Globals.s_logger.debug(" Apply() end");
		}
		
		private function callFunc(functionName:String,... arguments):void
		{
			arguments[0].unshift(functionName);
			
			ExternalInterface.call.apply(null, arguments[0]);
		}
	}
}