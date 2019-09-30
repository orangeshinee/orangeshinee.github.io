---
title: python爬取网站图片
categories: 代码
tags:
  - python
  - 爬虫
abbrlink: 10762
date: 2016-11-10 10:00:47
updated: 2017-04-23 09:23:24
---



> 爬虫小练习。看妹子 ( ͡° ͜ʖ ͡°)

<!---more--->

### 主要步骤：

1. 获取网页地址，找到图片地址所在标签

2. 用beautifulsoup解析出图片实际地址以及图片标题

3. 分析网页页面逻辑，找出最终页码

4. 写入循环，在每页将图片写入到本地

### 主要代码

```python3
start_html = requests.get(baseUrl, headers= headers)
content = start_html.content
```
这里用.content是为了避免网页编码和python编码不同而导致中文乱码问题，各个网站的编码都不一样，有些事utf-8,有些事GBK，还有其他的。这里可以避免编码影响。

按F12，检查图片地址所在标签，见下图
![图片地址](https://picsshine.oss-cn-shenzhen.aliyuncs.com/blogpics/blog-20170610-页码.png)
右键->copy selecter，可以看到，图片所在标签为 

```
div > div.ui-main > div:nth-child(9) > div.mala-text
```
所以在beautifulsoup中图片地址选择可以写成
```python
img_url = img_soup.find('div', class_='ui-main').find_all('img')
```
可以找出此页面所有img标签。同理可以找到图片标题。但是此处找到的是所在标签，打印出来的是
```
<img alt="美女" src="http://wx4.sinaimg.cn/mw600/680f28e6gy1ffi9650prlj20dw0iidj6.jpg" style="width: 350px; height: 466px;">

<a href="/miss/7159.html">美女</a>
```
所以声明一个新的变量来提取图片地址，同理得到标题
```python
imgs = img_url['src'] #图片地址
name = titles.tet_text()
```
最后，找到页码标签，
![页码](https://picsshine.oss-cn-shenzhen.aliyuncs.com/blogpics/blog-20170610-图片地址.png)
可以看到末页标签是在page类下的最后一个，所以我们可以用

```python
maxPages = soup.find('div',class_='page').find_all('a')[-1]['href']
maxpage0 = re.findall('\d+',maxPages)
#最大页面值
maxpage = maxpage0[0] #最终页码 值类型为int
```
soup找到的结果为一个数组，所以我们还要处理一下得到一个数字。

最后，图片的写入以及文件夹的创建。因为每一页都有八张图（最后一页不一定，因此页面循环时不要循环到最后一页），所以每一页循环八次获取图片。
```python
    path = str(page)
    #如果文件夹已经存在，再次创建会出错，所以这里用了一个if循环
    if os.path.exists('D:\meizitu\\'+path):
        print('文件夹已存在')
    else:
        os.makedirs(os.path.join("D:\meizitu",path)) #创建文件夹
    os.chdir("D:\meizitu\\"+path)
    for i in range(0,8):
        name = titles[i].get_text()  #图片标题
        imgs = img_url[i]['src']
        img = requests.get(imgs,headers=headers)
        #因为图片类型主要是JPG和GIF两种，所以这里也写一个if选择
        if imgs[-3:] == "gif":
            f = open(name+'.gif','ab')
            f.write(img.content)
            f.close()
        else:
            f = open(name + '.jpg', 'ab')
            f.write(img.content)
            f.close()
```

最终代码如下：
```python
# -*- coding:utf-8 -*-
# _author_:shineee

import requests
from bs4 import BeautifulSoup
import os
import re

headers = {'User-Agent':"Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/22.0.1207.1 Safari/537.1"}
##浏览器请求头（大部分网站没有这个请求头会报错、请务必加上）
baseUrl = 'http://www.qiubaichengren.com'
start_html = requests.get(baseUrl, headers= headers)
##将原网页内容提取出来。避免编码不同造成中文乱码
content = start_html.content
##声明soup变量，然后找出图片地址
soup = BeautifulSoup(content, 'lxml')
#末页
maxPages = soup.find('div',class_='page').find_all('a')[-1]['href']
maxpage0 = re.findall('\d+',maxPages)
#最大页面值
maxpage = maxpage0[0] #因为正则表达式出来的是数组，所以这里提取数组中的第一个数，也是唯一一个

for page in range(1,5):#这里5可以改成maxpage，但是太多了- -八百多页呢，喜欢的话自己可以慢慢等。。
    page_url = baseUrl + '/' + str(page) + '.html'
    img_html = requests.get(page_url,headers= headers)
    img_soup = BeautifulSoup(img_html.content,'lxml')
    img_url = img_soup.find('div', class_='ui-main').find_all('img')
    titles = img_soup.select('div[class="mtitle"]')  ##获取图片标题
    path = str(page)
    if os.path.exists('D:\meizitu\\'+path):
        print('文件夹已存在')
    else:
        os.makedirs(os.path.join("D:\meizitu",path)) #创建文件夹
    os.chdir("D:\meizitu\\"+path)
    for i in range(0,8):
        name = titles[i].get_text()  #图片标题
        imgs = img_url[i]['src']
        img = requests.get(imgs,headers=headers)
        if imgs[-3:] == "gif":
            f = open(name+'.gif','ab')
            f.write(img.content)
            f.close()
        else:
            f = open(name + '.jpg', 'ab')
            f.write(img.content)
            f.close()
    print('第'+str(page) +'页写入完成')
print('写入完毕。')
```