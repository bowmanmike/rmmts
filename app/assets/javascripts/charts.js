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

  var showSpendingChart = function() {

    $.getJSON($(location).attr('href') + '.json').done(function(stats) {
      var expenseData = {};
      var purchaseData = {};
      var spending = stats.spending;
      var spendingLabels = ["J", "F", "M", "A", "M", "J", "J", "A", "S", "O", "N", "D"];
      var expenseDataset = [];
      var purchaseDataset = []

      expenseDataset.push({
        data: spending[0].data,
        label: spending[0].label,
        fillColor: chartColor(0),
        strokeColor: chartColor(0),
        highlightFill: secondaryChartColor(0),
        highlightStroke: secondaryChartColor(0)
      });

      purchaseDataset.push({
        data: spending[1].data,
        label: spending[1].label,
        fillColor: chartColor(1),
        strokeColor: chartColor(1),
        highlightFill: secondaryChartColor(1),
        highlightStroke: secondaryChartColor(1)
      });


      expenseData.labels = spendingLabels;
      expenseData.datasets = expenseDataset;

      purchaseData.labels = spendingLabels;
      purchaseData.datasets = purchaseDataset;

      var expenseCtx = $('.expense-bar').get(0).getContext("2d");
      new Chart(expenseCtx).Bar(expenseData, {
        barShowStroke: false,
        scaleShowGridLines: false,
        scaleShowHorizontalLines: false,
        scaleShowVerticalLines: false,
        scaleLineColor: 'transparent',
        scaleShowLabels: false,
        barValueSpacing: 2,
        barDatasetSpacing: 0,
      });

      var purchaseCtx = $('.purchase-bar').get(0).getContext("2d");
      new Chart(purchaseCtx).Bar(purchaseData, {
        barShowStroke: false,
        scaleShowGridLines: false,
        scaleShowHorizontalLines: false,
        scaleShowVerticalLines: false,
        scaleLineColor: 'transparent',
        scaleShowLabels: false,
        barValueSpacing: 2,
        barDatasetSpacing: 0,
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
