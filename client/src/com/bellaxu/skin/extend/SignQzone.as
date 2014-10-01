package com.bellaxu.skin.extend
{
	import com.bellaxu.skin.BXImage;
	
	import game.core.GameResLoader;

	/**
	 * 黄钻标识
	 * @author BellaXu
	 */
	public class SignQzone extends BXImage
	{
		public function SignQzone()
		{
			
		}
		
		private var _isYear:Boolean;
		/**
		 * 是否年钻
		 */
		public function set isYear(value:Boolean):void
		{
			_isYear = value;
			level = _level;
		}
		
		public function get isYear():Boolean
		{
			return _isYear;
		}
		
		private var _level:int;
		
		/**
		 * 黄钻等级
		 */
		public function set level(value:int):void
		{
			_level = value;
			bitmapData = GameResLoader.getExtendBitmapData("SignQzone" + (_isYear ? "1_" : "0_") + value);
		}
		
		public function get level():int
		{
			return _level;
		}
		
		override public function clear():void
		{
			super.clear();
			
			_isYear = false;
			_level = 0;
		}
	}
}
