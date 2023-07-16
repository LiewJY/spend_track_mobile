import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:track/repositories/models/budget.dart';
import 'package:track/repositories/models/transactionSummary.dart';

class BudgetChart extends StatelessWidget {
  BudgetChart({
    super.key,
    required this.data,
    required this.totalBudget,
  });

  final List<Budget>? data;
  final double totalBudget;

  @override
  Widget build(BuildContext context) {
    final chartData = data;

    calculatePercentage(val) {
      return ((val / totalBudget) * 100).toStringAsFixed(2);
    }

    return Center(
      child: SfCircularChart(
        legend: Legend(
          isVisible: true,
          orientation: LegendItemOrientation.horizontal,
          position: LegendPosition.bottom,
          isResponsive: true,
          toggleSeriesVisibility: false,
          overflowMode: LegendItemOverflowMode.wrap,
        ),
        series: <CircularSeries>[
          DoughnutSeries<Budget, String>(
            // radius: '80%',
            innerRadius: '75%',
            dataSource: chartData,
            pointColorMapper: (Budget data, _) =>
                Color(int.parse(data.color.toString())),
            xValueMapper: (Budget data, _) =>
                '${data.name} RM ${data.amount?.toStringAsFixed(2)}', //name
            yValueMapper: (Budget data, _) => data.amount, //number
            //dataLabelMapper: (ChartData data, _) => "RM${data.y}" ,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              builder: (data, point, series, pointIndex, seriesIndex) {
                return Container(
                  child: Text('${calculatePercentage(data.amount)}%'),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
