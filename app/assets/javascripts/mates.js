// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('ready page:load', function() {

  $(document).ajaxSuccess( function(events, xhr, settings) {
    if (settings.url == $(location).attr('href') + '/update_mates') {

      $.getJSON('/usernames.json').done(function(mates) {
        var usernames = new Bloodhound({
          datumTokenizer: Bloodhound.tokenizers.whitespace,
          queryTokenizer: Bloodhound.tokenizers.whitespace,
          local: mates,
        });

        $('#username-search .query').typeahead(null, {
          source: usernames
        });
      });

    }
  });

  $('#getting-started-tabs').tabs({
    collapsible: true,
    heightStyle: 'content',
  });

  $(document).on('click', '.show-chore-link', function(e) {
    e.preventDefault();

    showPopUp();
  });

  $(document).on('click', '.new-purchase-button', function(e) {
    e.preventDefault();

    showPopUp();
  })

  $(document).on('click', '.new-housemate-purchase-link', function(e) {
    e.preventDefault();

    showPopUp();
  })

});
