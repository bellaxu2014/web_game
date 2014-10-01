package com.bellaxu.skin.extend
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.skin.BXDisplayObject;
	import com.bellaxu.skin.BXImage;
	import com.bellaxu.util.BXUtil;
	import com.bellaxu.util.MathUtil;
	
	import game.core.GameResLoader;

	/**
	 * 图片数字
	 * @author BellaXu
	 */
	public class ImageNumber extends BXDisplayObject
	{
		public function ImageNumber()
		{
			mouseEnabled = false;
		}
		
		private var _style:int;
		/**
		 * 数字样式
		 */
		public function set style(val:int):void
		{
			if(_style == val)
				return;
			_style = val;
			repaint();
		}
		
		public function get style():int
		{
			return _style;
		}
		
		private var _value:int;
		/**
		 * 数字值
		 */
		public function set value(val:int):void
		{
			_value = val;
			repaint();
		}
		
		public function get value():int
		{
			return _value;
		}
		
		override public function clear():void
		{
			super.clear();
			
			BXUtil.clearContainer(this);
			
			mouseEnabled = false;
			_style = 0;
			_value = 0;
			_width = 0;
		}
		
		override protected function repaint():void
		{
			super.repaint();
			
			BXUtil.clearContainer(this);
			
			var vec:Vector.<int> = MathUtil.getIntVec(_value);
			var i:int = 0, rx:int = 0;
			var img:BXImage;
			while(i < vec.length)
			{
				img = ObjectPool.get(BXImage);
				img.bitmapData = GameResLoader.getExtendBitmapData("ImageNumber" + _style + "_" + vec[i]);
				img.x = rx;
				addChild(img);
				
				rx += img.width;
				_width = rx;
				i++;
			}
		}
	}
}