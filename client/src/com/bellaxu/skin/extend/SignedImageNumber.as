package com.bellaxu.skin.extend
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.skin.BXDisplayObject;
	import com.bellaxu.skin.BXImage;

	/**
	 * 带符号图片数字
	 * @author BellaXu
	 */
	internal class SignedImageNumber extends BXDisplayObject
	{
		protected var _signImg:BXImage;
		protected var _imgNum:ImageNumber;
		
		public function SignedImageNumber()
		{
			_signImg = ObjectPool.get(BXImage);
			addChild(_signImg);
			
			_imgNum = ObjectPool.get(ImageNumber);
			addChild(_imgNum);
			
			mouseEnabled = false;
		}
		
		/**
		 * 值
		 */
		public function set value(val:int):void
		{
			_imgNum.value = val;
		}
		
		public function get value():int
		{
			return _imgNum.value;
		}
		
		override public function clear():void
		{
			super.clear();
			
			mouseEnabled = false;
			
			value = 0;
		}
	}
}