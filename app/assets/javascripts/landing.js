$(document).on('ready page:load', function() {

  $(document).on('click', '#more-info-button', function(e) {
    e.preventDefault();

    $('#info-div').addClass('animated slideInUp')
                  .css({
                    height: '30%',
                  });
  });

  $(document).on('click', '#close-info-div', function() {
    $('#info-div').css({
                    height: '0'
                });
  });

});
