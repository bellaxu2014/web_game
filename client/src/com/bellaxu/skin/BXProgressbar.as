package com.bellaxu.skin
{
	import com.bellaxu.ObjectPool;
	
	import flash.display.Shape;
	
	import game.core.GameResLoader;

	/**
	 * 进度条组件
	 * @author BellaXu
	 */
	public class BXProgressbar extends BXInterativeObject
	{
		private var _foreground:BXImage;
		private var _maskShape:Shape;
		private var _label:BXLabel;
		
		public function BXProgressbar()
		{
			_foreground = ObjectPool.get(BXImage);
			_foreground.x = 20;
			_foreground.y = 11;
			_foreground.bitmapData = GameResLoader.getBasicBitmapData("BXProgressbar" + _style + "_1");
			addChild(_foreground);
			
			_maskShape = new Shape();
			_foreground.mask = _maskShape;
			addChild(_maskShape);
			
			_label = ObjectPool.get(BXLabel);
			addChild(_label);
			
			mouseEnabled = false;
			lightEnabled = false;
			
			progress = 0;
		}
		
		private var _text:String = "";
		
		/**
		 * 文本
		 */
		public function set text(value:String):void
		{
			_text = value;
			_label.text = _text + " " + _progress + "%";
		}
		
		public function get text():String
		{
			return _text;
		}
		
		private var _progress:int;
		/**
		 * 进度(0~100)
		 */
		public function set progress(value:int):void
		{
			if(value < 0)
				value = 0;
			if(value > 100)
				value = 100;
			_progress = value;
			_label.text = _text + " " + _progress + "%";
			repaintNextFrame();
		}
		
		public function get progress():int
		{
			return _progress;
		}
		
		override public function clear():void
		{
			super.clear();
			
			mouseEnabled = false;
			lightEnabled = false;
			
			_text = "";
			_progress = 0;
		}
		
		override protected function repaint():void
		{
			super.repaint();
			if(_skin)
			{
				_label.x = _skin.width - _label.width >> 1;
				_label.y = (_skin.height - _label.height >> 1) + 3;
				
				_maskShape.graphics.clear();
				_maskShape.graphics.beginFill(0xffffff, 0);
				_maskShape.graphics.drawRect(_foreground.x, _foreground.y, _foreground.width * progress / 100, _foreground.height);
				_maskShape.graphics.endFill();
			}
		}
	}
}