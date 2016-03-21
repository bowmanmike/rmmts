// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('ready page:load', function() {

  $.getJSON('/housenames.json').done(function(houses) {
    var houseList = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.whitespace,
      queryTokenizer: Bloodhound.tokenizers.whitespace,
      local: houses,
    });

    $('#house-search-form .query').typeahead(null, {
      source: houseList
    });
  });

  $(document).on('click', '#edit-house-button', function(e) {
    e.preventDefault();

    showPopUp();
  });

  $(document).on('click', '.new-announcement-button', function(e) {
    e.preventDefault();

    showPopUp();
  });

  $(document).on('click', '.edit-announcement-button', function(e) {
    e.preventDefault();

    showPopUp();
  });

  $(document).on('click', '.show-chore-link', function(e) {
    e.preventDefault();

    showPopUp();
  });

  $(document).on('click', '.edit-chore-button', function(e) {
    e.preventDefault();

    showPopUp();
  });

  $(document).on('click', '.new-chore-button', function(e) {
    e.preventDefault();

    showPopUp();
  });

  $(document).on('click', '.show-expense-link', function(e) {
    e.preventDefault();

    showPopUp();
  });

  $(document).on('click', '.edit-expense-button', function(e) {
    e.preventDefault();

    showPopUp();
  });

  $(document).on('click', '.new-expense-button', function(e) {
    e.preventDefault();

    showPopUp();
  });

  $(document).on('click', '.show-purchase-link', function(e) {
    e.preventDefault();

    showPopUp();
  });

  $(document).on('click', '.new-purchase-button', function(e) {
    e.preventDefault();

    showPopUp();
  });

  $(document).on('click', '.edit-purchase-button', function(e) {
    e.preventDefault();

    showPopUp();
  });

  $(document).on('click', '.new-expense-payment-button', function(e) {
    e.preventDefault();

    showPopUp();
  });

  $(document).on('click', '.new-purchase-payment-button', function(e) {
    e.preventDefault();

    showPopUp();
  });

  $(document).on('click', '.house-stats',function(e) {
    e.preventDefault();

    showPopUp();
  });

  $(document).on('click', '.update-house-mates-button',function(e) {
    e.preventDefault();

    showPopUp();
  });

  $(document).on('click', '.show-month-calendar-button',function(e) {
    e.preventDefault();

    showPopUp();
  });

  $(document).on('click', '.simple-calendar > a', function(e) {
    e.preventDefault();
    var self = $(this);

    $.ajax({
      type: 'get',
      url: self.attr('href'),
      dataType: 'script',
    })
  })
});

$(document).on('page:partial-load', function() {

  $(document).on('click', '.edit-purchase-button', function(e) {
    e.preventDefault();

    showPopUp();
  });

});
