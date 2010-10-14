$(document).ready(function() {
  $('#request').click(function() {
    
    $.fancybox({
          'width': '50%',
          'height': '50%',
          'hideOnOverlayClick': false,
          'autoScale': true,
          'transitionIn': 'elastic',
          'transitionOut': 'elastic',
          'type': 'iframe',
          'content': '/invite'
      });
  });

});