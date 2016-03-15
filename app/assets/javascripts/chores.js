// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('ready page:load', function() {

  initializeDragAndDrop();
  setAccordionLists();

  $(window).resize(function() {
    setAccordionLists();
  });

  $(document).ajaxSuccess(function() {
    initializeDragAndDrop();
  });

  function initializeDragAndDrop() {
    $('.incomplete-chores-list > .chore').draggable({
      containment: '.chores-full-container',
      snap: '.card-list',
      revert: 'invalid',
      helper: 'clone',
    });

    $('.complete-chores-list > .chore').draggable({
      containment: '.chores-full-container',
      snap: '.card-list',
      revert: 'invalid',
      helper: 'clone',
    });

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
    var checkmark = ui.draggable.find('.check-mark');
    checkmark.click();
  }

  function setAccordionLists() {
    if (window.innerWidth < 600) {
      $('.card-container').accordion({
        active: false,
        collapsible: true,
        height: 'content',
        icons: false,
      });
    } else {
      if ($('.card-container').hasClass('ui-accordion')) {
        $('.card-container').accordion('destroy');
      }
    }
    if $('.card-container').hasClass('each-message').accordion('destroy');
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
