package com.bellaxu.skin.extend
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.lib.Lib;
	import com.bellaxu.lib.LibName;
	import com.bellaxu.skin.BXImage;
	
	import game.core.GameFile;
	import game.core.GameResLoader;

	/**
	 * 快捷栏物品
	 * @author BellaXu
	 */
	public class ItemQuick extends ItemBase
	{
		private var _imgKey:BXImage;
		
		public function ItemQuick()
		{
			super();
			
			_imgKey = ObjectPool.get(BXImage);
			addChild(_imgKey);
		}
		
		private var _key:uint;
		/**
		 * 键值
		 */
		public function set key(value:uint):void
		{
			_key = value;
			
			if(_key)
			{
				_imgKey.bitmapData = GameResLoader.getExtendBitmapData("Item_k" + value);
				_imgKey.y = _imgBorder.height - _imgKey.height;
			}
			else
			{
				_imgKey.bitmapData = null;
			}
		}
		
		public function get key():uint
		{
			return _key;
		}
		
		private var _isItem:Boolean;
		/**
		 * 是否物品
		 */
		public function set isItem(value:Boolean):void
		{
			_isItem = value;
		}
		
		public function get isItem():Boolean
		{
			return _isItem;
		}
		
		private var _data:*;
		/**
		 * 物品数据
		 */
		public function get data():*
		{
			return _data;
		}
		
		override public function clear():void
		{
			super.clear();
			
			_key = 0;
			_data = null;
			_isItem = false;
		}
		
		override public function set itemId(value:int):void
		{
			if(isLocked)
				return;
			
			if(_isItem)
			{
				_data = Lib.getObj(LibName.PUB_ITEM, value);
				if(_data)
				{
					super.itemId = value;
					
					_imgIcon.source = value > 0 ? GameFile.getItemIcon(value, size) : null;
					_imgBind.visible = _data.is_bind == 1;
					_imgMetier.bitmapData = GameResLoader.getExtendBitmapData("Item_m" + _data.metier);
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
			else
			{
				_data = Lib.getObj(LibName.PUB_SKILL, value);
				if(_data)
				{
					super.itemId = value;
					_imgIcon.source = value > 0 ? GameFile.getSkillIcon(value) : null;
				}
				else
				{
					super.itemId = 0;
					_imgIcon.source = null;
				}
				_imgBind.visible = false;
				_imgMetier.bitmapData = null;
				_imgQuality.bitmapData = null;
			}
		}
	}
}