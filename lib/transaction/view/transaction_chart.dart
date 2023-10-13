import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:track/repositories/models/transactionSummary.dart';

class TransactionChart extends StatelessWidget {
  TransactionChart({super.key, required this.data});

  final TransactionSummary data;

  @override
  Widget build(BuildContext context) {
    final chartData = data.spendingCategoryList;

    calculatePercentage(val) {
      return ((val / data.totalSpending) * 100).toStringAsFixed(2);
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
          DoughnutSeries<SpendingByCategory, String>(
             radius: '75%',
            innerRadius: '75%',
            dataSource: chartData,
            pointColorMapper: (SpendingByCategory data, _) =>
                Color(int.parse(data.color.toString())),
            xValueMapper: (SpendingByCategory data, _) =>
                '${data.categoryName} RM ${data.amount?.toStringAsFixed(2)}', //name
            yValueMapper: (SpendingByCategory data, _) => data.amount, //number
            //dataLabelMapper: (ChartData data, _) => "RM${data.y}" ,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              builder: (data, point, series, pointIndex, seriesIndex) {
                return Text('${calculatePercentage(data.amount)}%');
              },
            ),
          )
        ],
      ),
    );
  }
}
