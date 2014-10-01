# -*- coding:utf-8 -*-

import os
import os.path
import fnmatch
import shutil
import urllib.request
import sys

#测试外网地址
#url = 'http://203.195.136.208:8083/GameRes/'
#朋友网地址
url = 'http://jzzy.xhgame.com/szww0725/GameRes/'

if len(sys.argv) > 1:
    url = sys.argv[1]


loc_url = 'D:/BellaXu/client/bin-debug/res/'
out_url = os.path.curdir + os.path.sep + 'upload/'

tname = 'version.txt'

def getServerData():
    d = urllib.request.urlopen(url + tname).read().decode('utf-8')
    r = d.split('\n')
    dic = {}
    for r1 in r:
        r2 = r1.split(' ')
        if len(r2) < 3:
            pass
        else:
            path = r2[0]
            md5 = r2[1]
            ver = r2[2]
            dic[path] = {'md5': md5, 'ver': ver}
    return dic

def getLocalData():
    f = open(loc_url + tname, 'r')
    r = f.read().split('\n')
    dic = {}
    for r1 in r:
        r2 = r1.split(' ')
        if len(r2) < 3:
            pass
        else:
            path = r2[0]
            md5 = r2[1]
            ver = r2[2]
            dic[path] = {'md5': md5, 'ver': ver}
    return dic

def main():
    dic_1 = getServerData()
    dic_2 = getLocalData()
    
    if not os.path.isdir(out_url):
        os.makedirs(out_url)

    for root, dirs, files in os.walk(out_url, topdown=False):
        for name in files:
            os.remove(os.path.join(root, name))
        for name in dirs:
            os.rmdir(os.path.join(root, name))
    
    for r in dic_2:
        if dic_1.get(r) is None or int(dic_1[r]['ver']) != int(dic_2[r]['ver']):
            print('add upload item: ' + r + ', ver=' + dic_2[r]['ver'])
            r1 = r.split('/')
            ff = os.path.sep
            fn = ''
            for r2 in r1:
                if fnmatch.fnmatch(r2, '*.*'):
                    fn = r2
                    pass
                else:
                    ff += r2 + os.path.sep
            if not os.path.isdir(out_url + ff):
                os.makedirs(out_url + ff)

            if os.path.exists(loc_url + r):
                shutil.copyfile(loc_url + r, out_url + r)

    print('add upload item: ' + 'version.ver')
    shutil.copyfile(loc_url + 'version.ver', out_url + 'version.ver')

    print('add upload item: ' + 'version.txt')
    shutil.copyfile(loc_url + 'version.txt', out_url + 'version.txt')

    print('add upload item: ' + 'version.js')
    shutil.copyfile(loc_url + 'version.js', out_url + 'version.js')

if __name__ == "__main__":
    main()

    
