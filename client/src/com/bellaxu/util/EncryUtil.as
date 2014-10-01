package com.bellaxu.util
{
	import flash.utils.ByteArray;

	/**
	 * 加密规则
	 * @author BellaXu
	 */
	public class EncryUtil
	{
		/**
		 * 解析amd文件
		 */
		public static function decodeBytes(bytes:ByteArray):ByteArray
		{
			if(bytes.readInt() == 2014 && bytes.readInt() == 7 && bytes.readInt() == 1)
			{
				if(bytes.readUTF() == "xhgame" && bytes.readUTF() == "bellaxu")
				{
					var temp:ByteArray = new ByteArray();
					bytes.readBytes(temp, 0, bytes.bytesAvailable);
					temp.position = 0;
					temp.uncompress();
					return temp;
				}
			}
			return bytes;
		}
	}
}