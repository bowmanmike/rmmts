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
        // Get context with jQuery - using jQuery's .get() method.
        var ctx = $("#test-chart").get(0).getContext("2d");
        // This will get the first returned node in the jQuery collection.
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

  // var pieData = [];
  // for (i = 0; i < getPieData.length; i++) {
  //   pieData.push({
  //       value: getPieData[i].value,
  //       label: getPieData[i].label,
  //       color: chartColor(i)
  //   });
  // };

  // drawPieChart();


  // var urlJSON =
  // var dataJSON = $.getJSON(urlJSON);
  // var responseJSON = dataJSON.responseText;
  // var objectJSON = $.parseJSON(responseJSON);

});
