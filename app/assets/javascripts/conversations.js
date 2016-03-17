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

  var timeoutID = undefined

  if (document.getElementsByClassName('messages').length > 0) {
    $(document).on('click', '.conversation-link', function(e) {
      e.preventDefault();
      var conversation = $(this);
      clearTimeout(timeoutID);

      function initializeAjaxPolling() {
        $.getScript('/conversations/ ' + conversation.attr('data-id') + '/new_messages');
        timeoutID = setTimeout(initializeAjaxPolling, 5000);
      }

      initializeAjaxPolling();

      $('a').not('.conversation-link').click(function() {
        clearTimeout(timeoutID);
      });
    });
  }

  $(document).on('submit', '#new_message', function() {
    $('#message_body').val('');
  });

  $(document).on('click', '.messaging-header', function() {
    $('.all-conversations').toggleClass('slide-down');
  });

  $(document).on('click', '.each-conversation', function() {
    $('.all-conversations').removeClass('slide-down');
  })
})
