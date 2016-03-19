$(document).on('ready page:load', function() {

  $(document).ajaxSuccess(function() {
    $('.tooltip').tooltipster({
      theme: 'tooltipster-punk',
      animation: 'grow',
      contentAsHTML: true,
      interactive: true,
      minWidth: '300',
      functionInit: function(origin, content) {
        $.ajax({
          url: origin.attr('href'),
          dataType: 'HTML',
          success: function(data) {
            return origin.tooltipster('content', data);
          }
        });
      }
    });
  });


});
