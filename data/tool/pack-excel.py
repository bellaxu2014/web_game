# -*- coding:utf-8 -*-

import os
import os.path
import fnmatch
import sys
import hashlib
import struct
import zlib
import xlrd
import xml.dom.minidom as minidom
from xml.etree.ElementTree import ElementTree

#配置目录
CONF_DIR = os.path.dirname(__file__) + os.path.sep
SAVE_DIR = 'D:/BellaXu/client/src/com/bellaxu/lib/'
OUTPUT_DIR = 'D:/BellaXu/client/bin-debug/res/lib/'

if len(sys.argv) > 1:
    SAVE_DIR = sys.argv[1]
if len(sys.argv) > 2:
    OUTPUT_DIR = sys.argv[2]

ATTR_LIST = [
]

def getUTF8(s):
    s = s.encode('utf')
    return struct.pack('>H%ds' % len(s), len(s), s)

def getByte(i):
    return struct.pack('>i', i);

def createASFiles():
    dom = minidom.parse(CONF_DIR + 'config-export.xml')
    xml = dom.getElementsByTagName('xml')
    cols = xml[0].getElementsByTagName('data')
    libname = []
    descs = {}
    ununique = []
    LIB_BYTE = b''
    for data in cols:
        excel = data.getAttribute('excel')
        name = data.getAttribute('name')
        unique = data.getAttribute('unique')
        export = data.getAttribute('export')
        file = xlrd.open_workbook(excel)
        sheet = file.sheet_by_name(name)
        
        createASFile(sheet, name, export)
        libname.append(export)
        descs[export] = name
        if unique != 'true':
            ununique.append(export.upper())
        
        #将数据加入lib
        LIB_BYTE += getUTF8(export)
        #列数
        rcn = 0
        ncols = sheet.ncols
        nrows = sheet.nrows
        for colnum in range(0, ncols):
            col = sheet.col_values(colnum)
            if col:
                colName = col[0]
                colType = col[1]
                colDesc = col[2]
                if colName != '':
                    rcn += 1
        LIB_BYTE += getByte(rcn)
        #列名-列类型
        for colnum in range(0, ncols):
            col = sheet.col_values(colnum)
            if col:
                colName = col[0]
                colType = col[1]
                colDesc = col[2]
                if colName != '':
                    LIB_BYTE += getUTF8(colName)
                    LIB_BYTE += getUTF8(colType)
        #行数
        rrn = 0
        for rownum in range(3, nrows):
            row = sheet.row_values(rownum)
            if row:
                if row[0] != '':
                    rrn += 1
        LIB_BYTE += getByte(rrn)
        #行数据
        for rownum in range(3, nrows):
            row = sheet.row_values(rownum)
            if row:
                if row[0] != '':
                    for i in range(0, rcn):
                        col = sheet.col_values(i)
                        if col[1] == 'int' and row[i] != '':
                            LIB_BYTE += getUTF8(str(int(row[i])))
                        else:
                            LIB_BYTE += getUTF8(str(row[i]))
    createLibName(libname, descs, ununique)
    createLibAtt()
    createLibs(LIB_BYTE)

#导出model文件        
def createASFile(sheet, name, export):
    cname = export + 'Model'
    print('导出 ' + SAVE_DIR + 'model/' + cname + '.as')
    f = open(SAVE_DIR + 'model/' + cname + '.as', 'w', -1, 'utf-8')
    s = 'package com.bellaxu.lib.model' + '\n'
    s +='{' + '\n'
    s +='\t' + '/**' + '\n' 
    s +='\t' + ' * ' + name + '数据模型' + '\n'
    s +='\t' + ' * @author BellaXu' + '\n' 
    s +='\t' + ' */' + '\n'
    s +='\t' + 'public class ' + cname + '\n'
    s +='\t' + '{' + '\n'
    ncols = sheet.ncols
    for colnum in range(0, ncols):
        col = sheet.col_values(colnum)
        if col:
            colName = col[0]
            colType = col[1]
            colDesc = col[2]
            if colName != '':
                s +='\t' + '\t' + '/**' + '\n'
                s +='\t' + '\t' + ' * ' + colDesc + '\n'
                s +='\t' + '\t' + ' */' + '\n'
                s +='\t' + '\t' + 'public var ' + colName + ':' + colType + ';' + '\n' 
                canAppend = True
                for attr in ATTR_LIST:
                    if attr[0] == colName:
                        canAppend = False
                        break
                if canAppend == True:
                    ATTR_LIST.append([colName, colDesc])
    s +='\t' + '\t' + '\n'
    s +='\t' + '\t' + 'public function ' + cname + '()' + '\n'
    s +='\t' + '\t' + '{' + '\n'
    s +='\t' + '\t' + '\t' + '\n'
    s +='\t' + '\t' + '}' + '\n'
    s +='\t' + '}' + '\n'
    s +='}'
    f.write(s)
    f.close()

def createLibName(libname, descs, ununique):
    print('导出 ' + SAVE_DIR + 'LibName' + '.as')
    f = open(SAVE_DIR + 'LibName' + '.as', 'w', -1, 'utf-8')
    s = 'package com.bellaxu.lib' + '\n'
    s +='{' + '\n'
    s +='\t' + '/**' + '\n' 
    s +='\t' + ' * ' + 'lib表名定义' + '\n'
    s +='\t' + ' * @author BellaXu' + '\n' 
    s +='\t' + ' */' + '\n'
    s +='\t' + 'public class ' + 'LibName' + '\n'
    s +='\t' + '{' + '\n'
    first = False
    for name in libname:
        s += '\t' + '\t' + '/**' + '\n'
        s += '\t' + '\t' + ' * ' + descs[name] + '\n'
        s += '\t' + '\t' + ' */' + '\n'
        s += '\t' + '\t' + 'public static const ' + name.upper() + ':String = ' + '\"' + name + '\";' + '\n'
    s += '\t' + '\t' + '/**' + '\n'
    s += '\t' + '\t' + ' * 没有主键的表' + '\n'
    s += '\t' + '\t' + ' */' + '\n'
    s +='\t' + '\t' + 'public static const UNUNIQUES:Array = ['
    ulen = len(ununique)
    for i in range(0, ulen):
        s += ununique[i]
        if i < ulen - 1:
            s +=', '
    s +='];' + '\n'
    s +='\t' + '}' + '\n'
    s +='}'
    f.write(s)
    f.close()

def createLibAtt():
    print('导出 ' + SAVE_DIR + 'LibAtt' + '.as')
    f = open(SAVE_DIR + 'LibAtt' + '.as', 'w', -1, 'utf-8')
    s = 'package com.bellaxu.lib' + '\n'
    s +='{' + '\n'
    s +='\t' + '/**' + '\n' 
    s +='\t' + ' * \"' + 'lib属性名定义' + '\"\n'
    s +='\t' + ' * @author BellaXu' + '\n' 
    s +='\t' + ' */' + '\n'
    s +='\t' + 'public class LibAtt' + '\n'
    s +='\t' + '{' + '\n'
    for attr in ATTR_LIST:
        s += '\t' + '\t' + '/**' + '\n'
        s += '\t' + '\t' + ' * ' + attr[1] + '\n'
        s += '\t' + '\t' + ' */' + '\n'
        s +='\t' + '\t' + 'public static const ' + attr[0] + ':String = \"' + attr[0] + '\";' + '\n'
    s +='\t' + '}' + '\n'
    s +='}'
    f.write(s)
    f.close()

def createLibs(b):
    print('导出 ' + OUTPUT_DIR + 'config.lib');
    f = open(OUTPUT_DIR + 'config.lib', 'wb')
    f.write(zlib.compress(b))
    f.flush()
    f.close()
    
def main():
    os.chdir(CONF_DIR)
    createASFiles()

if __name__ == "__main__":
    main()

    
