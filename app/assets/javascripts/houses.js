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
});

// var data = {
//               mates: [
//                 { username: "tomtown" },
//                 { username: "pcruiksh" },
//                 { username: "bobsmith" },
//                 { username: "billsmith" },
//                 { username: "benjamin" }
//                      ]
//             };
