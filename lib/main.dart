import 'package:flutter/material.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class Question {
  final String questionText;
  final bool answer;

  Question({required this.questionText, required this.answer});
}

class _QuizPageState extends State<QuizPage> {
  @override
  List<Widget> scoreKeeper = [];
  int questionNumber = 0;
  List<Question> questions = [
    Question(
        questionText: 'You can lead a cow down stairs but not up stairs.',
        answer: false),
    Question(
        questionText:
            'Approximately one quarter of human bones are in the feet.',
        answer: true),
    Question(questionText: 'A slug\'s blood is green.', answer: true),
  ];
  bool checkAnswer({required bool userAnswer, required int questionNumber}) {
    bool questionAnswer = questions[questionNumber].answer;
    if (userAnswer == questionAnswer) {
      return true;
    }
    return false;
  }

  void evaluate(bool userAnswer) {
    setState(() {
      if (checkAnswer(userAnswer: userAnswer, questionNumber: questionNumber)) {
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
        questionNumber < questions.length - 1
            ? questionNumber++
            : questionNumber = 0;
      } else {
        scoreKeeper.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
        questionNumber < questions.length - 1
            ? questionNumber++
            : questionNumber = 0;
      }
    });

    print('the question number $questionNumber');
    print('the question number ${questions.length}');
  }

  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                // 'This is where the question text will go.',
                questions[questionNumber].questionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.green,
                child: const Center(
                  child: Text(
                    'True',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              onPressed: () {
                //The user picked true.
                evaluate(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.red,
                child: const Center(
                  child: Text(
                    'False',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              onPressed: () {
                //The user picked false.
                evaluate(false);
              },
            ),
          ),
        ),
        Expanded(
            child: Row(
          children: scoreKeeper,
        ))
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
