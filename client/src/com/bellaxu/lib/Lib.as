package com.bellaxu.lib
{
	import com.bellaxu.lib.ext.IN;
	import com.bellaxu.lib.ext.IS;
	import com.bellaxu.lib.ext.IS_IN;
	import com.bellaxu.lib.ext.NO;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import game.core.GameResLoader;
	
	/**
	 * 配置库
	 * @author BellaXu
	 */
	public class Lib
	{
		private static const M_PATH:String = "com.bellaxu.lib.model.";
		private static const M_NAME:String = "Model";
		private static var _libDic:Dictionary = new Dictionary();
		private static var _cacheDic:Dictionary = new Dictionary(); //二级缓存，提高性能
		
		public static function init(bytes:ByteArray):void
		{
			bytes.uncompress();
			bytes.position = 0;
			var numAtt:int;
			var name:String;
			var attNameVec:Vector.<String>;
			var attTypeVec:Vector.<String>;
			var i:int, j:int, k:int, si:int, len:int;
			var cls:Class;
			var selfKey:Boolean;
			var model:*;
			var key:String;
			var attVal:String;
			var dic:Dictionary;
			var ary:Array;
			while (bytes.bytesAvailable > 0)
			{
				name = bytes.readUTF();
				numAtt = bytes.readInt();//有多少个属性
				attNameVec = new <String>[];//属性名数组
				attTypeVec = new <String>[];//属性类型数组
				i = 0;
				while(i++ < numAtt)
				{
					attNameVec.push(bytes.readUTF());
					attTypeVec.push(bytes.readUTF());
				}
				len = bytes.readInt();
				cls = GameResLoader.getClass(M_PATH + name + M_NAME);
				if(cls)
					dic = new Dictionary();
				
				selfKey = LibName.UNUNIQUES.indexOf(name) > -1;
				i = si = 0;
				while (i++ < len)
				{
					if(cls)
						model = new cls();
					j = 0;
					while (j < numAtt)
					{
						attVal = bytes.readUTF();
						if (j == 0)
							key = attVal;
						if(cls)
						{
							if(attTypeVec[j].indexOf("Vector.") > -1)
							{
								if(attTypeVec[j] == "Vector.<int>")
								{
									model[attNameVec[j]] = new <int>[];
								}
								else if(attTypeVec[j] == "Vector.<Number>")
								{
									model[attNameVec[j]] = new <Number>[];
								}
								else if(attTypeVec[j] == "Vector.<String>")
								{
									model[attNameVec[j]] = new <String>[];
								}
								if(attVal != "")
								{
									ary = attVal.split(",");
									k = 0;
									while(k < ary.length)
									{
										model[attNameVec[j]].push(ary[k]);
										k++;
									}
								}
							}
							else
							{
								model[attNameVec[j]] = attVal;
							}
						}
						j++;
					}
					if(cls)
						dic[selfKey ? si++ : key] = model;
				}
				if(cls)
					_libDic[name] = dic;
			}
		}
		
		/**
		 * 使用方法：
		 * <br/>1.通过Lib.getObj获得一个model
		 * <br/>2.将model载入特定的ResModel中（构造函数载入）
		 * <br/>3.key为xml中关键字的值
		 */
		public static function getObj(libName:String, key:int):*
		{
			if(!_libDic[libName])
				return null;
			return _libDic[libName][key];
		}
		
		/**
		 * 通过多个条件取一条唯一值
		 */
		public static function getObj2(libName:String, ...args):*
		{
			var arr:Array = [];
			arr.push(libName);
			arr = arr.concat(args);
			var vec:* = getVec.apply(null, arr);
			if(vec && vec.length)
				return vec[0];
			return null;
		}
		
		/**
		 * 计算表中att不同的数量
		 */
		public static function getDifNum(libName:String, att:String):int
		{
			var dic:Dictionary = _libDic[libName];
			if(!dic)
				return 0;
			var count:int = 0;
			var tmp:uint = 0;
			var obj:Object;
			for each(obj in dic)
			{
				if(obj[att] != tmp)
				{
					tmp = obj[att];
					count++;
				}
			}
			return count;
		}
		
		/**
		 * 索引机制的统一
		 * <br/>使用方法：
		 * <br/>1.通过Lib.getArr获得一个Vec
		 * <br/>2.将Vec中的Object载入特定的ResModel中（构造函数载入）
		 * <br/>3.args是参数格式如：[attname, IS, attvalue] 或者[attname, IN, value1, value2]
		 */
		public static function getVec(libName:String, ...args):*
		{
			if(!_libDic[libName])
				return null;
			//计算cache_key
			var cache_key:String = libName + "_";
			var ary:Array;
			var i:int, j:int;
			while(i < args.length)
			{
				ary = args[i];
				j = 0;
				while(j < ary.length)
				{
					cache_key += ary[j];
					j++;
				}
				if (i != args.length - 1)
					cache_key += "_";
				i++;
			}
			if(_cacheDic[cache_key])
				return _cacheDic[cache_key];
			//动态构建Vector
			var vecCls:Class = GameResLoader.getClass("__AS3__.vec.Vector.<" + M_PATH + libName + M_NAME + ">") as Class;
			var vec:* = new vecCls();
			var cls:Class = GameResLoader.getClass(M_PATH + libName + M_NAME);
			if(!cls)
				return;
			var dic:Dictionary = _libDic[libName];
			var attname:String;
			var flag:String;
			var attvalue:int;
			var value1:int;
			var value2:int;
			var obj:Object;
			for each(obj in dic)
			{
				i = 0;
				while(i < args.length)
				{
					ary = args[i];
					attname = ary[0];
					flag = ary[1];
					if(flag == IS)
					{
						attvalue = ary[2];
						if(obj[attname] != attvalue)
							break;
					}
					else if(flag == NO)
					{
						attvalue = ary[2];
						if(obj[attname] == attvalue)
							break;
					}
					else if(flag == IN)
					{
						value1 = ary[2];
						value2 = ary[3];
						if(obj[attname] < value1 || obj[attname] > value2)
							break;
					}
					else if(flag == IS_IN)
					{
						for(j = 2;j < ary.length;j++)
						{
							if(obj[attname] == ary[j])
								break;
						}
						if(j >= ary.length)
							break;
					}
					i++;
				}
				if(i >= args.length)
					vec.push(obj);
			}
			_cacheDic[cache_key] = vec;
			return vec;
		}
	}
}