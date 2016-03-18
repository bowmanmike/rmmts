$(document).on('ready page:load', function() {

  var getPieData = function() {

    $.getJSON( $(location).attr('href') + ".json" ).done(function(data){
      var pieData = [];

      var chartColor = function(num) {
        if (num == 0)
            return "#F38630";
        if (num == 1)
            return "#E0E4CC";
        if (num == 2)
            return "#69D2E7";
        if (num == 3)
            return "#003399";
        if (num == 4)
            return "#969696";
      };

      var drawPieChart = function() {
        var ctx = $("#test-chart").get(0).getContext("2d");
        var myNewChart = new Chart(ctx).Pie(pieData);
      }

      for (i = 0; i < data.length; i++) {
        pieData.push({
            value: data[i].value,
            label: data[i].label,
            color: chartColor(i)
        });
      };

      drawPieChart();

    });
  };

  getPieData();

});
