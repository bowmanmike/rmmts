// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('ready page:load', function() {
  $(document).on('change', '#chore_recurring', function() {
    $('.recurrence').toggle()
  });

  $('.check-mark').on('click', function() {
    $(this).toggleClass('is-checked');
  });

  $('.show-notification-options').on('click', function(e) {
    e.preventDefault();

    $(this).parents('.chore').addClass('hide-card');
    $(this).parents('.chore').siblings('.notification-settings').removeClass('hide-card');
  });

  $('.hide-notification-options').on('click', function(e) {
    e.preventDefault();

    $(this).parents('.notification-settings').addClass('hide-card');
    $(this).parents('.notification-settings').siblings('.chore').removeClass('hide-card');
  });
});
