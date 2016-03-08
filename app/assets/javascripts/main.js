$(document).on('ready page:load', function() {

  $(document).on('click', '#login-link', function(e) {
    e.preventDefault();
    showPopUp();
  })

  $(document).on('click', '#signup-link', function(e) {
    e.preventDefault();
    showPopUp();
  })


  $('html').on('click', '.popup-form', function(e) {
    e.stopPropagation();
  })

  $('html').on('click', function() {
    hidePopUp();
  });

  $('.popup-form').on('submit', function() {
    $(this).add('#overlay').removeClass('is-active');
  })
})

var showPopUp = function() {
  $('#overlay').addClass('is-active');
  $('.popup-form').addClass('is-active');
}

var hidePopUp = function() {
  $('.popup-form').removeClass('is-active');
  $('#overlay').removeClass('is-active');
}
