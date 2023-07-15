import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:track/repositories/models/transactionSummary.dart';

class TransactionChart extends StatelessWidget {
  TransactionChart({super.key, required this.data});

  final TransactionSummary data;

  @override
  Widget build(BuildContext context) {
    // final List<ChartData> chartData = [
    //   ChartData('David', 1, Color.fromRGBO(9, 0, 136, 1)),
    //   ChartData('Steve', 38, Color.fromRGBO(147, 0, 119, 1)),
    //   ChartData('Jack', 34, Color.fromRGBO(228, 0, 124, 1)),
    //   ChartData('Others', 52, Color.fromRGBO(255, 189, 57, 1))
    // ];
    final chartData = data.spendingCategoryList;

    calp(val) {
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
          overflowMode: LegendItemOverflowMode.wrap
          // legendItemBuilder: (legendText, series, point, seriesIndex) {
          //   return Container(
          //     child: Row(
          //       children: [
          //         Text(legendText),
          //                             // Text(seriesIndex.toString()),
          //                             // Text(series.toString()),

          //         // Icon(Icons.fiber_manual_record,
          //         // //color: Color(int.parse(data.color.toString()),
          //         // )

          //       ],
          //     ),
          //   );
          // },
          // alignment: ChartAlignment.near
          //alignment: ChartAlignment.center
          // Border color and border width of legend
          // borderColor: Colors.black,
          //borderWidth: 2,
        ),
        series: <CircularSeries>[
          DoughnutSeries<SpendingByCategory, String>(
            dataSource: chartData,
            pointColorMapper: (SpendingByCategory data, _) =>
                Color(int.parse(data.color.toString())),
            xValueMapper: (SpendingByCategory data, _) =>
                '${data.categoryName} ${calp(data.amount)}%', //name
            yValueMapper: (SpendingByCategory data, _) => data.amount, //number
            //dataLabelMapper: (ChartData data, _) => "RM${data.y}" ,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
              // showCumulativeValues: true
            ),
            // Corner style of doughnut segment
            //cornerStyle: CornerStyle.bothCurve
          )
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
