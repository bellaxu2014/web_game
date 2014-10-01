package com.bellaxu.net.struct
{
	import com.bellaxu.util.MathUtil;

	public class StructEquipMore extends StructBase
	{
		public var quality:uint;
		public var strengthLv:uint;
		public var identified:uint;
		public var fightValue:uint;
		public var skillId:uint;
		public var price:uint = MathUtil.getRandomInt(0, 99999);
		public var sortId:uint = MathUtil.getRandomEle([0, 10000, 10001]);
		
		public var basicAtt:Vector.<int> = new <int>[];
		public var pureAtt:Vector.<int> = new <int>[];
		public var gemAtt:Vector.<int> = new <int>[];
		
		public function StructEquipMore(l:uint = 0, i:uint = 0, sid:uint = 0, a1:uint = 0, a2:uint = 0, a3:uint = 0, a4:uint = 0, pa1:uint = 0, pa2:uint = 0, pa3:uint = 0, pa4:uint = 0)
		{
			quality = MathUtil.getRandomInt(0, 4);
			strengthLv = l;
			identified = i;
			skillId = sid;
			fightValue = MathUtil.getRandomInt(0, 9999);
			
			gemAtt.push(400000000);
			gemAtt.push(400000000);
			gemAtt.push(400000000);
			
			basicAtt.push(a1);
			basicAtt.push(a2);
			basicAtt.push(a3);
			basicAtt.push(a4);
			
			pureAtt.push(pa1);
			pureAtt.push(pa2);
			pureAtt.push(pa3);
			pureAtt.push(pa4);
		}
	}
}