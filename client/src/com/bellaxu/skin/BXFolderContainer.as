package com.bellaxu.skin
{
	import com.bellaxu.ObjectPool;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	/**
	 * 可折叠项
	 * @author BellaXu
	 */
	public class BXFolderContainer extends BXDisplayGroup
	{
		protected var _btnVec:Vector.<BXButton>;
		
		public function BXFolderContainer()
		{
			super();
			_btnVec = new <BXButton>[];
		}
		
		override public function addOne(label:String):void
		{
			var i:int = 0;
			var btn:BXButton;
			while(i < _btnVec.length)
			{
				if(_btnVec[i].label == label)
					return;
				i++;
			}
			for each(btn in _btnVec)
			{
				if(btn.label == label)
					return;
			}
			btn = ObjectPool.get(BXButton);
			btn.style = 9;
			btn.width = width;
			btn.label = label;
			addChild(btn);
			
			var dis:BXDisplayObjectContainer = ObjectPool.get(BXDisplayObjectContainer);
			dis.width = width;
			
			_btnVec.push(btn);
			_disDic[btn] = dis;
		}
		
		override public function delOne(label:String):void
		{
			var i:int = 0;
			while(i < _btnVec.length)
			{
				if(_btnVec[i].label == label)
				{
					removeChild(_btnVec[i]);
					delete _disDic[_btnVec[i]];
					_btnVec[i].clear();
					_btnVec.splice(i, 1);
					return;
				}
				i++;
			}
		}
		
		override public function addSub(dis:BXDisplayObject, ...args):void
		{
			if(args.length < 0)
				return;
			var i:int = args[0];
			if(i >= _btnVec.length)
				return;
			var container:BXDisplayObjectContainer = _disDic[_btnVec[i]];
			container.addChild(dis);
		}
		
		override public function set width(value:Number):void
		{
			super.width = value;
			for each(var btn:BXButton in _btnVec)
			{
				btn.width = value;
				_disDic[btn].width = value;
			}
		}
		
		override public function clear():void
		{
			super.clear();
			
			numColumns = 1;
			for each(var btn:BXButton in _btnVec)
			{
				btn.clear();
			}
			_btnVec.length = 0;
		}
		
		override protected function downHandler(e:MouseEvent):void
		{
			if(e.target is BXButton)
			{
				var dis:BXDisplayObjectContainer = _disDic[e.target];
				if(contains(dis))
				{
					removeChild(dis);
				}
				else
				{
					addChildAt(dis, getChildIndex(e.target as BXButton) + 1);
				}
			}
		}
	}
}