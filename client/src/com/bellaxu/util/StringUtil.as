package com.bellaxu.util
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import game.core.GameReg;
	
	/**
	 * 字符串工具
	 * @author BellaXu
	 * Created on 2014.4.18
	 */
	public class StringUtil 
	{
		/**
		 * 去掉字符串左右两端的空格，返回新串
		 */
		public static function trim(input:String):String
		{
			return StringUtil.ltrim(StringUtil.rtrim(input));
		}
		
		public static function ltrim(input:String):String
		{
			var size:Number = input.length;
			for(var i:Number = 0; i < size; i++)
			{
				if(input.charCodeAt(i) > 32)
					return input.substring(i);
			}
			return "";
		}
		
		public static function rtrim(input:String):String
		{
			var size:Number = input.length;
			for(var i:Number = size; i > 0; i--)
			{
				if(input.charCodeAt(i - 1) > 32)
					return input.substring(0, i);
			}
			return "";
		}
		
		/**
		 * 替换字符串中的内容
		 */
		public static function replace(str:String, info:Dictionary):String
		{
			if (!str || !info)
				return "";
			var result:String = str;
			var p:String;
			var patten:RegExp;
			for (var key:String in info)
			{
				p = "{" + key + "}";
				patten = new RegExp(p, "g");
				result = result.replace(patten, String(info[key]));
			}
			return result;
		}
		
		/**
		 * 获得字符串的字节长度
		 * 输入：
		 *   str:String 需要获取字节长度的字符串
		 * 输出：
		 *   int 字节长度
		 * 错误：
		 *   -1 字符串为null
		 */               
		public static function getByteLen(str:String ):int 
		{
			var len:int = -1;
			if(str != null)
			{
				var ba:ByteArray = new ByteArray();
				ba.writeObject(str); //如果使用的是UTF8的编码，用这个可以得到
				len = ba.length;
			}
			return len;
		}
		
		/**
		 * 取字符串长度，支持中文
		 */
		public static function getStringLength(thisString : String) : Number
		{
			var thisStringBytsLength :ByteArray = new ByteArray();
			thisStringBytsLength.writeMultiByte(thisString,"cn-gb");
			return thisStringBytsLength.length;
		}
		
		/**
		 * 返回指定长度的重复char字符串  
		 */	
		public static function repeatStr(char:String, len:int):String
		{
			var result:String = "";
			while (len > 0)
			{
				result += char;
				len--;
			}
			return result;
		}
		
		/**
		 * 判断text字符串是否为纯数字字符串
		 */
		public static function JudgeText(text:String):int
		{
			var arr:Array = text.match(GameReg.NO_DIGIT);
			if (!arr || arr.length == 0)
				return -1;
			return int(text);
		}
		
		/**
		 * 补齐字符串
		 * 因为这里使用的是字节长度（一个中文算2个字节）
		 * 所以指定的长度是指字节长度，用来填补的字符按一个字节算
		 * 如果填补的字符使用中文那么会导致结果不正确，但这里没有对填补字符做检测
		 * @param str 源字符串
		 * @param length 指定的字节长度
		 * @param char 填补的字符
		 * @param doubleChar 对连续两个填补字符进行替换
		 * @param ignoreHtml 是否忽略HTML代码，默认为true
		 */		
		public static function complementByChar(str:String, length:int, char:String, doubleChar:String="", ignoreHtml:Boolean=true):String
		{
			var byteLen:int = getStringLength(ignoreHtml ? str.replace(GameReg.HTML, "") : str);
			var addstr:String = repeatStr(char, length - byteLen);
			if (doubleChar != "") addstr = addstr.replace(new RegExp(char + char, "g"), doubleChar)
			return str + addstr;
		}
		
		/**
		 * 将值如0x12的char转换为字符串"12"
		 */
		public static function charToSZ(c:uint):String
		{
			const char_map:Array = ["0", "1", "2","3","4","5","6","7","8","9","A","B","C","D","E","F"];
			var c1:uint = (c >> 4) & 0xf;
			var c2:uint = c & 0xf;
			var s:Array = [];
			s[0] = char_map[c1];
			s[1] = char_map[c2];
			return (s[0] + s[1]);
		}
		
		/**
		 * 把通过byteArrayToString转换过来的字符串转回bytearray
		 */
		public static function stringToByteArray(str:String):ByteArray
		{
			var ba:ByteArray = new ByteArray;
			ba.position = 0;
			for (var i:int= 0; i < str.length/2; i++ )
			{
				ba.writeByte(int("0x"+str.charAt(i*2)+str.charAt(i*2+1)));
			}
			return ba;
		}
		
		/**
		 * 把ByteArray转换成对应的字符串
		 */
		public static function byteArrayToString(ba:ByteArray):String
		{
			ba.position = 0;
			var bastr:String = "";
			while (ba.position < ba.length)
			{
				bastr += charToSZ(ba.readByte());
			}
			return bastr;
		}
		
		private static function NumStr(value:int):String
		{
			var s:String;
			if (value < 10)
				s = "0" + value.toString()
			else
				s = value.toString();
			return s;
		}
		
		/**
		 * 通过秒数获取对应中文字符串信息：XX时XX分XX秒
		 */
		public static function getFormatCNTimeBySec(sec:uint):String
		{
			var result:String = "";
			var second:uint = sec % 60;
			var minute:uint = sec / 60 % 60;
			var hour:uint = sec / 60 / 60;
			if (hour >= 0){
				result += NumStr(hour) + "时";
			}
			if (minute >= 0){
				result += NumStr(minute) + "分";
			}
			if (second >= 0){
				result += NumStr(second) + "秒";
			}
			return result;
		}
		
		/**
		 * 通过秒数获取对应中文字符串信息：X小时X分钟
		 */
		public static function getHourMinuteFormat(sec:uint):String
		{
			var result:String = "";
			var second:uint = sec % 60
			var minute:uint = sec / 60 % 60;
			var hour:uint = sec / 60 / 60;
			if (second > 0)
				minute++;
			if (hour > 0)
				result += hour + "小时";
			if (minute > 0)
				result += minute + "分钟";
			return result;
		}
		
		/**
		 * 换成标准时间：XX：XX：XX
		 */
		public static function getFormatTimeBySec(sec:int, needH:Boolean = true):String
		{
			var second:uint = sec % 60;
			var minute:uint = sec / 60 % 60;
			var hour:uint = sec / 60 / 60;			
			var s:String;
			var m:String;
			var h:String;
			s = NumStr(second);
			m = NumStr(minute);
			h = NumStr(hour);
			return (needH ? h + ":" : "") + m + ":" + s;
		}
		
		/**
		 * 通过Date获取对应中文字符串信息：XXXX.XX.XX XX:XX:XX
		 */
		public static function getFormatTimeByDate(mydate:Date, needTime:Boolean = true):String
		{
			var year:Number = mydate.getFullYear(); 
			var month:Number = mydate.getMonth() + 1; 
			var day:Number = mydate.getDate(); 
			var hour:Number = mydate.getHours(); 
			var minute:Number = mydate.getMinutes(); 
			var second:Number = mydate.getSeconds();
			
			var monthStr:String = (month >= 10) ? month.toString() : ("0" + month);
			var dayStr:String = (day >= 10) ? day.toString() : ("0" + day);
			var hourStr:String = (hour >= 10) ? hour.toString() : ("0" + hour);
			var minuteStr:String = (minute >= 10) ? minute.toString() : ("0" + minute);
			var secondStr:String = (second >= 10) ? second.toString() : ("0" + second);
			
			if(needTime)
				return year + "." + monthStr + "." + dayStr + " " + hourStr + ":" + minuteStr + ":" + secondStr;
			return year + "-" + monthStr + "-" + dayStr ;
		}
		
		/**
		 * 换掉String中某位
		 */
		public static function replaceCharAt(source:String, pos:int, value:int):String
		{
			var str1:String = source.substring(0, pos);
			var str2:String = source.substring(pos + 1, source.length);
			return str1 + value + str2;
		}
	}
}