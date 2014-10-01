package com.bellaxu.lang
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	/**
	 * 语言管理
	 * @author BellaXu
	 */
	public class Lang
	{
		/**
		 * 本地语言包
		 */
		private static const CLIENT:String = "client";
		/**
		 * 服务器语言包
		 */
		private static const SERVER:String = "server";
		
		private static var _dic:Dictionary;
		
		/**
		 * 导入语言
		 */
		public static function init(bytes:ByteArray):void
		{
			if(!_dic)
				_dic = new Dictionary();
			bytes.uncompress();
			bytes.position = 0;
			var name:String;
			var num:int;
			var i:int;
			while (bytes.bytesAvailable > 0)
			{
				name = bytes.readUTF();
				if(!_dic[name])
					_dic[name] = new Dictionary();
				num = bytes.readInt();
				i = 0;
				while(i++ < num)
				{
					_dic[name][bytes.readUTF()] = bytes.readUTF();
				}
			}
		}
		
		/**
		 * 获取指定语言包内的串值
		 */
		public static function getLocalString(key:String):String
		{
			if(_dic && _dic[CLIENT] && _dic[CLIENT][key])
				return _dic[CLIENT][key];
			return "";
		}
		
		/**
		 * 获取服务器串值
		 */
		public static function getServerString(key:String):String
		{
			if(_dic && _dic[SERVER] && _dic[SERVER][key])
				return _dic[SERVER][key];
			return "";
		}
	}
}