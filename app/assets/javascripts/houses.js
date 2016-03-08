// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('ready page:load', function() {
  $(document).on('click', '#new-announcement-button', function(e) {
    e.preventDefault();

    showPopUp();
  })

  $(document).on('click', '.edit-announcement-button', function(e) {
    e.preventDefault();

    showPopUp();
  })

  $(document).on('click', '.edit-chore-button', function(e) {
    e.preventDefault();

    showPopUp();
  })
});
