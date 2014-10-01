package com.bellaxu.res
{
	import com.bellaxu.util.MathUtil;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	/**
	 * 资源版本日期
	 * @author BellaXu
	 */
	public class ResVer
	{
		private static var dic:Dictionary = new Dictionary();
		
		public static function init(bytes:ByteArray):void
		{
			bytes.uncompress();
			bytes.position = 0;
			while (bytes.bytesAvailable > 0)
			{
				dic[bytes.readUTF()] = bytes.readUTF();
			}
		}
		
		public static function getVer(url:String):String
		{
			if(dic[url])
				return dic[url];
			//找不到版本，就返回随机版本
			var ran:int = MathUtil.getRandomInt(10000, 99999);
			return ran.toString();
		}
	}
}