---
title: Hexo网站主题美化记录
categories:
  - 博客
tags:
  - Next
  - Hexo
  - HTML/CSS
abbrlink: hexo-next-customization
date: 2018-09-15 13:00:47
---

Next一直是Hexo最热门的主题,本站采用了Next的Pisces主题,然后根据其他大佬的美化教程进行适当修改,记录一下.
虽然不是前端,但是对前端一直有兴趣,相比后端,前端作品完成后给人的成就感来的更直接,看到写出来的东西可以立即展现确实是一直道不出的乐趣.
网站纯粹因为兴趣,我是个喜欢小细节让自己满意的人,只要认定了的就必须改,所以经常会因为一丢丢小地方达不到自己想要的而`废寝忘食`,没办法前端页面懂得不多,每次看一点忘一点.也不是没有收获~

<!---more--->

## 网站主页面
[主页面](https://shineee.win)是看到了 [@iissnan](https://github.com/iissnan) 的[主页](http://iissnan.com/)。clone一下,稍稍加了个头像和背景.

还有一个我很喜欢的是[@zchen9](https://github.com/zchen9)的[主页](https://www.chen9.info/),可惜功力不够无法~~复刻~~（copy）



## 博客首页

### 修改页面大小

Pisces主题的页面比较大,稍微小一点比较有紧凑感,更改了页面宽度,使得侧栏和主页面居中：

```css
.header {
    width: 960px
}

.container .main-inner {
    width: 960px;
    margin: 0 auto;
}
```

### 侧栏网站logo

本来是title和subtitle,不好看,单改字体又没那种感觉,就自己ps了一个logo,然后在`\next\layout\_partials\header\brand.swig`中修改了一下,将title换成了图片:

```html
<div>
    <a href="{{ config.root }}" class="brand" rel="start">
        <span class="logo-line-before"><i></i></span>
        <span class="site-title"><img src="img.png"></span>
        <span class="logo-line-after"><i></i></span>
    </a>
</div>
```

同时加了一个鼠标移动效果:

```css
.site-meta:hover {
  background: rgba(0,0,0,0.9);
  border-radius: 0 0 70px 70px;
  box-shadow: 0 8px 20px -3px rgba(0,0,0,0.6);
}
.site-meta {
    background: rgba(0,0,0,0.8);
    border-radius: 0 0 0 0;
    box-shadow: 0 2px 15px 0 rgba(0,0,0,0.6);
    transition: all 0.2s linear;
}
```



### 自定义图标

图标来自[阿里巴巴图标库](https://www.iconfont.cn/),真的是好用的一皮.选择心仪的图标加入到你的项目中,然后就可以直接调用了.这里采用的是`symbol引用`

> 这是一种全新的使用方式，应该说这才是未来的主流，也是平台目前推荐的用法。相关介绍可以参考这篇[文章](https://www.iconfont.cn/help/detail?spm=a313x.7781069.1998910419.d8cf4382a&helptype=code) 这种用法其实是做了一个svg的集合，与上面两种相比具有如下特点：
>
> - 支持多色图标了，不再受单色限制。
> - 通过一些技巧，支持像字体那样，通过`font-size`,`color`来调整样式。
> - 兼容性较差，支持 ie9+,及现代浏览器。
> - 浏览器渲染svg的性能一般，还不如png。

主要是因为它是彩色的,好看……o((≧▽≦o) ～

1. 在图标库选择好你的图标后，选择Symbol，复制css链接，加入到`blog/source/data/head.swig`中

2. 在styles.styl中加入.icon样式

   ```css
   .icon {
       width: 20px; height: 20px;
       vertical-align: -4.5px;
       fill: currentColor;
       overflow: hidden;
   }
   ```
   
3. 在`\next\layout\_partials\header\menu-item.swig`中修改,将图标格式修改为svg

   ```css
   {%- set menuText = __('menu.' + name) | replace('menu.', '') %}
   {%- if theme.menu_settings.icons %}
   	{%- set menuIcon = '<svg class="icon aria-hidden="true"><use xlink:href="#' + value.split('||')[1] | trim | default('icon-zhizhuxia') + '"></use></svg><br>' %}
   {%- endif %}
   ```

   这里参看阿里巴巴图标库的[使用教程](https://www.iconfont.cn/help/detail?spm=a313x.7781069.1998910419.d8cf4382a&helptype=code)

   最后，在`next\_config.yml`中将图标名称改成阿里图标库中的名称就可以了

   ```xml
   social:
     GitHub: https://github.com/xxx || icon-github-footer
   ```

侧栏中社交链接图标也是如此

### 归档页面显示十二生肖
参考大佬的[配置](guanqr.com/tech/website/hexo-theme-next-customization/)，然后在自己修改一下css就ok。


### 其他细节

类似标签、背景动画、评论以及next主题自带原有的功能不再赘述，Google一下大把，最重要的还是要自己喜欢，同时能够在学习大佬的过程中不断提升自己。





## 参考大佬

以下是在博客搭建和美化过程中搜到的大佬们，网站很棒内容很干，希望有一天也能成为~~大佬中的一员~~(不，你不想.jpg)

[@co5=Shioko](https://co5.me/)

[@神代綺凜](https://moe.best/cross.html) 这个博客是基于Typecho的，但是很多东西还是可以借鉴的嘛～

[@荷戟独彷徨](https://www.guanqr.com/)  但是大佬已经转成[Hugo](https://github.com/gohugoio/hugo)了 - -





长路漫漫，希望可以走的远一点。

多写，多搜，多思考。