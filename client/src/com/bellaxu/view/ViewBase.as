package com.bellaxu.view
{
	import com.bellaxu.skin.BXDisplayObject;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.events.Event;
	
	import game.core.GameColor;
	import game.core.GameResize;

	/**
	 * 视图基类
	 * @author BellaXu
	 */
	public class ViewBase extends BXDisplayObject
	{
		private var _bgShape:Shape;
		private var _bgAlpha:Number = 1;
		private var _isFull:Boolean;
		private var _rw:uint;
		private var _rh:uint;
		
		public function ViewBase()
		{
			super();
		}
		
		/**
		 * 是否全屏
		 */
		public function set isFull(value:Boolean):void
		{
			_isFull = value;
			
			if(_isFull)
			{
				if(!_bgShape)
					_bgShape = new Shape();
				//添加在最底层，注意此类添加其他对象时若想放最底应从1开始
				addChildAt(_bgShape, 0);
			}
			else
			{
				removeChild(_bgShape);
			}
		}
		
		public function get isFull():Boolean
		{
			return _isFull;
		}
		
		override public function clear():void
		{
			super.clear();
			
			if(_bgShape)
				if(contains(_bgShape))
					removeChild(_bgShape);
			
			_rw = 0;
			_rh = 0;
			_isFull = false;
			_bgAlpha = 1;
		}
		
		/**
		 * 父容器
		 */
		public function get container():DisplayObjectContainer
		{
			return View.userUi;
		}
		
		/**
		 * 背景透明度
		 */
		public function set bgAlpha(alpha:Number):void
		{
			if(!_isFull)
				return;
			_bgAlpha = alpha;
			updateBgShape();
		}
		
		/**
		 * 显示
		 */
		public function show():void
		{
			if(!parent)
				container.addChild(this);
		}
		
		/**
		 * 移除
		 */
		public function hide():void
		{
			if(parent)
				parent.removeChild(this);
		}
		
		protected function afterAddedToStage():void
		{
			//此处添加到舞台后的规则
		}
		
		protected function afterRemovedFromStage():void
		{
			//此处添加移出舞台后的规则
		}
		
		protected function afterResized():void
		{
			//此处添加自适应规则
		}
		
		override protected function onAddedToStage(e:Event):void
		{
			afterAddedToStage();
			_rw = width;
			_rh = height;
			GameResize.add(onResize);
		}
		
		override protected function onRemovedFromStage(e:Event):void
		{
			if(_bgShape)
				if(contains(_bgShape))
					removeChild(_bgShape);
			afterRemovedFromStage();
			GameResize.del(onResize);
		}
		
		private function onResize():void
		{
			//按规则响应缩放
			if(true)
			{
				x = stage.stageWidth - _rw >> 1;
				y = stage.stageHeight - _rh >> 1;
			}
			if(_isFull)
			{
				updateBgShape();
			}
			afterResized();
		}
		
		private function updateBgShape():void
		{
			var startX:int = _rw - stage.stageWidth >> 1;
			var startY:int = _rh - stage.stageHeight >> 1;
			_bgShape.graphics.clear();
			_bgShape.graphics.beginFill(GameColor.INT_BLACK, _bgAlpha);
			_bgShape.graphics.drawRect(startX, startY, stage.stageWidth, stage.stageHeight);
			_bgShape.graphics.endFill();
		}
	}
}