package com.bellaxu.net.dataset
{
	import com.bellaxu.net.struct.StructEquipMore;
	import com.bellaxu.net.struct.StructItem;

	public class ItemSet
	{
		public function getEquipedByPos(pos:uint):StructItem
		{
			var si:StructItem = new StructItem();
			si.id = 200000001;
			si.equipMore = new StructEquipMore(4, 1, 20001, 4, 4);
			return si;
		}
		
		public function getById(id:uint):Vector.<StructItem>
		{
			return new <StructItem>[];
		}
		
		public function getBySortId(sid:uint):Vector.<StructItem>
		{
			return new <StructItem>[];
		}
	}
}