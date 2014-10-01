package com.bellaxu.lib.model
{
	/**
	 * 物品表数据模型
	 * @author BellaXu
	 */
	public class Pub_itemModel
	{
		/**
		 * 物品编号
		 */
		public var id:int;
		/**
		 * 名字
		 */
		public var name:String;
		/**
		 * 描述
		 */
		public var desc:String;
		/**
		 * 类型
		 */
		public var type:int;
		/**
		 * 职业
		 */
		public var metier:int;
		/**
		 * 位置
		 */
		public var pos:int;
		/**
		 * 是否绑定
		 */
		public var is_bind:int;
		/**
		 * 等级
		 */
		public var level:int;
		/**
		 * 需求等级
		 */
		public var need_level:int;
		/**
		 * 最大强化等级
		 */
		public var max_strength:int;
		/**
		 * 品质
		 */
		public var quality:int;
		/**
		 * 孔数
		 */
		public var hole_num:int;
		/**
		 * 起始耐久度
		 */
		public var dura:int;
		/**
		 * 最大堆叠数
		 */
		public var stack:int;
		/**
		 * 能否使用
		 */
		public var can_use:int;
		/**
		 * 能否销售
		 */
		public var can_sale:int;
		/**
		 * 能否快速使用
		 */
		public var can_quick:int;
		/**
		 * 能否发送
		 */
		public var can_send:int;
		/**
		 * 能否销毁
		 */
		public var can_destroy:int;
		/**
		 * 价格数组
		 */
		public var prices:Vector.<int>;
		/**
		 * 属性数组
		 */
		public var atts:Vector.<int>;
		/**
		 * 属性值数组
		 */
		public var values:Vector.<int>;
		/**
		 * 附带效果数组
		 */
		public var impacts:Vector.<int>;
		
		public function Pub_itemModel()
		{
			
		}
	}
}