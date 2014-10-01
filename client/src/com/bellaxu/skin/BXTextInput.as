package com.bellaxu.skin
{
	import flash.events.FocusEvent;
	import flash.system.IME;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import game.core.GameColor;
	import game.core.GameConf;
	
	/**
	 * 输入框组件
	 * @author BellaXu
	 */
	public class BXTextInput extends BXInterativeObject
	{
		private var _textfield:TextField;
		private var _format:TextFormat;
		
		public function BXTextInput()
		{
			super();
			
			_textfield = new TextField();
			_textfield.x = 3;
			_textfield.type = TextFieldType.INPUT;
			_textfield.selectable = true;
			_textfield.multiline = false;
			_textfield.wordWrap = false;
			addChild(_textfield);
			
			_format = new TextFormat();
			_format.font = GameConf.FONT;
			_format.size = 12;
			_format.color = GameColor.INT_WIHTE;
			_format.align = TextFormatAlign.LEFT;
			_textfield.defaultTextFormat = _format;
			
			_width = 80;
			_height = 17;
			
			lightEnabled = false;
			addEventListener2(FocusEvent.FOCUS_IN, focusInHandler);
			addEventListener2(FocusEvent.FOCUS_OUT, focusOutHandler);
		}
		
		public function set stageFocus(value:Boolean):void
		{
			if(value)
			{
				if(stage)
					stage.focus = _textfield;
			}
			else
			{
				if(stage.focus == _textfield)
					stage.focus = stage;
			}
		}
		
		/**
		 * 文字对齐
		 */
		public function set align(value:String):void
		{
			_format.align = value;
			_textfield.defaultTextFormat = _format;
			_textfield.text = _textfield.text;
		}
		
		/**
		 * 文本
		 */
		public function set text(value:String):void
		{
			_textfield.text = value;
		}
		
		public function get text():String
		{
			return _textfield.text;
		}
		
		/**
		 * html文本
		 */
		public function set htmlText(value:String):void
		{
			_textfield.htmlText = value;
		}
		
		/**
		 * 文本颜色
		 */
		public function set textColor(value:uint):void
		{
			_textfield.textColor = value;
		}
		
		/**
		 * 最大可输入字符数
		 */
		public function set maxChars(value:uint):void
		{
			_textfield.maxChars = value;
		}
		
		/**
		 * 限制字符
		 */
		public function set restrict(value:String):void
		{
			_textfield.restrict = value;
		}
		
		override public function clear():void
		{
			super.clear();
			
			_format.font = GameConf.FONT;
			_format.size = 12;
			_format.color = GameColor.INT_WIHTE;
			_format.align = TextFormatAlign.LEFT;
			_textfield.defaultTextFormat = _format;
			
			_textfield.text = "";
			width = 80;
			height = 17;
		}
		
		override protected function repaint():void
		{
			super.repaint();
			
			_textfield.width = _width - 6;
			_textfield.height = _textfield.textHeight + 5;
			if(_skin)
				_textfield.y = _skin.height - _textfield.textHeight - 4 >> 1;
		}
		
		private function focusInHandler(e:FocusEvent):void
		{
			IME.enabled = true;
		}
		
		private function focusOutHandler(e:FocusEvent):void
		{
			IME.enabled = false;
		}
	}
}