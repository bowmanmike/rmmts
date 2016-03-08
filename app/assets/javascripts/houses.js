// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('ready page:load', function() {

  var usernames = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    prefetch: '/usernames.json',
    remote: '/usernames.json'
  });

  $('#username-search .query').typeahead(null, {
    // displayKey: 'username',
    name: 'mates',
    // display: 'username',
    source:
  });


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

  $(document).on('click', '.new-chore-button', function(e) {
    e.preventDefault();

    showPopUp();
  })

  $(document).on('click', '.edit-expense-button', function(e) {
    e.preventDefault();

    showPopUp();
  })

  $(document).on('click', '.new-expense-button', function(e) {
    e.preventDefault();

    showPopUp();
  })

  $(document).on('click', '.new-purchase-button', function(e) {
    e.preventDefault()

    showPopUp();
  })

  $(document).on('click', '.edit-purchase-button', function(e) {
    e.preventDefault()

    showPopUp();
  });
});
