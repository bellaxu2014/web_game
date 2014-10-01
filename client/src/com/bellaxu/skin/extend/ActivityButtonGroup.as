package com.bellaxu.skin.extend
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.skin.BXDisplayObject;
	import com.bellaxu.skin.BXImageButton;
	
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import game.core.GameResLoader;

	/**
	 * 活动按钮组合
	 * @author BellaXu
	 */
	public class ActivityButtonGroup extends BXDisplayObject
	{
		private var _vec:Vector.<ActivityButton>;
		private var _dic:Dictionary;
		
		private var _btnShow:BXImageButton;
		
		public function ActivityButtonGroup()
		{
			_vec = new <ActivityButton>[];
			_dic = new Dictionary();
			
			_btnShow = ObjectPool.get(BXImageButton);
			_btnShow.bitmapData = GameResLoader.getExtendBitmapData("Activity_show");
			addChild(_btnShow);
		}
		
		/**
		 * 开启活动
		 */
		public function addActivity(name:String, time:int = 0):void
		{
			if(_dic[name])
				return;
			
			var act:ActivityButton = ObjectPool.get(ActivityButton);
			act.type = name;
			if(time > 0)
				act.time = time;
			addChild(act);
			
			_vec.push(act);
			_dic[name] = act;
			
			repaintNextFrame();
		}
		
		/**
		 * 关闭活动
		 */
		public function delActivity(name:String):void
		{
			if(!_dic[name])
				return;
			
			_vec.splice(_vec.indexOf(_dic[name]), 1);
			delete _dic[name];
			
			repaintNextFrame();
		}
		
		override public function clear():void
		{
			super.clear();
			
			_btnShow.rotation = 0;
			_btnShow.x = 0;
			_btnShow.y = 0;
		}
		
		override protected function repaint():void
		{
			var i:int;
			var maxCol:int = 7;
			var perCol:int = 65;
			var beginX:int = 52;
			while(i < _vec.length)
			{
				_vec[i].x = -beginX - (i % maxCol) * perCol;
				_vec[i].y = int(i / maxCol) * perCol;
				addChild(_vec[i]);
				i++;
			}
		}
		
		override protected function downHandler(e:MouseEvent):void
		{
			super.downHandler(e);
			
			switch(e.target)
			{
				case _btnShow:
					if(numChildren > 1)
					{
						_btnShow.rotation = 180;
						_btnShow.x = _btnShow.width;
						_btnShow.y = _btnShow.height;
						
						while(numChildren > 1)
						{
							removeChildAt(1);
						}
					}
					else
					{
						_btnShow.rotation = 0;
						_btnShow.x = 0;
						_btnShow.y = 0;
						
						repaint();
					}
					break;
			}
		}
	}
}