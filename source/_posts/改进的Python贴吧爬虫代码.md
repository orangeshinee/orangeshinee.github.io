---
title: 改进的Python贴吧爬虫代码 
date: 2016-9-26 10:00:47
updated: 2017-4-26 10:40:47
copyright: true
categories:
- 代码
tags:
- Python
- 爬虫
---

之前在知乎上面看到许多用Python爬虫做的有趣项目，于是也去学习了一番（入门）。看到很多教程都有关于贴吧爬虫的小例子，于是自己也跟着做了一遍。

<!-- more -->

可能是教程时间有点早了，多数都是两三年前的，基本都是用正则表达式来提取关键信息，而且还专门写了一个类来处理各种HTML标签。正则表达式并不难学，但是要真正弄清除却很耗时间，尤其对于新手来说，读懂正则表达式是一件很头疼的事，写出正确的表达式更头疼。

后来学习了requests和beautiful soup两个库，那感觉，仿佛春风拂过泸沽湖,秋雨浸润九寨沟。怎一个**爽**字了得。

关于requests和beautiful soup两个库的教程网上有很多，我看的是[崔庆才的博客](http://cuiqingcai.com/1052.html),内容十分全面，里面的Python爬虫教程也十分适合入门学习。

在其原有的贴吧爬虫代码的基础上，我将提取内容的正则表达式全部替换成了用beautiful soup来获取网页标签内容。

简单来说，Beautiful Soup是python的一个库，最主要的功能是从网页抓取数据。官方解释如下：

> Beautiful Soup提供一些简单的、python式的函数用来处理导航、搜索、修改分析树等功能。它是一个工具箱，通过解析文档为用户提供需要抓取的数据，因为简单，所以不需要多少代码就可以写出一个完整的应用程序。
>
> Beautiful Soup自动将输入文档转换为Unicode编码，输出文档转换为utf-8编码。你不需要考虑编码方式，除非文档没有指定一个编码方式，这时，Beautiful Soup就不能自动识别编码方式了。然后，你仅仅需要说明一下原始编码方式就可以了。
>
> Beautiful Soup已成为和lxml、html6lib一样出色的python解释器，为用户灵活地提供不同的解析策略或强劲的速度。



上代码：

``` python
#-*- coding: UTF-8 -*-
#__author__shineee
#__time__2016.10__
#__Python27__


import requests
import re
from bs4 import BeautifulSoup
from itertools import chain
import string
import sys
reload(sys)
sys.setdefaultencoding('utf-8')


class Tieba:
	def __init__(self, baseUrl, seeLZ):
		# base链接地址
		self.baseURL = baseUrl
		# 是否只看楼主
		self.seeLZ = '?see_lz=' + str(seeLZ)
		# 全局file变量，文件写入操作对象
		self.file = None
		#默认的标题，如果没有成功获取到标题的话则会用这个标题
		self.defaultTitle = u"百度贴吧"

	def getPage(self, pageNum):
		try:
		# 构建URL
			url = self.baseURL + self.seeLZ + '&pn=' + str(pageNum)
			response = requests.get(url).text.encode('utf-8')
			# 返回UTF-8格式编码内容
			return response.replace('<br>', '\n')
		# 无法连接，报错
		except ValueError as e:
			if hasattr(e, "reason"):
				print u"连接百度贴吧失败,错误原因", e.reason
				return None

	# 获取帖子标题
	def getTitle(self, page):
		#新建soup对象
		soup = BeautifulSoup(page)
        #获取标题
		title = unicode(soup.h3.string)
		if title:
			# 如果存在，则返回标题
			# 若文件名中有/符号则替换掉 否则写入文件时会出错
			return title.replace('/', ' ')
		else:
			return None

	# 获取帖子一共有多少页
	def getPageNum(self, page):
		soup = BeautifulSoup(page)
        #利用soup的select规则找出帖子总页码数
		page = soup.select('li[style="margin-left:8px"]')
		for ii in page:
			nums = ii.get_text()
			break
		num = re.findall(r'[0-9]+(?=[^0-9]*$)', nums)
		result = ''.join(num)
		if result:
			return result
		else:
			return None

	def setFileTitle(self, title):
		# 如果标题不是为None，即成功获取到标题
		if title is not None:
			self.file = open(title + ".txt", "w+")
		else:
			self.file = open(self.defaultTitle + ".txt", "w+")

	# 获取每一层楼的内容,传入页面内容
	def getContent(self, page):
		# 匹配所有楼层的内容
		contents1 = []
		contents2 = []
		soup = BeautifulSoup(page)
        #获取帖子发布时间
		time = soup.select('div[class="post-tail-wrap"]')
		for ii in time:
			texts = ii.get_text('  ')
            #将无用信息去除掉
			texts2 = texts.rjust(80).replace(u'举报  |  侵权举报  有害信息举报  ', '')
			contents1.append(texts2 + '\n' + '\n' + '-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-')
		# 提取正文内容
		items = soup.select('cc')
		for iii in items:
			contents2.append(iii.get_text().encode('utf8').lstrip())
        #将两个list合并为一个list 重叠合并
		contents = list(chain.from_iterable(zip(contents2, contents1)))
		return contents

	# 向文件写入每一楼的信息
	def writeData(self, contents):
		for item in contents:
			self.file.write(item+'\n'+'\n'+'\n')

	def start(self):
		indexPage = self.getPage(1)
		pageNum = self.getPageNum(indexPage)
		title = self.getTitle(indexPage)
		self.setFileTitle(title)
		if pageNum == None:
			print "URL已失效，请重试"
			return
		try:
			print "该帖子共有" + str(pageNum) + "页"
			for i in range(1, int(pageNum) + 1):
				print "正在写入第" + str(i) + "页数据"
				page = self.getPage(i)
				contents = self.getContent(page)
				self.writeData(contents)
				# 出现写入异常
		except IOError, e:
			print "写入异常，原因" + e.message
		finally:
			print "写入任务完成"


print u"请输入帖子代号"
baseURL = 'http://tieba.baidu.com/p/' + str(raw_input(u'http://tieba.baidu.com/p/'))
seeLZ = raw_input(u"是否只获取楼主发言，是输入1，否输入0\n")
bdtb = Tieba(baseURL, seeLZ)
bdtb.start()

```



相比较正则表达式而言，soup更加清晰明了，也更便于操作。