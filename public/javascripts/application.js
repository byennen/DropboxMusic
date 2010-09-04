// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery(function ($) {
	$("#mainbox li").hover(
		function () {
			$(this).css('border', '1px solid darkgrey');
		},
		function () {
			$(this).css('border', '1px solid transparent');
		}
	);
});
