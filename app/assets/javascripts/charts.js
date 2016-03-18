$(document).on('ready page:load', function() {

  var showPointsChart = function() {

    $.getJSON($(location).attr('href') + '.json').done(function(stats){
      var pointsData = [];
      var points = stats.points;

      for (i = 0; i < points.length; i++) {
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
  };

  if ($(location).attr('href').search('stats') >= 0) {
    showPointsChart();
  };

  var chartColor = function(num) {
    // From Google's Material Design colour palette
    // http://www.google.com/design/spec/style/color.html#color-color-palette
    if (num == 0)
        return "#76FF03";
    if (num == 1)
        return "#00E676";
    if (num == 2)
        return "#1DE9B6";
    if (num == 3)
        return "#00E5FF";
    if (num == 4)
        return "#00B0FF";
    if (num == 5)
        return "#2979FF";
    if (num == 6)
        return "#651FFF";
    if (num == 7)
        return "#D500F9";
    if (num == 8)
        return "#F50057";
    if (num == 9)
        return "#FF1744";
  };

});
