package com.bellaxu.skin.extend
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.skin.BXDisplayObject;
	import com.bellaxu.skin.BXImage;
	import com.bellaxu.skin.BXPosition;
	import com.bellaxu.util.MathUtil;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Point;
	
	import game.core.GameConf;
	import game.core.GameFrame;
	import game.core.GameFrameGroup;
	import game.core.GameResLoader;

	/**
	 * 指引组件
	 * @author BellaXu
	 */
	public class Guide extends BXDisplayObject
	{
		private var _arrow:BXImage;
		
		public function Guide()
		{
			_arrow = ObjectPool.get(BXImage);
			_arrow.bitmapData = GameResLoader.getExtendBitmapData("Guide");
			addChild(_arrow);
			
			mouseEnabled = false;
		}
		
		private var _target:DisplayObject;
		
		/**
		 * 目标
		 */
		public function set target(value:DisplayObject):void
		{
			_target = value;
			if(value)
			{
				if(GameConf.stage)
				{
					GameConf.stage.addChild(this);
					
					position = _position;
				}
			}
			else
			{
				if(parent)
					parent.removeChild(this);
			}
		}
		
		private var _position:uint;
		
		/**
		 * 位置
		 */
		public function set position(value:uint):void
		{
			_position = value;
			if(_target && parent)
			{
				var p:Point = parent.localToGlobal(new Point(_target.x, _target.y));
				switch(value)
				{
					case BXPosition.TOP:
						_arrow.rotation = 90;
						x = p.x + (_target.width + _arrow.width >> 1);
						y = p.y - _arrow.height - 2;
						break;
					case BXPosition.BOTTOM:
						_arrow.rotation = -90;
						x = p.x + (_target.width - _arrow.width >> 1);
						y = p.y + _target.height + _arrow.height + 2;
						break;
					case BXPosition.LEFT:
						_arrow.rotation = 0;
						x = p.x - _arrow.width - 2;
						y = p.y + (_target.height - _arrow.height >> 1);
						break;
					case BXPosition.RIGHT:
						_arrow.rotation = 180;
						x = p.x + _target.width + _arrow.width - 2;
						y = p.y + (_target.height + _arrow.height >> 1);
						break;
				}
			}
		}
		
		override protected function onAddedToStage(e:Event):void
		{
			if(!GameFrame.has(renderArrow, GameFrameGroup.DISPLAY))
				GameFrame.add(renderArrow, GameFrameGroup.DISPLAY, 1);
		}
		
		override protected function onRemovedFromStage(e:Event):void
		{
			GameFrame.del(renderArrow, GameFrameGroup.DISPLAY);
		}
		
		override public function clear():void
		{
			super.clear();
			
			GameFrame.del(renderArrow, GameFrameGroup.DISPLAY);
			
			_target = null;
			_position = 0;
		}
		
		private function renderArrow():void
		{
			var seed:int = MathUtil.getRandomInt(0, 99999);
		}
	}
}