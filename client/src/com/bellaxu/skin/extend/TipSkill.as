package com.bellaxu.skin.extend
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.lang.Lang;
	import com.bellaxu.lib.Lib;
	import com.bellaxu.lib.LibAtt;
	import com.bellaxu.lib.LibName;
	import com.bellaxu.lib.ext.IS;
	import com.bellaxu.lib.model.Pub_itemModel;
	import com.bellaxu.lib.model.Pub_priceTypeModel;
	import com.bellaxu.lib.model.Pub_skillLvModel;
	import com.bellaxu.lib.model.Pub_skillModel;
	import com.bellaxu.net.dataset.DataSet;
	import com.bellaxu.net.struct.StructSkillMore;
	import com.bellaxu.skin.BXLabel;
	import com.bellaxu.skin.BXTextArea;
	import com.bellaxu.util.HtmlUtil;
	
	import game.core.GameColor;

	/**
	 * 技能悬浮
	 * @author BellaXu
	 */
	public class TipSkill extends TipBase
	{
		private var _item:ItemSkill;
		private var _lbLv:BXLabel;
		private var _lbCurLv:BXLabel;
		private var _lbMpCost:BXLabel;
		private var _lbCastDis:BXLabel;
		private var _lbCdTime:BXLabel;
		
		private var _lbNextLv:BXLabel;
		private var _lbStudyLv:BXLabel;
		private var _lbMpCost2:BXLabel;
		private var _lbCastDis2:BXLabel;
		private var _lbCdTime2:BXLabel;
		private var _taDesc2:BXTextArea;
		
		private var _lbNeedLv:BXLabel;
		private var _lbCondition:BXLabel;
		private var _lbNeedOther:BXLabel;
		
		public function TipSkill()
		{
			super();
			
			_item = ObjectPool.get(ItemSkill);
			_item.x = 13;
			_item.y = 12;
			addChild(_item);
			
			_lbTitle.textColor = GameColor.TIP_SKILL_NAME;
			_lbTitle.size = 16;
			_lbTitle.x = _item.x + _item.width + 5;
			_lbTitle.y = _item.y;
			_line1.y = _item.y + _item.height + 8;
			_taDesc.width = _border.width - 24;
			
			_lbLv = ObjectPool.get(BXLabel);
			_lbLv.text = Lang.getLocalString("tip_skill_lv");
			_lbLv.x = _lbTitle.x;
			_lbLv.y = _lbTitle.y + 28;
			addChild(_lbLv);
			
			_lbCurLv = ObjectPool.get(BXLabel);
			_lbCurLv.text = Lang.getLocalString("tip_skill_cur_lv");
			_lbCurLv.textColor = GameColor.TIP_SUBTITLE;
			_lbCurLv.x = _taDesc.x;
			_lbCurLv.y = _line1.y + _line1.height + 5;
			addChild(_lbCurLv);
			
			_lbMpCost = ObjectPool.get(BXLabel);
			_lbMpCost.text = Lang.getLocalString("tip_skill_mp_cost");
			_lbMpCost.textColor = GameColor.TIP_SKILL_FOCUS;
			_lbMpCost.x = _taDesc.x + 10;
			_lbMpCost.y = _lbCurLv.y + 20;
			addChild(_lbMpCost);
			
			_lbCastDis = ObjectPool.get(BXLabel);
			_lbCastDis.text = Lang.getLocalString("tip_skill_cast_dis");
			_lbCastDis.textColor = GameColor.TIP_SKILL_FOCUS;
			_lbCastDis.x = _lbMpCost.x;
			_lbCastDis.y = _lbMpCost.y + 20;
			addChild(_lbCastDis);
			
			_lbCdTime = ObjectPool.get(BXLabel);
			_lbCdTime.text = Lang.getLocalString("tip_skill_cd_time");
			_lbCdTime.textColor = GameColor.TIP_SKILL_FOCUS;
			_lbCdTime.x = _lbCastDis.x;
			_lbCdTime.y = _lbCastDis.y + 20;
			addChild(_lbCdTime);
			
			_taDesc.y = _lbCdTime.y + 20;
			
			_lbNextLv = ObjectPool.get(BXLabel);
			_lbNextLv.text = Lang.getLocalString("tip_skill_next_lv");
			_lbNextLv.textColor = GameColor.TIP_SUBTITLE;
			_lbNextLv.x = _taDesc.x;
			addChild(_lbNextLv);
			
			_lbMpCost2 = ObjectPool.get(BXLabel);
			_lbMpCost2.text = Lang.getLocalString("tip_skill_mp_cost");
			_lbMpCost2.textColor = GameColor.TIP_SKILL_FOCUS;
			_lbMpCost2.x = _lbMpCost.x ;
			addChild(_lbMpCost2);
			
			_lbCastDis2 = ObjectPool.get(BXLabel);
			_lbCastDis2.text = Lang.getLocalString("tip_skill_cast_dis");
			_lbCastDis2.textColor = GameColor.TIP_SKILL_FOCUS;
			_lbCastDis2.x = _lbMpCost.x;
			addChild(_lbCastDis2);
			
			_lbCdTime2 = ObjectPool.get(BXLabel);
			_lbCdTime2.text = Lang.getLocalString("tip_skill_cd_time");
			_lbCdTime2.textColor = GameColor.TIP_SKILL_FOCUS;
			_lbCdTime2.x = _lbMpCost.x;
			addChild(_lbCdTime2);
			
			_taDesc2 = ObjectPool.get(BXTextArea);
			_taDesc2.width = _border.width - 24;
			_taDesc2.x = 12;
			addChild(_taDesc2);
			
			_lbNeedLv = ObjectPool.get(BXLabel);
			_lbNeedLv.text = Lang.getLocalString("tip_skill_learn_lv");
			_lbNeedLv.textColor = GameColor.INT_WIHTE;
			_lbNeedLv.x = _lbMpCost.x;
			addChild(_lbNeedLv);
			
			_lbCondition = ObjectPool.get(BXLabel);
			_lbCondition.text = Lang.getLocalString("tip_skill_condition");
			_lbCondition.textColor = GameColor.INT_WIHTE;
			_lbCondition.x = _lbMpCost.x;
			addChild(_lbCondition);
			
			_lbNeedOther = ObjectPool.get(BXLabel);
			_lbNeedOther.text = Lang.getLocalString("tip_skill_need");
			_lbNeedOther.textColor = GameColor.INT_WIHTE;
			_lbNeedOther.x = _lbMpCost.x;
			addChild(_lbNeedOther);
		}
		
		override public function clear():void
		{
			super.clear();
		}
		
		override public function set itemId(value:int):void
		{
			super.itemId = value;
			
			var data:Pub_skillModel = Lib.getObj(LibName.PUB_SKILL, value);
			if(data)
			{
				var skillMore:StructSkillMore = more as StructSkillMore;
				var level:uint = 1;
				if(skillMore && skillMore.level)
					level = skillMore.level;
				var lvm:Pub_skillLvModel = Lib.getObj2(LibName.PUB_SKILLLV, [LibAtt.id, IS, data.id], [LibAtt.level, IS, level]);
				if(!lvm)
				{
					if(parent)
						parent.removeChild(this);
					return;
				}
				var lvm2:Pub_skillLvModel = Lib.getObj2(LibName.PUB_SKILLLV, [LibAtt.id, IS, data.id], [LibAtt.level, IS, level + 1]);
				
				_item.itemId = data.id;
				_lbTitle.text = data.name;
				_lbLv.text = Lang.getLocalString("tip_skill_lv") + (level > data.max_lv ? data.max_lv : level) + "/" + data.max_lv;
				_lbMpCost.text = Lang.getLocalString("tip_skill_mp_cost") + lvm.mp_cost;
				_lbCastDis.text = Lang.getLocalString("tip_skill_cast_dis") + lvm.distance;
				_lbCdTime.text = Lang.getLocalString("tip_skill_cd_time") + int(lvm.cd_time / 1000) + " " + Lang.getLocalString("uint_time_s");
				_taDesc.htmlText = lvm.desc;
				if(lvm2)
				{
					var cm:Pub_skillModel = Lib.getObj(LibName.PUB_SKILL, lvm.condition_id);
					var im:Pub_itemModel = Lib.getObj(LibName.PUB_ITEM, lvm.need_item);
					
					_lbNextLv.text = Lang.getLocalString("tip_skill_next_lv");
					_lbNextLv.y = _taDesc.y + _taDesc.height + 4;
					_lbNeedLv.htmlText = Lang.getLocalString("tip_skill_learn_lv") + HtmlUtil.getHtmlText(lvm.need_lv.toString(), 
						DataSet.characterSet.level >= lvm.need_lv ? GameColor.STR_GREEN : GameColor.STR_RED);
					_lbNeedLv.y = _lbNextLv.y + 20;
					if(cm)
					{
						_lbCondition.htmlText = Lang.getLocalString("tip_skill_condition") + HtmlUtil.getHtmlText(cm.name + " " + lvm.condition_lv + Lang.getLocalString("uint_level"), 
							DataSet.skillSet.checkSkill(lvm.condition_id, lvm.condition_lv) ? GameColor.STR_GREEN : GameColor.STR_RED);
						_lbCondition.y = _lbNeedLv.y + 20;
					}
					else
					{
						_lbCondition.text = "";
						_lbCondition.y = _lbNeedLv.y;
					}
					var needOtherStr:String = "";
					var tm:Pub_priceTypeModel;
					if(lvm.study_cost > 0)
					{
						tm = Lib.getObj(LibName.PUB_PRICETYPE, MoneyType.COIN);
						needOtherStr = Lang.getLocalString("tip_skill_need") + " " + HtmlUtil.getHtmlText(lvm.study_cost.toString() + tm.desc, 
							DataSet.characterSet.coins >= lvm.study_cost ? GameColor.STR_GREEN : GameColor.STR_RED);
					}
					if(lvm.study_exp > 0)
					{
						tm = Lib.getObj(LibName.PUB_PRICETYPE, MoneyType.EXP);
						needOtherStr += " " + HtmlUtil.getHtmlText(lvm.study_exp.toString() + tm.desc, 
							DataSet.characterSet.exp >= lvm.study_exp ? GameColor.STR_GREEN : GameColor.STR_RED);
					}
					if(im)
					{
						if(lvm.study_cost > 0 && lvm.study_exp > 0)
							needOtherStr += "\n          ";
						else
							needOtherStr += " ";
						needOtherStr += HtmlUtil.getHtmlText(im.name + " " + lvm.need_item_num + Lang.getLocalString("uint_item"), 
							DataSet.itemSet.getById(lvm.need_item).length >= lvm.need_item_num ? GameColor.STR_GREEN : GameColor.STR_RED);
					}
					_lbNeedOther.htmlText = needOtherStr;
					_lbNeedOther.y = _lbCondition.y + 20;
					_lbMpCost2.text = Lang.getLocalString("tip_skill_mp_cost") + lvm2.mp_cost;
					_lbMpCost2.y = _lbNeedOther.y + (lvm.study_cost > 0 && lvm.study_exp > 0 && im ? 44 : 24);
					_lbCastDis2.text = Lang.getLocalString("tip_skill_cast_dis") + lvm2.distance;
					_lbCastDis2.y = _lbMpCost2.y + 20;
					_lbCdTime2.text = Lang.getLocalString("tip_skill_cd_time") + int(lvm2.cd_time / 1000) + " " + Lang.getLocalString("uint_time_s");
					_lbCdTime2.y = _lbCastDis2.y + 20;
					_taDesc2.htmlText = lvm2.desc;
					_taDesc2.y = _lbCdTime2.y + 20;
					_border.height = _taDesc2.y + _taDesc2.height + 10;
				}
				else
				{
					_lbNextLv.text = "";
					_lbNeedLv.text = "";
					_lbCondition.text = "";
					_lbNeedOther.text = "";
					_lbMpCost2.text = "";
					_lbCastDis2.text = "";
					_lbCdTime2.text = "";
					_taDesc2.text = "";
					_border.height = _taDesc.y + _taDesc.height + 10;
				}
			}
			else
			{
				if(parent)
					parent.removeChild(this);
			}
		}
	}
}