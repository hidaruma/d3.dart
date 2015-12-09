import 'package:d3/d3.dart';

main() {
  var width = 420, barHeight = 20;

  var x = new LinearScale().range([0, width]);

  var chart = new Selection(".chart").attr("width", width);

  new Xhr.tsv("data.tsv", type, (error, data) {
    x.domain([0, max(data, (d) => d['value'])]);

    chart.attr("height", barHeight * data.length);

    var bar = chart
        .selectAll("g")
        .data(data)
        .enter()
        .append("g")
        .attr("transform", (d, i) {
      return "translate(0,${i * barHeight})";
    });

    bar.append("rect").attr("width", (d) {
      return x(d['value']);
    }).attr("height", barHeight - 1);

    bar.append("text").attr("x", (d) {
      return x(d['value']) - 3;
    }).attr("y", barHeight / 2).attr("dy", ".35em").text((d) {
      return d['value'];
    });
  });
}

type(d, i) {
  d['value'] = double.parse(d['value']);
  return d;
}
