package game.core
{
	import com.bellaxu.ObjectPool;
	import com.bellaxu.net.struct.StructEquipMore;
	import com.bellaxu.net.struct.StructSkillMore;
	import com.bellaxu.skin.BXButton;
	import com.bellaxu.skin.BXCheckBox;
	import com.bellaxu.skin.BXComboBox;
	import com.bellaxu.skin.BXDataLineList;
	import com.bellaxu.skin.BXDisplayObjectContainer;
	import com.bellaxu.skin.BXFolderContainer;
	import com.bellaxu.skin.BXImage;
	import com.bellaxu.skin.BXImageButton;
	import com.bellaxu.skin.BXLabel;
	import com.bellaxu.skin.BXLine;
	import com.bellaxu.skin.BXMovie;
	import com.bellaxu.skin.BXNumberInput;
	import com.bellaxu.skin.BXPage;
	import com.bellaxu.skin.BXPanel;
	import com.bellaxu.skin.BXPosition;
	import com.bellaxu.skin.BXProgressbar;
	import com.bellaxu.skin.BXRadioButton;
	import com.bellaxu.skin.BXRadioButtonGroup;
	import com.bellaxu.skin.BXSimplePage;
	import com.bellaxu.skin.BXSlider;
	import com.bellaxu.skin.BXTabbar;
	import com.bellaxu.skin.BXTextArea;
	import com.bellaxu.skin.BXTextInput;
	import com.bellaxu.skin.BXTitle;
	import com.bellaxu.skin.BXTree;
	import com.bellaxu.skin.BXWindow;
	import com.bellaxu.skin.extend.ActivityButton;
	import com.bellaxu.skin.extend.ActivityButtonGroup;
	import com.bellaxu.skin.extend.ActivityButtonName;
	import com.bellaxu.skin.extend.ComboNumber;
	import com.bellaxu.skin.extend.FightValueDrop;
	import com.bellaxu.skin.extend.FightValueNumber;
	import com.bellaxu.skin.extend.FightValueUp;
	import com.bellaxu.skin.extend.Guide;
	import com.bellaxu.skin.extend.HpAddNumber;
	import com.bellaxu.skin.extend.HpReduceNumber;
	import com.bellaxu.skin.extend.Item;
	import com.bellaxu.skin.extend.ItemBase;
	import com.bellaxu.skin.extend.ItemDrop;
	import com.bellaxu.skin.extend.ItemEquip;
	import com.bellaxu.skin.extend.ItemQuick;
	import com.bellaxu.skin.extend.ItemSkill;
	import com.bellaxu.skin.extend.LevelupNumber;
	import com.bellaxu.skin.extend.MoneyLabel;
	import com.bellaxu.skin.extend.MpAddNumber;
	import com.bellaxu.skin.extend.SignQgame;
	import com.bellaxu.skin.extend.SignQzone;
	import com.bellaxu.skin.extend.SignVip;
	import com.bellaxu.util.MathUtil;
	
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;

	/**
	 * 测试类
	 * @author BellaXu
	 */
	public class GameTest
	{
		public static function testSkin():void
		{
			var i:int;
			var ti:BXTextInput = ObjectPool.get(BXTextInput);
			ti.x = 200;
			ti.y = 200;
			ti.text = "jlfja";
			ti.width = 100;
			GameConf.stage.addChild(ti);
			
			var ta:BXTextArea = ObjectPool.get(BXTextArea);
			ta.x = 200;
			ta.y = 100;
			ta.width = 200;
			ta.height = 100;
			ta.text = "更新公告：\n1.坐骑进阶消耗降低；\n2.商城修改；\n3.技能释放优化；";
			GameConf.stage.addChild(ta);
			
			for(i = 1;i < 8;i++)
			{
				var bt:BXButton = ObjectPool.get(BXButton);
				bt.x = 350 + (i - 1) * 80;
				bt.y = 200;
				if(i == 1)
					bt.label = '出售';
				bt.tip = "我是按钮" + i;
				bt.style = i;
				GameConf.stage.addChild(bt);
				if(i == 1)
				{
					bt.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void{
						GameCursor.cursor = GameCursor.cursor == GameCursor.SELL ? GameCursor.DEFAULT : GameCursor.SELL;
					});
				}
			}
			for(i = 100;i < 101;i++)
			{
				var cc:BXImageButton = ObjectPool.get(BXImageButton);
				cc.x = 350 + (i - 100) * 100;
				cc.y = 260;
				cc.style = i;
				GameConf.stage.addChild(cc);
			}
			
			var bb:BXCheckBox = ObjectPool.get(BXCheckBox);
			bb.x = 150;
			bb.y = 450;
			bb.label = "使用小肥猪";
			GameConf.stage.addChild(bb);
			
			var bc:BXRadioButton = ObjectPool.get(BXRadioButton);
			bc.x = 150;
			bc.y = 500;
			bc.label = "使用小肥猪";
			bc.selected = true;
			GameConf.stage.addChild(bc);
			
			var bdc:BXDisplayObjectContainer = ObjectPool.get(BXDisplayObjectContainer);
			bdc.x = 150;
			bdc.y = 550;
			bdc.width = 60;
			bdc.numColumns = 1;
			bdc.verticalGap = 0;
			GameConf.stage.addChild(bdc);
			
			for(i = 0;i < 10;i++)
			{
				var tb:BXLabel = ObjectPool.get(BXLabel);
				tb.text = "label" + i;
				bdc.addChild(tb);
			}
			
			var bcb:BXComboBox = ObjectPool.get(BXComboBox);
			bcb.x = 450;
			bcb.y = 650;
			bcb.inputEnabled = true;
			bcb.addItem("葫芦娃");
			bcb.addItem("周董");
			bcb.addItem("印娟");
			bcb.addItem("彭静");
			bcb.addItem("张晓");
			bcb.addItem("蓝海鹏");
			bcb.addItem("张佳慧");
			bcb.addItem("许少锋");
			bcb.addItem("冯叔");
			bcb.delItem("彭静");
			bcb.delItem("张晓");
			GameConf.stage.addChild(bcb);
			
			var btb:BXTabbar = ObjectPool.get(BXTabbar);
			btb.x = 600;
			btb.y = 650;
			btb.addTab("葫芦小娃娃");
			btb.addTab("周董");
			btb.addTab("印娟");
			btb.addTab("彭静");
			btb.addTab("张晓");
			btb.addTab("蓝海鹏");
			btb.addTab("张佳慧");
			btb.addTab("许少锋");
			btb.addTab("冯叔");
			GameConf.stage.addChild(btb);
			
			var btb2:BXTabbar = ObjectPool.get(BXTabbar);
			btb2.x = 600;
			btb2.y = 700;
			btb2.tabStyle = 2;
			btb2.tabPosition = BXPosition.BOTTOM;
			btb2.addTab("1");
			btb2.addTab("2");
			btb2.addTab("3");
			btb2.addTab("4");
			btb2.addTab("5");
			GameConf.stage.addChild(btb2);
			
			var btb3:BXTabbar = ObjectPool.get(BXTabbar);
			btb3.x = 800;
			btb3.y = 680;
			btb3.tabStyle = 3;
			btb3.tabPosition = BXPosition.LEFT;
			btb3.addTab("葫芦娃");
			btb3.addTab("印娟");
			btb3.addTab("周董");
			GameConf.stage.addChild(btb3);
			
			var btb4:BXTabbar = ObjectPool.get(BXTabbar);
			btb4.x = 830;
			btb4.y = 780;
			btb4.tabStyle = 4;
			btb4.addTab("综合");
			btb4.addTab("世界");
			btb4.addTab("场景");
			btb4.addTab("队伍");
			btb4.addTab("帮派");
			btb4.addTab("私聊");
			GameConf.stage.addChild(btb4);
			
			var bxn:BXNumberInput = ObjectPool.get(BXNumberInput);
			bxn.x = 600;
			bxn.y = 280;
			bxn.maxValue = 10;
			GameConf.stage.addChild(bxn);
			
			var bp:BXPage = ObjectPool.get(BXPage);
			bp.x = 750;
			bp.y = 280;
			bp.maxPage = 3;
			GameConf.stage.addChild(bp);
			
			for(i = 0;i < 6;i++)
			{
				var big:BXImage = ObjectPool.get(BXImage);
				big.x = 100 + i * 65;
				big.y = 20;
				big.source = GameFile.getHeadIcon(int(i / 2) + 1, (i % 2) + 1);
				GameConf.stage.addChild(big);
			}
			for(i = 0;i < 10;i++)
			{
				var ble:BXLine = ObjectPool.get(BXLine);
				ble.x = 500 ;
				ble.y = 20+ i * 5;
				ble.width = 200;
				GameConf.stage.addChild(ble);
			}
			
			var bsr:BXSlider = ObjectPool.get(BXSlider);
			bsr.x = 510;
			bsr.y = 110;
			GameConf.stage.addChild(bsr);
			
			var title:BXTitle = ObjectPool.get(BXTitle);
			title.x = 620;
			title.y = 460;
			title.text = "<font color='#ffff00'><b>董卓迷宫</b></font>";
			GameConf.stage.addChild(title);
			
			var bpb:BXProgressbar = ObjectPool.get(BXProgressbar);
			bpb.x = 470;
			bpb.y = 150;
			bpb.text = "采集中";
			GameConf.stage.addChild(bpb);
			var pfunc:Function = function():void{
				bpb.progress += 1;
				if(bpb.progress >= 100)
					bpb.progress = 0;
			};
			GameTimer.add(50, pfunc);
			
			var me:BXMovie = ObjectPool.get(BXMovie);
			me.x = 800;
			me.y = 350;
			me.source = "effect/rungirl.amd";
			me.interval = 8;
			me.play();
			GameConf.stage.addChild(me);
			
			var me2:BXMovie = ObjectPool.get(BXMovie);
			me2.x = 750;
			me2.y = 345;
			me2.source = "effect/runboy.amd";
			me2.interval = 8;
			me2.play();
			GameConf.stage.addChild(me2);
			
			var bsp:BXSimplePage = ObjectPool.get(BXSimplePage);
			bsp.x = 1220;
			bsp.y = 600;
			bsp.contentWidth = 120;
			bsp.maxPage = 5;
			GameConf.stage.addChild(bsp);
			
			var bdsc:BXFolderContainer = ObjectPool.get(BXFolderContainer);
			bdsc.x = 1355;
			bdsc.y = 160;
			bdsc.width = 180;
			bdsc.height = 200;
			bdsc.addOne("可折叠按钮1");
			bdsc.addOne("可折叠按钮2");
			bdsc.addOne("可折叠按钮3");
			bdsc.addOne("可折叠按钮4");
			GameConf.stage.addChild(bdsc);
			
			var brgp:BXRadioButtonGroup = ObjectPool.get(BXRadioButtonGroup);
			brgp.x = 50;
			brgp.y = 690;
			brgp.width = 200;
			brgp.numColumns = 3;
			brgp.addOne("郑");
			brgp.addOne("许");
			brgp.addOne("李");
			GameConf.stage.addChild(brgp);
			var bmy:MoneyLabel;
			for(i = 0;i < 8;i++)
			{
				bmy = ObjectPool.get(MoneyLabel);
				bmy.x = 310;
				bmy.y = 590 + 20 * i;
				bmy.type = i;
				bmy.value = MathUtil.getRandomInt(0, 9999999999);
				bmy.playAsChinese = MathUtil.getRandomEle([false, true]);
				GameConf.stage.addChild(bmy);
			}
			
			var bge:Guide = ObjectPool.get(Guide);
			bge.target = bmy;
			bge.position = BXPosition.TOP;
			GameConf.stage.addChild(bge);
			
			var bge2:Guide = ObjectPool.get(Guide);
			bge2.target = bmy;
			bge2.position = BXPosition.BOTTOM;
			GameConf.stage.addChild(bge2);
			
			var bge3:Guide = ObjectPool.get(Guide);
			bge3.target = bmy;
			bge3.position = BXPosition.LEFT;
			GameConf.stage.addChild(bge3);
			
			var bge4:Guide = ObjectPool.get(Guide);
			bge4.target = bmy;
			bge4.position = BXPosition.RIGHT;
			GameConf.stage.addChild(bge4);
			
			for(i = 0;i <= 9;i++)
			{
				var svip:SignVip = ObjectPool.get(SignVip);
				svip.x = 35;
				svip.y = 20 + i * 20;
				svip.value = i;
				GameConf.stage.addChild(svip);
			}
			
			for(i = 1;i <= 10;i++)
			{
				var qgame:SignQgame = ObjectPool.get(SignQgame);
				qgame.x = svip.x;
				qgame.y = svip.y + i * 20;
				qgame.level = i;
				GameConf.stage.addChild(qgame);
			}
			
			for(i = 1;i <= 10;i++)
			{
				var qgame2:SignQgame = ObjectPool.get(SignQgame);
				qgame2.x = svip.x + 30;
				qgame2.y = svip.y + i * 20;
				qgame2.level = i;
				qgame2.isYear = true;
				GameConf.stage.addChild(qgame2);
			}
			
			for(i = 1;i <= 10;i++)
			{
				var qzone:SignQzone = ObjectPool.get(SignQzone);
				qzone.x = qgame.x;
				qzone.y = qgame.y + i * 20;
				qzone.level = i;
				GameConf.stage.addChild(qzone);
			}
			
			for(i = 1;i <= 10;i++)
			{
				var qzone2:SignQzone = ObjectPool.get(SignQzone);
				qzone2.x = qgame2.x;
				qzone2.y = qgame2.y + i * 20;
				qzone2.level = i;
				qzone2.isYear = true;
				GameConf.stage.addChild(qzone2);
			}
			
			var lvlnum:LevelupNumber = ObjectPool.get(LevelupNumber);
			lvlnum.x = 145;
			lvlnum.y = 250;
			lvlnum.level = 39;
			GameConf.stage.addChild(lvlnum);
			
			var comboNum:ComboNumber = ObjectPool.get(ComboNumber);
			comboNum.x = 220;
			comboNum.y = 300;
			comboNum.combo = 0;
			GameConf.stage.addChild(comboNum);
			
			var comboNum2:ComboNumber = ObjectPool.get(ComboNumber);
			comboNum2.x = 220;
			comboNum2.y = 360;
			comboNum2.combo = 28;
			GameConf.stage.addChild(comboNum2);
			
			var fvn:FightValueNumber = ObjectPool.get(FightValueNumber);
			fvn.x = 300;
			fvn.y = 440;
			fvn.value = 2880;
			GameConf.stage.addChild(fvn);
			
			var fvu:FightValueUp = ObjectPool.get(FightValueUp);
			fvu.x = 300;
			fvu.y = 470;
			fvu.value = 154;
			GameConf.stage.addChild(fvu);
			
			var fvd:FightValueDrop = ObjectPool.get(FightValueDrop);
			fvd.x = 300;
			fvd.y = 510;
			fvd.value = 1051;
			GameConf.stage.addChild(fvd);
			
			var han:HpAddNumber = ObjectPool.get(HpAddNumber);
			han.x = 510;
			han.y = 460;
			han.value = 851;
			GameConf.stage.addChild(han);
			
			var hrn:HpReduceNumber = ObjectPool.get(HpReduceNumber);
			hrn.x = 510;
			hrn.y = 500;
			hrn.value = 2600;
			GameConf.stage.addChild(hrn);
			
			var man:MpAddNumber = ObjectPool.get(MpAddNumber);
			man.x = 510;
			man.y = 540;
			man.value = 884;
			GameConf.stage.addChild(man);
			
			var item:ItemBase = ObjectPool.get(Item);
			item.itemId = 100000000;
			item.num = 81;
			item.x = 640;
			item.y = 540;
			GameConf.stage.addChild(item);
			
			item = ObjectPool.get(Item);
			item.itemId = 200000000;
			item.more = new StructEquipMore(0, 0, 20001, 8, 9, 6);
			item.x = 700;
			item.y = 540;
			GameConf.stage.addChild(item);
			
			item = ObjectPool.get(Item);
			item.itemId = 200000001;
			item.more = new StructEquipMore(4, 1, 20001, 4, 4);
			item.x = 760;
			item.y = 540;
			GameConf.stage.addChild(item);
			
			item = ObjectPool.get(Item);
			item.itemId = 200000002;
			item.more = new StructEquipMore(12, 1, 0, 5, 5);
			item.x = 820;
			item.y = 540;
			GameConf.stage.addChild(item);
			
			item = ObjectPool.get(Item);
			item.itemId = 200000003;
			item.more = new StructEquipMore(0, 1, 0, 3, 3, 2, 2);
			item.x = 880;
			item.y = 540;
			GameConf.stage.addChild(item);
			
			item = ObjectPool.get(Item);
			item.itemId = 200000004;
			item.more = new StructEquipMore(0, 0, 0, 120, 180);
			item.x = 940;
			item.y = 540;
			GameConf.stage.addChild(item);
			
			item = ObjectPool.get(Item);
			item.itemId = 200000005;
			item.more = new StructEquipMore(0, 1, 0, 220, 280);
			item.x = 1000;
			item.y = 540;
			GameConf.stage.addChild(item);
			
			item = ObjectPool.get(Item);
			item.itemId = 300000000;
			item.cd = 10000;
			item.x = 1060;
			item.y = 540;
			GameConf.stage.addChild(item);
			
			item = ObjectPool.get(Item);
			item.itemId = 300000001;
			item.cd = 3000;
			item.num = 80;
			item.x = 1120;
			item.y = 540;
			GameConf.stage.addChild(item);
			
			item = ObjectPool.get(Item);
			item.itemId = 400000000;
			item.cd = 10000;
			item.num = 10;
			item.x = 1180;
			item.y = 540;
			GameConf.stage.addChild(item);
			
			item = ObjectPool.get(Item);
			item.itemId = 500000000;
			item.num = 3;
			item.dragable = false;
			item.x = 1240;
			item.y = 540;
			GameConf.stage.addChild(item);
			
			item = ObjectPool.get(Item);
			item.isLocked = true;
			item.itemId = 600000000;
			item.num = 18;
			item.x = 1300;
			item.y = 540;
			GameConf.stage.addChild(item);
			
			item = ObjectPool.get(Item);
			item.x = 950;
			item.y = 460;
			GameConf.stage.addChild(item);
			
			item = ObjectPool.get(ItemSkill);
			item.itemId = 10000;
			item.more = new StructSkillMore(3);
			item.x = 1010;
			item.y = 470;
			GameConf.stage.addChild(item);
			
			item = ObjectPool.get(ItemSkill);
			item.itemId = 20000;
			item.x = 1070;
			item.y = 470;
			GameConf.stage.addChild(item);
			
			item = ObjectPool.get(ItemSkill);
			item.itemId = 30000;
			item.x = 1130;
			item.y = 470;
			GameConf.stage.addChild(item);
			
			item = ObjectPool.get(ItemSkill);
			item.itemId = 40000;
			item.more = new StructSkillMore(3);
			item.cd = 8000;
			item.x = 1190;
			item.y = 470;
			GameConf.stage.addChild(item);
			
			item = ObjectPool.get(ItemSkill);
			item.itemId = 50000;
			item.more = new StructSkillMore(10);
			item.x = 1250;
			item.y = 470;
			GameConf.stage.addChild(item);
			
			item = ObjectPool.get(ItemSkill);
			item.isLocked = true;
			item.x = 1310;
			item.y = 470;
			GameConf.stage.addChild(item);
			
			var itemE:ItemEquip = ObjectPool.get(ItemEquip);
			itemE.pos = 1;
			itemE.itemId = 200000000;
			itemE.more = new StructEquipMore(0, 1, 0, 8, 9, 6);
			itemE.x = 1380;
			itemE.y = 280;
			GameConf.stage.addChild(itemE);
			
			itemE = ObjectPool.get(ItemEquip);
			itemE.pos = 2;
			itemE.itemId = 200000001;
			itemE.more = new StructEquipMore(7, 1, 0, 3, 3);
			itemE.x = 1440;
			itemE.y = 280;
			GameConf.stage.addChild(itemE);
			
			itemE = ObjectPool.get(ItemEquip);
			itemE.pos = 2;
			itemE.x = 1500;
			itemE.y = 280;
			GameConf.stage.addChild(itemE);
			
			itemE = ObjectPool.get(ItemEquip);
			itemE.pos = 3;
			itemE.itemId = 200000002;
			itemE.more = new StructEquipMore(0, 1, 0, 5, 7);
			itemE.x = 1380;
			itemE.y = 340;
			GameConf.stage.addChild(itemE);
			
			itemE = ObjectPool.get(ItemEquip);
			itemE.pos = 4;
			itemE.itemId = 200000003;
			itemE.more = new StructEquipMore(0, 1, 0, 2, 4, 3, 3);
			itemE.isLocked = true;
			itemE.x = 1440;
			itemE.y = 340;
			GameConf.stage.addChild(itemE);
			
			itemE = ObjectPool.get(ItemEquip);
			itemE.pos = 5;
			itemE.x = 1380;
			itemE.y = 400;
			GameConf.stage.addChild(itemE);
			
			itemE = ObjectPool.get(ItemEquip);
			itemE.pos = 8;
			itemE.x = 1440;
			itemE.y = 400;
			GameConf.stage.addChild(itemE);
			
			var itemQ:ItemQuick = ObjectPool.get(ItemQuick);
			itemQ.isItem = true;
			itemQ.itemId = 300000001;
			itemQ.key = Keyboard.BACKQUOTE;
			itemQ.x = 1500;
			itemQ.y = 460;
			GameConf.stage.addChild(itemQ);
			
			itemQ = ObjectPool.get(ItemQuick);
			itemQ.isItem = true;
			itemQ.itemId = 300000002;
			itemQ.key = Keyboard.SPACE;
			itemQ.x = 1440;
			itemQ.y = 460;
			GameConf.stage.addChild(itemQ);
			
			itemQ = ObjectPool.get(ItemQuick);
			itemQ.itemId = 10000;
			itemQ.key = Keyboard.NUMBER_1;
			itemQ.x = 1500;
			itemQ.y = 520;
			GameConf.stage.addChild(itemQ);
			
			itemQ = ObjectPool.get(ItemQuick);
			itemQ.itemId = 20000;
			itemQ.key = Keyboard.NUMBER_2;
			itemQ.x = 1440;
			itemQ.y = 520;
			GameConf.stage.addChild(itemQ);
			
			itemQ = ObjectPool.get(ItemQuick);
			itemQ.itemId = 10000;
			itemQ.key = Keyboard.Q;
			itemQ.x = 1500;
			itemQ.y = 580;
			GameConf.stage.addChild(itemQ);
			
			itemQ = ObjectPool.get(ItemQuick);
			itemQ.itemId = 10001;
			itemQ.key = Keyboard.W;
			itemQ.isLocked = true;
			itemQ.x = 1440;
			itemQ.y = 580;
			GameConf.stage.addChild(itemQ);
			
			var itemD:ItemDrop;
			itemD = ObjectPool.get(ItemDrop);
			itemD.itemId = 100000000;
			itemD.x = 1440;
			itemD.y = 680;
			GameConf.stage.addChild(itemD);
			
			itemD = ObjectPool.get(ItemDrop);
			itemD.itemId = 200000000;
			itemD.x = 1500;
			itemD.y = 680;
			GameConf.stage.addChild(itemD);
			
			itemD = ObjectPool.get(ItemDrop);
			itemD.itemId = 200000001;
			itemD.x = 1440;
			itemD.y = 770;
			GameConf.stage.addChild(itemD);
			
			itemD = ObjectPool.get(ItemDrop);
			itemD.itemId = 300000001;
			itemD.x = 1500;
			itemD.y = 770;
			GameConf.stage.addChild(itemD);
			
			var abg:ActivityButtonGroup = ObjectPool.get(ActivityButtonGroup);
			abg.addActivity(ActivityButtonName.BATTLE, 1989999);
			abg.addActivity(ActivityButtonName.BOSS);
			abg.addActivity(ActivityButtonName.CHARGE);
			abg.addActivity(ActivityButtonName.DAILY);
			abg.addActivity(ActivityButtonName.FAMOUS);
			abg.addActivity(ActivityButtonName.GOLD);
			abg.addActivity(ActivityButtonName.GOLDCOPY);
			abg.addActivity(ActivityButtonName.HORSE);
			abg.addActivity(ActivityButtonName.LEGION, 3899);
			abg.addActivity(ActivityButtonName.LEVEL);
			abg.addActivity(ActivityButtonName.MAZE);
			abg.addActivity(ActivityButtonName.MOBILE);
			abg.addActivity(ActivityButtonName.ONLINE);
			abg.addActivity(ActivityButtonName.OPEN);
			abg.addActivity(ActivityButtonName.SHOP);
			abg.addActivity(ActivityButtonName.THREE);
			abg.addActivity(ActivityButtonName.TOWER);
			abg.addActivity(ActivityButtonName.TREASURE);
			abg.x = 1200;
			abg.y = 800;
			GameConf.stage.addChild(abg);
			
			
			var bw:BXWindow = ObjectPool.get(BXWindow);
			bw.title = "背包";
			bw.width = 370;
			bw.height = 300;
			GameConf.stage.addChild(bw);
			
			var me3:BXMovie = ObjectPool.get(BXMovie);
			me3.x = 345;
			me3.y = 35;
			me3.source = "effect/winddoll.amd";
			me3.interval = 20;
			me3.play();
			bw.addChild(me3);
			
			var btb5:BXTabbar = ObjectPool.get(BXTabbar);
			btb5.x = 14;
			btb5.y = 40;
			btb5.tabStyle = 5;
			btb5.tabPosition = BXPosition.LEFT;
			btb5.addTab("全部");
			btb5.addTab("装备");
			btb5.addTab("药品");
			btb5.addTab("宝石");
			btb5.addTab("卷轴");
			btb5.addTab("其他");
			bw.addChild(btb5);
			
			var bpl:BXPanel = ObjectPool.get(BXPanel);
			bpl.x = 20;
			bpl.y = 40;
			bpl.width = 332;
			bpl.height = 254;
			bw.addChild(bpl);
			
			var bpl2:BXPanel = ObjectPool.get(BXPanel);
			bpl2.x = 132;
			bpl2.y = 10;
			bpl2.width = 193;
			bpl2.height = 238;
			bpl2.style = 4;
			bpl.addChild(bpl2);
			
			var dll:BXDataLineList = ObjectPool.get(BXDataLineList);
			dll.x = 7;
			dll.y = 7;
			dll.width = bpl2.width - 14;
			dll.height = 238;
			dll.addOne("line1");
			dll.addOne("line2");
			dll.addOne("line3");
			dll.addOne("line4");
			dll.addOne("line5");
			dll.addOne("line6");
			dll.addOne("line7");
			dll.addOne("line8");
			bpl2.addChild(dll);
			
			var bte:BXTree = ObjectPool.get(BXTree);
			bte.x = 15;
			bte.y = 10;
			bte.addNode("50级装备");
			bte.addNode("60级装备");
			bte.addNode("70级装备");
			bte.addNode("80级装备");
			bte.addNode("90级装备");
			bte.addNode("100级装备");
			bte.width = 100;
			bte.height = 240;
			for(i = 0;i < 6;i++)
			{
				bte.addSub("装备1", i);
				bte.addSub("装备2", i);
				bte.addSub("装备3", i);
			}
			for(i = 0;i < 6;i++)
			{
				bte.addSub("属性1", i, 0);
				bte.addSub("属性2", i, 0);
				bte.addSub("属性3", i, 0);
				bte.addSub("属性4", i, 0);
				bte.addSub("属性5", i, 0);
			}
			bpl.addChild(bte);
		}
	}
}