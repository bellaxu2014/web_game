package com.bellaxu.skin.extend
{
	import game.core.GameResLoader;

	/**
	 * hp增加
	 * @author BellaXu
	 */
	public class HpAddNumber extends SignedImageNumber
	{
		public function HpAddNumber()
		{
			super();
			
			_signImg.bitmapData = GameResLoader.getExtendBitmapData("ImageNumber4_+");
			
			_imgNum.style = 4;
			_imgNum.x = _signImg.width;
			_imgNum.value = 0;
			
			mouseEnabled = false;
		}
	}
}