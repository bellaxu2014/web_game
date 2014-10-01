package com.bellaxu.skin
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.util.BXUtil;
	
	import flash.display.BitmapData;
	import flash.events.MouseEvent;

	/**
	 * 位图按钮
	 * @author BellaXu
	 */
	public class BXImageButton extends BXButton
	{
		private var _image:BXImage;
		
		public function BXImageButton()
		{
			_image = ObjectPool.get(BXImage);
			addChildAt(_image, 0);
			
			_style = -1;
			
			label = "";
		}
		
		/**
		 * 直接设置位图
		 */
		public function set bitmapData(value:BitmapData):void
		{
			_image.bitmapData = value;
		}
		
		/**
		 * 图片路径
		 */
		public function set source(value:String):void
		{
			_image.source = value;
		}
		
		public function get source():String
		{
			return _image.source;
		}
		
		override public function set style(value:int):void
		{
			_style = -1;
		}
		
		override public function clear():void
		{
			super.clear();
			
			label = "";
			
			_image.bitmapData = null;
		}
		
		override public function get width():Number
		{
			return _image.width;
		}
		
		override public function get height():Number
		{
			return _image.height;
		}
		
		private var _isOver:Boolean;
		
		override protected function overHandler(e:MouseEvent):void
		{
			_isOver = true;
			BXUtil.setBrightness(_image, 0.15);
		}
		
		override protected function downHandler(e:MouseEvent):void
		{
			BXUtil.setBrightness(_image, -0.15);
		}
		
		override protected function outHandler(e:MouseEvent):void
		{
			_isOver = false;
			BXUtil.setBrightness(_image, 0);
		}
		
		override protected function upHandler(e:MouseEvent):void
		{
			BXUtil.setBrightness(_image, _isOver ? 0.15 : 0);
		}
	}
}