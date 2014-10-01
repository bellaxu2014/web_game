# -*- coding:utf-8 -*-

import os
import os.path
import fnmatch
import sys
import struct
import zlib
import xml.dom.minidom as minidom
from xml.etree.ElementTree import ElementTree

#项目目录
BASE_DIR = 'D:/BellaXu/data/语言/'
OUTPUT_DIR = 'D:/BellaXu/client/bin-debug/res/lang/'

if len(sys.argv) > 1:
    BASE_DIR = sys.argv[1]
if len(sys.argv) > 2:
    OUTPUT_DIR = sys.argv[2]
    
#文件后缀到swift xml类型的映射关系
FILE_SUFFIX_MAP = {
    'xml' : 'bytearray'
}
#仅处理以下文件类型
FILE_TYPES = [
    'xml'
]

def getUTF8(s):
    s = s.encode('utf')
    return struct.pack('>H%ds' % len(s), len(s), s)

def getByte(i):
    return struct.pack('>i', i);

#打包一个目录下的所有文件
def pickle_dir(from_dir):
    #进入打包目录    
    for root, dirs, files in os.walk(from_dir):
        if root.find('.svn') >= 0:
            pass
        else:
            if files:
                pname = root.split(from_dir)[1]
                s = b''
                for fn in files:
                    tmp = fn.split('.')
                    if tmp[1] in FILE_TYPES:
                        s += getUTF8(tmp[0])
                        dom = minidom.parse(root + '/' + fn)
                        xml = dom.getElementsByTagName('xml')
                        cols = xml[0].getElementsByTagName('lang')
                        s += getByte(cols.length)
                        for lang in cols:
                            s += getUTF8(lang.getAttribute('id'))
                            s += getUTF8(lang.getAttribute('value'))
                print('导出 ' + OUTPUT_DIR + pname + '.lan')
                f = open(OUTPUT_DIR + pname + '.lan', 'wb')
                f.write(zlib.compress(s))
                f.flush()
                f.close()

def main():
    #direct to project
    os.chdir(BASE_DIR)
    pickle_dir(BASE_DIR)

if __name__ == "__main__":
    main()
