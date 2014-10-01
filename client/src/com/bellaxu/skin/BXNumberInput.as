package com.bellaxu.skin
{
	import com.bellaxu.ObjectPool;
	
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextFormatAlign;
	
	import game.core.GameFrame;
	import game.core.GameFrameGroup;
	import game.core.GameResLoader;

	/**
	 * 数字控件
	 * @author BellaXu
	 */
	public class BXNumberInput extends BXDisplayObject
	{
		private var _btnRed:BXImageButton;
		private var _btnAdd:BXImageButton;
		private var _input:BXTextInput;
		
		public function BXNumberInput()
		{
			_btnRed = ObjectPool.get(BXImageButton);
			_btnRed.bitmapData = GameResLoader.getBasicBitmapData("BXNumberInput_red");
			addChild(_btnRed);
			
			_input = ObjectPool.get(BXTextInput);
			_input.x = _btnRed.x + _btnRed.width + 2;
			_input.height = _btnRed.height;
			_input.align = TextFormatAlign.CENTER;
			_input.restrict = "0-9";
			_input.text = "1";
			_input.addEventListener(TextEvent.TEXT_INPUT, onTextChanged);
			addChild(_input);
			
			_btnAdd = ObjectPool.get(BXImageButton);
			_btnAdd.x = _input.x + _input.width + 2;
			_btnAdd.bitmapData = GameResLoader.getBasicBitmapData("BXNumberInput_add");
			addChild(_btnAdd);
		}
		
		public function set inputWidth(value:uint):void
		{
			_input.width = value;
			_btnAdd.x = _input.x + _input.width + 2;
		}
		
		private var _maxValue:uint = uint.MAX_VALUE;
		
		public function set maxValue(value:uint):void
		{
			_maxValue = value;
		}
		
		public function get maxValue():uint
		{
			return _maxValue;
		}
		
		override public function clear():void
		{
			super.clear();
			
			_input.text = "1";
		}
		
		override protected function downHandler(e:MouseEvent):void
		{
			var i:int;
			if(e.target == _btnAdd)
			{
				i = int(_input.text);
				if(i < _maxValue)
					_input.text = (i + 1).toString();
			}
			else if(e.target == _btnRed)
			{
				i = int(_input.text);
				if(i > 1)
					_input.text = (i - 1).toString();
			}
		}
		
		private function onTextChanged(e:TextEvent):void
		{
			if(!GameFrame.has(delayCheckText, GameFrameGroup.DISPLAY))
				GameFrame.add(delayCheckText, GameFrameGroup.DISPLAY, 1);
		}
		
		private function delayCheckText():void
		{
			if(int(_input.text) > _maxValue)
				_input.text = _maxValue.toString();
		}
	}
}