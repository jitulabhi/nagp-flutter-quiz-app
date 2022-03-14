import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizapp/blocs/question/question-event.dart';
import 'package:quizapp/blocs/question/question-state.dart';
import 'package:quizapp/models/question_option_model.dart';

import '../blocs/question/question-bloc.dart';

// ignore: must_be_immutable
class BuildQuestion extends StatelessWidget {
  late QuestionState _state;
  late int _quizId;

  BuildQuestion(quizId){
    _quizId = quizId;
  }

  @override
  Widget build(BuildContext context) {
    _state = context.read<QuestionBloc>().state;
    return Material(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: Text(
                _state.list[_state.currentIndex].label,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButtonColumn(_state.list[_state.currentIndex].optionA, context),
            _buildButtonColumn(_state.list[_state.currentIndex].optionB, context)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButtonColumn(_state.list[_state.currentIndex].optionC, context),
            _buildButtonColumn(_state.list[_state.currentIndex].optionD, context)
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        BlocBuilder<QuestionBloc, QuestionState>(builder: (_, quizState) {
          //watching the state
          bool finished = quizState.currentIndex == quizState.list.length - 1;

          if (!finished) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNextButtonColumn("NEXT", context),
              ],
            );
          } else {
            return const SizedBox(
              height: 10,
            );
          }
        }),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildFinishButtonColumn("FINISH", context),
          ],
        )
      ]),
    );
  }

  Container _buildButtonColumn(
      QuestionOptionModel option, BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 8),
        child: SizedBox(
          width: 150,
          child: ElevatedButton(
            onPressed: () => BlocProvider.of<QuestionBloc>(context)
                .add(SelectQuestionOption(_quizId, option)),
            child: Text(option.label),
          ),
        ));
  }

  _buildFinishButtonColumn(String label, BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 8),
        child: SizedBox(
          width: 150,
          child: ElevatedButton(
            onPressed: () => BlocProvider.of<QuestionBloc>(context)
                .add(FinishQuestion()),
            child: Text(label),
          ),
        ));
  }

  _buildNextButtonColumn(String label, BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 8),
        child: SizedBox(
          width: 150,
          child: ElevatedButton(
            onPressed: () => BlocProvider.of<QuestionBloc>(context)
                .add(SkipQuestion()),
            child: Text(label),
          ),
        ));
  }
}
