package com.bellaxu.skin.extend
{
	import game.core.GameResLoader;

	/**
	 * mp增加
	 * @author BellaXu
	 */
	public class MpAddNumber extends SignedImageNumber
	{
		public function MpAddNumber()
		{
			super();
			
			_signImg.bitmapData = GameResLoader.getExtendBitmapData("ImageNumber3_+");
			
			_imgNum.style = 3;
			_imgNum.x = _signImg.width;
			_imgNum.value = 0;
			
			mouseEnabled = false;
		}
	}
}