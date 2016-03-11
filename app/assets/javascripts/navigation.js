$(document).on('ready page:load', function() {
  var menuToggle = $('#js-mobile-menu').unbind();

  if (window.matchMedia("(max-width: 599px)").matches) {
    $('#js-navigation-menu').removeClass("show");
  }

  menuToggle.on('click', function(e) {
    e.preventDefault();
    $('#js-navigation-menu').slideToggle();
  });
});
