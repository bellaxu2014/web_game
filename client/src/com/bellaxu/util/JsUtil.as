package com.bellaxu.util
{
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	/**
	 * js调用
	 * @author BellaXu
	 */
	public class JsUtil
	{
		private static var _gameConfig:Object;
		
		public static function getGameVer():String
		{
			var obj:Object = getGameConfig();
			if(obj)
				return obj['version'];
			return null;
		}
		
		/**
		 * 获取配置
		 */
		public static function getGameConfig():Object
		{
			if(_gameConfig) return _gameConfig;
			return ExternalInterface.available ? ExternalInterface.call("getClientConfig") : null;
		}
		
		/**
		 * 添加收藏
		 */
		public static function addFavorite():void
		{
			if(ExternalInterface.available)
				ExternalInterface.call("bookmark");
		}
		
		/**
		 * 导航至url
		 */
		public static function navigateTo(url:String):void
		{
			navigateToURL(new URLRequest(url), "_blank");
		}
		
		/**
		 * 刷新页面
		 */
		public static function refresh():void
		{
			if(ExternalInterface.available)
				ExternalInterface.call("refreshpage");
		}
	}
}