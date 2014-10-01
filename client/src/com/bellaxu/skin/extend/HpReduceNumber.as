package com.bellaxu.skin.extend
{
	import game.core.GameResLoader;

	/**
	 * hp减少
	 * @author BellaXu
	 */
	public class HpReduceNumber extends SignedImageNumber
	{
		public function HpReduceNumber()
		{
			super();
			
			_signImg.bitmapData = GameResLoader.getExtendBitmapData("ImageNumber5_-");
			
			_imgNum.style = 5;
			_imgNum.x = _signImg.width;
			_imgNum.value = 0;
			
			mouseEnabled = false;
		}
	}
}