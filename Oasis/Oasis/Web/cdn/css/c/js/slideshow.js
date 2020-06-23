/**
* planetta slideshow
* version 1.01
* written by dorbens
* http://www.themeforest.net/user/dorbens
**/

$(function(){
    /* Collect info about the li's and stuff
    ==============================================*/
    var imgCount = $(".slideshow-wrapper li").length; // Get the number of the images
    var imgCurrent = 1;
    $('.slideshow-wrapper li').slice(1).hide(); // Hide all the li's but the first one

    /* slideshow function
    ==============================================*/
    function slideShow(){
        $('.slideshow-wrapper li').stop(true,true).hide();
        $('.slideshow-wrapper li:nth-child(' + imgCurrent + ')').stop(true,true).fadeTo(1000,1);
    }

    /* slideshow navigation
    ==============================================*/
    $('.slideshow-nav .next').click(function(){
        if (imgCurrent < imgCount) {
            imgCurrent ++;
            slideShow();
        } else {
            imgCurrent = 1;
            slideShow();
        }
    });
    $('.slideshow-nav .prev').click(function(){
         // don't accept under 1
         if (imgCurrent > 1) {
            imgCurrent --;
            slideShow();
        } else {
            imgCurrent = imgCount;
            slideShow();
        }
    });

    $(document).ready(function() {
        $('.slideshow-wrapper > li img,.slideshow-wrapper > li iframe').fadeIn('normal');
    });
});