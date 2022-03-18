import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _barChart(state)),
              const SizedBox(
                height: 50,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _gaugeChart(state))
            ],
          );
        })));
  }

  List<Widget> _barChart(ResultState state) {
    return [
      Container(
        height: 300,
        //margin: const EdgeInsets.only(bottom: 50),
        child: charts.BarChart(_barChartSeriesList(state),
            animate: false, barGroupingType: charts.BarGroupingType.grouped),
        constraints: const BoxConstraints(maxHeight: 300, maxWidth: 300),
      )
    ];
  }

  List<charts.Series<BarChartModel, String>>
      _barChartSeriesList(ResultState state) {
    var quizNames = state.mapByQuizAndQuizId.keys.toList();

    final List<BarChartModel> attemptedData = [];
    final List<BarChartModel> correctData = [];
    final List<BarChartModel> incorrectData = [];

    quizNames.forEach((key) {
      attemptedData.add(BarChartModel(
          key, state.mapByQuizAndQuizId[key]!.entries.first.value.attempted));
      correctData.add(BarChartModel(
          key, state.mapByQuizAndQuizId[key]!.entries.first.value.correct));
      incorrectData.add(BarChartModel(
          key, state.mapByQuizAndQuizId[key]!.entries.first.value.incorrect));
    });

    return [
      charts.Series<BarChartModel, String>(
        id: 'Attempted',
        domainFn: (BarChartModel model, _) => model.quizName,
        measureFn: (BarChartModel model, _) => model.count,
        data: attemptedData,
        colorFn: (BarChartModel model, _) =>
            charts.ColorUtil.fromDartColor(Colors.green),
      ),
      charts.Series<BarChartModel, String>(
        id: 'Correct',
        domainFn: (BarChartModel model, _) => model.quizName,
        measureFn: (BarChartModel model, _) => model.count,
        data: correctData,
        colorFn: (BarChartModel model, _) =>
            charts.ColorUtil.fromDartColor(Colors.blue),
      ),
      charts.Series<BarChartModel, String>(
        id: 'Incorrect',
        domainFn: (BarChartModel model, _) => model.quizName,
        measureFn: (BarChartModel model, _) => model.count,
        data: incorrectData,
        colorFn: (BarChartModel model, _) =>
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
      chartList.add(Column(children: [
        Text(key + '(' + score.toStringAsFixed(0) + '%)'),
        SizedBox(
            height: 100,
            width: 100,
            child: charts.PieChart<String>(seriesList,
                animate: false,
                defaultRenderer: charts.ArcRendererConfig(
                    arcWidth: 10,
                    startAngle: 4 / 5 * pi,
                    arcLength: 7 / 5 * pi)))
      ]));
    });
    return chartList;
  }
}

class GaugePercentage {
  final String quizName;
  final double score;

  GaugePercentage(this.quizName, this.score);
}


class BarChartModel {
  late String _quizName;
  late int _count;

  String get quizName => _quizName;
  int get count => _count;

  BarChartModel(String quizName, int count) {
    this._quizName = quizName;
    this._count = count;
  }
}
