$(document).on('ready page:load', function() {

  var showPointsChart = function() {

    $.getJSON($(location).attr('href') + '.json').done(function(stats) {
      var pointsData = [];
      var points = stats.points;
      for (i = 0; i < points.length; i++) {
        pointsData.push({
            value: points[i].value,
            label: points[i].label,
            color: chartColor(i)
        });
      };

      var pointsCtx = $('.points-pie').get(0).getContext("2d");
      new Chart(pointsCtx).Pie(pointsData, {
        segmentShowStroke: false,
        percentageInnerCutout: 70
      });
    });
  };

  var showSpendingChart = function() {

    $.getJSON($(location).attr('href') + '.json').done(function(stats) {
      var spendingData = {};
      var spending = stats.spending;
      var labels = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
      var datasets = [];
      for (i = 0; i < spending.length; i++) {
        datasets.push({
            data: spending[i].data,
            label: spending[i].label,
            fillColor: chartColor(i),
            highlightFill: secondaryChartColor(i)
        });
      };

      spendingData.push(labels: labels);
      spendingData.push(datasets: datasets);

      var spendingCtx = $('.spending-bar').get(0).getContext("2d");
      new Chart(spendingCtx).Bar(spendingData, {
        barShowStroke: false,
        scaleShowGridLines: false,
      });
    });
  };

  if ($(location).attr('href').search('stats') >= 0) {
    showPointsChart();
    showSpendingChart();
  };

  var chartColor = function(num) {
    // From Google's Material Design colour palette
    // http://www.google.com/design/spec/style/color.html#color-color-palette
    if (num == 0)
        return "#00B0FF";
    if (num == 1)
        return "#00E5FF";
    if (num == 2)
        return "#1DE9B6";
    if (num == 3)
        return "#00E676";
    if (num == 4)
        return "#76FF03";
    if (num == 5)
        return "#C6FF00";
    if (num == 6)
        return "#FFEA00";
    if (num == 7)
        return "#FFC400";
    if (num == 8)
        return "#FF9100";
    if (num == 9)
        return "#FF3D00";
    if (num == 10)
        return "#FF1744";
    if (num == 11)
        return "#F50057";
    if (num == 12)
        return "#D500F9";
  };

  var secondaryChartColor = function(num) {
    // From Google's Material Design colour palette
    // http://www.google.com/design/spec/style/color.html#color-color-palette
    if (num == 0)
        return "#0091EA";
    if (num == 1)
        return "#00B8D4";
    if (num == 2)
        return "#00BFA5";
    if (num == 3)
        return "#00C853";
    if (num == 4)
        return "#64DD17";
    if (num == 5)
        return "#AEEA00";
    if (num == 6)
        return "#FFD600";
    if (num == 7)
        return "#FFAB00";
    if (num == 8)
        return "#FF6D00";
    if (num == 9)
        return "#DD2C00";
    if (num == 10)
        return "#D50000";
    if (num == 11)
        return "#C51162";
    if (num == 12)
        return "#AA00FF";
  };

});
