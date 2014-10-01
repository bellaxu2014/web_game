package game.core
{
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;

	/**
	 * 游戏中用到的滤镜
	 * @author BellaXu
	 */
	public class GameFilter
	{
		/**
		 * ui-发光-白色
		 */
		public static var UI_GLOW_WHITE:GlowFilter = new GlowFilter(0xffffff, 0.4, 2, 2, 2, BitmapFilterQuality.LOW, false, false);
		/**
		 * ui-发光-黑色
		 */
		public static var UI_GLOW_BLACK:GlowFilter = new GlowFilter(0x000000, 0.8, 2, 2, 2, BitmapFilterQuality.LOW, false, false);
		/**
		 * 发光-黄色
		 */
		public static var GLOW_YELLOW:GlowFilter = new GlowFilter(0xF14400, 1, 3, 3, 2, BitmapFilterQuality.LOW, false, false);
		/**
		 * 发光-白色
		 */
		public static var GLOW_WHITE:GlowFilter = new GlowFilter(0xffffff, 1, 2, 2, 4, BitmapFilterQuality.LOW, false, false);
		/**
		 * 发光-红色
		 */
		public static var GLOW_RED:GlowFilter = new GlowFilter(0xff1800, 1, 2, 2, 4, BitmapFilterQuality.LOW, false, false);
		/**
		 * 发光-绿色
		 */
		public static var GLOW_GREEN:GlowFilter = new GlowFilter(0x6ff00, 1, 2, 2, 4, BitmapFilterQuality.LOW, false, false);
	}
}