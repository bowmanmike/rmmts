$(document).on('ready page:load page:change', function() {

  $(document).on('page:change', function() {
    $(document).on('keypress', function(e) {
      if ( $('.popup-form').hasClass('is-active') ) {
        if ( e.which == 13 && !e.shiftKey) {
          e.preventDefault();
          // alert("i was pressed");
          var form = document.getElementsByClassName('popup-form is-active')[0].children[0].getElementsByTagName('form')[0];
          form.submit();
        }
      }
    });
  });

});
