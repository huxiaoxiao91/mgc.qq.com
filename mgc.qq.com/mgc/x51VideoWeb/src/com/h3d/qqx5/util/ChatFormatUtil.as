package com.h3d.qqx5.util
{
	import com.h3d.qqx5.common.Globals;
	
	import flash.net.getClassByAlias;

	/**
	 * @author liuchui
	 */
	public class ChatFormatUtil
	{
		public function ChatFormatUtil()
		{
			
		}
		
		private static const x5_chat_special_char:String = "$";
		private static const x5_chat_text_head:String = "$t$";
		private static const x5_chat_text_tail:String = "$z";
		private static const x5_chat_image_head:String = "$i";
		private static const x5_chat_image_tail:String = "$18$18$";
		private static const FIND_START:int = 0;
		private static const FIND_TEXT:int = 1;
		private static const FIND_IMAGE:int = 2;
		private static const FIND_LINK_TEXT:int = 3;
		
		public static function WebChatFormatToX5ChatFormat(chatnodes:Array):String
		{
			var res:String = "";
			for(var i:int=0; i < chatnodes.length; ++i)
			{
				var node:Object = chatnodes[i];
				if(node.nodeType == ChatNode.TEXT)
				{
					res += x5_chat_text_head + Replace$InWebMsg(node.content) + x5_chat_text_tail;
				}
				else if(node.nodeType == ChatNode.IMAGE)
				{
					res += x5_chat_image_head + node.content + x5_chat_image_tail;
				}
			}
			return res;
		}
		
		public static function WebChatFormatToX5ChatFormatV2(chat_msg:String):String
		{
			if(chat_msg == null)
			{
				Globals.s_logger.log("chat_msg is null");
				return "";
			}
			var msg_end:int = chat_msg.length;
			var pos:int = 0;
			var last_pos:int = 0;
			var parse_stat:int = FIND_START;
			var failure:Boolean = false;
			var str:String = "";
			while (pos != msg_end && pos != -1 && !failure)
			{
				switch (parse_stat)
				{
					case FIND_START:
					{
						pos = chat_msg.indexOf("/mgcchat_", pos);
						var start:int = pos;
						if (start != -1)
						{
							//找到了表情
							var face_end:int = start + 12;
							if(last_pos != start)
							{
								str += x5_chat_text_head + chat_msg.substring(last_pos,start) + x5_chat_text_tail;
							}
							parse_stat = FIND_IMAGE;
							if (face_end > msg_end)
							{
								//找打了表情标识，但是长度不够。
								return str + x5_chat_text_head + chat_msg.substring(start) + x5_chat_text_tail;
							}
						}
						else 
						{
							//没找到表情,从当前查找节点到最后的内容都是文字
							str += x5_chat_text_head + chat_msg.substring(last_pos) + x5_chat_text_tail;
						}
					}
						break;
					case FIND_IMAGE:
					{
						var uir_name_beg:int = pos + 9;
						var uir_name_end:int = uir_name_beg + 3;
						if(uir_name_end != -1)
						{
							var uir:String = chat_msg.substring(uir_name_beg, uir_name_end);
							if(uir.length > 0)
							{
								str += x5_chat_image_head + uir + x5_chat_image_tail;
							}
						}
						else 
						{
							failure = true;
							break;
						}
						parse_stat = FIND_START;
						pos += 12;
						last_pos = pos;
					}
						break;
				}
			}
			return str;
		}
		
		public static function X5ChatFormatToWebChatFormatV2(chat_msg:String):String
		{
			var res:Array = new Array;
			res = X5ChatFormatToWebChatFormat(chat_msg);
			var str:String ="";
			for each(var node:ChatNode in res)
			{
				if(node.nodeType == ChatNode.TEXT)
				{
					str += node.content;
				}
				else if(node.nodeType == ChatNode.IMAGE)
				{
					str += "/mgcchat_" + node.content;
				}
			}
			return str;
		}
		
		
		public static function X5ChatFormatToWebChatFormat(chat_msg:String):Array
		{
			var res:Array = new Array;
			var msg_end:int = chat_msg.length;
			var pos:int = 0;
			var mypPattern:RegExp = /\\/g;
			
			var parse_stat:int = FIND_START;
			var failure:Boolean = false;
			while (pos != msg_end && pos != -1 && !failure)
			{
				switch (parse_stat)
				{
					case FIND_START:
					{
						pos = chat_msg.indexOf(x5_chat_special_char, pos);
						if (pos != -1)
						{
							pos++;
							if (pos != msg_end)
							{
								var ch:String = chat_msg.charAt(pos);
								if (ch == "t")
								{
									parse_stat = FIND_TEXT;
								}
								else if (ch == "i")
								{
									parse_stat = FIND_IMAGE;
								}
								else if (ch == "l")
								{
									parse_stat = FIND_LINK_TEXT;
								}
							}
						}
					}
						break;
					case FIND_TEXT:
					{
						var text_start:int = chat_msg.indexOf(x5_chat_special_char, pos);
						if (text_start != -1)
						{
							pos = chat_msg.indexOf(x5_chat_text_tail, ++text_start);
							if (text_start != msg_end && pos != -1)
							{
								var text_str:String = chat_msg.substring(text_start, pos++);
								if(text_str.length > 0)
								{
									var node:ChatNode = new ChatNode;
									node.nodeType = ChatNode.TEXT;
									node.content = Replace$InX5Msg(text_str).replace(mypPattern,"\\\\");
									//node.content = encodeURI(Replace$InX5Msg(text_str));
									res.push(node);
									Globals.s_logger.debug("node.content:" + node.content);
								}
							}
							else
							{
								failure = true;
								break;
							}
						}
						
						parse_stat = FIND_START;
					}
						break;
					case FIND_LINK_TEXT:
					{
						var url_beg:int = ++pos;
						var url_end:int = chat_msg.indexOf(x5_chat_special_char, pos);
						failure = true;
						if (url_end != -1)
						{
							var url:String = chat_msg.substring(url_beg, url_end);
							var realinfo:String = "";
							
							var font_begin:int = chat_msg.indexOf(x5_chat_special_char, ++url_end);
							if (font_begin != -1)
							{
								var text_start1:int = chat_msg.indexOf(x5_chat_special_char, ++font_begin);
								if (text_start1 != -1)
								{
									pos = chat_msg.indexOf(x5_chat_text_tail, ++text_start1);
									if (text_start1 != msg_end && pos != -1)
									{
										realinfo = chat_msg.substring(text_start1, pos++);
										
										if(realinfo.length > 0)
										{
											var node1:ChatNode = new ChatNode;
											node1.nodeType = ChatNode.TEXT;
											node1.content = Replace$InX5Msg(realinfo).replace(mypPattern,"\\\\");
											res.push(node1);
										}
										failure = false;
									}
								}
							}
						}
						
						if (failure)
						{
							break;
						}
						parse_stat = FIND_START;
					}
						break;
					case FIND_IMAGE:
					{
						var uir_name_beg:int = ++pos;
						var uir_name_end:int = chat_msg.indexOf(x5_chat_special_char, pos);
						if (uir_name_end != -1)
						{
							var uir:String = chat_msg.substring(uir_name_beg, uir_name_end);
							if(uir.length > 0)
							{
								var node2:ChatNode = new ChatNode;
								node2.nodeType = ChatNode.IMAGE;
								node2.content = uir;
								res.push(node2);
							}
						}
						else
						{
							failure = true;
							break;
						}
						
						parse_stat = FIND_START;
					}
						break;
				}
			}
			return res;
		}
		
		public static function IsAllSpace(msg:String):String
		{
			var patternSpaceHead:RegExp =/^\s*/;
			var patternSpaceTail:RegExp =/\s*$/; 
			var stmp:String = msg.replace(patternSpaceHead,"").replace(patternSpaceTail,"");
			if(stmp.length == 0)
				return "";
			return stmp;
		}
		
		public static function trimMsg(msg:String):String
		{
			var start_index:int = 0;
			var end_index:int = msg.length;
			var bFindStart:Boolean = false;
			for(var i:int = 0 ;i < msg.length;i++)
			{
				if(msg.charAt(i) != " ")
				{
					if(!bFindStart)
					{
						start_index = i;
						bFindStart = true;
					}
					end_index = i;
				}
			}
			msg = msg.substring(start_index,end_index + 1);
			return msg;
		}
		
		private static function Replace$InWebMsg(msg:String):String
		{
			var res:String = "";
			for (var i:int = 0; i < msg.length; ++i)
			{
				var ch:String = msg.charAt(i);
				if (ch == x5_chat_special_char)
				{
					res += ch;
					res += ch;
				}
				else
				{
					res += ch;
				}
			}
			return res;
		}
		
		private static function Replace$InX5Msg(msg:String):String
		{
			var res:String = "";
			for (var i:int = 0; i < msg.length; ++i)
			{
				var ch:String = msg.charAt(i);
				if (ch == x5_chat_special_char)
				{
					if (i < (msg.length - 1) && msg.charAt(i + 1) == x5_chat_special_char)
					{
						res += ch;
						++i;
					}
					else
					{
						res += ch;
					}
				}
				else
				{
					res += ch;
				}
			}
			return res;
		}
	}	
}