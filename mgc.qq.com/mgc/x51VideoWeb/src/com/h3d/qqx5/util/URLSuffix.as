package com.h3d.qqx5.util
{
	public class URLSuffix
	{
		public static function CreateVersionString():String
		{
			return "?v=" + Math.floor(Math.random()*1000000000).toString();
		}
	}
}