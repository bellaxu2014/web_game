package com.bellaxu.skin.extend
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.skin.BXDisplayObject;
	import com.bellaxu.skin.BXImage;
	
	import game.core.GameResLoader;

	/**
	 * 连斩数字
	 * @author BellaXu
	 */
	public class ComboNumber extends BXDisplayObject
	{
		private var _background:BXImage;
		private var _combo:ImageNumber;
		private var _foreground:BXImage;
		
		public function ComboNumber()
		{
			_background = ObjectPool.get(BXImage);
			_background.bitmapData = GameResLoader.getExtendBitmapData("ComboNumber_b");
			addChild(_background);
			
			_foreground = ObjectPool.get(BXImage);
			_foreground.bitmapData = GameResLoader.getExtendBitmapData("ComboNumber_f");
			_foreground.x = 85;
			_foreground.y = -2;
			addChild(_foreground);
			
			_combo = ObjectPool.get(ImageNumber);
			_combo.y = 8;
			addChild(_combo);
			
			mouseEnabled = false;
			
			combo = 0;
		}
		
		/**
		 * 连斩数
		 */
		public function set combo(value:int):void
		{
			_combo.value = value;
			_combo.x = (_background.width - _foreground.x - _combo.width>> 1) + 15;
		}
		
		public function get combo():int
		{
			return _combo.value;
		}
		
		override public function clear():void
		{
			super.clear();
			
			combo = 0;
		}
	}
}