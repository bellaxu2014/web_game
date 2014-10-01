package com.bellaxu.skin
{
	import flash.events.MouseEvent;
	import flash.text.TextFormatAlign;

	/**
	 * 选择框组件
	 * @author BellaXu
	 */
	public class BXCheckBox extends BXInterativeObject
	{
		private var _labelTxt:BXLabel;
		
		private var _label:String;
		private var _htmlLabel:String;
		private var _selected:Boolean;
		
		public function BXCheckBox()
		{
			super();
			
			_labelTxt = new BXLabel();
			_labelTxt.align = TextFormatAlign.LEFT;
			_labelTxt.indent = 5;
			addChild(_labelTxt);
		}
		
		/**
		 * 文本
		 */
		public function set label(value:String):void
		{
			_labelTxt.text = value;
		}
		
		public function get label():String
		{
			return _labelTxt.text;
		}
		
		/**
		 * 文本颜色
		 */
		public function set labelColor(value:int):void
		{
			_labelTxt.textColor = value;
		}
		
		/**
		 * html格式文本
		 */
		public function set htmlLabel(value:String):void
		{
			_labelTxt.htmlText = value;
		}
		
		public function get htmlLabel():String
		{
			return _labelTxt.htmlText;
		}
		
		public function set selected(value:Boolean):void
		{
			_selected = value;
			innerStyle = _selected ? 1 : 0;
			updateSkin();
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		override public function clear():void
		{
			super.clear();
			
			_selected = false;
			_labelTxt.text = "";
		}
		
		override protected function downHandler(e:MouseEvent):void
		{
			super.downHandler(e);
			selected = !selected;
		}
		
		override public function set width(value:Number):void
		{
			_width = value;
			_labelTxt.width = value - _labelTxt.x;
		}
		
		override public function get width():Number
		{
			return (_skin ? _skin.width : super.width) + _labelTxt.width;
		}
		
		override protected function repaint():void
		{
			super.repaint();
			
			if(_skin)
			{
				_labelTxt.x = _skin.width;
				_labelTxt.y = _skin.height - _labelTxt.textHeight - 5 >> 1;
			}
		}
	}
}