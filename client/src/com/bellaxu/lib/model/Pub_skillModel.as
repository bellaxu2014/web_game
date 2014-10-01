package com.bellaxu.lib.model
{
	/**
	 * 技能表数据模型
	 * @author BellaXu
	 */
	public class Pub_skillModel
	{
		/**
		 * 技能编号
		 */
		public var id:int;
		/**
		 * 名称
		 */
		public var name:String;
		/**
		 * 职业
		 */
		public var metier:int;
		/**
		 * 最大等级
		 */
		public var max_lv:int;
		/**
		 * 是否被动
		 */
		public var is_passive:int;
		/**
		 * 攻击类型
		 */
		public var attack_type:int;
		/**
		 * 作用类型
		 */
		public var camp:int;
		/**
		 * 技能组编号
		 */
		public var sort:int;
		/**
		 * 是否远程
		 */
		public var is_remote:int;
		
		public function Pub_skillModel()
		{
			
		}
	}
}