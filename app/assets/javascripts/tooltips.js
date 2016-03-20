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
      minWidth: '200',
      position: 'bottom',
      content: 'loading...',
      // function to fire before tooltip opens - load the points-pie div into the tooltip?
      // functionBefore: function(origin, continueTooltip) {
      //   continueTooltip();
      //   $.ajax({
      //     url: origin.attr('href'),
      //     success: function(data) {
      //       var canvas = $($.parseHTML(data)).find('canvas.points-pie').clone();
      //       return origin.tooltipster('content', canvas);
      //     }
      //   });
      // },
      // function to fire when tooltip and content is added to the dom, run the showPointsChart
      // function to populate the tooltip with the pie chart from the stats page.
      functionReady: function(origin, tooltip) {
        // retrieve and format the JSON data needed for the chart
        $.ajax({
          url: origin.attr('href'),
          success: function(data) {
            var canvas = $($.parseHTML(data)).find('.points-pie').clone();
            return origin.tooltipster('content', canvas);
          }
        });

        $.getJSON(origin.attr('href') + '.json').done(function(stats){
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


  });
});
