$(document).on('ready page:load page:change', function() {

  $(document).on('page:change', function() {

    $(document).on('keypress', function(e) {
      if ( $('.popup-form').hasClass('is-active') ) {

        if ( e.which == 13 && !e.shiftKey) {
          e.preventDefault();
          var form = $('.is-active').find('form');
          form.find(':submit').get(0).click();
        }
      }
    });

  });

});
