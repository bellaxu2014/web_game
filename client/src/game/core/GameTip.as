package game.core
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.skin.BXTip;
	import com.bellaxu.skin.extend.Item;
	import com.bellaxu.skin.extend.ItemBase;
	import com.bellaxu.skin.extend.ItemEquip;
	import com.bellaxu.skin.extend.ItemQuick;
	import com.bellaxu.skin.extend.ItemSkill;
	import com.bellaxu.skin.extend.ItemType;
	import com.bellaxu.skin.extend.TipBase;
	import com.bellaxu.skin.extend.TipEquip;
	import com.bellaxu.skin.extend.TipItem;
	import com.bellaxu.skin.extend.TipSkill;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * 鼠标提示
	 * @author BellaXu
	 */
	public class GameTip
	{
		/**
		 * 注册鼠标提示
		 */
		public static function regist(dis:DisplayObject):void
		{
			if(GameConf.stage && (dis.hasOwnProperty("tip") || dis.hasOwnProperty("itemId")))
			{
				dis.addEventListener(MouseEvent.MOUSE_OVER, mouseHandler);
				dis.addEventListener(MouseEvent.MOUSE_OUT, mouseHandler);
				dis.addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
				
				dis.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			}
		}
		
		/**
		 * 取消鼠标提示
		 */
		public static function unRegist(dis:DisplayObject):void
		{
			dis.removeEventListener(MouseEvent.MOUSE_OVER, mouseHandler);
			dis.removeEventListener(MouseEvent.MOUSE_OUT, mouseHandler);
			dis.addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
		}
		
		private static var _curTip:*;
		
		private static function mouseHandler(e:MouseEvent):void
		{
			if(e.type == MouseEvent.MOUSE_OVER && !ItemBase.hasDrag)
			{
				var dis:Object = e.currentTarget;
				//优先显示物品悬浮
				if(dis.itemId > 0)
				{
					var it:TipBase;
					if(dis is Item)
					{
						it = ObjectPool.get((dis as Item).data.type == ItemType.EQUIP ? TipEquip : TipItem);
						if(it is TipEquip)
						{
							(it as TipEquip).compareMode = true;
							(it as TipEquip).more = (dis as Item).more;
						}
					}
					else if(dis is ItemEquip)
					{
						it = ObjectPool.get(TipEquip);
						(it as TipEquip).more = (dis as ItemEquip).more;
					}
					else if(dis is ItemSkill)
					{
						it = ObjectPool.get(TipSkill);
						(it as TipSkill).more = (dis as ItemSkill).more;
					}
					else if(dis is ItemQuick)
					{
						it = ObjectPool.get((dis as ItemQuick).isItem ? TipItem : TipSkill);
					}
					it.itemId = (dis as ItemBase).itemId;
					GameConf.stage.addChild(it);
					
					_curTip = it;
				}
				else if(dis.tip)
				{
					var tip:BXTip = ObjectPool.get(BXTip);
					tip.text = dis.tip;
					GameConf.stage.addChild(tip);
					
					_curTip = tip;
				}
			}
			else
			{
				if(_curTip && GameConf.stage.contains(_curTip))
					GameConf.stage.removeChild(_curTip);
			}
		}
		
		private static function onRemovedFromStage(e:Event):void
		{
			e.target.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			GameTip.unRegist(e.target as DisplayObject);
		}
	}
}