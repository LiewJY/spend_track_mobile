import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:track/repositories/models/budget.dart';
import 'package:track/repositories/models/transactionSummary.dart';

class BudgetExpensesChart extends StatelessWidget {
  BudgetExpensesChart({
    super.key,
    required this.data,
    required this.totalBudget,
  });

  final List<Budget>? data;
  final double totalBudget;

  @override
  Widget build(BuildContext context) {
    final chartData = data;

    calculatePercentage(budget, actualSpending) {
      if (budget == 0) {
        if (actualSpending == 0) {
          return 0;
        }
        return 110;
      } else {
        return ((actualSpending / budget) * 100);
      }
    }
    //${calculatePercentage(data.amount)}%

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
          RadialBarSeries<Budget, String>(
            radius: '100%',
            gap: '3%',
            maximumValue: 100,
            useSeriesColor: true,
            trackOpacity: 0.2,
            cornerStyle: CornerStyle.bothCurve,
            dataSource: chartData,
            pointColorMapper: (Budget data, _) =>
                Color(int.parse(data.color.toString())),
            xValueMapper: (Budget data, _) => '${data.name}', //name
            yValueMapper: (Budget data, _) =>
                calculatePercentage(data.amount, data.amountSpent), //number
            //dataLabelMapper: (ChartData data, _) => "RM${data.y}" ,
            // dataLabelSettings: DataLabelSettings(
            //   isVisible: true,
            //   labelPosition: ChartDataLabelPosition.outside,
            //   // builder: (data, point, series, pointIndex, seriesIndex) {
            //   //   return Container(
            //   //     child: Text('${calculatePercentage(data.amount)}%'),
            //   //   );
            //   // },
            // ),
          )
        ],
      ),
    );
  }
}
