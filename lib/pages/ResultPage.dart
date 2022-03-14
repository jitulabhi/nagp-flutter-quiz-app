import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/result/result-bloc.dart';
import '../blocs/result/result-event.dart';
import '../blocs/result/result-state.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return BlocProvider(create: (_) => ResultBloc()..add(LoadResult()),
    child: Scaffold(
        body: 
          BlocBuilder<ResultBloc, ResultState>(builder: (context, state) {
            return Text("close");
  })
    )
    );

  }

}