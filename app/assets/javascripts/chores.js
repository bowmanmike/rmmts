// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('ready page:load', function() {

  initializeDragAndDrop();

  $(document).ajaxSuccess(function() {
    initializeDragAndDrop();
  });

  function initializeDragAndDrop() {
    $('.incomplete-chores-list > .chore').draggable({
      containment: '.chores-full-container',
      snap: '.card-list',
    });

    $('.complete-chores-list > .chore').draggable({
      containment: '.chores-full-container',
      snap: '.card-list',
    })

    $('.incomplete-chores-list').droppable({
      accept: '.complete-chores-list > .chore',
      drop: choreDropEvent
    })

    $('.complete-chores-list').droppable({
      accept: '.incomplete-chores-list > .chore',
      drop: choreDropEvent
    });
  }

  function choreDropEvent(event, ui) {
    var chore = ui.draggable;
    var checkmark = chore.find('.check-mark');
    checkmark.click();
  }

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
                                   .addClass('animated flipInX')
                                   .removeClass('hide-card');
  });

  $(document).on('click', '.hide-notification-options', function(e) {
    e.preventDefault();

    $(this).parents('.chore-back').addClass('hide-card');
    $(this).parents('.chore-back').siblings('.chore-front').removeClass('hide-card');
  });
});
