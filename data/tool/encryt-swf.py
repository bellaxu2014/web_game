# -*- coding:utf-8 -*-

import os
import struct
import zlib
import fnmatch
import sys

path_1 = 'D:/BellaXu/client/bin-release/'
path_2 = 'D:/BellaXu/client/fla/'
path_3 = 'D:/BellaXu/client/bin-debug/res/'

if len(sys.argv) > 1:
    path_1 = sys.argv[1]
if len(sys.argv) > 2:
    path_2 = sys.argv[2]
if len(sys.argv) > 3:
    path_3 = sys.argv[3]

#仅处理以下文件类型
FILE_TYPES = [
    'swf'
]

def getUTF8(s):
    s = s.encode('utf')
    return struct.pack('>H%ds' % len(s), len(s), s)

def copyfile(path, fn, outpath, outfn):
    print('导出 ' + outpath + outfn)
    f = open(path + fn, 'rb')
    fs = open(outpath + outfn, 'wb')
    fs.write(f.read())
    fs.close()
    f.close()

def encode(path, fn, outpath, outfn):
    f = open(path + fn, 'rb')
    zs = zlib.compress(f.read())
    f.close()
    bs = struct.pack('>3i', 2014, 7, 1)
    bs += getUTF8('xhgame')
    bs += getUTF8('bellaxu')
    bs += zs
    print('导出 ' + outpath + outfn)
    fs = open(outpath + outfn, 'wb')
    fs.write(bs)
    fs.close()

def encode_1():
    copyfile(path_1, 'GameLoader.swf', path_3, 'GameLoader.swf')
    encode(path_1, 'Game.swf', path_3, 'game.amd')

def encode_2():
    for root, dirs, files in os.walk(path_2 + 'effect/'):
        if files:
            for fn in files:
                    tmp = fn.split('.')
                    if len(tmp) < 2:
                        continue
                    if tmp[1] in FILE_TYPES:
                        encode(path_2 + 'effect/', fn, path_3 + 'effect/', tmp[0] + '.amd')
    
    for root, dirs, files in os.walk(path_2 + 'model/'):
        if files:
            for fn in files:
                    tmp = fn.split('.')
                    if len(tmp) < 2:
                        continue
                    if tmp[1] in FILE_TYPES:
                        encode(path_2 + 'model/', fn, path_3 + 'model/', tmp[0] + '.amd')
    
    for root, dirs, files in os.walk(path_2 + 'skin/'):
        if files:
            for fn in files:
                    tmp = fn.split('.')
                    if len(tmp) < 2:
                        continue
                    if tmp[1] in FILE_TYPES:
                        encode(path_2 + 'skin/', fn, path_3 + 'skin/', tmp[0] + '.amd')
    
    for root, dirs, files in os.walk(path_2 + 'ui/'):
        if files:
            for fn in files:
                    tmp = fn.split('.')
                    if len(tmp) < 2:
                        continue
                    if tmp[1] in FILE_TYPES:
                        encode(path_2 + 'ui/', fn, path_3 + 'ui/', tmp[0] + '.amd')

def main():
    os.chdir(path_1)
    encode_1()
    encode_2()

if __name__ == "__main__":
    main()
