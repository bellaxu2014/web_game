package com.bellaxu.skin.extend
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.lang.Lang;
	import com.bellaxu.net.struct.StructBase;
	import com.bellaxu.skin.BXDisplayObject;
	import com.bellaxu.skin.BXImage;
	import com.bellaxu.skin.BXLabel;
	
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import game.core.GameFrame;
	import game.core.GameFrameGroup;
	import game.core.GameMsg;
	import game.core.GameResLoader;
	import game.core.GameTimer;

	/**
	 * 物品
	 * @author BellaXu
	 */
	public class ItemBase extends BXDisplayObject
	{
		/**拖动时的镜像**/
		private static var imgCopy:BXImage;
		private static var dragRect:Rectangle;
		
		protected var _imgBorder:BXImage;
		protected var _imgLock:BXImage;
		protected var _imgIcon:BXImage;
		protected var _imgQuality:BXImage;
		protected var _imgMetier:BXImage;
		protected var _imgBind:BXImage;
		protected var _imgStrength:ImageNumber;
		protected var _imgNum:BXImage;
		protected var _lbNum:BXLabel;
		protected var _lbCD:BXLabel;
		protected var _spCD:Shape;
		
		public function ItemBase()
		{
			_imgBorder = ObjectPool.get(BXImage);
			_imgBorder.bitmapData = GameResLoader.getExtendBitmapData("Item_b1");
			addChild(_imgBorder);
			
			_imgLock = ObjectPool.get(BXImage);
			_imgLock.bitmapData = GameResLoader.getExtendBitmapData("Item_l2");
			_imgLock.x = -1;
			_imgLock.y = -1;
			_imgLock.visible = false;
			addChild(_imgLock);
			
			_imgIcon = ObjectPool.get(BXImage);
			_imgIcon.x = 3;
			_imgIcon.y = 3;
			addChild(_imgIcon);
			
			_imgQuality = ObjectPool.get(BXImage);
			_imgQuality.x = -1;
			_imgQuality.y = -1;
			addChild(_imgQuality);
			
			_imgMetier = ObjectPool.get(BXImage);
			_imgMetier.x = 1;
			_imgMetier.y = 1;
			addChild(_imgMetier);
			
			_imgBind = ObjectPool.get(BXImage);
			_imgBind.bitmapData = GameResLoader.getExtendBitmapData("Item_l1");
			_imgBind.x = 2;
			_imgBind.y = _imgBorder.height - _imgBind.height - 1;
			_imgBind.visible = false;
			addChild(_imgBind);
			
			_imgStrength = ObjectPool.get(ImageNumber);
			_imgStrength.style = 9;
			_imgStrength.visible = false;
			addChild(_imgStrength);
			
			_imgNum = ObjectPool.get(BXImage);
			_imgNum.bitmapData = GameResLoader.getExtendBitmapData("Item_b5");
			_imgNum.x = _imgBorder.width - _imgNum.width;
			_imgNum.y = _imgBorder.height - _imgNum.height;
			_imgNum.visible = false;
			addChild(_imgNum);
			
			_lbNum = ObjectPool.get(BXLabel);
			_lbNum.size = 10;
			_lbNum.text = "1";
			_lbNum.visible = false;
			addChild(_lbNum);
			
			_spCD = new Shape();
			_spCD.visible = false;
			addChild(_spCD);
			
			_lbCD = ObjectPool.get(BXLabel);
			_lbCD.size = 14;
			_lbCD.visible = false;
			addChild(_lbCD);
		}
		
		private var _dragable:Boolean = true;
		/**
		 * 是否可拖动
		 */
		public function set dragable(value:Boolean):void
		{
			_dragable = value;
		}
		
		public function get dragable():Boolean
		{
			return _dragable;
		}
		
		private var _more:StructBase;
		/**
		 * 更多数据
		 */
		public function set more(value:StructBase):void
		{
			_more = value;
		}
		
		public function get more():StructBase
		{
			return _more;
		}
		
		/**
		 * 是否锁定
		 */
		public function set isLocked(value:Boolean):void
		{
			_imgLock.visible = value;
			
			if(value)
				clean();
		}
		
		public function get isLocked():Boolean
		{
			return _imgLock.visible;
		}
		
		/**
		 * 数量
		 */
		public function set num(value:int):void
		{
			if(isLocked)
				return;
			if(value > 1)
			{
				_lbNum.visible = true;
				_imgNum.visible = true;
				_lbNum.text = value.toString();
				_lbNum.x = _imgNum.x + (_imgNum.width - _lbNum.width >> 1);
				_lbNum.y = _imgNum.y + (_imgNum.height - _lbNum.height >> 1) + 1;
			}
			else
			{
				_lbNum.text = value.toString();
				_lbNum.visible = false;
				_imgNum.visible = false;
				
				if(value == 0)
					clean();
			}
		}
		
		/**
		 * 清空数据但不回收
		 */
		public function clean():void
		{
			super.itemId = 0;
			_imgIcon.source = null;
			_imgMetier.bitmapData = null;
			_imgQuality.bitmapData = null;
			_imgBind.visible = false;
			_imgNum.visible = false;
			_imgStrength.visible = false;
			_lbNum.visible = false;
		}
		
		public function get num():int
		{
			return int(_lbNum.text);
		}
		
		protected var _cdGap:Number = 0;
		protected var _cdBegin:uint = 0
		private var _cdTotal:uint = 0;
		private var _renderCount:int = 0;
		/**
		 * 冷却时间(ms)
		 */
		public function set cd(value:int):void
		{
			if(isLocked)
				return;
			_lbCD.text = (value / 1000).toString();
			_lbCD.x = _imgBorder.width - _lbCD.width >> 1;
			_lbCD.y = _imgBorder.height - _lbCD.height >> 1;
			
			_cdTotal = value;
			_cdGap = 400 * (_imgBorder.width - 1) / _cdTotal;
			_cdBegin = 1;
			_renderCount = 0;
			if(cd > 0)
			{
				GameTimer.add(100, updateCDShape);
				_lbCD.visible = true;
				_spCD.visible = true;
			}
			else
			{
				GameTimer.del(updateCDShape);
				_lbCD.visible = false;
				_spCD.visible = false;
			}
		}
		
		public function get cd():int
		{
			var t:int = (_renderCount + 1) / 10;
			if(t > 0)
				t *= 1000;
			return _cdTotal - t;
		}
		
		private var _size:int = 40;
		/**
		 * 尺寸
		 */
		public function set size(value:int):void
		{
			_size = value;
		}
		
		public function get size():int
		{
			return _size;
		}
		
		override public function clear():void
		{
			super.clear();
			
			_size = 40;
			_cdGap = 0;
			_cdTotal = 0;
			_renderCount = 0;
			_more = null;
			_imgIcon.source = null;
			_imgQuality.bitmapData = null;
			_imgMetier.bitmapData = null;
			_imgBind.visible = false;
			_imgStrength.visible = false;
			_imgLock.visible = false;
			_imgNum.visible = false;
			_lbNum.visible = false;
			_spCD.visible = false;
			_lbNum.text = "1";
			
			_dragable = true;
		}
		
		/**
		 * 是否正在拖动
		 */
		public static var hasDrag:Boolean;
		
		override protected function downHandler(e:MouseEvent):void
		{
			if(isLocked || !_dragable || !itemId)
				return;
			if(!imgCopy)
				imgCopy = ObjectPool.get(BXImage);
			if(!dragRect)
				dragRect = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
			dragRect.width = stage.stageWidth - _size;
			dragRect.height = stage.stageHeight - _size;
			imgCopy.source = _imgIcon.source;
			imgCopy.startDrag(false, dragRect);
			stage.addChild(imgCopy);
			stage.addEventListener(MouseEvent.MOUSE_UP, moveMouseUpHandler);
			GameFrame.add(updateTarget, GameFrameGroup.DISPLAY);
			
			hasDrag = true;
		}
		
		private function moveMouseUpHandler(e:MouseEvent):void
		{
			hasDrag = false;
			
			stage.removeChild(imgCopy);
			stage.removeEventListener(MouseEvent.MOUSE_UP, moveMouseUpHandler);
			GameFrame.del(updateTarget, GameFrameGroup.DISPLAY);
			imgCopy.stopDrag();
			imgCopy.source = null;
			
			if(e.target is ItemBase)
			{
				var target:ItemBase = e.target as ItemBase;
				if(!target.isLocked)
				{
					//共四类格子：物品格、装备格、技能格、快捷格
					//拖动规则：
					//1.物品格
					//   拖动至相同物品时判断堆叠
					//  可拖至其它物品格
					//  若为装备可拖至装备格
					//  若可快捷使用可拖至快捷格
					//2.装备格
					//  可拖至物品格
					//  可拖至其它同类型的装备格
					//3.技能格
					//  可拖至快捷栏
					//4.快捷格
					//  可拖至其他快捷格
					//  拖至其它地方视为取消快捷
					if(this is Item)
					{
						if(target is Item)
						{
							if((this as Item).itemId == (target as Item).itemId && (target as Item).num < (target as Item).data.stack)
							{
								updateStacks(this as Item, target as Item);
							}
							else
							{
								swapItemData(this, target);
							}
						}
						else if(target is ItemEquip)
						{
							if((this as Item).data.type == ItemType.EQUIP)
							{
								if((this as Item).data.pos == (target as ItemEquip).pos)
								{
									swapItemData(this, target);
								}
								else
								{
									GameMsg.showMsg(Lang.getLocalString("item_equip_not_pos"));
								}
							}
							else
							{
								GameMsg.showMsg(Lang.getLocalString("item_not_equip"));
							}
						}
						else if(target is ItemQuick)
						{
							if((this as Item).data.can_quick == 1)
							{
								copyItemData(this, target);
							}
							else
							{
								GameMsg.showMsg(Lang.getLocalString("item_not_quick"));
							}
						}
					}
					else if(this is ItemEquip)
					{
						if(target is Item)
						{
							if(!(target as Item).data || (target as Item).data.pos == (this as ItemEquip).pos)
							{
								swapItemData(this, target);
							}
							else
							{
								GameMsg.showMsg(Lang.getLocalString("item_equip_not_replace"));
							}
						}
						else if(target is ItemEquip)
						{
							if((target as ItemEquip).pos == (this as ItemEquip).pos)
							{
								swapItemData(this, target);
							}
							else
							{
								GameMsg.showMsg(Lang.getLocalString("item_equip_not_replace"));
							}
						}
					}
					else if(this is ItemSkill)
					{
						if(target is ItemQuick)
						{
							copyItemData(this, target);
						}
					}
					else if(this is ItemQuick)
					{
						if(target is ItemQuick)
						{
							swapItemData(this, target);
						}
					}
				}
			}
			else
			{
				if(this is ItemQuick)
				{
					clearItemData(this);
				}
			}
		}
		
		/**
		 * 更新堆叠
		 */
		private function updateStacks(i1:Item, i2:Item):void
		{
			var max:uint = i2.data.stack - i2.num;
			var add:uint = i1.num > max ? max : i1.num;
			i1.num -= add;
			i2.num += add;
		}
		
		/**
		 * 交换数据
		 */
		private function swapItemData(i1:ItemBase, i2:ItemBase):void
		{
			if(i2 is ItemQuick && i1 is ItemQuick)
			{
				var f:Boolean = (i1 as ItemQuick).isItem;
				(i1 as ItemQuick).isItem = (i2 as ItemQuick).isItem;
				(i2 as ItemQuick).isItem = f;
			}
			
			var tid:int = i2.itemId;
			var tm:StructBase = i2.more;
			var tnum:int = i2.num;
			var tcd:int = i2.cd;
			
			i2.itemId = i1.itemId;
			i2.more = i1.more;
			i2.num = i1.num;
			i2.cd = i1.cd;
			
			i1.itemId = tid;
			i1.more = tm;
			i1.num = tnum;
			i1.cd = tcd;
		}
		
		/**
		 * 复制数据
		 */
		private function copyItemData(i1:ItemBase, i2:ItemBase):void
		{
			if(i2 is ItemQuick)
				(i2 as ItemQuick).isItem = i1 is Item;
			i2.itemId = i1.itemId;
			i2.more = i1.more;
			i2.num = i1.num;
			i2.cd = i1.cd;
		}
		
		private function clearItemData(i:ItemBase):void
		{
			i.itemId = 0;
			i.more = null;
			i.num = 0;
			i.cd = 0;
		}
		
		private function updateTarget():void
		{
			imgCopy.x = stage.mouseX - (_size >> 1);
			imgCopy.y = stage.mouseY - (_size >> 1);
		}
		
		private function updateCDShape():void
		{
			++_renderCount;
			
			var hw:int = _imgBorder.width >> 1;
			var sw:int = _imgBorder.width - _cdBegin;
			var hs:int = sw >> 1;
			var gap:Number = _cdGap * _renderCount;
			var bgap:Number = gap / hs;
			
			_spCD.graphics.clear();
			_spCD.graphics.beginFill(0xcccccc, 0.8);
			_spCD.graphics.moveTo(hw, hw);
			_spCD.graphics.lineTo(hw, _cdBegin);
			if(bgap < 7)
				_spCD.graphics.lineTo(_cdBegin, _cdBegin);
			if(bgap < 5)
				_spCD.graphics.lineTo(_cdBegin, sw);
			if(bgap < 3)
				_spCD.graphics.lineTo(sw, sw);
			if(bgap < 1)
				_spCD.graphics.lineTo(sw, _cdBegin);
			var sg:Number;
			if(bgap < 1)
			{
				sg = hw + gap;
				if(sg > sw)
					sg = sw;
				_spCD.graphics.lineTo(sg, _cdBegin);
			}
			else if(bgap < 3)
			{
				sg = gap - hw;
				if(sg < _cdBegin)
					sg = _cdBegin;
				else if(sg > sw)
					sg = sw;
				_spCD.graphics.lineTo(sw, sg);
			}
			else if(bgap < 5)
			{
				sg = sw - (gap - 3 * hs);
				if(sg < _cdBegin)
					sg = _cdBegin;
				else if(sg > sw)
					sg = sw;
				_spCD.graphics.lineTo(sg, sw);
			}
			else if(bgap < 7)
			{
				sg = sw - (gap - 5 * hs);
				if(sg < _cdBegin)
					sg = _cdBegin;
				else if(sg > sw)
					sg = sw;
				_spCD.graphics.lineTo(_cdBegin, sg);
			}
			else
			{
				sg = gap - 7 * hs;
				if(sg < _cdBegin)
					sg = _cdBegin;
				else if(sg > hw)
					sg = hw;
				_spCD.graphics.lineTo(sg, _cdBegin);
			}
			_spCD.graphics.lineTo(hw, hw);
			_spCD.graphics.endFill();
			
			if(_renderCount % 10 == 0)
			{
				var leftTime:int = (_cdTotal - _renderCount * 100) / 1000;
				_lbCD.text = leftTime.toString();
				_lbCD.x = _imgBorder.width - _lbCD.width >> 1;
				_lbCD.y = _imgBorder.height - _lbCD.height >> 1;
				
				if(leftTime <= 0)
				{
					_spCD.visible = false;
					_lbCD.visible = false;
					GameTimer.del(updateCDShape);
				}
			}
		}
	}
}