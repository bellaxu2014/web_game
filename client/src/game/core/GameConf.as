package game.core
{
	import flash.display.Stage;

	/**
	 * 游戏自定义变量
	 * @author BellaXu
	 */
	public class GameConf
	{
		//-----------------------------------常量-----------------------------------------
		/**最小宽**/
		public static const MIN_WIDTH:int = 1024;
		/**最小高**/
		public static const MIN_HEIGHT:int = 576;
		/**额定帧频**/
		public static const FPS:int = 60;
		/**背景色**/
		public static const BG_COLOR:uint = 0x000000;
		/**字体**/
		public static const FONT:String = "Microsoft YaHei";
		/**语言**/
		public static const LANG:String = "zh-cn";
		
		//-----------------------------------变量-----------------------------------------
		/**舞台**/
		public static var stage:Stage = null;
		/**资源服务器地址**/
		public static var cdnPath:String = "res/";
		/**url传参**/
		public static var urlval:Object = null;
		
		//-----------------------------------方法-----------------------------------------
		/**
		 * 是否为调试环境
		 */
		public static function get isDebug():Boolean
		{
			return !urlval || !urlval.ServerAddress || !urlval.Port;
		}
	}
}