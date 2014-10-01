package com.bellaxu.skin
{
	import com.bellaxu.ObjectPool;

	/**
	 * 标题
	 * @author BellaXu
	 */
	public class BXTitle extends BXInterativeObject
	{
		private var _title:BXLabel;
		
		public function BXTitle()
		{
			_title = ObjectPool.get(BXLabel);
			addChild(_title);
			
			mouseEnabled = false;
			lightEnabled = false;
		}
		
		/**
		 * 标题
		 */
		public function set text(value:String):void
		{
			_title.htmlText = value;
			_title.x = width - _title.width >> 1;
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
			_title.x = width - _title.width >> 1;
		}
		
		override public function clear():void
		{
			super.clear();
			
			mouseEnabled = false;
		}
	}
}