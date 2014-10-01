package com.bellaxu.skin
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.util.BXUtil;
	
	import flash.events.MouseEvent;
	import flash.text.TextFormatAlign;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import game.core.GameResLoader;
	
	/**
	 * 翻页组件
	 * @author BellaXu
	 */
	public class BXPage extends BXInterativeObject
	{
		private var _btnTop:BXImageButton;
		private var _btnPre:BXImageButton;
		private var _btnNex:BXImageButton;
		private var _btnLas:BXImageButton;
		private var _content:BXDisplayObjectContainer;
		
		private var _label:BXTextInput;
		
		private var _contentDic:Dictionary;
		
		public function BXPage()
		{
			_btnTop = ObjectPool.get(BXImageButton);
			_btnTop.bitmapData = GameResLoader.getBasicBitmapData("BXPage1_1");
			addChild(_btnTop);
			
			_btnPre = ObjectPool.get(BXImageButton);
			_btnPre.bitmapData = GameResLoader.getBasicBitmapData("BXPage1_2");
			addChild(_btnPre);
			
			_label = ObjectPool.get(BXTextInput);
			_label.width = 44;
			_label.height = _btnPre.height;
			_label.align = TextFormatAlign.CENTER;
			_label.mouseEnabled = false;
			_label.mouseChildren = false;
			_label.text = "1/1";
			addChild(_label);
			
			_btnNex = ObjectPool.get(BXImageButton);
			_btnNex.bitmapData = GameResLoader.getBasicBitmapData("BXPage1_2");
			_btnNex.rotation = 180;
			addChild(_btnNex);
			
			_btnLas = ObjectPool.get(BXImageButton);
			_btnLas.bitmapData = GameResLoader.getBasicBitmapData("BXPage1_1");
			_btnLas.rotation = 180;
			addChild(_btnLas);
			
			lightEnabled = false;
		}
		
		public function set numberWidth(value:uint):void
		{
			_label.width = value;
			repaintNextFrame();
		}
		
		private var _maxPage:int = 1;
		
		/**
		 * 最大页数
		 */
		public function set maxPage(value:int):void
		{
			_maxPage = value;
			_label.text = _curPage + "/" + _maxPage;
		}
		
		public function get maxPage():int
		{
			return _maxPage;
		}
		
		private var _curPage:int = 1;
		
		/**
		 * 当前页
		 */
		public function set page(value:int):void
		{
			if(_curPage == value)
				return;
			_curPage = value;
			_label.text = _curPage + "/" + _maxPage;
			updateContent();
		}
		
		public function get page():int
		{
			return _curPage;
		}

		/**
		 * 设置页面填充
		 */
		public function setPageContent(page:int, content:ByteArray):void
		{
			_contentDic[page] = content;
			if(page == _curPage)
				updateContent();
		}
		
		override public function clear():void
		{
			super.clear();
			
			_maxPage = 1;
			_curPage = 1;
			_label.text = "1/1";
			_label.width = 44;
			
			BXUtil.clearDic(_contentDic);
		}
		
		override protected function repaint():void
		{
			super.repaint();
			
			if(_skin)
			{
				_label.x = _skin.width - _label.width >> 1;
				_label.y = _skin.height - _label.height - 6 >> 1;
				
				_btnPre.x = _label.x - _btnPre.width - 2;
				_btnPre.y = _label.y;
				_btnTop.x = _btnPre.x - _btnTop.width - 2;
				_btnTop.y = _label.y;
				
				_btnNex.y = _label.y + _btnNex.height;
				_btnLas.y = _label.y + _btnLas.height;
			}
			else
			{
				_btnTop.x = 0;
				_btnTop.y = 0;
				_btnPre.x = _btnTop.x + _btnTop.width + 2;
				_btnPre.y = 0;
				
				_label.x = _btnPre.x + _btnPre.width + 2;
				_label.y = 0;
				
				_btnNex.y = _btnNex.height;
				_btnLas.y = _btnLas.height;
			}
			_btnNex.x = _label.x + _label.width + 2;
			_btnLas.x = _btnNex.x + _btnNex.width + 2;
			
			_btnNex.x += _btnNex.width;
			_btnLas.x += _btnLas.width;
		}
		
		override protected function downHandler(e:MouseEvent):void
		{
			super.downHandler(e);
			switch(e.target)
			{
				case _btnTop:
					page = 1;
					break;
				case _btnPre:
					if(_curPage > 1)
						page--;
					break;
				case _btnNex:
					if(_curPage < _maxPage)
						page++;
					break;
				case _btnLas:
					page = _maxPage;
					break;
			}
		}
		
		private function updateContent():void
		{
			
		}
	}
}