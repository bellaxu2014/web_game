package com.bellaxu.skin
{
	/**
	 * 线条
	 * @author BellaXu
	 */
	public class BXLine extends BXInterativeObject
	{
		public function BXLine()
		{
			mouseEnabled = false;
			lightEnabled = false;
		}
		
		override public function clear():void
		{
			super.clear();
			
			mouseEnabled = false;
		}
	}
}