package com.bellaxu.skin.extend
{
	import com.bellaxu.skin.BXPosition;
	
	import game.core.GameResLoader;

	/**
	 * 战斗力数字
	 * @author BellaXu
	 */
	public class FightValueNumber extends SignedImageNumber
	{
		public function FightValueNumber()
		{
			super();
			
			_signImg.bitmapData = GameResLoader.getExtendBitmapData("Attr_fightvalue");
			
			_imgNum.style = 8;
			_imgNum.x = _signImg.width;
			_imgNum.value = 0;
			
			mouseEnabled = false;
		}
		
		private var _position:uint = 2;
		
		public function set position(value:uint):void
		{
			if(value < BXPosition.LEFT)
				value = BXPosition.LEFT;
			if(value > BXPosition.RIGHT)
				value = BXPosition.RIGHT;
			_position = value;
			if(value == BXPosition.LEFT)
			{
				_signImg.x = 0;
				_imgNum.x = _signImg.width;
			}
			else if(value == BXPosition.RIGHT)
			{
				_imgNum.x = 0;
				_signImg.x = _imgNum.width;
			}
		}
		
		override public function set value(val:int):void
		{
			super.value = val;
			position = _position;
		}
		
		override public function clear():void
		{
			super.clear();
			
			_position = 2;
		}
	}
}