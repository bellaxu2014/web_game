package com.bellaxu.skin
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.util.BXUtil;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextFormatAlign;
	
	import game.core.GameResLoader;
	
	/**
	 * 列表组件
	 * @author BellaXu
	 */
	public class BXComboBox extends BXInterativeObject
	{
		private var _input:BXTextInput;
		private var _label:BXLabel;
		private var _downBtn:BXImageButton;
		private var _downList:BXDisplayObjectContainer;
		
		public function BXComboBox()
		{
			_input = ObjectPool.get(BXTextInput);
			_input.style = 2;
			_input.visible = false;
			_input.align = TextFormatAlign.CENTER;
			addChild(_input);
			
			_label = ObjectPool.get(BXLabel);
			_label.align = TextFormatAlign.CENTER;
			addChild(_label);
			
			_downBtn = ObjectPool.get(BXImageButton);
			_downBtn.bitmapData = GameResLoader.getBasicBitmapData("BXComboBox" + _style + "_down");
			addChild(_downBtn);
			
			_downList = ObjectPool.get(BXDisplayObjectContainer);
			_downList.height = 120;
			_downList.horizontalCenter = true;
			_downList.numColumns = 1;
			_downList.bgColor = _listColor;
			_downList.bgAlpha = 0.9;
			_downList.addEventListener(MouseEvent.MOUSE_DOWN, onDownListDown);
			
			lightEnabled = false;
			
			_width = 100;
			_height = 20;
		}
		
		/**
		 * 添加项
		 */
		public function addItem(label:String):void
		{
			var i:int;
			var lb:BXLabel;
			while(i < _downList.numChildren)
			{
				lb = _downList.getChildAt(i) as BXLabel;
				if(lb.text == label)
					return;
				i++;
			}
			lb = ObjectPool.get(BXLabel);
			lb.mouseEnabled = true;
			lb.text = label;
			_downList.addChild(lb);
			
			if(_downList.numChildren == 1)
				selectedIndex = 0;
		}
		
		/**
		 * 删除项
		 */
		public function delItem(label:String):void
		{
			var i:int;
			var lb:BXLabel;
			while(i < _downList.numChildren)
			{
				lb = _downList.getChildAt(i) as BXLabel;
				if(lb.text == label)
				{
					if(_selectedIndex == i)
						if(_downList.numChildren > 0)
							selectedIndex = 0;
					lb.clear();
					_downList.removeChild(lb);
					return;
				}
				i++;
			}
		}
		
		private var _listColor:uint = 0x292929;
		
		/**
		 * 背景色
		 */
		public function set listColor(value:uint):void
		{
			if(_listColor == value)
				return;
			_listColor = value;
			_downList.bgColor = value;
		}
		
		private var _selectedIndex:int = -1;
		
		/**
		 * 选择项下标
		 */
		public function set selectedIndex(value:int):void
		{
			_selectedIndex = value;
			_label.text = BXLabel(_downList.getChildAt(value)).text;
			_label.width = _downBtn.x;
		}
		
		public function get selectedIndex():int
		{
			return _selectedIndex;
		}
		
		/**
		 * 选中的值
		 */
		public function get selectedValue():String
		{
			return _label.text;
		}
		
		/**
		 * 限制输入
		 */
		public function set restrict(value:String):void
		{
			_input.restrict = value;
		}
		
		/**
		 * 最大输入字符
		 */
		public function set maxChars(value:uint):void
		{
			_input.maxChars = value;
		}
		
		private var _inputEnabled:Boolean;
		
		/**
		 * 是否可输入
		 */
		public function set inputEnabled(value:Boolean):void
		{
			_inputEnabled = value;
			_label.mouseEnabled = value;
		}
		
		public function get inputEnabled():Boolean
		{
			return _inputEnabled;
		}
		
		override public function set style(value:int):void
		{
			super.style = value;
			
			var bmd:BitmapData = GameResLoader.getBasicBitmapData("BXComboBox" + _style + "_down");
			if(bmd)
				_downBtn.bitmapData = bmd;
		}
		
		override public function clear():void
		{
			super.clear();
			
			if(contains(_downList))
				removeChild(_downList);
			
			_downBtn.style = 300;
			_input.visible = false;;
			_inputEnabled = false;
			_label.mouseEnabled = false;
			_listColor = 0x292929;
			_selectedIndex = -1;
			_selectedIndexOld = -1;
			
			_width = 100;
			_height = 20;
			
			BXUtil.clearContainer(_downList);
		}
		
		override protected function onAddedToStage(e:Event):void
		{
			stage.addEventListener(MouseEvent.MOUSE_DOWN, onStageMouseDown);
			super.onAddedToStage(e);
		}
		
		override protected function onRemovedFromStage(e:Event):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, onStageMouseDown);
			super.onRemovedFromStage(e);
		}
		
		private function onStageMouseDown(e:MouseEvent):void
		{
			var p1:Point = localToGlobal(new Point(_skin.x, _skin.y));
			var p4:Point = localToGlobal(new Point(_skin.width, contains(_downList) ? _downList.y + _downList.height : _skin.y + _skin.height));
			if(e.stageX < p1.x || e.stageX > p4.x || e.stageY < p1.y || e.stageY > p4.y)
			{
				if(contains(_downList))
					removeChild(_downList);
				resetInput();
			}
		}
		
		private function resetInput():void
		{
			if(_input.visible)
			{
				_input.visible = false;
				if(_input.text != "")
				{
					_label.text = _input.text;
					_label.width = _downBtn.x;
				}
				else
				{
					selectedIndex = _selectedIndexOld;
				}
			}
		}
		
		private var _selectedIndexOld:int = -1;
		
		override protected function downHandler(e:MouseEvent):void
		{
			super.downHandler(e);
			switch(e.target)
			{
				case _downBtn:
					if(contains(_downList))
					{
						removeChild(_downList);
					}
					else
					{
						addChildAt(_downList, 0);
					}
					resetInput();
					break;
				case _label:
					if(_inputEnabled)
					{
						_input.visible = true;
						_input.stageFocus = true;
						_selectedIndexOld = _selectedIndex;
						_label.text = "";
					}
					break;
			}
		}
		
		override protected function overHandler(e:MouseEvent):void
		{
			if(e.target is BXLabel && e.target != _label)
				_downList.selectedIndex = _downList.getChildIndex(e.target as BXLabel);
		}
		
		override protected function outHandler(e:MouseEvent):void
		{
			if(e.target is BXLabel && e.target != _label)
				_downList.selectedIndex = -1;
		}
		
		override protected function repaint():void
		{
			super.repaint();
			
			if(_skin)
			{
				_downBtn.x = _skin.width - _downBtn.width - 2;
				_downBtn.y = _skin.height - _downBtn.height >> 1;
				
				_input.width = _downBtn.x;
				_input.y = _skin.height - _input.height - 1 >> 1;
				
				_label.width = _downBtn.x;
				_label.y = _skin.height - _label.height >> 1;
				
				_downList.width = _downBtn.x;
				_downList.x = _skin.x;
				_downList.y = _skin.y + _skin.height;
			}
		}
		
		private function onDownListDown(e:MouseEvent):void
		{
			if(e.target is BXLabel)
			{
				selectedIndex = _downList.getChildIndex(e.target as DisplayObject);
				if(contains(_downList))
					removeChild(_downList);
				_input.visible = false;
				_input.text = "";
			}
		}
	}
}