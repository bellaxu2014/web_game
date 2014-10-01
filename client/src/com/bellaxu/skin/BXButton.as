package com.bellaxu.skin
{
	import com.bellaxu.lang.Lang;
	
	import flash.text.TextFormatAlign;
	
	import game.core.GameColor;

	/**
	 * 按钮组件
	 * @author BellaXu
	 */
	public class BXButton extends BXInterativeObject
	{
		private var _labelTxt:BXLabel;
		
		public function BXButton()
		{
			_labelTxt = new BXLabel();
			_labelTxt.align = TextFormatAlign.CENTER;
			_labelTxt.bold = true;
			_labelTxt.text = Lang.getLocalString("BXButton_default");
			addChild(_labelTxt);
			
			width = 70;
			height = 30;
		}
		
		public function set label(value:String):void
		{
			_labelTxt.text = value;
			repaintNextFrame();
		}
		
		public function get label():String
		{
			return _labelTxt.text;
		}
		
		public function set labelBold(value:Boolean):void
		{
			_labelTxt.bold = value;
			repaintNextFrame();
		}
		
		public function set labelColor(value:int):void
		{
			_labelTxt.textColor = value;
		}
		
		private var _labelOffset:int;
		
		/**
		 * 标签偏移
		 */
		public function set labelOffset(value:int):void
		{
			_labelOffset = value;
		}
		
		public function get labelOffset():int
		{
			return _labelOffset;
		}
		
		override protected function repaint():void
		{
			super.repaint();
			
			_labelTxt.width = _labelTxt.textWidth + 5;
			_labelTxt.height = _labelTxt.textHeight + 5;
			_labelTxt.x = width - _labelTxt.width >> 1;
			_labelTxt.y = (height - _labelTxt.height >> 1) + _labelOffset;
		}
		
		override public function clear():void
		{
			super.clear();
			
			_labelOffset = 0;
			_labelTxt.bold = false;
			_labelTxt.textColor = GameColor.INT_WIHTE;
			_labelTxt.text = Lang.getLocalString("BXButton_default");
			
			width = 70;
			height = 30;
		}
	}
}