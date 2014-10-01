package com.bellaxu.skin
{
	import com.bellaxu.util.BXUtil;
	
	import flash.events.MouseEvent;

	/**
	 * 数据行
	 * @author BellaXu
	 */
	internal class BXDataLine extends BXInterativeObject
	{
		public function BXDataLine()
		{
			
		}
		
		private var _label:String;
		/**
		 * 标识
		 */
		public function set label(value:String):void
		{
			_label = value;
		}
		
		public function get label():String
		{
			return _label;
		}
		
		private var _selected:Boolean;
		
		public function set selected(value:Boolean):void
		{
			_selected = value;
			if(_selected)
			{
				if(_skin)
					BXUtil.setBrightness(_skin, 0.15);
			}
			else
			{
				if(_skin)
					BXUtil.setBrightness(_skin, 0);
			}
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		override public function clear():void
		{
			super.clear();
			
			selected = false;
		}
		
		override protected function outHandler(e:MouseEvent):void
		{
			if(!_selected)
				super.outHandler(e);
		}
		
		override protected function downHandler(e:MouseEvent):void
		{
			
		}
	}
}