package com.bellaxu.skin.extend
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.skin.BXDisplayObject;
	import com.bellaxu.skin.BXImageButton;
	import com.bellaxu.skin.BXLabel;
	import com.bellaxu.skin.BXMovie;
	import com.bellaxu.util.StringUtil;
	
	import game.core.GameFile;
	import game.core.GameResLoader;
	import game.core.GameTimer;

	/**
	 * 活动按钮
	 * @author BellaXu
	 */
	public class ActivityButton extends BXDisplayObject
	{
		private var _imgIcon:BXImageButton;
		private var _lbTime:BXLabel;
		private var _mcOpen:BXMovie;
		
		public function ActivityButton()
		{
			_imgIcon = ObjectPool.get(BXImageButton);
			addChild(_imgIcon);
			
			_lbTime = ObjectPool.get(BXLabel);
			_lbTime.text = "";
			addChild(_lbTime);
			
			_mcOpen = ObjectPool.get(BXMovie);
			_mcOpen.source = GameFile.getEffect("activity");
			_mcOpen.interval = 8;
			_mcOpen.x = -12;
			_mcOpen.y = -8;
			_mcOpen.stop();
			addChild(_mcOpen);
		}
		
		private var _type:String;
		
		public function set type(value:String):void
		{
			_type = value;
			_imgIcon.bitmapData = GameResLoader.getExtendBitmapData(value);
		}
		
		public function get type():String
		{
			return _type;
		}
		
		private var _time:int;
		
		public function set time(value:int):void
		{
			_time = value;
			
			if(_time > 0)
			{
				_lbTime.text = StringUtil.getFormatTimeBySec(_time / 1000, false);
				_lbTime.x = _imgIcon.width - _lbTime.width >> 1;
				_lbTime.y = _imgIcon.height - 3;
				
				showEffect(false);
				GameTimer.add(1000, updateTime);
			}
			else
			{
				_lbTime.text = "";
				showEffect(true);
				GameTimer.del(updateTime);
			}
		}
		
		public function get time():int
		{
			return _time;
		}
		
		override public function clear():void
		{
			super.clear();
			
			_type = null;
			_lbTime.text = "";
			_time = 0;
		}
		
		private function updateTime():void
		{
			_time -= 1000;
			if(_time < 0)
			{
				_lbTime.text = "";
				showEffect(true);
				GameTimer.del(updateTime);
				return;
			}
			
			_lbTime.text = StringUtil.getFormatTimeBySec(_time / 1000, false);
			_lbTime.x = _imgIcon.width - _lbTime.width >> 1;
			_lbTime.y = _imgIcon.height - 3;
		}
		
		private function showEffect(show:Boolean):void
		{
			if(show)
			{
				_mcOpen.play();
				if(!contains(_mcOpen))
					addChild(_mcOpen);
			}
			else
			{
				_mcOpen.stop();
				if(contains(_mcOpen))
					removeChild(_mcOpen);
			}
		}
	}
}