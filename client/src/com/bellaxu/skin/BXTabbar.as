package com.bellaxu.skin
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.util.BXUtil;
	
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import game.core.GameResLoader;

	/**
	 * 导航条组件
	 * @author BellaXu
	 */
	public class BXTabbar extends BXDisplayObject
	{
		private var _buttons:BXDisplayObjectContainer;
		private var _content:BXDisplayObjectContainer;
		
		private var _contentDic:Dictionary;
		
		public function BXTabbar()
		{
			_buttons = ObjectPool.get(BXDisplayObjectContainer);
			_buttons.numColumns = int.MAX_VALUE;
			addChild(_buttons);
			
			_content = ObjectPool.get(BXDisplayObjectContainer);
			addChild(_content);
			
			_contentDic = new Dictionary();
		}
		
		/**
		 * 添加项
		 */
		public function addTab(label:String):void
		{
			var i:int;
			var bt:BXImageButton;
			while(i < _buttons.numChildren)
			{
				bt = _buttons.getChildAt(i) as BXImageButton;
				if(bt.label == label)
					return;
				i++;
			}
			bt = ObjectPool.get(BXImageButton);
			bt.bitmapData = GameResLoader.getBasicBitmapData("BXTabbar" + _tabStyle);
			bt.labelOffset = 2;
			bt.labelBold = false;
			bt.label = label;
			_buttons.addChild(bt);
			
			if(_buttons.numChildren == 1)
			{
				selectedIndex = 0;
			}
			
			if(_tabPosition == BXPosition.TOP)
			{
				_buttons.x = 0;
				_buttons.y = -bt.height;
				_buttons.width = (bt.width + _buttons.horizontalGap) * _buttons.numChildren;
			}
			else if(_tabPosition == BXPosition.BOTTOM)
			{
				_buttons.x = 0;
				_buttons.y = _content.height;
				_buttons.width = (bt.width + _buttons.horizontalGap) * _buttons.numChildren;
			}
			else if(_tabPosition == BXPosition.LEFT)
			{
				_buttons.x = -bt.width;
				_buttons.y = 0;
				_buttons.height = (bt.height + _buttons.verticalGap) * _buttons.numChildren;
			}
			else if(_tabPosition == BXPosition.RIGHT)
			{
				_buttons.x = _content.width;
				_buttons.y = 0;
				_buttons.height = (bt.height + _buttons.verticalGap) * _buttons.numChildren;
			}
		}
		
		/**
		 * 删除项
		 */
		public function delTab(label:String):void
		{
			var i:int;
			var bt:BXImageButton;
			while(i < _buttons.numChildren)
			{
				bt = _buttons.getChildAt(i) as BXImageButton;
				if(bt.label == label)
				{
					bt.clear();
					_buttons.removeChild(bt);
					return;
				}
				i++;
			}
		}
		
		/**
		 * 设置tab内容
		 */
		public function setTabContent(tab:int, content:ByteArray):void
		{
			//填充数据
			_contentDic[tab] = content;
			
			if(tab == _selectedIndex)
				updateContent();
		}
		
		private var _tabPosition:uint;
		
		public function set tabPosition(value:uint):void
		{
			if(_tabPosition == value)
				return;
			
			_tabPosition = value;
			
			_buttons.numColumns = (_tabPosition == BXPosition.TOP || _tabPosition == BXPosition.BOTTOM ? int.MAX_VALUE : 1);
		}
		
		private var _tabStyle:int = 1;
		
		/**
		 * 设置按钮样式
		 */
		public function set tabStyle(value:int):void
		{
			//tabbar的button样式从400开始，以十位数标记style
			if(_tabStyle == value)
				return;
			
			_tabStyle = value;
			
			var i:int;
			var bt:BXImageButton;
			while(i < _buttons.numChildren)
			{
				bt = _buttons.getChildAt(i) as BXImageButton;
				bt.bitmapData = GameResLoader.getBasicBitmapData("BXTabbar" + _tabStyle + (i == _selectedIndex ? "_1" : ""));
				i++;
			}
		}
		
		public function set tabGap(value:int):void
		{
			_buttons.horizontalGap = value;
		}
		
		private var _selectedIndex:int = -1;
		
		/**
		 * 选择项下标
		 */
		public function set selectedIndex(value:int):void
		{
			if(_selectedIndex == value)
				return;
			
			var bt:BXImageButton;
			if(_selectedIndex > -1 && _selectedIndex < _buttons.numChildren)
			{
				bt = _buttons.getChildAt(_selectedIndex) as BXImageButton;
				bt.bitmapData = GameResLoader.getBasicBitmapData("BXTabbar" + _tabStyle);
				bt.labelBold = false;
			}
			_selectedIndex = value;
			if(_selectedIndex > -1 && _selectedIndex < _buttons.numChildren)
			{
				bt = _buttons.getChildAt(_selectedIndex) as BXImageButton;
				bt.bitmapData = GameResLoader.getBasicBitmapData("BXTabbar" + _tabStyle + "_1");
				bt.labelBold = true;
				
				updateContent();
			}
		}
		
		public function get selectedIndex():int
		{
			return _selectedIndex;
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
			_content.width = value;
			if(_tabPosition == BXPosition.RIGHT)
				_buttons.x = _content.width;
		}
		
		override public function set height(value:Number):void
		{
			super.height = value;
			_content.height = value;
			if(_tabPosition == BXPosition.BOTTOM)
				_buttons.y = _content.height;
		}
		
		override public function clear():void
		{
			super.clear();
			
			_tabPosition = 0;
			_tabStyle = 1;
			_selectedIndex = -1;
			
			tabPosition = BXPosition.TOP;
			
			BXUtil.clearDic(_contentDic);
			BXUtil.clearContainer(_buttons);
		}
		
		override protected function downHandler(e:MouseEvent):void
		{
			if(e.target is BXImageButton)
				selectedIndex = _buttons.getChildIndex(e.target as BXImageButton);
		}
		
		private function updateContent():void
		{
			//先清除
			BXUtil.clearContainer(_content);
			
		}
	}
}