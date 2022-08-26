/*
 * @Date: 2019-09-26 18:31:31
 * @LastEditTime: 2019-09-26 18:44:41
 * @description: 欺骗效果，标题栏
 */

/* 离开当前页面时修改网页标题，回到当前页面时恢复原来标题 */
window.onload = function() {
  var OriginTitile = document.title;
  var titleTime;
  document.addEventListener('visibilitychange', function() {
    if(document.hidden) {
      $('[rel="icon"]').attr('href', "/images/fail.ico");
      $('[rel="shortcut icon"]').attr('href', "/images/fail.ico");
      document.title = '╭(°A°`)╮ 页面崩溃啦 ~';
      clearTimeout(titleTime);
    } else {
      $('[rel="icon"]').attr('href', "/images/sun_smile.ico");
      $('[rel="shortcut icon"]').attr('href', "/images/sun_smile.ico");
      document.title = '(ฅ>ω<*ฅ) 噫又好了~';
      titleTime = setTimeout(function() {
        document.title = OriginTitile;
      }, 2000);
	}
  });
}