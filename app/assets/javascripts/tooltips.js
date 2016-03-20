$(document).on('ready page:load', function() {

  $(document).ajaxSuccess(function() {
    // tooltip for all links with class tooltip
    $('.tooltip').tooltipster({
      theme: 'tooltipster-punk',
      animation: 'grow',
      contentAsHTML: true,
      interactive: true,
      minWidth: '400',
      functionInit: function(origin, content) {
        $.ajax({
          url: origin.attr('href'),
          dataType: 'html',
          success: function(data) {
            return origin.tooltipster('content', data);
          }
        });
      }
    });

    // tooltip for the stats page link
    $('.link-to-stats > a').tooltipster({
      theme: 'tooltipster-punk',
      animation: 'grow',
      contentAsHTML: true,
      interactive: true,
      minWidth: '400',
      position: 'bottom',
      content: 'loading...',
      // function to fire before tooltip opens - load the points-pie div into the tooltip?
      functionBefore: function(origin, continueTooltip) {
        continueTooltip();
        $.ajax({
          url: origin.attr('href'),
          success: function(data) {
            var chart = $($.parseHTML(data)).find('.points-pie').clone();
            return origin.tooltipster('content', chart);
          }
        });
      },
      // function to fire when tooltip and content is added to the dom, run the showPointsChart
      // function to populate the tooltip with the pie chart from the stats page.

    });


  });
});
