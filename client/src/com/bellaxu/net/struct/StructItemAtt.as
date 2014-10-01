package com.bellaxu.net.struct
{
	public class StructItemAtt
	{
		public var basicAtt1:uint;
		public var basicAtt2:uint;
		public var basicAtt3:uint;
		public var basicAtt4:uint;
		
		public var strengthAtt1:uint;
		public var strengthAtt2:uint;
		public var strengthAtt3:uint;
		public var strengthAtt4:uint;
		
		public function StructItemAtt(a1:uint = 0, a2:uint = 0, a3:uint = 0, a4:uint = 0, sa1:uint = 0, sa2:uint = 0, sa3:uint = 0, sa4:uint = 0)
		{
			basicAtt1 = a1;
			basicAtt2 = a2;
			basicAtt3 = a3;
			basicAtt4 = a4;
			
			strengthAtt1 = sa1;
			strengthAtt2 = sa2;
			strengthAtt3 = sa3;
			strengthAtt4 = sa4;
		}
	}
}