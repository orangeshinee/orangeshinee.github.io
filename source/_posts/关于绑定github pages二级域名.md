---
title: 关于绑定github pages二级域名
date: 2016-10-10 10:00:47
categories:
- 代码
tags: 
- Github 
- Hexo
---



最近在用Hexo配置好博客的[主页面](http://blog.shineee.win)后，又想来倒持一下来弄个好看的真·主页。后来在各个Hexo的主题下面，看到了[@iissnan](https://github.com/iissnan)的[主页](http://iissnan.com/)。很好看，就去clone下来了，稍微稍微加工了一下。

<!---more--->

因为github.io绑定的域名是blog.shineee.win。所以新建了一个repo然后在主页面新建CNAME指向真主页域名shineee.win就可以了。

在dnspod解析里面，加上一个blog的指向github.io就ok。

但是在实际操作中有点小问题。project shineee是ph-pages，但是却无法定位，后来改成master之后才正常，尚不清楚原因，，以后有机会继续好好研究。。