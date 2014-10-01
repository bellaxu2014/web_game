package com.bellaxu.skin.extend
{
	import game.core.GameResLoader;

	/**
	 * vip标识
	 * @author BellaXu
	 */
	public class SignVip extends SignedImageNumber
	{
		public function SignVip()
		{
			super();
			
			_signImg.bitmapData = GameResLoader.getExtendBitmapData("ImageNumber11_+");
			
			_imgNum.style = 11;
			_imgNum.x = _signImg.width;
			_imgNum.value = 0;
			
			mouseEnabled = false;
		}
	}
}