package com.bellaxu.skin
{
	import com.bellaxu.ObjectPool;
	
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import game.core.GameFrame;
	import game.core.GameFrameGroup;
	import game.core.GameResLoader;

	/**
	 * 滚动条组件
	 * @author BellaXu
	 */
	internal class BXScrollbar extends BXInterativeObject
	{
		private var _upBtn:BXImageButton;
		private var _downBtn:BXImageButton;
		private var _moveBtn:BXImageButton;
		
		private var _rect:Rectangle;
		
		private var _target:BXDisplayObjectContainer;
		private var _mask:Shape;
		
		public function BXScrollbar()
		{
			_upBtn = ObjectPool.get(BXImageButton);
			_upBtn.bitmapData = GameResLoader.getBasicBitmapData("BXScrollbar" + _style + "_up");
			addChild(_upBtn);
			
			_downBtn = ObjectPool.get(BXImageButton);
			_downBtn.bitmapData = GameResLoader.getBasicBitmapData("BXScrollbar" + _style + "_down");
			addChild(_downBtn);
			
			_moveBtn = ObjectPool.get(BXImageButton);
			_moveBtn.x = 2;
			_moveBtn.bitmapData = GameResLoader.getBasicBitmapData("BXScrollbar" + _style + "_move");
			addChild(_moveBtn);
			
			_rect = new Rectangle(1, 15, 0, 100);
			
			this.lightEnabled = false;
			this.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
		}
		
		override public function set style(value:int):void
		{
			super.style = value;
			
			_upBtn.bitmapData = GameResLoader.getBasicBitmapData("BXScrollbar" + _style + "_up");
			_downBtn.bitmapData = GameResLoader.getBasicBitmapData("BXScrollbar" + _style + "_down");
			_moveBtn.bitmapData = GameResLoader.getBasicBitmapData("BXScrollbar" + _style + "_move");
		}
		
		/**
		 * 目标容器
		 */
		public function set target(value:BXDisplayObjectContainer):void
		{
			_target = value;
			if(_target)
			{
				_target.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
				_target.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
			}
			repaintNextFrame();
		}
		
		public function update():void
		{
			repaintNextFrame();
		}
		
		override public function clear():void
		{
			super.clear();

			moveMouseUpHandler();
			
			if(_target)
				_target.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
			_target = null;
		}
		
		override protected function repaint():void
		{
			super.repaint();
			
			if(_skin)
			{
				_skin.x = 5;
				_skin.y = _upBtn.height;
				if(_target)
					_skin.height = _target.height - _upBtn.height - _downBtn.height;
				
				
				_downBtn.y = _skin.y + _skin.height;
				
				_rect.x = _moveBtn.x;
				_rect.y = _skin.y;
				_rect.height = _skin.height - _moveBtn.height;
			}
			
			if(_target)
			{
				_moveBtn.y = _rect.y + (_target.scrollPosition * _rect.height);
				_moveBtn.visible = _target.scrollbarVisible;
			}
			else
			{
				_moveBtn.visible = false;
			}
		}
		
		override protected function downHandler(e:MouseEvent):void
		{
			switch(e.target)
			{
				case _upBtn:
					scrollUp(e);
					break;
				case _moveBtn:
					_moveBtn.startDrag(false, _rect);
					stage.addEventListener(MouseEvent.MOUSE_UP, moveMouseUpHandler);
					GameFrame.add(updateTarget, GameFrameGroup.DISPLAY);
					break;
				case _downBtn:
					scrollDown(e);
					break;
				default:
					var p:Point = localToGlobal(new Point(_moveBtn.x, _moveBtn.y));
					if(e.stageY < p.y)
					{
						scrollUp(e);
					}
					else
					{
						scrollDown(e);
					}
					break;
			}
		}
		
		private function updateTarget():void
		{
			if(!_target)
				return;
			_target.scrollPosition = Number(((_moveBtn.y - _rect.y) / _rect.height).toFixed(2));
		}
		
		private function moveMouseUpHandler(e:MouseEvent = null):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, moveMouseUpHandler);
			GameFrame.del(updateTarget, GameFrameGroup.DISPLAY);
			_moveBtn.stopDrag();
		}
		
		private function mouseWheelHandler(e:MouseEvent):void
		{
			e.stopImmediatePropagation();
			e.delta > 0 ? scrollUp(e) : scrollDown(e);
		}
		
		private function scrollUp(e:MouseEvent):void
		{
			if(!_target)
				return;
			_target.scrollPosition -= (e.delta ? e.delta : 1) * _target.scrollPercent;
		}
		
		private function scrollDown(e:MouseEvent):void
		{
			if(!_target)
				return;
			e.delta = -e.delta;
			_target.scrollPosition += (e.delta ? e.delta : 1) * _target.scrollPercent;
		}
	}
}