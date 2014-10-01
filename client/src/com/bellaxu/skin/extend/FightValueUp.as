package com.bellaxu.skin.extend
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.skin.BXImage;
	
	import game.core.GameResLoader;

	/**
	 * 战斗力提升
	 * @author BellaXu
	 */
	public class FightValueUp extends FightValueNumber
	{
		private var _addImg:BXImage;
		
		public function FightValueUp()
		{
			super();
			
			_addImg = ObjectPool.get(BXImage);
			_addImg.bitmapData = GameResLoader.getExtendBitmapData("ImageNumber6_+");
			_addImg.x = _signImg.width;
			_addImg.y = _signImg.height - _addImg.height >> 1;
			addChild(_addImg);
			
			_imgNum.style = 6;
			_imgNum.x = _addImg.x + _addImg.width;
		}
		
		override public function set position(value:uint):void
		{
			
		}
	}
}