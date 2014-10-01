package com.bellaxu.lib.model
{
	/**
	 * 技能等级数据模型
	 * @author BellaXu
	 */
	public class Pub_skillLvModel
	{
		/**
		 * 技能编号
		 */
		public var id:int;
		/**
		 * 等级
		 */
		public var level:int;
		/**
		 * 描述
		 */
		public var desc:String;
		/**
		 * 前置技能编号
		 */
		public var condition_id:int;
		/**
		 * 前置技能等级
		 */
		public var condition_lv:int;
		/**
		 * 需要等级
		 */
		public var need_lv:int;
		/**
		 * 消耗物品
		 */
		public var need_item:int;
		/**
		 * 消耗物品数量
		 */
		public var need_item_num:int;
		/**
		 * 学习消耗银两
		 */
		public var study_cost:int;
		/**
		 * 学习消耗经验
		 */
		public var study_exp:int;
		/**
		 * 法力消耗
		 */
		public var mp_cost:int;
		/**
		 * 冷却时间
		 */
		public var cd_time:int;
		/**
		 * 施法时间
		 */
		public var cast_time:int;
		/**
		 * 技能距离
		 */
		public var distance:int;
		/**
		 * 范围
		 */
		public var area:int;
		
		public function Pub_skillLvModel()
		{
			
		}
	}
}