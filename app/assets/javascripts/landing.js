$(document).on('ready page:load', function() {

  $('#landing-page-circle').height($('#landing-page-circle').width());

  $(window).resize(function(){
    $('#landing-page-circle').height($('#landing-page-circle').width());
  });

});
