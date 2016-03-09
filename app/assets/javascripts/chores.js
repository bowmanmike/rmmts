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

    $(this).parents('.chore-front').addClass('hide-card');
    $(this).parents('.chore-front').siblings('.chore-back').removeClass('hide-card');

    $(this).parents('.chore').addClass('is-flipped');
  });

  $('.hide-notification-options').on('click', function(e) {
    e.preventDefault();

    $(this).parents('.chore-back').addClass('hide-card');
    $(this).parents('.chore-back').siblings('.chore-front').removeClass('hide-card');
  });
});
