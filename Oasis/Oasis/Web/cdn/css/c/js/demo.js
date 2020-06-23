/* add a demo comment
===============================*/	
function demo_add_comment(btn){
	if ($(btn).is('.disabled'))
		return false;
	$(btn).addClass('disabled').html('Submiting ..');
	/************************************************

	-----> here you should add your ajax code <------

	*************************************************/
	var $form_fullname = $('#form-fullname').val();
	var $form_email = $('#form-email').val();
	var $form_website = $('#form-fullname').val();
	var $the_date = getTimestamp();
	var $form_comment = $('#form-comment').val() + '\n<i>This is a demo comment</i>';

	$('#comments > ul').append('<li class="comment"><div class="comment-body"><div class="author"><div class="avatar"><img src="media/other/dorbens-avatar.png" alt="" /></div></div><div class="comment-two"><div class="comment-info"><span class="details"><p><a href="' + $form_email + '">' + $form_fullname + '</a>' + $the_date + '</p></span><span class="options"><a href="#addComment" class="btn btn-mini">Reply</a>&nbsp;&nbsp;<a href="#" class="btn btn-mini">Edit</a></span><div class="clearfix"></div></div><p class="the-comment">' + $form_comment.replace(/\n\r?/g, '<br />') + '</p></div><div class="clearfix"></div></div></li><!--li.comment-->').fadeIn('slow');
	$('#comments > ul li:last-child').hide().delay(600).fadeIn(1200,function(){
		$(btn).removeClass('disabled').html('Publish');
	});
}


/* get english month name (short)
===============================*/	
function getTimestamp() {
	var currentTime = new Date()
	var hours = currentTime.getHours()
	var minutes = currentTime.getMinutes()
	var monthNames = [ "Jan", "Feb", "March", "April", "May", "June", "July", "Aug", "Sep", "Oct", "Nov", "Dec" ];
	if (minutes < 10)
		minutes = "0" + minutes
	var suffix = "AM";
	if (hours >= 12) {
		suffix = "PM";
		hours = hours - 12;
	}
	if (hours == 0)
		hours = 12;
	return currentTime.getDate() + 'th ' + monthNames[currentTime.getMonth()] + ', ' + currentTime.getFullYear() + ' at ' + hours + ':' + minutes + ' ' + suffix;
}