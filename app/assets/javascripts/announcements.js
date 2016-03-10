// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('ready page:load', function() {

  $(document).on('click', '#show-announcements-button', function() {
    $('.full-card-list').addClass('animated fadeIn')
                            .css({
                              height: 'auto'
                           });
  });

  $(document).on('click', '#hide-announcements-button', function() {
    $('.full-card-list').css({
                              height: '0'
                           }).removeClass('animated fadeIn');
  });

});
