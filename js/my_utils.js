/* Custome js */

window.onload = function () {
    // 将相册下的点开大图链接更新
    // 去除.th.就是原图
    var gallery = document.querySelector("div.gallery-page")
    if (gallery !== null) {
        var a_links = gallery.querySelectorAll("a")
        for (let index = 0; index < a_links.length; index++) {
            var img_link = a_links[index].href;
            const globalRegex = new RegExp('\\/(\w+).th.(jpg|png|gif|jpeg)', 'g');
            const ossRegex = new RegExp('\\?x-oss-process(.*)', 'g')
            if (globalRegex.test(img_link)) {
                img_link = img_link.replace(".th.", ".")
            } else if (img_link.startsWith('https://picsshine.oss-cn-shenzhen.aliyuncs.com/images/')) {
                img_link = img_link.replace(ossRegex, '')
            }
            a_links[index].href = img_link
        }
    }
}