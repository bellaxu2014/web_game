package com.bellaxu.util
{
	import game.core.GameColor;
	
	import game.core.GameConf;

	/**
	 * html包装类
	 * @author BellaXu
	 */
	public class HtmlUtil
	{
		/**
		 * 拼html串
		 */
		public static function getHtmlText(text:String, color:String = null, size:int = 12, bold:Boolean = false, face:String = null):String
		{
			if(!color)
				color = GameColor.STR_WHITE;
			if(!face)
				face = GameConf.FONT;
			return "<font face='" + face + "' size='" + size + "' color='" + color + "'>" + (bold ? "<b>" : "") + text + (bold ? "</b>" : "") + "</font>";
		}
	}
}