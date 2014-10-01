package com.bellaxu.skin.extend
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.lib.Lib;
	import com.bellaxu.lib.LibName;
	import com.bellaxu.lib.model.Pub_itemModel;
	import com.bellaxu.skin.BXLabel;
	import com.bellaxu.util.HtmlUtil;
	
	import game.core.GameColor;
	import game.core.GameFile;
	import game.core.GameFilter;
	import game.core.GameResLoader;

	/**
	 * 掉落物，即拥有标题的图片
	 * @author BellaXu
	 */
	public class ItemDrop extends ItemBase
	{
		private var _lbName:BXLabel;
		
		public function ItemDrop()
		{
			super();
			
			size = ItemSize.SIZE_32;
			_imgBorder.bitmapData = null;
			
			_lbName = ObjectPool.get(BXLabel);
			_lbName.filters = [GameFilter.UI_GLOW_WHITE];
			addChild(_lbName);
			
			_imgIcon.x = 0;
			_imgIcon.y = 0;
			_imgMetier.x = -3;
			_imgMetier.y = -3;
			_imgBind.x = 0;
			_imgBind.y = size - _imgBind.height - 1;
			_imgNum.x = size - _imgNum.width;
			_imgNum.y = size - _imgNum.height;
		}
		
		private var _data:Pub_itemModel;
		/**
		 * 物品数据
		 */
		public function get data():Pub_itemModel
		{
			return _data;
		}
		
		override public function clear():void
		{
			super.clear();
			
			_data = null;
			_lbName.text = "";
		}
		
		override public function set itemId(value:int):void
		{
			_data = Lib.getObj(LibName.PUB_ITEM, value);
			if(_data)
			{
				_lbName.htmlText = HtmlUtil.getHtmlText(_data.name, GameColor.getColorByQuality(_data.quality));
				_lbName.x = _imgIcon.x + (size - _lbName.width >> 1);
				_lbName.y = _imgIcon.y - _lbName.height - 2;
				
				_imgIcon.source = value > 0 ? GameFile.getItemIcon(value, size) : null;
				_imgBind.visible = _data.is_bind == 1;
				_imgMetier.bitmapData = GameResLoader.getExtendBitmapData("Item_m" + _data.metier);
			}
			else
			{
				_lbName.text = "";
				
				_imgIcon.source = null;
				_imgBind.visible = false;
				_imgMetier.bitmapData = null;
			}
		}
	}
}