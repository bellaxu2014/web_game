package com.bellaxu.skin.extend
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.skin.BXDisplayObject;
	import com.bellaxu.skin.BXImage;
	import com.bellaxu.util.BXUtil;
	
	import game.core.GameResLoader;

	/**
	 * 星条
	 * @author BellaXu
	 */
	public class Starbar extends BXDisplayObject
	{
		public function Starbar()
		{
			
		}
		
		private var _star:uint;
		/**
		 * 星级
		 */
		public function set star(value:uint):void
		{
			_star = value;
			repaintNextFrame();
		}
		
		public function get star():uint
		{
			return _star;
		}
		
		private var _maxStar:uint;
		/**
		 * 最大星级
		 */
		public function set maxStar(value:uint):void
		{
			_maxStar = value;
			repaintNextFrame();
		}
		
		public function get maxStar():uint
		{
			return _maxStar;
		}
		
		override public function clear():void
		{
			super.clear();
			
			_star = 0;
			_maxStar = 0;
		}
		
		override protected function repaint():void
		{
			super.repaint();
			
			BXUtil.clearContainer(this);
			
			var i:int = 0, rx:int = 0;
			var img:BXImage;
			while(i < _maxStar)
			{
				img = ObjectPool.get(BXImage);
				img.bitmapData = GameResLoader.getExtendBitmapData("ItemTip_s");
				img.x = rx;
				addChild(img);
				
				rx += img.width + 3;
				_width = rx;
				i++;
			}
			i = _star;
			while(i < _maxStar)
			{
				img = getChildAt(i) as BXImage;
				BXUtil.setEnabled(img, false);
				i++;
			}
		}
	}
}