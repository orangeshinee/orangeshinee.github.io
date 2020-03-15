/*
 * @Date: 2019-09-26 18:31:31
 * @LastEditTime: 2019-09-26 18:44:41
 * @description: 欺骗效果，标题栏
 */
var OriginTitle = document.title;
var titleTime;
document.addEventListener('visibilitychange', function () {
  if (document.hidden) {
    $('[rel="icon"]').attr('href', "/img/TEP.ico");
    document.title = '╭(°A°`)╮ 页面崩溃啦 ~';
    clearTimeout(titleTime);
  }
  else {
    $('[rel="icon"]').attr('href', "/favicon.ico");
    document.title = '(ฅ>ω<*ฅ) 噫又好了~' + OriginTitle;
    titleTime = setTimeout(function () {
      document.title = OriginTitle;
    }, 2000);
  }
});