$(document).on('ready page:load', function() {

  initializeTooltips();

  $(document).ajaxSuccess(function() {
    initializeTooltips();
  });

  function initializeTooltips() {
    if ( document.getElementsByClassName('tooltip').length > 0 ) {
      // set tooltips for calendar chores, purchases and expenses
      $('.tooltip').tooltipster({
        theme: 'tooltipster-punk',
        animation: 'grow',
        contentAsHTML: true,
        interactive: true,
        minWidth: '400',
        functionInit: function(origin, content) {
          $.ajax({
            url: origin.attr('href'),
            success: function(data) {
              return origin.tooltipster('content', data);
            }
          });
        }
      });

      // set tooltip for the stats page link showing pie chart
      $('.link-to-stats > a').tooltipster({
        theme: 'tooltipster-punk',
        animation: 'grow',
        contentAsHTML: true,
        interactive: true,
        minWidth: '200',
        position: 'bottom',
        content: 'loading...',
        functionReady: function(origin, tooltip) {
          $.ajax({
            url: origin.attr('href'),
            success: function(data) {
              var canvas = $($.parseHTML(data)).find('.points-pie').clone();
              // insert the canvas element into the tooltip div so it can be populated with the chart
              origin.tooltipster('content', canvas);
              // retrieve and format the JSON data needed for the chart, generate the pie chart inside the canvas
              $.getJSON(origin.attr('href') + '.json').done(function(stats) {
                var pointsData = [];
                var points = stats.points;

                for (var i = 0; i < points.length; i++) {
                  pointsData.push({
                      value: points[i].value,
                      label: points[i].label,
                      color: chartColor(i)
                  });
                };

                var ctx = $('.points-pie').get(0).getContext("2d");
                new Chart(ctx).Pie(pointsData, {
                  segmentShowStroke: false,
                  percentageInnerCutout: 70
                });
              });
            }
          });
          // Chart colour definition
          var chartColor = function(num) {
            // From Google's Material Design colour palette
            // http://www.google.com/design/spec/style/color.html#color-color-palette
            if (num == 0)
                return "#1DE9B6";
            if (num == 1)
                return "#00E676";
            if (num == 2)
                return "#76FF03";
            if (num == 3)
                return "#C6FF00";
            if (num == 4)
                return "#FFEA00";
            if (num == 5)
                return "#FFC400";
            if (num == 6)
                return "#FF9100";
            if (num == 7)
                return "#FF3D00";
            if (num == 8)
                return "#FF1744";
            if (num == 9)
                return "#F50057";
            if (num == 10)
                return "#D500F9";
          };
        }
      });
    }
  }

});
