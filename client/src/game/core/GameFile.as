package game.core
{
	import com.bellaxu.res.ResFolder;
	import com.bellaxu.res.ResType;

	/**
	 * 游戏文件的索引
	 * @author BellaXu
	 */
	public class GameFile
	{
		private static const SPLITER:String = ".";
		
		/**
		 * 语言包
		 */
		public static function getLang():String
		{
			return ResFolder.LANG + GameConf.LANG + SPLITER + ResType.LAN;
		}
		
		/**
		 * 取广告图
		 */
		public static function getLoadImage():String
		{
			return ResFolder.IMAGE + "load" + SPLITER + ResType.JPG;
		}
		
		/**
		 * 取效果文件
		 */
		public static function getEffect(name:String):String
		{
			return ResFolder.EFFECT + name + SPLITER + ResType.AMD;
		}
		
		/**
		 * 头像文件
		 */
		public static function getHeadIcon(career:int, sex:int):String
		{
			return ResFolder.IMAGE_HEAD + career + sex + SPLITER + ResType.PNG;
		}
		
		/**
		 * 获取图标
		 */
		public static function getItemIcon(id:int, size:int = 40):String
		{
			return ResFolder["ITEM_" + size] + id + SPLITER + ResType.PNG;
		}
		
		/**
		 * 获取技能图标
		 */
		public static function getSkillIcon(id:int):String
		{
			return ResFolder.SKILL + id + SPLITER + ResType.PNG;
		}
	}
}