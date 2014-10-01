package com.bellaxu.skin.extend
{
	import com.bellaxu.lib.Lib;
	import com.bellaxu.lib.LibName;
	import com.bellaxu.lib.model.Pub_itemModel;
	import com.bellaxu.net.struct.StructBase;
	import com.bellaxu.net.struct.StructEquipMore;
	
	import game.core.GameFile;
	import game.core.GameResLoader;

	/**
	 * 物品
	 * @author BellaXu
	 */
	public class Item extends ItemBase
	{
		public function Item()
		{
			super();
		}
		
		private var _data:Pub_itemModel;
		/**
		 * 物品数据
		 */
		public function get data():Pub_itemModel
		{
			return _data;
		}
		
		override public function set more(value:StructBase):void
		{
			if(isLocked)
				return;
			var itemMore:StructEquipMore = value as StructEquipMore;
			super.more = itemMore;
			
			if(itemMore)
			{
				_imgStrength.value = itemMore.strengthLv;
				_imgStrength.x = _imgBorder.width - _imgStrength.width - 2;
				_imgStrength.y = 2;
				_imgStrength.visible = itemMore.strengthLv > 0;
				
				_imgQuality.bitmapData = data.type != ItemType.EQUIP || itemMore.identified == 0 ? null : GameResLoader.getExtendBitmapData("Item_q" + itemMore.quality);
			}
			else
			{
				_imgStrength.visible = false;
				_imgQuality.bitmapData = null;
			}
		}
		
		override public function clear():void
		{
			super.clear();
			
			_data = null;
		}
		
		override public function set itemId(value:int):void
		{
			if(isLocked)
				return;
			
			_data = Lib.getObj(LibName.PUB_ITEM, value);
			if(_data)
			{
				super.itemId = value;
				
				_imgIcon.source = value > 0 ? GameFile.getItemIcon(value, size) : null;
				_imgBind.visible = _data.is_bind == 1;
				_imgMetier.bitmapData = GameResLoader.getExtendBitmapData("Item_m" + _data.metier);
				if(_data.type != ItemType.EQUIP)
					_imgQuality.bitmapData = GameResLoader.getExtendBitmapData("Item_q" + _data.quality);
			}
			else
			{
				super.itemId = 0;
				
				_imgIcon.source = null;
				_imgBind.visible = false;
				_imgMetier.bitmapData = null;
				_imgQuality.bitmapData = null;
			}
		}
	}
}