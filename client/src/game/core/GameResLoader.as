package game.core
{
	import com.bellaxu.res.ResLoader;
	import com.bellaxu.res.ResPath;
	import com.bellaxu.util.JsUtil;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.utils.ByteArray;
	
	/**
	 * 游戏资源加载器
	 * @author BellaXu
	 */
	public class GameResLoader
	{
		public static var loadedNum:int = 0;
		public static var totalNum:int = 0;
		public static var queue:Vector.<String> = new <String>[
			ResPath.VERSION,
			GameFile.getLang(),
			ResPath.SKIN_BASIC,
			ResPath.GAME,
			ResPath.CONFIG,
			ResPath.SKIN_EXTEND
		];
		
		private static var loader:ResLoader = new ResLoader();
		private static var completeFunc:Function;
		private static var progressFunc:Function;
		
		public static function load(onComplete:Function, onProgress:Function):void
		{
			totalNum = queue.length;
			completeFunc = onComplete;
			progressFunc = onProgress;
			continueLoad();
		}
		
		private static function continueLoad():void
		{
			if(loadedNum < totalNum)
			{
				var url:String = queue[loadedNum];
				var ver:String = url == ResPath.VERSION ? JsUtil.getGameVer() : null;
				if(url == ResPath.GAME)
					url = GameConf.isDebug ? ResPath.GAME_TEST : ResPath.GAME;
				loader.load(url, onLoaded, onProgress, null, ver);
			}
		}
		
		private static function onProgress(bytesLoaded:uint, bytesTotal:uint):void
		{
			if(progressFunc != null)
				progressFunc(bytesLoaded, bytesTotal);
		}
		
		private static function onLoaded(url:String):void
		{
			loadedNum++;
			completeFunc(url);
			continueLoad();
		}
		
		/**
		 * 取基础皮肤
		 */
		public static function getBasicSkin(name:String):MovieClip
		{
			return loader.getMc(ResPath.SKIN_BASIC, name);
		}
		
		/**
		 * 取基础包下位图
		 */
		public static function getBasicBitmapData(name:String):BitmapData
		{
			return loader.getBmd(ResPath.SKIN_BASIC, name);
		}
		
		/**
		 * 取扩展包下皮肤
		 */
		public static function getExtendSkin(name:String):MovieClip
		{
			return loader.getMc(ResPath.SKIN_EXTEND, name);
		}
		
		/**
		 * 取扩展包下位图
		 */
		public static function getExtendBitmapData(name:String):BitmapData
		{
			return loader.getBmd(ResPath.SKIN_EXTEND, name);
		}
		
		public static function getBytes(url:String):ByteArray
		{
			return loader.getBytes(url);
		}
		
		public static function getContent(url:String):*
		{
			return loader.getContent(url);
		}
		
		/**
		 * 取主域中类定义
		 */
		public static function getClass(name:String):Class
		{
			return loader.getDefClass(null, name);
		}
	}
}