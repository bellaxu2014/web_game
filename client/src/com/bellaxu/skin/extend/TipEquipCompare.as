package com.bellaxu.skin.extend
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.skin.BXImage;
	
	import flash.events.Event;
	
	import game.core.GameResLoader;

	/**
	 * 装备对比悬浮
	 * @author BellaXu
	 */
	public class TipEquipCompare extends TipEquip
	{
		private var _imgEquiped:BXImage;
		
		public function TipEquipCompare()
		{
			super();
			
			_imgEquiped = ObjectPool.get(BXImage);
			_imgEquiped.bitmapData = GameResLoader.getExtendBitmapData("ItemTip_e");
			_imgEquiped.x = _border.width - _imgEquiped.width - 10;
			_imgEquiped.y = _imgTitle.y + _imgTitle.height + 32;
			addChild(_imgEquiped);
		}
		
		override public function set compareMode(value:Boolean):void
		{
			_compareMode = false;
		}
		
		override protected function onAddedToStage(e:Event):void
		{
			
		}
		
		override protected function onRemovedFromStage(e:Event):void
		{
			
		}
		
		override public function set itemId(value:int):void
		{
			super.itemId = value;
		}
	}
}