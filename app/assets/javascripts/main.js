$(document).on('ready page:load', function() {

  $(document).on('click', '#login-link', function(e) {
    e.preventDefault();
    showPopUp();
  });

  $(document).on('click', '#signup-link', function(e) {
    e.preventDefault();
    showPopUp();
  });

  $(document).on('click', '.edit-mate-link', function(e) {
    e.preventDefault();
    showPopUp();
  });

  $(document).on('click', '.point-total > a', function(e) {
    e.preventDefault();
    showPopUp();
  });

  $('#overlay').on('click', function() {
    hidePopUp();
  });

  $('.popup-form').on('submit', function() {
    hidePopUp();
  });
});

var showPopUp = function() {
  $('#overlay').addClass('is-active');
  $('.popup').addClass('is-active');
  $('.popup-form').addClass('is-active');
  $('body').addClass('noscroll');

  $('.close-popup-link').on('click', function() {
    hidePopUp();
  })
}

var hidePopUp = function() {
  $('.popup').removeClass('is-active');
  $('#overlay').removeClass('is-active');
  $('.popup-form').removeClass('is-active');
  $('body').removeClass('noscroll');
  $('.popup-form').html('');
}
