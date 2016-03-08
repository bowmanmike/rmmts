// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('ready page:load', function() {
  $(document).on('change', '#chore_recurring', function() {
    $('.recurrence').toggle()
  });

  $('.check-mark').on('click', function() {
    $(this).toggleClass('is-checked');
  });
});
