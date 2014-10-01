package com.bellaxu.skin
{
	import com.bellaxu.IClearable;
	import com.bellaxu.ObjectPool;
	import com.bellaxu.lang.Lang;
	
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import game.core.GameColor;
	import game.core.GameConf;
	import game.core.GameTip;
	
	/**
	 * 静态文本
	 * @author BellaXu
	 */
	public class BXLabel extends TextField implements IClearable
	{
		private var _format:TextFormat;
		
		public function BXLabel()
		{
			_format = new TextFormat();
			_format.font = GameConf.FONT;
			_format.size = 12;
			_format.color = GameColor.INT_WIHTE;
			_format.align = TextFormatAlign.LEFT;
			defaultTextFormat = _format;
			
			selectable = false;
			mouseEnabled = false;
			multiline = false;
			wordWrap = false;
			type = TextFieldType.DYNAMIC;
			
			text = Lang.getLocalString("BXLabel_default");
		}
		
		private var _tip:String;
		/**
		 * 文本悬浮
		 */
		public function set tip(value:String):void
		{
			_tip = value;
			if(_tip != null)
			{
				GameTip.regist(this);
			}
			else
			{
				GameTip.unRegist(this);
			}
		}
		
		public function get tip():String
		{
			return _tip;
		}
		
		private var _itemId:int;
		/**
		 * 物品id
		 */
		public function set itemId(value:int):void
		{
			_itemId = value;
			if(_itemId > 0)
			{
				GameTip.regist(this);
			}
			else
			{
				GameTip.unRegist(this);
			}
		}
		
		public function get itemId():int
		{
			return _itemId;
		}
		
		public function clear():void
		{
			ObjectPool.put(BXLabel, this);
			
			_tip = null;
			_itemId = 0;
			
			_format.font = GameConf.FONT;
			_format.size = 12;
			_format.color = GameColor.INT_WIHTE;
			_format.align = TextFormatAlign.LEFT;
			defaultTextFormat = _format;
			
			mouseEnabled = false;
			selected = false;
			
			text = Lang.getLocalString("BXLabel_default");
		}
		
		public function set selected(value:Boolean):void
		{
			this.bold = value;
			this.textColor = value ? GameColor.INT_RED : GameColor.INT_WIHTE;
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
		 * 对齐
		 */
		public function set align(value:String):void
		{
			_format.align = value;
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
		
		override public function set textColor(value:uint):void
		{
			super.textColor = value;
			_format.color = value;
		}
		
		override public function set text(value:String):void
		{
			super.text = value;
			width = textWidth + int(_format.indent) + 5;
			height = textHeight + int(_format.indent) + 5;
		}
		
		override public function set htmlText(value:String):void
		{
			super.htmlText = value;
			width = textWidth + int(_format.indent) + 5;
			height = textHeight + int(_format.indent) + 5;
		}
		
		/**
		 * label为静态的文本
		 */
		override public function set type(value:String):void
		{
			super.type = TextFieldType.DYNAMIC;
		}
		
		/**
		 * label为单行
		 */
		override public function set multiline(value:Boolean):void
		{
			super.multiline = false;
		}
		
		/**
		 * label不自动换行
		 */
		override public function set wordWrap(value:Boolean):void
		{
			super.wordWrap = false;
		}
	}
}