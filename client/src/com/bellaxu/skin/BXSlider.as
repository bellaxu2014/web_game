package com.bellaxu.skin
{
	import com.bellaxu.ObjectPool;
	
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import game.core.GameFrame;
	import game.core.GameFrameGroup;
	import game.core.GameResLoader;

	/**
	 * 拖动条
	 * @author BellaXu
	 */
	public class BXSlider extends BXInterativeObject
	{
		private var _progress:BXImage;
		private var _maskShape:Shape;
		private var _moveBtn:BXImageButton;
		private var _label:BXLabel;
		
		private var _rect:Rectangle;
		
		public function BXSlider()
		{
			_progress = ObjectPool.get(BXImage);
			_progress.bitmapData = GameResLoader.getBasicBitmapData("BXSlider1_1");
			_progress.x = 2;
			_progress.y = 2;
			addChild(_progress);
			
			_maskShape = new Shape();
			_progress.mask = _maskShape;
			addChild(_maskShape);
			
			_moveBtn = ObjectPool.get(BXImageButton);
			_moveBtn.bitmapData = GameResLoader.getBasicBitmapData("BXSlider1_2");
			_moveBtn.y = _progress.y + int(_progress.height - _moveBtn.height >> 1);
			addChild(_moveBtn);
			
			_label = ObjectPool.get(BXLabel);
			_label.visible = false;
			addChild(_label);
			
			lightEnabled = false;
			
			value = 0.5;
			
			_rect = new Rectangle(_progress.x, _moveBtn.y, _progress.x + _progress.width - _moveBtn.width, 0);
		}
		
		private var _value:Number = 0.5;
		/**
		 * 百分比值，0~100
		 */
		public function set value(val:Number):void
		{
			if(val < 0)
				val = 0;
			if(val > 1)
				val = 1;
			_value = val;
			_label.text = _value + "";
			repaintNextFrame();
		}
		
		public function get value():Number
		{
			return _value;
		}
		
		override public function clear():void
		{
			super.clear();
			
			_value = 0.5;
		}
		
		override protected function downHandler(e:MouseEvent):void
		{
			if(e.target == _moveBtn)
			{
				_updateByDrag = true;
				_moveBtn.startDrag(false, _rect);
				stage.addEventListener(MouseEvent.MOUSE_UP, moveMouseUpHandler);
				GameFrame.add(updateTarget, GameFrameGroup.DISPLAY);
			}
			else
			{
				value = Number(((e.localX - _rect.x) / _rect.width).toFixed(2));
			}
		}
		
		override protected function overHandler(e:MouseEvent):void
		{
			_label.visible = true;
		}
		
		override protected function outHandler(e:MouseEvent):void
		{
			_label.visible = false;
		}
		
		override protected function repaint():void
		{
			super.repaint();
			if(_skin)
			{
				_label.x = _skin.width - _label.width >> 1;
				_label.y = -_label.height;
				
				var mw:int = (_progress.width - _moveBtn.width) * _value + 5;
				
				_maskShape.graphics.clear();
				_maskShape.graphics.beginFill(0xffffff, 0);
				_maskShape.graphics.drawRect(_progress.x, _progress.y, mw, _progress.height);
				_maskShape.graphics.endFill();
				
				if(!_updateByDrag)
					_moveBtn.x = _progress.x + (_progress.width - _moveBtn.width) * _value;
			}
		}
		
		private var _updateByDrag:Boolean;
		
		private function updateTarget():void
		{
			value = Number(((_moveBtn.x - _rect.x) / _rect.width).toFixed(2));
		}
		
		private function moveMouseUpHandler(e:MouseEvent = null):void
		{
			_updateByDrag = false;
			stage.removeEventListener(MouseEvent.MOUSE_UP, moveMouseUpHandler);
			GameFrame.del(updateTarget, GameFrameGroup.DISPLAY);
			_moveBtn.stopDrag();
		}
	}
}