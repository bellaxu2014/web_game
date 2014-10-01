package game.core
{
	/**
	 * 游戏正则
	 * @author BellaXu
	 */
	public class GameReg
	{
		/**Html**/
		public static const HTML:RegExp = /<(.*)>.*<\/>|<(.*) \/>/;
		/**非数字*/
		public static const NO_DIGIT:RegExp = /^[0-9]*$/;
		/**换行*/
		public static const WRAP:RegExp = /\r\n/g;
	}
}