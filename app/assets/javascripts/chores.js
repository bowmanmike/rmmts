// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('ready page:load', function() {

  $(document).on('change', '#chore_recurring', function() {
    $('.recurrence').toggle()
  });

  $(document).on('click', '.check-mark', function() {
    $(this).toggleClass('is-checked');
  });

  $(document).on('click', '.show-notification-options', function(e) {
    e.preventDefault();
    $(this).parents('.chore-front').addClass('animated flipInX');
    $(this).parents('.chore-front').addClass('hide-card');
    $(this).parents('.chore-front').siblings('.chore-back')
                                   .css({
                                     'overflow': 'auto',
                                     height: 'auto'
                                   })
                                   .addClass('animated flipInX')
                                   .removeClass('hide-card');
  });

  $(document).on('click', '.hide-notification-options', function(e) {
    e.preventDefault();

    $(this).parents('.chore-back').addClass('hide-card');
    $(this).parents('.chore-back').siblings('.chore-front').removeClass('hide-card');
  });
});
