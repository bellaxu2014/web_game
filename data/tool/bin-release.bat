::先还原所有修改（开发服不做任何手动修改，都走发布脚本）
svn cleanup C:/xampp/htdocs/bin/xhgz/
svn cleanup C:/xampp/htdocs/bin/xhgz/fla/
svn cleanup C:/xampp/htdocs/bin/client_dev/Client/GameRes/
svn cleanup C:/xampp/htdocs/bin/szww_cehua/

svn revert C:/xampp/htdocs/bin/xhgz/ --depth=infinity
svn revert C:/xampp/htdocs/bin/xhgz/fla/ --depth=infinity
svn revert C:/xampp/htdocs/bin/client_dev/Client/GameRes/ --depth=infinity
svn revert C:/xampp/htdocs/bin/szww_cehua/ --depth=infinity

::更新所有SVN
svn update C:/xampp/htdocs/bin/xhgz/
svn update C:/xampp/htdocs/bin/xhgz/fla/
svn update C:/xampp/htdocs/bin/client_dev/Client/GameRes/
svn update C:/xampp/htdocs/bin/szww_cehua/

::生成lib
cd ../szww_cehua/主线/腾讯/tools
Game.DataC.exe .\ 2
一键生成.py C:/xampp/htdocs/bin/client_dev/Client/GameRes/localres/
cd ../../联运/tools
Game.DataC.exe .\ 2
一键生成.py C:/xampp/htdocs/bin/client_dev/Client/GameRes/localres/
cd ../../../../release

::编译主程序
call ant

::打包lang
pack-lang.py C:/xampp/htdocs/bin/client_dev/Client/GameRes/localres/
pack-lang2.py C:/xampp/htdocs/bin/client_dev/Client/GameRes/localres/

::AMD加密并拷贝至GameRes
swf-to-amd.py C:/xampp/htdocs/bin/client_dev/Client/GameRes/ui/

::生成版本文件
version.py C:/xampp/htdocs/bin/client_dev/Client/GameRes/

::svn提交本次构建
svn commit -m 整体构建提交 C:/xampp/htdocs/bin/xhgz/
svn commit -m 整体构建提交 C:/xampp/htdocs/bin/client_dev/Client/GameRes/
svn commit -m 整体构建提交 C:/xampp/htdocs/bin/szww_cehua/

pause 