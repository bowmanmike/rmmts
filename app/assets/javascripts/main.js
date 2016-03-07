$(document).on('ready page:load', function() {
  $(document).on('click', '#login-link', function(e) {
    e.preventDefault();

    $('#overlay').addClass('is-active');
    $('.popup-form').addClass('is-active');
  })


  $('html').on('click', '.popup-form', function(e) {
    e.stopPropagation();
  })

  $('html').on('click', function() {
    $('.popup-form').removeClass('is-active');
    $('#overlay').removeClass('is-active');
  });

  $('.popup-form').on('submit', function() {
    $(this).add('#overlay').removeClass('is-active');
  })
})
