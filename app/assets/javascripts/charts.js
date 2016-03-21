$(document).on('ready page:load', function() {

  var showPointsChart = function() {

    $.getJSON($(location).attr('href') + '.json').done(function(stats){
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
  };

  var showPointsChartPopup = function() {

    $.getJSON($(location).attr('href') + '/stats.json').done(function(stats){
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
        fillColor: chartColor(2),
        strokeColor: chartColor(2),
        highlightFill: secondaryChartColor(2),
        highlightStroke: secondaryChartColor(2)
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

  var showSpendingChartPopup = function() {

    $.getJSON($(location).attr('href') + '/stats.json').done(function(stats) {
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
        fillColor: chartColor(2),
        strokeColor: chartColor(2),
        highlightFill: secondaryChartColor(2),
        highlightStroke: secondaryChartColor(2)
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
  }

  $(document).ajaxSuccess( function( event, xhr, settings ) {
    if (settings.url == $(location).attr('href') + '/stats') {
      if ($('.popup-form').has('.house-stats-header')) {
        showPointsChartPopup();
        showSpendingChartPopup();
      }
    }
  });

  var chartColor = function(num) {
    // From Google's Material Design colour palette
    // http://www.google.com/design/spec/style/color.html#color-color-palette
    if (num == 0)
        return "#2979FF";
    if (num == 1)
        return "#00B0FF";
    if (num == 2)
        return "#00E5FF";
    if (num == 3)
        return "#1DE9B6";
    if (num == 4)
        return "#00E676";
    if (num == 5)
        return "#76FF03";
    if (num == 6)
        return "#C6FF00";
    if (num == 7)
        return "#FFEA00";
    if (num == 8)
        return "#FFC400";
    if (num == 9)
        return "#FF9100";
    if (num == 10)
        return "#FF3D00";
  };

  var secondaryChartColor = function(num) {
    // From Google's Material Design colour palette
    // http://www.google.com/design/spec/style/color.html#color-color-palette
    if (num == 0)
        return "#448AFF";
    if (num == 1)
        return "#40C4FF";
    if (num == 2)
        return "#18FFFF";
    if (num == 3)
        return "#64FFDA";
    if (num == 4)
        return "#69F0AE";
    if (num == 5)
        return "#B2FF59";
    if (num == 6)
        return "#EEFF41";
    if (num == 7)
        return "#FFFF00";
    if (num == 8)
        return "#FFD740";
    if (num == 9)
        return "#FFAB40";
    if (num == 10)
        return "#FF6E40";
  };

});
