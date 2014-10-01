package com.bellaxu.skin
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.util.BXUtil;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	/**
	 * 单选组合
	 * @author BellaXu
	 */
	public class BXRadioButtonGroup extends BXDisplayGroup
	{
		public function BXRadioButtonGroup()
		{
			super();
		}
		
		override public function addOne(label:String):void
		{
			var i:int;
			var rb:BXRadioButton;
			while(i < numChildren)
			{
				rb = getChildAt(i) as BXRadioButton;
				if(rb.label == label)
					return;
				i++;
			}
			rb = ObjectPool.get(BXRadioButton);
			rb.selected = false;
			rb.label = label;
			addChild(rb);
			
			if(numChildren == 1)
				selectedIndex = 0;
		}
		
		override public function delOne(label:String):void
		{
			var i:int;
			var rb:BXRadioButton;
			while(i < numChildren)
			{
				rb = getChildAt(i) as BXRadioButton;
				if(rb.label == label)
				{
					if(rb.selected)
						if(numChildren > 0)
							selectedIndex = 0;
					rb.clear();
					removeChild(rb);
					return;
				}
				i++;
			}
		}
		
		override public function set selectedIndex(value:int):void
		{
			var i:int;
			var rb:BXRadioButton;
			while(i < numChildren)
			{
				rb = getChildAt(i) as BXRadioButton;
				rb.selected = (i == value);
				_selectedIndex = i;
				i++;
			}
		}
		
		override protected function downHandler(e:MouseEvent):void
		{
			if(e.target is BXRadioButton)
				selectedIndex = getChildIndex(e.target as DisplayObject);
		}
		
		override public function clear():void
		{
			super.clear();
			
			BXUtil.clearContainer(this);
		}
	}
}