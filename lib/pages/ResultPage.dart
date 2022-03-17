import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/models/result_bar_chart_by_quiz_name_model.dart';

import '../blocs/result/result-bloc.dart';
import '../blocs/result/result-event.dart';
import '../blocs/result/result-state.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => ResultBloc()..add(LoadResult()),
        child: Scaffold(body:
            BlocBuilder<ResultBloc, ResultState>(builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  height: 300,
                  //margin: const EdgeInsets.only(bottom: 50),
                  child: charts.BarChart(_seriesList(state),
                      animate: false,
                      barGroupingType: charts.BarGroupingType.grouped),
                  constraints:
                      const BoxConstraints(maxHeight: 300, maxWidth: 300),
                )
              ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _gaugeChart(state))
            ],
          );
        })));
  }

  List<charts.Series<ResultBarChartByQuizNameModel, String>> _seriesList(
      ResultState state) {
    var quizNames = state.mapByQuizAndQuizId.keys.toList();

    final List<ResultBarChartByQuizNameModel> attemptedData = [];
    final List<ResultBarChartByQuizNameModel> correctData = [];
    final List<ResultBarChartByQuizNameModel> incorrectData = [];

    quizNames.forEach((key) {
      attemptedData.add(ResultBarChartByQuizNameModel(
          key, state.mapByQuizAndQuizId[key]!.entries.first.value.attempted));
      correctData.add(ResultBarChartByQuizNameModel(
          key, state.mapByQuizAndQuizId[key]!.entries.first.value.correct));
      incorrectData.add(ResultBarChartByQuizNameModel(
          key, state.mapByQuizAndQuizId[key]!.entries.first.value.incorrect));
    });

    return [
      charts.Series<ResultBarChartByQuizNameModel, String>(
        id: 'Attempted',
        domainFn: (ResultBarChartByQuizNameModel model, _) => model.quizName,
        measureFn: (ResultBarChartByQuizNameModel model, _) => model.count,
        data: attemptedData,
        colorFn: (ResultBarChartByQuizNameModel model, _) =>
            charts.ColorUtil.fromDartColor(Colors.green),
      ),
      charts.Series<ResultBarChartByQuizNameModel, String>(
        id: 'Correct',
        domainFn: (ResultBarChartByQuizNameModel model, _) => model.quizName,
        measureFn: (ResultBarChartByQuizNameModel model, _) => model.count,
        data: correctData,
        colorFn: (ResultBarChartByQuizNameModel model, _) =>
            charts.ColorUtil.fromDartColor(Colors.blue),
      ),
      charts.Series<ResultBarChartByQuizNameModel, String>(
        id: 'Incorrect',
        domainFn: (ResultBarChartByQuizNameModel model, _) => model.quizName,
        measureFn: (ResultBarChartByQuizNameModel model, _) => model.count,
        data: incorrectData,
        colorFn: (ResultBarChartByQuizNameModel model, _) =>
            charts.ColorUtil.fromDartColor(Colors.red),
      ),
    ];
  }

  List<Widget> _gaugeChart(ResultState state) {
    var quizNames = state.mapByQuizAndQuizId.keys.toList();

    List<Widget> chartList = [];

    quizNames.forEach((key) {
      double score =
          (state.mapByQuizAndQuizId[key]!.entries.first.value.correct) *
              100 /
              (state.mapByQuizAndQuizId[key]!.entries.first.value.attempted);
      final data = [
        GaugePercentage('Score', score),
      ];

      var seriesList = [
        charts.Series<GaugePercentage, String>(
          id: 'Percentage',
          domainFn: (GaugePercentage percentage, _) => percentage.quizName,
          measureFn: (GaugePercentage percentage, _) => percentage.score,
          data: data,
        )
      ];
      chartList.add( Row(
            children: [
              Text(key + '(' + score.toStringAsFixed(0) + '%)'),
           SizedBox(
          height: 100,
          width: 100,
          child: charts.PieChart<String>(seriesList,
              animate: false,
              defaultRenderer: charts.ArcRendererConfig(
                  arcWidth: 10,
                  startAngle: 4 / 5 * pi,
                  arcLength: 7 / 5 * pi)
                  )
           )
                   ]

          )
          );
    }
    );
    return chartList;
  }
}

class GaugePercentage {
  final String quizName;
  final double score;

  GaugePercentage(this.quizName, this.score);
}
