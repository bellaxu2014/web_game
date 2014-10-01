package com.bellaxu.skin
{
	import com.bellaxu.ObjectPool;
	import game.core.GameFrameGroup;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import game.core.GameFrame;

	/**
	 * 显示对象容器基类
	 * @author BellaXu
	 */
	public class BXDisplayObjectContainer extends BXDisplayObject
	{
		private var _scrollbar:BXScrollbar;
		private var _container:Sprite;
		private var _maskShape:Shape;
		private var _selectedShape:Shape;
		
		public function BXDisplayObjectContainer()
		{
			//为了让设置宽高及时有效
			graphics.beginFill(_bgColor, _bgAlpha);
			graphics.drawRect(0, 0, 1, 1);
			graphics.endFill();
			
			_maskShape = new Shape();
			_container = new Sprite();
			_container.mask = _maskShape;
			_selectedShape = new Shape();
			
			super.addChild(_container);
			super.addChild(_maskShape);
			super.addChild(_selectedShape);
			
			_width = 100;
			_height = 100;
			_maskShape.graphics.clear();
			_maskShape.graphics.beginFill(0xffffff, 0);
			_maskShape.graphics.drawRect(0, 0, _width, _height);
			_maskShape.graphics.endFill();
		}
		
		protected var _selectedIndex:int = -1;
		
		public function set selectedIndex(value:int):void
		{
			if(_selectedIndex == value || !numColumns)
				return;
			
			_selectedIndex = value;
			
			if(_selectedIndex >= 0)
			{
				var child:DisplayObject = getChildAt(value / _numColumns);
				
				if(child)
				{
					if(!super.contains(_selectedShape))
						super.addChild(_selectedShape);
					
					_selectedShape.graphics.clear();
					_selectedShape.graphics.beginFill(0xffffff, 0.1);
					_selectedShape.graphics.drawRect(0, 0, child.width + (child.x << 1), child.height);
					_selectedShape.graphics.endFill();
					_selectedShape.x = _container.x;
					_selectedShape.y = _container.y + child.y;
				}
			}
			else
			{
				if(super.contains(_selectedShape))
					super.removeChild(_selectedShape);
			}
		}
		
		public function get selectedIndex():int
		{
			return _selectedIndex;
		}
		
		private var _bgColor:int = 0x000000;
		
		/**
		 * 背景色
		 */
		public function set bgColor(value:int):void
		{
			_bgColor = value;
			updateBg();
		}
		
		private var _bgAlpha:Number = 0;
		/**
		 * 背景透明度
		 */
		public function set bgAlpha(value:Number):void
		{
			_bgAlpha = value;
			updateBg();
		}
		
		private var _horizontalGap:uint;
		
		/**
		 * 水平间隔
		 */
		public function set horizontalGap(value:int):void
		{
			_horizontalGap = value;
		}
		
		public function get horizontalGap():int
		{
			return _horizontalGap;
		}
		
		private var _verticalGap:uint;
		
		/**
		 * 垂直间隔
		 */
		public function set verticalGap(value:int):void
		{
			_verticalGap = value;
		}
		
		public function get verticalGap():int
		{
			return _verticalGap;
		}
		
		private var _numColumns:uint;
		
		/**
		 * 列数
		 */
		public function set numColumns(value:uint):void
		{
			_numColumns = value;
			updateDisplayList();
		}
		
		public function get numColumns():uint
		{
			return _numColumns;
		}
		
		private var _scrollPosition:Number = 0;
		
		/**
		 * 滚动位置，范围0~1
		 */
		public function set scrollPosition(value:Number):void
		{
			if(value < 0)
				value = 0;
			if(value > 1)
				value = 1;
			_scrollPosition = value;
			_container.y = -_containerGap * value;
			if(_scrollbar)
				_scrollbar.update();
		}
		
		public function get scrollPosition():Number
		{
			return _scrollPosition;
		}
		
		private var _scrollPercent:Number;
		
		/**
		 * 每次滚动的百分比，范围0~1
		 */
		public function get scrollPercent():Number
		{
			return _scrollPercent;
		}
		
		private var _containerGap:int;
		
		/**
		 * 滚动条是否可见
		 */
		public function get scrollbarVisible():Boolean
		{
			return _containerGap > 0;
		}
		
		private var _horizontalCenter:Boolean;
		
		/**
		 * 是否水平居中
		 */
		public function set horizontalCenter(value:Boolean):void
		{
			_horizontalCenter = value;
			updateDisplayList();
		}
		
		public function get horizontalCenter():Boolean
		{
			return _horizontalCenter;
		}
		
		override public function set width(value:Number):void
		{
			if(_width == value)
				return;
			super.width = value;
					
			_maskShape.graphics.clear();
			_maskShape.graphics.beginFill(0xffffff, 0);
			_maskShape.graphics.drawRect(0, 0, value, height);
			_maskShape.graphics.endFill();
		
			updateBg();
			updateDisplayList();
		}
		
		override public function set height(value:Number):void
		{
			if(_height == value)
				return;
			super.height = value;
			
			_maskShape.graphics.clear();
			_maskShape.graphics.beginFill(0x00ff24);
			_maskShape.graphics.drawRect(0, 0, width, value);
			_maskShape.graphics.endFill();
			
			updateBg();
			visibleScroll();
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			_container.addChild(child);
			updateDisplayList();
			return child;
		}
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			_container.addChildAt(child, index);
			updateDisplayList();
			return child;
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			_container.removeChild(child);
			updateDisplayList();
			return child;
		}
		
		override public function removeChildAt(index:int):DisplayObject
		{
			var child:DisplayObject = _container.removeChildAt(index);
			updateDisplayList();
			return child;
		}
		
		override public function removeChildren(beginIndex:int=0, endIndex:int=int.MAX_VALUE):void
		{
			_container.removeChildren(beginIndex, endIndex);
			updateDisplayList();
		}
		
		override public function contains(child:DisplayObject):Boolean
		{
			return _container.contains(child);
		}
		
		override public function getChildAt(index:int):DisplayObject
		{
			return _container.getChildAt(index);
		}
		
		override public function getChildByName(name:String):DisplayObject
		{
			return _container.getChildByName(name);
		}
		
		override public function getChildIndex(child:DisplayObject):int
		{
			return _container.getChildIndex(child);
		}
		
		override public function get numChildren():int
		{
			return _container.numChildren;
		}
		
		override public function clear():void
		{
			super.clear();
			
			selectedIndex = -1;
			
			_horizontalGap = 0;
			_verticalGap = 0;
			_numColumns = 0;
			_bgColor = 0x000000;
			_bgAlpha = 0;
			_width = 100;
			_height = 100;
			_maskShape.graphics.clear();
			_maskShape.graphics.beginFill(0xffffff, 0);
			_maskShape.graphics.drawRect(0, 0, _width, _height);
			_maskShape.graphics.endFill();
			
			if(_scrollbar)
				if(super.contains(_scrollbar))
					super.removeChild(_scrollbar);
			_scrollbar = null;
		}
		
		private function updateBg():void
		{
			graphics.clear();
			graphics.beginFill(_bgColor, _bgAlpha);
			graphics.drawRect(0, 0, _width + (_scrollbar && super.contains(_scrollbar) ? _scrollbar.width : 0), _height);
			graphics.endFill();
		}
		
		private function updateDisplayList():void
		{
			if(!GameFrame.has(updateOnNextFrame, GameFrameGroup.DISPLAY))
				GameFrame.add(updateOnNextFrame, GameFrameGroup.DISPLAY, 1);
		}
		
		private function updateOnNextFrame():void
		{
			if(_numColumns)
			{
				var child:DisplayObject;
				var r:int, c:int, i:int, j:int, nx:int, ny:int, tw:int, tx:int, mx:int, bj:int, tj:int = 0;
				while(i < _container.numChildren)
				{
					r = i / _numColumns;
					c = i % _numColumns;
					
					child = _container.getChildAt(i);
					child.x = nx + _horizontalGap;
					child.y = ny + _verticalGap;
					
					tw += child.width;
					
					if(c == _numColumns - 1)
					{
						nx = 0;
						ny = child.y + child.height;
						
						//根据horizontalCenter字段再次布局
						if(_width && _horizontalCenter)
						{
							bj = r * _numColumns;
							tj = (r + 1) * _numColumns;
							mx = _width - tw >> 1;
							for(j = bj; j < tj; j++)
							{
								child = _container.getChildAt(j);
								child.x += mx;
							}
							tw = 0;
						}
					}
					else
					{
						nx = child.x + child.width;
					}
					
					i++;
				}
			}
			visibleScroll();
		}
		
		private function visibleScroll():void
		{
			if(!_height)
			{
				_container.mask = null;
				if(_scrollbar)
					if(super.contains(_scrollbar))
						super.removeChild(_scrollbar);
				return;
			}
			_container.mask = _maskShape;
			var vh:int = 0;
			var child:DisplayObject;
			if(_container.numChildren > 0)
			{
				child = _container.getChildAt(_container.numChildren - 1);
				vh = child.y + child.height;
			}
			_containerGap = vh - _height;
			if(_containerGap <= 0)
			{
				_containerGap = 0;
			}
			else
			{
				var gap:int = _containerGap / 20;
				_scrollPercent = Number((1 / gap).toFixed(2));
			}
			if(vh > _height)
			{
				if(!_scrollbar)
				{
					_scrollbar = ObjectPool.get(BXScrollbar);
					_scrollbar.target = this;
				}
				if(!super.contains(_scrollbar))
					super.addChild(_scrollbar);
				
				_scrollbar.x = width;
				_scrollbar.update();
				
				updateBg();
			}
			else
			{
				if(_scrollbar)
					if(super.contains(_scrollbar))
						super.removeChild(_scrollbar);
				_scrollbar = null;
			}
			scrollPosition = _scrollPosition;
		}
	}
}