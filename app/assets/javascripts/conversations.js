// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('ready page:load', function() {
  $(document).on('keypress', function(e) {
    if (e.which === 13 && !e.shiftKey) {
      e.preventDefault();

      $("#new_message").submit();
      $("#message_body").val('');
    }

  });

  $(document).on('submit', '#new_message', function() {
    $('#message_body').val('');
  });

  $(document).on('click', '.messaging-header', function() {
    $('.all-conversations').toggleClass('slide-down');
  })
})
