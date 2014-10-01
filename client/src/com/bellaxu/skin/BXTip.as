package com.bellaxu.skin
{
	import com.bellaxu.ObjectPool;
	import game.core.GameFrameGroup;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	import game.core.GameFrame;

	/**
	 * 鼠标提示
	 * @author BellaXu
	 */
	public class BXTip extends BXInterativeObject
	{
		private var _label:BXLabel;
		
		public function BXTip()
		{
			_label = ObjectPool.get(BXLabel);
			_label.x = 6;
			_label.y = 2;
			addChild(_label);
			
			mouseEnabled = false;
			lightEnabled = false;
			
			width = 80;
			height = 50;
		}
		
		/**
		 * 设置文本
		 */
		public function set text(value:String):void
		{
			_label.htmlText = value;
			width = _label.width + 12;
			height = _label.height + 4;
		}
		
		override public function clear():void
		{
			super.clear();
			
			_label.text = "";
			width = 80;
			height = 50;
		}
		
		override protected function onAddedToStage(e:Event):void
		{
			super.onAddedToStage(e);
			GameFrame.add(updateTip, GameFrameGroup.DISPLAY);
		}
		
		override protected function onRemovedFromStage(e:Event):void
		{
			super.onRemovedFromStage(e);
			GameFrame.del(updateTip, GameFrameGroup.DISPLAY);
			clear();
		}
		
		private function updateTip():void
		{
			if(stage)
			{
				x = stage.mouseX;
				y = stage.mouseY;
				
				var p:Point = localToGlobal(new Point(width, height));
				if(p.x < stage.stageWidth)
				{
					x += 20;
				}
				else
				{
					x -= width + 2;
				}
				if(p.y < stage.stageHeight)
				{
					y += 20;
				}
				else
				{
					y -= height + 2;
				}
			}
		}
	}
}