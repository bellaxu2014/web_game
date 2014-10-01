package game.core
{
	/**
	 * 颜色定义
	 * @author BellaXu
	 */
	public class GameColor
	{
		/**ui-label**/
		public static const UI_LABEL:uint = 0xffe9a9;
		/**ui-备注**/
		public static const UI_REMARK:uint = 0xa39c66;
		/**ui-备注**/
		public static const UI_REMARK_STR:String = "#a39c66";
		/**ui-技能名字**/
		public static const TIP_SKILL_NAME:uint = 0xff7b23;
		/**ui-技能焦点**/
		public static const TIP_SKILL_FOCUS:uint = 0x84e6ff;
		/**ui-技能名字**/
		public static const TIP_SUBTITLE:uint = 0xffaa3c;
		
		/**int黑色**/
		public static const INT_BLACK:uint = 0x000000;
		/**int灰色**/
		public static const INT_GRAY:uint = 0x878888;
		/**int白色**/
		public static const INT_WIHTE:uint = 0xfff5d2;
		/**int黄色**/
		public static const INT_YELLOW:uint = 0xfcc738;
		/**int绿色**/
		public static const INT_GREEN:uint = 0x8afd5c;
		/**int蓝色**/
		public static const INT_BLUE:uint = 0x06bffc;
		/**int紫色**/
		public static const INT_PURPLE:uint = 0xe65eff;
		/**int红色**/
		public static const INT_RED:uint = 0xff6a78;
		
		/**str黑色**/
		public static const STR_BLACK:String = "#000000";
		/**str灰色**/
		public static const STR_GRAY:String = "#878888";
		/**str白色**/
		public static const STR_WHITE:String = "#fff5d2";
		/**str黄色**/
		public static const STR_YELLOW:String = "#fcc738";
		/**str绿色**/
		public static const STR_GREEN:String = "#8afd5c";
		/**str蓝色**/
		public static const STR_BLUE:String = "#06bffc";
		/**str紫色**/
		public static const STR_PURPLE:String = "#e65eff";
		/**str红色**/
		public static const STR_RED:String = "#ff6a78";
		
		/**
		 * 获取品质对应的颜色
		 */
		public static function getColorByQuality(q:int):String
		{
			switch(q)
			{
				case 0:
					return STR_WHITE;
				case 1:
					return STR_GREEN;
				case 2:
					return STR_BLUE;
				case 3:
					return STR_PURPLE;
				case 4:
					return STR_YELLOW;
			}
			return STR_WHITE;
		}
	}
}