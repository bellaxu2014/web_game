package com.bellaxu.skin.extend
{
	import com.bellaxu.lib.Lib;
	import com.bellaxu.lib.LibName;
	import com.bellaxu.lib.model.Pub_skillModel;
	import com.bellaxu.net.struct.StructBase;
	import com.bellaxu.net.struct.StructSkillMore;
	
	import game.core.GameFile;
	import game.core.GameResLoader;

	/**
	 * 技能物品
	 * @author BellaXu
	 */
	public class ItemSkill extends ItemBase
	{
		public function ItemSkill()
		{
			_imgBorder.bitmapData = GameResLoader.getExtendBitmapData("Item_b3");
			_imgIcon.x = 5;
			_imgIcon.y = 5;
		}
		
		private var _data:Pub_skillModel;
		/**
		 * 技能数据
		 */
		public function get data():Pub_skillModel
		{
			return _data;
		}
		
		override public function set more(value:StructBase):void
		{
			if(isLocked)
				return;
			var skillMore:StructSkillMore = value as StructSkillMore;
			super.more = value;
		}
		
		override public function clear():void
		{
			super.clear();
			
			_data = null;
			dragable = true;
		}
		
		override public function set cd(value:int):void
		{
			super.cd = value;
			if(isLocked)
				return;
			_cdGap = 400 * (_imgBorder.width - 5) / value;
			_cdBegin = 5;
		}
		
		override public function set itemId(value:int):void
		{
			if(isLocked)
				return;
			
			_data = Lib.getObj(LibName.PUB_SKILL, value);
			if(_data)
			{
				super.itemId = value;
				
				_imgIcon.source = value > 0 ? GameFile.getSkillIcon(value) : null;
				dragable = _data.is_passive == 0;
			}
			else
			{
				super.itemId = 0;
				
				_imgIcon.source = null;
			}
		}
	}
}