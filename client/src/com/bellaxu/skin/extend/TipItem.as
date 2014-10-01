package com.bellaxu.skin.extend
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.lang.Lang;
	import com.bellaxu.lib.Lib;
	import com.bellaxu.lib.LibName;
	import com.bellaxu.lib.model.Pub_itemModel;
	import com.bellaxu.lib.model.Pub_itemTypeModel;
	import com.bellaxu.skin.BXLabel;
	import com.bellaxu.skin.BXLine;
	import com.bellaxu.util.HtmlUtil;
	
	import game.core.GameColor;
	import game.core.GameFilter;
	import game.core.GameResLoader;

	/**
	 * 物品悬浮
	 * @author BellaXu
	 */
	public class TipItem extends TipBase
	{
		private var _item:Item;
		private var _lbType:BXLabel;
		private var _lbNeedLv:BXLabel;
		private var _line2:BXLine;
		private var _lbPrice:BXLabel;
		private var _mlPrice:MoneyLabel;
		private var _lbSend:BXLabel;
		
		public function TipItem()
		{
			super();
			
			_border.width = 220;
			_lbTitle.filters = [GameFilter.UI_GLOW_BLACK];
			_ImgArrow2.x = _border.width - 4;
			_line1.width = _border.width - (_line1.x << 1);
			_taDesc.width = _border.width - 24;
			_taDesc.y = _line1.y + _line1.height + 5;
			
			_item = ObjectPool.get(Item);
			_item.x = 13;
			_item.y = 41;
			addChild(_item);
			
			_lbType = ObjectPool.get(BXLabel);
			_lbType.text = Lang.getLocalString("tip_item_type");
			_lbType.x = 68;
			_lbType.y = 44;
			addChild(_lbType);
			
			_lbNeedLv = ObjectPool.get(BXLabel);
			_lbNeedLv.text = Lang.getLocalString("tip_item_need_lv");
			_lbNeedLv.x = 68;
			_lbNeedLv.y = _lbType.y + 20;
			addChild(_lbNeedLv);
			
			_line2 = ObjectPool.get(BXLine);
			_line2.x = _line1.x;
			_line2.width = _border.width - (_line2.x << 1);
			addChild(_line2);
			
			_lbPrice = ObjectPool.get(BXLabel);
			_lbPrice.text = Lang.getLocalString("tip_item_sell_price");
			_lbPrice.textColor = GameColor.INT_YELLOW;
			_lbPrice.x = _taDesc.x;
			addChild(_lbPrice);
			
			_mlPrice = ObjectPool.get(MoneyLabel);
			_mlPrice.type = MoneyType.COIN;
			_mlPrice.x = _lbPrice.x + _lbPrice.textWidth;
			addChild(_mlPrice);
			
			_lbSend = ObjectPool.get(BXLabel);
			_lbSend.text = Lang.getLocalString("tip_item_send");
			_lbSend.textColor = GameColor.UI_REMARK;
			_lbSend.x = _lbPrice.x;
			addChild(_lbSend);
		}
		
		override public function clear():void
		{
			super.clear();
			
			_border.width = 220;
		}
		
		override public function set itemId(value:int):void
		{
			super.itemId = value;
			
			var data:Pub_itemModel = Lib.getObj(LibName.PUB_ITEM, value);
			if(data)
			{
				var typeM:Pub_itemTypeModel = Lib.getObj(LibName.PUB_ITEMTYPE, data.type);
				if(typeM)
					_lbType.text = Lang.getLocalString("tip_item_type") + typeM.desc;
				
				_imgTitle.bitmapData = GameResLoader.getExtendBitmapData("ItemTip_d" + data.quality);
				_lbTitle.htmlText = HtmlUtil.getHtmlText(data.name, GameColor.getColorByQuality(data.quality), 14, true);
				_lbTitle.x = _border.width - _lbTitle.width >> 1;
				_lbNeedLv.text = Lang.getLocalString("tip_item_need_lv") + data.need_level.toString();
				_item.itemId = data.id;
				_taDesc.htmlText = data.desc;
				_line2.y = _taDesc.y + _taDesc.height + 4;
				_lbPrice.y = _line2.y + _line2.height + 4;
				_mlPrice.value =  data.prices && data.prices.length ? data.prices[0] : 0;
				_mlPrice.y = _lbPrice.y;
				_lbSend.y = _lbPrice.y + _lbPrice.textHeight + 2;
				_border.height = _lbSend.y + _lbSend.height + 6;
			}
			else
			{
				if(parent)
					parent.removeChild(this);
			}
		}
	}
}