package com.bellaxu.skin
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.util.BXUtil;
	
	import flash.events.MouseEvent;
	
	import game.core.GameResLoader;

	/**
	 * 相对简单的翻页，只提供左右翻
	 * @author BellaXu
	 */
	public class BXSimplePage extends BXDisplayObject
	{
		private var _leftBg:BXImage;
		private var _leftBtn:BXImageButton;
		private var _rightBg:BXImage;
		private var _rightBtn:BXImageButton;
		
		private var _content:BXDisplayObjectContainer;
		
		public function BXSimplePage()
		{
			_leftBg = ObjectPool.get(BXImage);
			_leftBg.bitmapData = GameResLoader.getBasicBitmapData("BXSimplePage1_1");
			addChild(_leftBg);
			
			_leftBtn = ObjectPool.get(BXImageButton);
			_leftBtn.bitmapData = GameResLoader.getBasicBitmapData("BXSimplePage1_2");
			_leftBtn.x = _leftBg.width - _leftBtn.width >> 1;
			_leftBtn.y = _leftBg.height - _leftBtn.height >> 1;
			addChild(_leftBtn);
			
			_content = ObjectPool.get(BXDisplayObjectContainer);
			_content.x = _leftBg.width;
			addChild(_content);
			
			_rightBg = ObjectPool.get(BXImage);
			_rightBg.bitmapData = GameResLoader.getBasicBitmapData("BXSimplePage1_1");
			_rightBg.rotation = 180;
			_rightBg.x = _leftBg.x + _leftBg.width + _rightBg.width;
			_rightBg.y = _rightBg.height;
			addChild(_rightBg);
			
			_rightBtn = ObjectPool.get(BXImageButton);
			_rightBtn.bitmapData = GameResLoader.getBasicBitmapData("BXSimplePage1_2");
			_rightBtn.rotation = 180;
			_rightBtn.x = _leftBg.x + _leftBg.width + _rightBtn.width + (_rightBg.width - _rightBtn.width >> 1);
			_rightBtn.y = _rightBtn.height + (_rightBg.height - _rightBtn.height >> 1);
			addChild(_rightBtn);
			
			repaintBtns();
		}
		
		private var _contentWidth:int;
		/**
		 * 真实宽度
		 */
		public function set contentWidth(value:int):void
		{
			_contentWidth = value;
			_content.width = value;
			_rightBg.x = _leftBg.x + _leftBg.width + _rightBg.width + _contentWidth;
			_rightBtn.x = _leftBg.x + _leftBg.width + _rightBtn.width + (_rightBg.width - _rightBtn.width >> 1) + _contentWidth;
		}
		
		public function get contentWidth():int
		{
			return _contentWidth;
		}
		
		private var _contentHeight:int;
		/**
		 * 真实宽度
		 */
		public function set contentHeight(value:int):void
		{
			_contentHeight = value;
			_content.height = value;
		}
		
		public function get contentHeight():int
		{
			return _contentHeight;
		}
		
		private var _maxPage:int = 1;
		/**
		 * 最大页数
		 */
		public function set maxPage(value:int):void
		{
			_maxPage = value;
			repaintBtns();
		}
		
		public function get maxPage():int
		{
			return _maxPage;
		}
		
		private var _curPage:int = 1;
		/**
		 * 当前页
		 */
		public function get curPage():int
		{
			return _curPage;
		}
		
		override public function clear():void
		{
			super.clear();
			
			_contentWidth = 0;
			_maxPage = 1;
			_curPage = 1;
		}
		
		override protected function downHandler(e:MouseEvent):void
		{
			var needUpdate:Boolean = false;
			if(e.target == _leftBtn)
			{
				if(_curPage > 1)
				{
					_curPage--;
					
					needUpdate = true;
				}
			}
			else if(e.target == _rightBtn)
			{
				if(_curPage < _maxPage)
				{
					_curPage++;
					
					needUpdate = true;
				}
			}
			if(needUpdate)
			{
				BXUtil.clearContainer(_content);
				
				updateContent();
				repaintBtns();
			}
		}
		
		private function repaintBtns():void
		{
			BXUtil.setEnabled(_leftBtn, _curPage > 1);
			BXUtil.setEnabled(_rightBtn, _curPage < _maxPage);
		}
		
		private function updateContent():void
		{
			
		}
	}
}