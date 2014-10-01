package com.bellaxu.skin
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.util.BXUtil;
	
	import flash.events.MouseEvent;

	/**
	 * 数据列表
	 * @author BellaXu
	 */
	public class BXDataLineList extends BXDisplayGroup
	{
		public function BXDataLineList()
		{
			super();
		}
		
		override public function addOne(label:String):void
		{
			var i:int = 0;
			var line:BXDataLine;
			while(i < numChildren)
			{
				line = getChildAt(i) as BXDataLine;
				if(line.label == label)
					return;
				i++;
			}
			line = ObjectPool.get(BXDataLine);
			line.selected = false;
			addChild(line);
			
			if(numChildren == 1)
				selectedIndex = 0;
		}
		
		override public function delOne(label:String):void
		{
			var i:int = 0;
			var line:BXDataLine;
			while(i < numChildren)
			{
				line = getChildAt(i) as BXDataLine;
				if(line.label == label)
				{
					line.clear();
					removeChild(line);
					return;
				}
				i++;
			}
		}
		
		override public function set selectedIndex(value:int):void
		{
			var i:int;
			var rb:BXDataLine;
			while(i < numChildren)
			{
				rb = getChildAt(i) as BXDataLine;
				rb.selected = (i == value);
				_selectedIndex = i;
				i++;
			}
		}
		
		override public function clear():void
		{
			super.clear();
			
			BXUtil.clearContainer(this);
		}
		
		override protected function downHandler(e:MouseEvent):void
		{
			if(e.target is BXDataLine)
			{
				if(_selectedIndex >= 0)
					BXDataLine(getChildAt(_selectedIndex)).selected = false;
				if(contains(e.target as BXDataLine))
					selectedIndex = getChildIndex(e.target as BXDataLine);
			}
		}
	}
}