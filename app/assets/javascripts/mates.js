// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on('ready page:load', function() {

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
});
