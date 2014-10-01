package com.bellaxu.skin.extend
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.lang.Lang;
	import com.bellaxu.lib.Lib;
	import com.bellaxu.lib.LibAtt;
	import com.bellaxu.lib.LibName;
	import com.bellaxu.lib.ext.IS;
	import com.bellaxu.lib.model.Pub_equipSortModel;
	import com.bellaxu.lib.model.Pub_equipStrengthModel;
	import com.bellaxu.lib.model.Pub_itemModel;
	import com.bellaxu.lib.model.Pub_itemPosModel;
	import com.bellaxu.lib.model.Pub_itemQualityModel;
	import com.bellaxu.lib.model.Pub_propertyModel;
	import com.bellaxu.lib.model.Pub_skillModel;
	import com.bellaxu.net.dataset.DataSet;
	import com.bellaxu.net.struct.StructEquipMore;
	import com.bellaxu.net.struct.StructItem;
	import com.bellaxu.skin.BXLabel;
	import com.bellaxu.skin.BXLine;
	import com.bellaxu.skin.BXPosition;
	import com.bellaxu.skin.BXTextArea;
	import com.bellaxu.util.HtmlUtil;
	
	import flash.geom.Point;
	
	import game.core.GameColor;
	import game.core.GameFilter;
	import game.core.GameResLoader;

	/**
	 * 装备悬浮
	 * @author BellaXu
	 */
	public class TipEquip extends TipBase
	{
		private var _item:Item;
		private var _lbType:BXLabel;
		private var _lbLevel:BXLabel;
		private var _lbQuality:BXLabel;
		private var _lbDura:BXLabel;
		private var _imgFight:FightValueNumber;
		private var _lbAttBasic:BXLabel;
		private var _lbIdentify:BXLabel;
		private var _starbar:Starbar;
		
		private var _line2:BXLine;
		private var _lbAttGem:BXLabel;
		private var _taAttGem:BXTextArea;
		
		private var _line3:BXLine;
		private var _taAttSort:BXTextArea;
		
		private var _line4:BXLine;
		private var _lbPrice:BXLabel;
		private var _mlPrice:MoneyLabel;
		private var _lbSend:BXLabel;
		
		private var _tipCompare:TipEquip;
		
		public function TipEquip()
		{
			super();
			
			_border.width = 256;
			_lbTitle.filters = [GameFilter.UI_GLOW_BLACK];
			_ImgArrow2.x = _border.width - 4;
			_line1.width = _border.width - (_line1.x << 1);
			_taDesc.width = _border.width - 24;
			
			_item = ObjectPool.get(Item);
			_item.x = 13;
			_item.y = 36;
			addChild(_item);
			
			_lbType = ObjectPool.get(BXLabel);
			_lbType.text = Lang.getLocalString("tip_equip_pos");
			_lbType.x = _item.x + _item.width + 5;
			_lbType.y = _item.y - 2;
			addChild(_lbType);
			
			_lbLevel = ObjectPool.get(BXLabel);
			_lbLevel.text = Lang.getLocalString("tip_equip_lv");
			_lbLevel.x = _lbType.x;
			_lbLevel.y = _lbType.y + 16;
			addChild(_lbLevel);
			
			_lbQuality = ObjectPool.get(BXLabel);
			_lbQuality.text = Lang.getLocalString("tip_equip_quality");
			_lbQuality.x = _lbType.x;
			_lbQuality.y = _lbLevel.y + 16;
			addChild(_lbQuality);
			
			_lbDura = ObjectPool.get(BXLabel);
			_lbDura.text = Lang.getLocalString("tip_equip_dura");
			_lbDura.x = _lbQuality.x + _lbQuality.width + 10;
			_lbDura.y = _lbQuality.y;
			addChild(_lbDura);
			
			_imgFight = ObjectPool.get(FightValueNumber);
			_imgFight.position = BXPosition.RIGHT;
			_imgFight.x = _item.x;
			_imgFight.y = _item.y + _item.height + 8;
			addChild(_imgFight);
			
			_line1.y = _imgFight.y + _imgFight.height + 5;
			
			_lbIdentify = ObjectPool.get(BXLabel);
			_lbIdentify.text = Lang.getLocalString("tip_equip_not_identify");
			_lbIdentify.x = _item.x;
			_lbIdentify.y = _line1.y + _line1.height+ 5;
			addChild(_lbIdentify);
			
			_lbAttBasic = ObjectPool.get(BXLabel);
			_lbAttBasic.text = Lang.getLocalString("tip_equip_att_basic");
			_lbAttBasic.x = _item.x;
			_lbAttBasic.y = _line1.y + _line1.height+ 5;
			addChild(_lbAttBasic);
			
			_starbar = ObjectPool.get(Starbar);
			_starbar.x = _item.x + 4;
			_starbar.y = _lbAttBasic.y + 25;
			addChild(_starbar);
			
			_taDesc.y = _starbar.y + 21;
			
			_line2 = ObjectPool.get(BXLine);
			_line2.x = _line1.x;
			_line2.width = _line1.width;
			addChild(_line2);
			
			_lbAttGem = ObjectPool.get(BXLabel);
			_lbAttGem.text = Lang.getLocalString("tip_equip_att_gem");
			_lbAttGem.x = _item.x;
			_lbAttGem.y = _line2.y + _line2.height+ 5;
			addChild(_lbAttGem);
			
			_taAttGem = ObjectPool.get(BXTextArea);
			_taAttGem.width = _taDesc.width;
			_taAttGem.x = _item.x;
			addChild(_taAttGem);
			
			_line3 = ObjectPool.get(BXLine);
			_line3.x = _line1.x;
			_line3.width = _line1.width;
			addChild(_line3);
			
			_taAttSort = ObjectPool.get(BXTextArea);
			_taAttSort.width = _taDesc.width;
			_taAttSort.x = _item.x;
			addChild(_taAttSort);
			
			_line4 = ObjectPool.get(BXLine);
			_line4.x = _line1.x;
			_line4.width = _border.width - (_line4.x << 1);
			addChild(_line4);
			
			_lbPrice = ObjectPool.get(BXLabel);
			_lbPrice.text = Lang.getLocalString("tip_item_sell_price");
			_lbPrice.textColor = GameColor.INT_YELLOW;
			_lbPrice.x = _item.x;
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
		
		protected var _compareMode:Boolean;
		
		public function set compareMode(value:Boolean):void
		{
			_compareMode = value;
		}
		
		public function get compareMode():Boolean
		{
			return _compareMode;
		}
		
		override public function clear():void
		{
			super.clear();
			
			if(_tipCompare)
			{
				if(_tipCompare.parent)
					_tipCompare.parent.removeChild(_tipCompare);
				_tipCompare.clear();
			}
			_item.more = null;
			_tipCompare = null;
			_compareMode = false;
			_border.width = 256;
		}
		
		override public function set itemId(value:int):void
		{
			super.itemId = value;
			
			var data:Pub_itemModel = Lib.getObj(LibName.PUB_ITEM, value);
			if(!data)
			{
				if(parent)
					parent.removeChild(this);
				return;
			}
			var pm:Pub_itemPosModel = Lib.getObj(LibName.PUB_ITEMPOS, data.pos);
			if(!pm)
			{
				if(parent)
					parent.removeChild(this);
				return;
			}
			var dataMore:StructEquipMore = more as StructEquipMore;
			
			_item.itemId = data.id;
			_item.more = dataMore;
			_lbType.text = Lang.getLocalString("tip_equip_pos") + pm.desc;
			_lbLevel.text = Lang.getLocalString("tip_equip_lv") + data.level;
			_lbDura.text = Lang.getLocalString("tip_equip_dura") + data.dura;
			if(dataMore && dataMore.identified == 1)
			{
				_imgFight.visible = true;
				_starbar.visible = true;
				_lbAttBasic.visible = true;
				_lbIdentify.visible = false;
				
				if(_compareMode)
				{
					var equiped:StructItem = DataSet.itemSet.getEquipedByPos(data.pos);
					if(equiped)
					{
						_tipCompare = ObjectPool.get(TipEquipCompare);
						_tipCompare.more = equiped.equipMore;
						_tipCompare.itemId = equiped.id;
						_tipCompare.x = -_tipCompare.width - 2;
						var lo:Point = localToGlobal(new Point(_tipCompare.x, _tipCompare.y));
						if(lo.x < 0)
							_tipCompare.x = _tipCompare.width + 2;
						addChildAt(_tipCompare, 0);
					}
				}
				
				var qm:Pub_itemQualityModel = Lib.getObj(LibName.PUB_ITEMQUALITY, dataMore.quality);
				
				_imgTitle.bitmapData = GameResLoader.getExtendBitmapData("ItemTip_z" + dataMore.quality);
				_lbTitle.htmlText = HtmlUtil.getHtmlText(data.name, GameColor.getColorByQuality(dataMore.quality), 14, true);
				_lbQuality.text = Lang.getLocalString("tip_equip_quality") + qm.desc;
				_imgFight.value = dataMore.fightValue;
				_starbar.star = dataMore.strengthLv;
				_starbar.maxStar = data.max_strength;
				_line1.y = _imgFight.y + _imgFight.height + 5;
				//基础属性
				var esm:Pub_equipStrengthModel = dataMore.strengthLv > 0 ? Lib.getObj2(LibName.PUB_EQUIPSTRENGTH, [LibAtt.id, IS, data.id], [LibAtt.level, IS, dataMore.strengthLv]) : null;
				var attStr:String = "";
				var i:int = 0;
				var attId:int;
				var attM:Pub_propertyModel;
				var attVal:int;
				while(i < data.atts.length)
				{
					attVal = dataMore.basicAtt[i] + (i < dataMore.pureAtt.length ? dataMore.pureAtt[i] : 0);
					if(attVal != 0)
					{
						attId = data.atts[i];
						attM = Lib.getObj(LibName.PUB_PROPERTY, attId);
						if(attM)
						{
							if(attM.hide != 1)
							{
								if(attStr != "")
									attStr += "<br/>";
								attStr += attM.desc + " +" + attVal;
								if(esm && esm.values.length)
									attStr += HtmlUtil.getHtmlText("(" + Lang.getLocalString("tip_equip_strength") + "+" + esm.values[i] + ")", GameColor.STR_YELLOW);
							}
						}
					}
					i++;
				}
				//附加特技
				if(dataMore.skillId > 0)
				{
					var sm:Pub_skillModel =  Lib.getObj(LibName.PUB_SKILL, dataMore.skillId);
					if(sm)
						attStr += "<br/>" + HtmlUtil.getHtmlText(Lang.getLocalString("tip_equip_add_skill") + sm.name, GameColor.STR_RED);
				}
				_taDesc.htmlText = attStr;
				//宝石镶嵌
				var proM:Pub_propertyModel;
				var strC:String;
				if(dataMore.gemAtt.length)
				{
					attStr = "";
					_line2.visible = true;
					_lbAttGem.visible = true;
					_taAttGem.visible = true;
					
					i = 0;
					var gemM:Pub_itemModel;
					while(i < dataMore.gemAtt.length)
					{
						gemM = Lib.getObj(LibName.PUB_ITEM, dataMore.gemAtt[i]);
						if(gemM)
						{
							strC = GameColor.getColorByQuality(gemM.quality);
							attStr += (i != 0 ? "<br/>" : "") + HtmlUtil.getHtmlText(gemM.name, strC);
							var j:int = 0;
							while(j < gemM.atts.length)
							{
								proM = Lib.getObj(LibName.PUB_PROPERTY, gemM.atts[j]);
								attStr += " " + proM.desc + "+" + gemM.values[j];
								j++;
							}
						}
						i++;
					}
					_taAttGem.htmlText = attStr;
						
					_line2.y = _taDesc.y + _taDesc.height + 4;
					_lbAttGem.y = _line2.y + _line2.height + 5;
					_taAttGem.x = _item.x;
					_taAttGem.y = _lbAttGem.y + 20;
					_line3.y = _taAttGem.y + _taAttGem.height + 4;
				}
				else
				{
					_line2.visible = false;
					_lbAttGem.visible = false;
					_taAttGem.visible = false;
					
					_line3.y = _taDesc.y + _taDesc.height + 4;
				}
				//套装属性
				var sortM:Pub_equipSortModel;
				if(dataMore.sortId > 0)
					sortM = Lib.getObj(LibName.PUB_EQUIPSORT, dataMore.sortId);
				if(sortM)
				{
					attStr = "";
					_line3.visible = true;
					_taAttSort.visible = true;
					
					_taAttSort.y = _line3.y + _line3.height + 5;
					
					var sorts:Vector.<StructItem> = DataSet.itemSet.getBySortId(dataMore.sortId);
					attStr += HtmlUtil.getHtmlText(sortM.name + "(" + sorts.length + "/" + sortM.num + ")", GameColor.STR_BLUE);
					if(sortM.num >= 2)
					{
						strC = sorts.length >= 2 ? GameColor.STR_BLUE : GameColor.STR_GRAY;
						attStr += "<br/>" + HtmlUtil.getHtmlText(sortM.name + "(2/" + sortM.num + ")", strC);
						if(sortM.prize2)
						{
							i = 0;
							while(i < sortM.prize2.length)
							{
								proM = Lib.getObj(LibName.PUB_PROPERTY, sortM.prize2[i]);
								if(proM)
									attStr += HtmlUtil.getHtmlText(" " + proM.desc + "+" + sortM.prize2[i + 1], strC);
								i += 2;
							}
						}
					}
					if(sortM.num >= 4)
					{
						strC = sorts.length >= 2 ? GameColor.STR_BLUE : GameColor.STR_GRAY;
						attStr += "<br/>" + HtmlUtil.getHtmlText(sortM.name + "(4/" + sortM.num + ")", strC);
						if(sortM.prize4)
						{
							i = 0;
							while(i < sortM.prize4.length)
							{
								proM = Lib.getObj(LibName.PUB_PROPERTY, sortM.prize4[i]);
								if(proM)
									attStr += HtmlUtil.getHtmlText(" " + proM.desc + "+" + sortM.prize4[i + 1], strC);
								i += 2;
							}
						}
					}
					if(sortM.num >= 6)
					{
						strC = sorts.length >= 2 ? GameColor.STR_BLUE : GameColor.STR_GRAY;
						attStr += "<br/>" + HtmlUtil.getHtmlText(sortM.name + "(6/" + sortM.num + ")", strC);
						if(sortM.prize6)
						{
							i = 0;
							while(i < sortM.prize6.length)
							{
								proM = Lib.getObj(LibName.PUB_PROPERTY, sortM.prize6[i]);
								if(proM)
									attStr += HtmlUtil.getHtmlText(" " + proM.desc + "+" + sortM.prize6[i + 1], strC);
								i += 2;
							}
						}
					}
					attStr += "<br/>" + HtmlUtil.getHtmlText(sortM.desc, GameColor.STR_BLUE);
					_taAttSort.htmlText = attStr;
					_line4.y = _taAttSort.y + _taAttSort.height + 4;
				}
				else
				{
					_line3.visible = false;
					_taAttSort.visible = false;
					_line4.y = _line3.y;
				}
				
				_mlPrice.value =  dataMore.price;
			}
			else
			{
				_imgFight.visible = false;
				_starbar.visible = false;
				_lbAttBasic.visible = false;
				_lbIdentify.visible = true;
				_line2.visible = false;
				_lbAttGem.visible = false;
				_taAttGem.visible = false;
				_line3.visible = false;
				_taAttSort.visible = false;
				
				_imgTitle.bitmapData = GameResLoader.getExtendBitmapData("ItemTip_z0");
				_lbTitle.htmlText = HtmlUtil.getHtmlText(data.name, GameColor.STR_WHITE, 14, true);
				_lbQuality.text = Lang.getLocalString("tip_equip_quality") + Lang.getLocalString("tip_equip_quality_unknown");
				_taDesc.text = "";
				_line1.y = _item.y + _item.height+ 8;
				_lbIdentify.y = _line1.y + _line1.height + 5;
				_line4.y = _lbIdentify.y + _lbIdentify.height + 4;
				_mlPrice.value =  data.prices && data.prices.length ? data.prices[0] : 0;
			}
			_lbTitle.x = _border.width - _lbTitle.width >> 1;
			_lbDura.x = _lbQuality.x + _lbQuality.width + 10;
			
			_lbPrice.y = _line4.y + _line4.height + 4;
			_mlPrice.y = _lbPrice.y;
			_lbSend.y = _lbPrice.y + _lbPrice.textHeight + 2;
			_border.height = _lbSend.y + _lbSend.height + 6;
		}
		
		override protected function updateTip():void
		{
			if(!_tipCompare)
			{
				super.updateTip();
			}
			else
			{
				if(stage)
				{
					x = stage.mouseX;
					y = stage.mouseY;
					
					var maxH:uint = _tipCompare.height > _border.height ? _tipCompare.height : _border.height;
					var p0:Point = localToGlobal(new Point(_tipCompare.x, maxH));
					var p:Point = localToGlobal(new Point(_border.width, maxH));
					if(p0.x < 0)
					{
						_tipCompare.x = _border.width + 2;
					}
					else
					{
						_tipCompare.x = -_border.width - 2;
					}
					if(p.x < stage.stageWidth)
					{
						x += 5;
					}
					else
					{
						x -= width + 2;
					}
					if(p.y < stage.stageHeight)
					{
						y += 25;
					}
					else
					{
						y -= height + 2;
					}
				}
			}
		}
	}
}