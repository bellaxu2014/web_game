# -*- coding:utf-8 -*-

import os
import os.path
import fnmatch
import sys
import hashlib
import struct
import zlib
import time

#项目目录
BASE_DIR = 'D:/BellaXu/client/bin-debug/res/'
FILE_NAME_0 = 'version.txt'
FILE_NAME = 'version.ver'

if len(sys.argv) > 1:
    BASE_DIR = sys.argv[1]

EXCEPT_FILES = [
    'map/*_*',
    '*.svn',
    'crossdomain.xml',
    'expressInstall.swf',
    'version.txt',
    'version.ver',
    'version.js'
]

def check_usable(fn):
    if fn == '':
        return False
    for exc in EXCEPT_FILES:
        if fnmatch.fnmatch(fn, exc):
            return False
    return True

def get_file_md5(strFile):
    file = open(strFile, "rb");  
    md5 = hashlib.md5();  
    strRead = "";
    while True:  
        strRead = file.read(8096);  
        if not strRead:  
            break;  
        md5.update(strRead);
    bRet = True;  
    strMd5 = md5.hexdigest();
    file.close()  
    return strMd5;

def getUTF8(s):
    s = s.encode('utf')
    return struct.pack('>H%ds' % len(s), len(s), s)

def getMd5AndVer(r0, fn):
    found = False
    found2 = False
    result = list()
    for i in r0:
        if found2 is True:
            result.append(i)
            return result
        if found is True:
            result.append(i)
            found2 = True
        if fnmatch.fnmatch(i, fn):
            found = True
    return result

def save_version(from_dir):
    print('version root ' + from_dir);
    if os.path.exists(from_dir + FILE_NAME_0) == False:
        f = open(from_dir + FILE_NAME_0, 'w', -1, 'utf-8')
        f.close();
    f0 = open(from_dir + FILE_NAME_0, 'r', -1, 'utf-8')
    r0 = f0.read().split('\n')
    f0.close()
    #组建字典
    dic = {}
    for r1 in r0:
        r2 = r1.split(' ')
        if len(r2) < 3:
            pass
        else:
            path = r2[0]
            md5 = r2[1]
            ver = r2[2]
            dic[path] = {'md5': md5, 'ver': ver}
    f = open(from_dir + FILE_NAME, 'wb')
    s = b'';
    for root, dirs, files in os.walk(from_dir):
        if root.find('.svn') >= 0:
            #pass svn files
            pass
        else:
            if files:
                for fn in files:
                    usable = check_usable(fn)
                    if usable:
                        if root != BASE_DIR:
                            ofn = root + os.path.sep + fn
                        else:
                            ofn = fn
                        ofn = ofn.replace('\\', '/')
                        rfn = ofn.replace(BASE_DIR, '')
                        strMd5 = get_file_md5(ofn)
                        ver = 1
                        if dic.get(rfn) is None:
                            print('version added ' + rfn)
                        obj = dic.setdefault(rfn, {'md5': strMd5, 'ver': ver})
                        md5 = dic[rfn]['md5']
                        ver = int(dic[rfn]['ver'])
                        if strMd5 != md5:
                            ver = ver + 1
                            print('version updated ' + rfn + '(' + str(ver) + ')')
                        dic[rfn] = {'md5': strMd5, 'ver': ver}
                        s = s + getUTF8(rfn) + getUTF8(str(ver))
    zs = zlib.compress(s)
    f.write(zs)
    f.flush()
    f.close()
    #保存time.txt
    print('导出 ' + from_dir + FILE_NAME_0)
    f0 = open(from_dir + FILE_NAME_0, 'w', -1, 'utf-8')
    for i in dic:
        obj = dic[i]
        md5 = obj['md5']
        ver = obj['ver']
        f0.write(i + ' ' + md5 + ' ' + str(ver) + '\n')
    f0.close()
    #更新version.js
    print('导出 ' + from_dir + 'version.js')
    loaderobj = dic['GameLoader.swf']
    tt = time.strftime("%m%d%H%M", time.localtime()) 
    f0 = open(from_dir + 'version.js', 'w', -1, 'utf-8')
    s = 'var ClientConfig =  getClientConfig();\n'
    s+= 'function getClientConfig()\n'
    s+= '{\n'
    s+= '\tvar cparams = {};\n'
    s+= '\tcparams.loaderver = \"' + str(loaderobj['ver']) + '\";\n'
    s+= '\tcparams.version = \"' + tt + '\";\n'
    s+= '\treturn cparams;\n'
    s+= '}'
    f0.write(s)
    f0.close()
    
def main():
    #direct to project
    os.chdir(BASE_DIR)
    save_version(BASE_DIR);

if __name__ == "__main__":
    main()

    
