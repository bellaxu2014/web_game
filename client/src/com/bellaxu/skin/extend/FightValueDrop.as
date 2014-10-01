package com.bellaxu.skin.extend
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.skin.BXImage;
	
	import game.core.GameResLoader;

	/**
	 * 战斗力掉落
	 * @author BellaXu
	 */
	public class FightValueDrop extends FightValueNumber
	{
		private var _redImg:BXImage;
		
		public function FightValueDrop()
		{
			super();
			
			_redImg = ObjectPool.get(BXImage);
			_redImg.bitmapData = GameResLoader.getExtendBitmapData("ImageNumber7_-");
			_redImg.x = _signImg.width;
			_redImg.y = _signImg.height - _redImg.height >> 1;
			addChild(_redImg);
			
			_imgNum.style = 7;
			_imgNum.x = _redImg.x + _redImg.width;
		}
		
		override public function set position(value:uint):void
		{
			
		}
	}
}