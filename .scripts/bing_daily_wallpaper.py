#!/usr/bin/env python2
# -*- coding: utf-8 -*-

import os
import json
import time
import datetime
import urllib2

# market: en-US zh-CN ja-JP en-AU en-UK de-DE en-NZ

class BingDailyWallpaper(object):
    url = 'http://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=zh-CN'
    resolution = '1920x1080'
    today = datetime.datetime.now().strftime("%Y,%m,%d").split(',')

    wallpaper_dir = os.path.join(
        os.path.expanduser("~"),
        'Pictures/Bing_Daily_Pic',
        today[0],
        today[1])

    wallpaper = os.path.join(
        wallpaper_dir,
        today[2] + '.jpeg')

    wallpaper_info = os.path.join(
        wallpaper_dir,
        today[2] + '.info')


    @classmethod
    def _check_network(cls):
        retry = 0
        max_tries = 2
        success = False
        check_url = "http://www.baidu.com"
    
        while retry < max_tries and not success:
            try:
                urllib2.urlopen(check_url, timeout=2)
                print ("Network check ok")
                success = True
            except urllib2.URLError, e:
                print ("Network check error, sleep 2 seconds")
                time.sleep(2)
    
            retry += 1
    
        return success


    @classmethod
    def _save_wallpaper(cls):
        print ("Downloading Bing wallpaper to %s" % (cls.wallpaper)) 
        try:
            resp = json.load(urllib2.urlopen(cls.url))
            urlbase = resp['images'][0]['urlbase']
            copyright = resp['images'][0]['copyright']
            url = 'http://www.bing.com' + urlbase + '_' + cls.resolution + '.jpg'
            bingpic = urllib2.urlopen(url)
            with open(cls.wallpaper, 'w') as pic, open (cls.wallpaper_info, 'wb') as info:
                pic.write(bingpic.read())
                info.write(copyright.encode('UTF-8'))
        except:
            raise
    
    
    @classmethod
    def _setup_wallpaper(cls):
        cmd = 'feh --bg-fill ' + cls.wallpaper
        print ("setup wallpaper")
        os.system(cmd)


    @classmethod
    def setup(cls):
        try:
            if not os.path.exists(cls.wallpaper_dir):  
                os.makedirs(cls.wallpaper_dir)
                                                       
            if not os.path.exists(cls.wallpaper): 
                cls._check_network()   
                cls._save_wallpaper()
            cls._setup_wallpaper()
        except:
            raise
        

if __name__ == '__main__':
    BingDailyWallpaper().setup()
