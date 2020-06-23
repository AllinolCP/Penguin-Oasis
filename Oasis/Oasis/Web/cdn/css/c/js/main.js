/***************************************************
Theme Name: planetta
Author: dorbens
Author URI: http://www.themeforest.net/user/dorbens
Version: 1.0

	File hierarchy:
	1) 	document.ready
	2) 	window.load
	3)	functions

***************************************************/

/* 1) document ready
---------------------------------------------------------------------------------------------------------------------------------------*/
$(document).ready(function() {

	//$('#slider .slider-wrapper').hide().delay(500).slideDown(500);




	/* check cookie for infobar
	=================================================================================*/	
	if ($.cookie('infobar') == "1") {
		if ($('#infobar').css("display") == "block"){
			$('#infobar').css('top','0');
			$('#header').css('paddingTop','39px');
		}			 
	}




	/* Item hover effect in projects page
	=================================================================================*/
	$('#content .projectsList .item').hover(function(){
		$('.project-item-preview .caption',this).stop(true,true).fadeIn(350).parent().find('.caption-enter').stop(true,true).fadeIn(450).animate({'top':'38%'},{duration:1600, queue: false, easing:'easeOutElastic'});
		$('.project-item-preview .caption-enter span',this).stop(true,true).animate({backgroundPosition:"0px 46px"},{duration:400});
	},function(){
		$('.project-item-preview .caption',this).fadeOut(650).parent().find('.caption-enter').stop(true,true).fadeOut(450).stop(true,true).animate({'top':'15px'},{duration:1000, queue: false, easing:'easeOutElastic'});
		$('.project-item-preview .caption-enter span',this).stop(true,true).animate({backgroundPosition:"0px -46px"},{duration:600});
	});




	/* flexslider settings
	=================================================================================*/
	$('.main-slider').flexslider({
		animation:          "fade",
		easing:             'easeInOutExpo',
		directionNav:       false,
		controlNav:       	true,
		smoothHeight:       true,
		touch:  			true, 
		video: 				true,
		animationSpeed:     750,
		keyboard: 			false,
		pauseOnAction: 		false,
		pauseOnHover: 		true,
		slideshowSpeed:     35000,
		start:function(){
			var myDiv1Para = $('.main-slider .flex-control-nav').remove();
			myDiv1Para.appendTo('#slider .slider-wrapper');
			$('#slider .slider-wrapper .flex-control-nav').fadeIn();
		}
	});
	$("#slider #slider-nav .slider-nav-next").click(function(){
		$('.main-slider').flexslider("next");
		$('.main-slider').flexslider("play");
	});
	$("#slider #slider-nav .slider-nav-prev").click(function(){
		$('.main-slider').flexslider("prev");
		$('.main-slider').flexslider("play");
	});
	$("#slider #slider-nav").css('visibility','visible').fadeTo(0,0);

	if ($('#slider .slider-warpper').css("display") != "none"){ // avoid showing the buttons in mobile 
		$("#slider").mouseover(function(){
			$("#slider #slider-nav").stop().fadeTo(750,1);
		}).mouseout(function(){
			$("#slider #slider-nav").stop().fadeTo(550,0);
		});
	}




	/* Back to top settings
	=================================================================================*/
	(function() {
		var settings = {
			button      : '#back-to-top',
			text        : '',
			min         : 200,
			fadeIn      : 500,
			fadeOut     : 300,
			scrollSpeed : 900,
			easingType  : 'easeInOutExpo'
		},
		oldiOS     = false,
		oldAndroid = false;
		if( /(iPhone|iPod|iPad)\sOS\s[0-4][_\d]+/i.test(navigator.userAgent) )
			oldiOS = true;
		if( /Android\s+([0-2][\.\d]+)/i.test(navigator.userAgent) )
			oldAndroid = true;
		$('body').append('<a href="#" id="' + settings.button.substring(1) + '" title="' + settings.text + '">' + settings.text + '</a>');
		$( settings.button ).click(function( e ){
			$('html, body').animate({ scrollTop : 0 }, settings.scrollSpeed, settings.easingType );
			e.preventDefault();
		});
		$(window).scroll(function() {
			var position = $(window).scrollTop();
			if( oldiOS || oldAndroid ) {
				$( settings.button ).css({
					'position' : 'absolute',
					'top'      : position + $(window).height()
				});
			}
			if ( position > settings.min ) 
				$( settings.button ).fadeIn( settings.fadeIn );
			else 
				$( settings.button ).fadeOut( settings.fadeOut );
		});
	})();



	
	/* hover effects for posts/projects at home
	=================================================================================*/
	$(".latest-projects .project,.latest-posts .post").hover(
		function(){$('.caption',this).stop(true,true).fadeIn(); },
		function(){$('.caption',this).stop(true,true).fadeOut(); }
	);

	/* Menu to select for small devices
	=================================================================================*/
	var $select = $('<select>')
        .appendTo('#mobile-menu');
    $('#menu li').each(function() {
        var $li    = $(this),
            $a     = $li.find('> a'),
            $p     = $li.parents('li'),
            prefix = new Array($p.length + 1).join(" - ");

        var $option = $('<option>')
            .text(prefix + ' ' + $a.text())
            .val($a.attr('href'))                       
            .appendTo($select);

        if ($li.hasClass('current')) {
            $option.attr('selected', 'selected');
        }
    });

	$("#mobile-menu").change(function() {
		window.location = $(this).find("option:selected").val();
	});



});








/* 2) window.load
---------------------------------------------------------------------------------------------------------------------------------------*/
$(window).load(function() {




	/* duplicate controlNav
	=================================================================================*/
	$('#slider .flex-control-nav li').click(function(){
		$('.main-slider').flexslider(parseInt($('a',this).html())-1);
	});

});








/* 3) functions
---------------------------------------------------------------------------------------------------------------------------------------*/




/* Infobar
=================================================================================*/	
$('#infobar .toggle').click(function(){
	if ($.cookie('infobar') == "1")	{
		$('#infobar').animate({'top':'-39px'},{duration: 400, easing: 'easeInOutExpo'});
		$('#header').animate({'paddingTop':'-39px'},{duration: 400, easing: 'easeInOutExpo'});
		$.cookie('infobar', null);
	} else {
		$('#infobar').animate({'top':'0'},{duration: 600, easing: 'easeInOutExpo'});
		$('#header').animate({'paddingTop':'39px'},{duration: 600, easing: 'easeInOutExpo'});
		$.cookie('infobar', "1");
	}
});




/* load bootstrap components
=================================================================================*/	
$(function(){
	$("[rel^='tooltip']").tooltip();
	$(".toggler").collapse('hide');
	$('button').addClass('btn');		//all <button>'s will have .btn class
});




/* Detect contact-Form
=================================================================================*/	
$('#contactForm').bind('submit', function (e) {
	if ($('#contact-form button[type="submit"]').is('.disabled'))
		return false;
  var data = {};
	$(this).find('input, textarea, select').each(function(i, field) {
		$(this).removeClass('input-error'),
	    data[field.name] = field.value;
	    if (field.value == null || field.value == "") {
	    	$(this).addClass('input-error');
	    	$(this).focus();
	    	$('#contact-form button[type="submit"]').removeClass('disabled').html('Submit');
  			e.preventDefault();	
  			return false;	
	    }
	});
	/************************************************

	-----> here you should add your ajax code <------

	*************************************************/
	e.preventDefault();
});


