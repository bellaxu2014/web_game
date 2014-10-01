package com.bellaxu.util
{
	import game.core.GameConf;

	/**
	 * 路径工具
	 * @author BellaXu
	 */
	public class PathUtil
	{
		/**
		 * 获取资源全路径
		 */
		public static function getPath(path:String):String
		{
			return GameConf.cdnPath + path;
		}
		
		/**
		 * 获取文件夹
		 */
		public static function getFolder(path:String):String
		{
			var i1:int = path.lastIndexOf("/");
			i1 = i1 > -1 ? i1 + 1 : 0;
			return path.substring(0, i1);
		}
		
		/**
		 * 获取文件名
		 */
		public static function getName(path:String):String
		{
			var i1:int = path.lastIndexOf("/");
			var i2:int = path.lastIndexOf(".");
			i1 = i1 > -1 ? i1 + 1 : 0;
			i2 = i2 > -1 ? i2 : path.length;
			return path.substring(i1, i2);
		}
		
		/**
		 * 获取文件类型
		 */
		public static function getType(path:String):String
		{
			var i2:int = path.lastIndexOf(".");
			i2 = i2 > -1 ? i2 + 1 : path.length;
			return path.substring(i2, path.length);
		}
	}
}