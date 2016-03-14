// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('ready page:load', function() {
  $(document).on('submit', '.request-password-reset-form', function(e) {
    e.stopPropagation();
  });
})
