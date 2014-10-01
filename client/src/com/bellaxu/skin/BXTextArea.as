package com.bellaxu.skin
{
	import com.bellaxu.IClearable;
	import com.bellaxu.ObjectPool;
	import game.core.GameColor;
	
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import game.core.GameConf;
	

	/**
	 * 文本区域组件
	 * @author BellaXu
	 */
	public class BXTextArea extends TextField implements IClearable
	{
		private static const DEFAULT_TEXT:String = "";
		
		private var _format:TextFormat;
		
		public function BXTextArea()
		{
			_format = new TextFormat();
			_format.font = GameConf.FONT;
			_format.size = 12;
			_format.color = GameColor.INT_WIHTE;
			_format.align = TextFormatAlign.LEFT;
			defaultTextFormat = _format;
			
			selectable = false;
			mouseEnabled = false;
			mouseWheelEnabled = false;
			multiline = true;
			wordWrap = true;
			type = TextFieldType.DYNAMIC;
			
			text = DEFAULT_TEXT;
		}
		
		public function clear():void
		{
			ObjectPool.put(BXTextArea, this);
			
			_format.font = GameConf.FONT;
			_format.size = 12;
			_format.color = GameColor.INT_WIHTE;
			_format.align = TextFormatAlign.LEFT;
			defaultTextFormat = _format;
			
			mouseEnabled = false;
			
			text = DEFAULT_TEXT;
		}
		
		/**
		 * 对齐
		 */
		public function set align(value:String):void
		{
			_format.align = value;
			defaultTextFormat = _format;
			text = text;
		}
		
		/**
		 * 首行缩进
		 */
		public function set indent(value:Object):void
		{
			_format.indent = value;
			defaultTextFormat = _format;
			text = text;
		}
		
		/**
		 * 字间距
		 */
		public function set letterSpacing(value:Object):void
		{
			_format.letterSpacing = value;
			defaultTextFormat = _format;
			text = text;
		}
		
		/**
		 * 行距
		 */
		public function set leading(value:Object):void
		{
			_format.leading = value;
			defaultTextFormat = _format;
			text = text;
		}
		
		/**
		 * 粗体
		 */
		public function set bold(value:Object) : void
		{
			_format.bold = value;
			defaultTextFormat = _format;
			text = text;
		}
		
		
		/**
		 * 文字大小
		 */
		public function set size(value:Object):void
		{
			_format.size = value;
			_format.indent = int(_format.size) << 2;
			defaultTextFormat = _format;
			text = text;
		}
		
		/**
		 * 字体
		 */
		public function set fontFamily(value:String):void
		{
			_format.font = value;
			defaultTextFormat = _format;
			text = text;
		}
		
		override public function set text(value:String):void
		{
			super.htmlText = value;
			height = textHeight + 5;
		}
		
		override public function set htmlText(value:String):void
		{
			super.htmlText = value;
			height = textHeight + 5;
		}
		
		override public function set textColor(value:uint):void
		{
			super.textColor = value;
			_format.color = value;
		}
		
		/**
		 * TextArea为静态的文本
		 */
		override public function set type(value:String):void
		{
			super.type = TextFieldType.DYNAMIC;
		}
		
		/**
		 * TextArea为多行
		 */
		override public function set multiline(value:Boolean):void
		{
			super.multiline = true;
		}
		
		/**
		 * TextArea为自动换行
		 */
		override public function set wordWrap(value:Boolean):void
		{
			super.wordWrap = true;
		}
	}
}