package com.bellaxu.skin.extend
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.skin.BXDisplayObject;
	import com.bellaxu.skin.BXImage;
	
	import game.core.GameResLoader;

	/**
	 * 升级数字
	 * @author BellaXu
	 */
	public class LevelupNumber extends BXDisplayObject
	{
		private var _leftF:BXImage;
		private var _lvlImg:ImageNumber;
		private var _rightF:BXImage;
		
		public function LevelupNumber()
		{
			_leftF = ObjectPool.get(BXImage);
			_leftF.bitmapData = GameResLoader.getExtendBitmapData("LevelupNumber_l");
			addChild(_leftF);
			
			_lvlImg = ObjectPool.get(ImageNumber);
			_lvlImg.style = 1;
			_lvlImg.x = _leftF.width + 10;
			addChild(_lvlImg);
			
			_rightF = ObjectPool.get(BXImage);
			_rightF.bitmapData = GameResLoader.getExtendBitmapData("LevelupNumber_r");
			_rightF.x = _lvlImg.x + _lvlImg.width + 10;
			addChild(_rightF);
			
			mouseEnabled = false;
		}
		
		private var _level:int;
		/**
		 * 等级
		 */
		public function set level(value:int):void
		{
			_level = value;
			_lvlImg.value = value;
			_rightF.x = _lvlImg.x + _lvlImg.width + 10;
		}
		
		public function get level():int
		{
			return _level;
		}
		
		override public function clear():void
		{
			super.clear();
			
			mouseEnabled = false;
			
			level = 0;
		}
	}
}