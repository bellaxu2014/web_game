package com.bellaxu.lib.model
{
	/**
	 * 套装表数据模型
	 * @author BellaXu
	 */
	public class Pub_equipSortModel
	{
		/**
		 * 套装编号
		 */
		public var id:int;
		/**
		 * 套装名称
		 */
		public var name:String;
		/**
		 * 描述
		 */
		public var desc:String;
		/**
		 * 件数
		 */
		public var num:int;
		/**
		 * 装备编号数组
		 */
		public var equips:Vector.<int>;
		/**
		 * 集齐2件奖励
		 */
		public var prize2:Vector.<int>;
		/**
		 * 集齐4件奖励
		 */
		public var prize4:Vector.<int>;
		/**
		 * 集齐6件奖励
		 */
		public var prize6:Vector.<int>;
		
		public function Pub_equipSortModel()
		{
			
		}
	}
}