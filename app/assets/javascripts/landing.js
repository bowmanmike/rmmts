$(document).on('ready page:load', function() {

  $(document).on('click', '#more-info-button', function(e) {
    e.preventDefault();

    $('#info-div').css({
      height: '30%',
      width: '100%' 
    });
  });

});
