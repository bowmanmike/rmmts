$(document).on('ready page:load page:change', function() {

  $(document).on('page:change', function() {
    $(document).on('keypress', function(e) {
      if ( $('.popup-form').hasClass('is-active') ) {
        var form = $('.is-active').find('form');
        if ( e.which == 13 && !e.shiftKey) {
          e.preventDefault();

          $.ajax({
            url: form.attr('action'),
            method: form.attr('method'),
            dataType: 'script',
            data: form.serialize(),
            success: function() {
              $('.popup-form').add('#overlay').add('.popup').removeClass('is-active');
              if (form.attr('action').search('sessions') >= 0) {
                location.reload();
              }
            }
          });
        }
      }
    });
  });

});
