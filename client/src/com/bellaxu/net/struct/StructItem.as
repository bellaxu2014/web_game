package com.bellaxu.net.struct
{
	/**
	 * 物品结构体
	 * @author BellaXu
	 */
	public class StructItem extends StructBase
	{
		public var id:uint;
		public var num:uint;
		public var itemMore:StructItemMore;
		public var equipMore:StructEquipMore;
		
		public function StructItem()
		{
		}
	}
}