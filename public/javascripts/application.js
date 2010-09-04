// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery(function ($) {
	// $("#mainbox li").hover(
	// 		function () {
	// 			$(this).css('opacity', '0.7');
	// 		},
	// 		function () {
	// 			$(this).css('opacity', '1');
	// 		}
	// 	);
	
	$(".addjam").click(function () {
		var $link = $(this);
		var dir = $link.attr('dir');
		$.post('/dropbox/jam', {'dir': dir}, function (data) {
			var $parent = $link.parent();
			$parent.removeClass('nojam');
			$parent.addClass('jam');
			$parent.html('<a href="/dropbox'+dir+'">'+dir+'</a>')
		});
		return false;
	});
});

var downloadFiles = function (path) {
	$.ajax({url: '/dropbox/'+path+'/download'});
}
