---
title: Hexo添加自定义相册
categories:
  - 博客
tags:
  - Next
  - Hexo
  - HTML/CSS
date: 2018-09-16 13:00:47
updated: 2019-9-26 15:50:47
---

不想拥有相册的blog不是好网站（

关于next主题下的相册搭建网上教程挺多的，但是很多都是那种瀑布流式，emmmmm.....

不符合我审美，我还是喜欢QQ空间式的（逃－

Google第一篇出来的是[css+markdown 实现 hexo 相册【进阶篇】](https://co5.me/2018/181112-gallerry2.html)讲真的挺好看的，可能因为人家是自己画的 -- 

大体内容跟大佬的差不多，不过她用的是加载服务器上的图片，而我用的是图床。同时利用next已经整合的fancy box，达到点击图片放大查看的效果，而不是跳转到图片原页面。

<!---more--->

## 布局

```html
- 相册页面
	- 相册封面
		- 相册内容
```



### 步骤

步骤的话与上述教程基本一致,只是修改了部分css样式,同时,因为要使得相册页面下的图片调用fancybox,需要修改`\next\source\js\utils.js`的部分代码

```js
// 如果是相册页面下的图片 启用fancybox
    if ($image.is('.img-row img')){
        $imageGalleryLink.addClass('post-gallery-img');
        $imageGalleryLink.attr('data-fancybox', 'gallery').attr('rel', 'gallery');
    }
```



### 修改缩略图

因为fancybox会自动生成缩略图,但实际上缩略图的src还是原图,所以加载的时候比较慢,这样也会造成资源浪费.所以还是在`\next\source\js\utils.js`中修改了下下,将缩略图地址转换为原图;

```js
wrapImageWithFancyBox: function() {
    document.querySelectorAll('.post-body :not(a) > img, .post-body > img, .gallery-page > img').forEach(element => {
      var $image = $(element);
      var imageLink = $image.attr('data-src') || $image.attr('src');
      var $imageWrapLink = $image.wrap(`<a class="fancybox fancybox.image" href="${imageLink}" itemscope itemtype="http://schema.org/ImageObject" itemprop="url"></a>`).parent('a');
      // 将缩略图src换成原图src
      var $imageGalleryLink = $image.wrap(`<a class="fancybox fancybox.image" href="${imageLink.replace(".th.",".")}" itemscope itemtype="http://schema.org/ImageObject" itemprop="url"></a>`).parent('a');
      if ($image.is('.post-gallery img')) {
        $imageWrapLink.addClass('post-gallery-img');
        $imageWrapLink.attr('data-fancybox', 'gallery').attr('rel', 'gallery');
      } else if ($image.is('.group-picture img')) {
        $imageWrapLink.attr('data-fancybox', 'group').attr('rel', 'group');
      } else {
        $imageWrapLink.attr('data-fancybox', 'default').attr('rel', 'default');
      }

      // 如果是相册页面下的图片 启用fancybox
      if ($image.is('.img-row img')){
        $imageGalleryLink.addClass('post-gallery-img');
        $imageGalleryLink.attr('data-fancybox', 'gallery').attr('rel', 'gallery');
      }
```

这里并不适用所有,因为我的图床是通过Chevereto自建的,在上传图片之后,会给你多个图片格式的链接,包括缩略图\中等图以及原图,他们的格式是酱紫的:

```
原图: xxx.jpg
中等: xxx.md.jpg
缩略图: xxx.th.jpg
```

所以,只要在相册内容页面的图片地址填入缩略图,然后utils.js中会将`th.`去掉,变成原图地址,这样点开之后就是原图了.

[路过图床](https://imgchr.com/)也可以提供这种多格式链接,同时免费注册用户可以无限传图,对于小用户来说很棒啦,完全够用.



### 页面布局

页面布局采用flex,这里有一篇详细介绍的

- https://zhuanlan.zhihu.com/p/25303493

简单来说,flex布局会让你的div按照你的需求,从左到右从上到下依次排列,同时还可以按照指定方式进行对齐;

```css
/*gallery*/
.gallery-page {
	margin-top: -50px;
}
.gallery-column,
.img-row {
	display: flex;
	flex-direction: row ;
    flex-wrap: wrap;
    justify-content: space-between;
}
.img-row a,
.gallery-column a {
	border-bottom: 0px;
}
.gallery-item {
	margin-bottom: -50px
}
.gallery-item p {
	margin: -25px auto -10px;
	max-width: 50%;
	text-align: center;
	font-size: 15px;
	color: $black-deep;
	background: rgba(255,255,255,.3);
	border-radius: 7px;
	border: 1px solid $black-deep;
	box-shadow: 0 8px 20px -8px rgba(0,0,0,.3);
}
.posts-expand .post-body .gallery-column a img {
	height: 250px;
	width: 300px;
	object-fit: cover;
}
.posts-expand .post-body img {
    max-width: 180px;
}
@media (max-width: 767px){
	.gallery-item p {
		min-width: 75px;
		font-size: 13px;
	}
    .posts-expand .post-body img {
    max-width: 150px;
}
```



### 另外

如果嫌麻烦的话,图片直接放博客静态文件就好了,github暂时速度还是可以的,也不用担心流量问题;

记录的很简陋,因为只要自己能看懂 - - ,到时候动手修改还能记起来改哪里- -

具体的还是请参考:

[css+markdown 实现 hexo 相册【进阶篇】](https://co5.me/2018/181112-gallerry2.html)

