package com.bellaxu.skin.extend
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.lib.Lib;
	import com.bellaxu.lib.LibName;
	import com.bellaxu.lib.model.Pub_itemModel;
	import com.bellaxu.net.struct.StructBase;
	import com.bellaxu.net.struct.StructEquipMore;
	import com.bellaxu.skin.BXImage;
	
	import game.core.GameFile;
	import game.core.GameResLoader;

	/**
	 * 装备物品
	 * @author BellaXu
	 */
	public class ItemEquip extends ItemBase
	{
		private var _imgName:BXImage;
		
		public function ItemEquip()
		{
			super();
			
			_imgName = ObjectPool.get(BXImage);
			addChild(_imgName);
		}
		
		private var _data:Pub_itemModel;
		/**
		 * 物品数据
		 */
		public function get data():Pub_itemModel
		{
			return _data;
		}
		
		private var _pos:int;
		/**
		 * 装备对应位置
		 */
		public function set pos(value:int):void
		{
			_pos = value;
			
			if(_pos > 0)
			{
				_imgName.bitmapData = GameResLoader.getExtendBitmapData("Item_e" + _pos);
				_imgName.x = _imgBorder.width - _imgName.width >> 1;
				_imgName.y = _imgBorder.height - _imgName.height - 2;
			}
			else
			{
				_imgName.bitmapData = null;
			}
		}
		
		public function get pos():int
		{
			return _pos;
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
				_imgStrength.visible = itemMore && itemMore.strengthLv > 0;
				
				_imgQuality.bitmapData = itemMore.identified == 0 ? null :  GameResLoader.getExtendBitmapData("Item_q" + itemMore.quality);
			}
			else
			{
				_imgStrength.visible = false;
				_imgQuality.bitmapData = null;
			}
		}
		
		override public function set isLocked(value:Boolean):void
		{
			super.isLocked = value;
			
			if(_pos > 0)
				_imgName.visible = value;
		}
		
		override public function clear():void
		{
			super.clear();
			
			_data = null;
			_pos = 0;
			_imgName.visible = true;
		}
		
		override public function set itemId(value:int):void
		{
			if(isLocked)
				return;
			
			_data = Lib.getObj(LibName.PUB_ITEM, value);
			if(_data && _data.type == ItemType.EQUIP && _data.pos == _pos)
			{
				super.itemId = value;
				
				_imgIcon.source = value > 0 ? GameFile.getItemIcon(value) : null;
				_imgName.visible = false;
				_imgBind.visible = _data.is_bind == 1;
				_imgMetier.bitmapData = GameResLoader.getExtendBitmapData("Item_m" + _data.metier);
			}
			else
			{
				super.itemId = 0;
				
				_imgIcon.source = null;
				_imgName.visible = true;
				_imgBind.visible = false;
				_imgMetier.bitmapData = null;
			}
		}
	}
}