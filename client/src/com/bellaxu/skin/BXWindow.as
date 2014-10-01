package com.bellaxu.skin
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.util.BXUtil;
	import com.bellaxu.view.ViewBase;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import game.core.GameResLoader;

	/**
	 * 窗口组件
	 * @author BellaXu
	 */
	public class BXWindow extends ViewBase
	{
		private var _panel:BXPanel;
		private var _title:BXLabel;
		private var _dragbar:Sprite;
		private var _close:BXImageButton;
		
		private var _rect:Rectangle;
		
		public function BXWindow()
		{
			_panel = ObjectPool.get(BXPanel);
			_panel.style = 1;
			addChild(_panel);
			
			_title = ObjectPool.get(BXLabel);
			_title.bold = true;
			_title.size = 14;
			_title.y = 11;
			addChild(_title);
			
			_dragbar = new Sprite();
			_dragbar.graphics.beginFill(0xffffff, 0);
			_dragbar.graphics.drawRect(0, 0, 10, 30);
			_dragbar.graphics.endFill();
			addChild(_dragbar);
			
			_close = ObjectPool.get(BXImageButton);
			_close.bitmapData = GameResLoader.getBasicBitmapData("BXWindow1_close");
			_close.x = _panel.width - _close.width - 10;
			_close.y = 9;
			addChild(_close);
			
			_rect = new Rectangle(0, 0, 0, 0);
		}
		
		public function set title(value:String):void
		{
			_title.text = value;
			_title.x = width - _title.textWidth >> 1;
		}
		
		public function set style(value:int):void
		{
			_panel.style = value;
			_close.bitmapData = GameResLoader.getBasicBitmapData("BXWindow" + value + "_close");
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
			_panel.width = value;
			_dragbar.width = value;
			_title.x = width - _title.textWidth >> 1;
			_close.x = _panel.width - _close.width - 10;
		}
		
		override public function set height(value:Number):void
		{
			super.height = value;
			_panel.height = value;
		}
		
		override public function clear():void
		{
			super.clear();
			
			BXUtil.clearContainer(this);
			
			dragUpHandler();
			
			_title.text = "";
			_panel.style = 1;
			_close.y = 0;
			_rect.width = 0;
			_rect.height = 0;
		}
		
		override protected function downHandler(e:MouseEvent):void
		{
			if(e.target == _close)
			{
				clear();
				if(parent)
					parent.removeChild(this);
			}
			else if(e.target == _dragbar)
			{
				_rect.width = stage.stageWidth - width;
				_rect.height = stage.stageHeight - height;
				
				this.startDrag(false, _rect);
				this.stage.addEventListener(MouseEvent.MOUSE_UP, dragUpHandler);
			}
		}
		
		private function dragUpHandler(e:MouseEvent = null):void
		{
			this.stage.removeEventListener(MouseEvent.MOUSE_UP, dragUpHandler);
			this.stopDrag();
		}
	}
}