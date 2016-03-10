// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('ready page:load', function() {

  $(document).on('click', '#show-announcements-button', function() {
    $('#announcements-list').addClass('animated fadeIn')
                            .css({
                              height: 'auto'
                           });
  });

  $(document).on('click', '#hide-announcements-button', function() {
    $('#announcements-list').css({
                              height: '0'
                           }).removeClass('animated fadeIn');
  });

});
