package com.bellaxu.skin
{
	/**
	 * 面板类
	 * @author BellaXu
	 */
	public class BXPanel extends BXInterativeObject
	{
		public function BXPanel()
		{
			_style = 3;
			
			mouseEnabled = false;
			lightEnabled = false;
		}
		
		override public function clear():void
		{
			super.clear();
			
			mouseEnabled = false;
			
			_style = 3;
		}
	}
}