// JavaScript Document
jQuery(function ($) {
    var index = 0;
    $('<div id="czjimggo"></div>').appendTo("#czjimgnews");

    //滑动导航改变内容
    $("#czjimgnewsNav li").hover(function () {
        if (MyTime) {
            clearInterval(MyTime);
        }
        index = $("#czjimgnewsNav li").index(this);
        MyTime = setTimeout(function () {
            ShowjQueryFlash(index);
            $('#czjimgnewsContent').stop();
        }, 500);

    }, function () {
        clearInterval(MyTime);
        MyTime = setInterval(function () {
            ShowjQueryFlash(index);
            index++;
            if (index == 4) {
                index = 0;
            }
        }, 3000);
    });
    //滑入 停止动画，滑出开始动画.
    $('#czjimgnewsContent').hover(function () {
        if (MyTime) {
            clearInterval(MyTime);
        }
    }, function () {
        MyTime = setInterval(function () {
            ShowjQueryFlash(index);
            index++;
            if (index == 4) {
                index = 0;
            }
        }, 3000);
    });
    //自动播放
    var MyTime = setInterval(function () {
        ShowjQueryFlash(index);
        index++;
        if (index == 4) {
            index = 0;
        }
    }, 3000);
});
function ShowjQueryFlash(i) {
    $("#czjimgnewsContent div").eq(i).animate({opacity: 1}, 1000).css({"z-index": "1"}).siblings().animate({opacity: 0}, 1000).css({"z-index": "0"});
    $("#czjimggo").animate({ left: i * 66 + 5 + "px"}, 300); //滑块滑动
    $("#czjimgnewsNav li").eq(i).addClass("current").siblings().removeClass("current");
}