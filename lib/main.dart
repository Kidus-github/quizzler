import 'package:flutter/material.dart';
import 'package:quizzler/QuizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

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

class _QuizPageState extends State<QuizPage> {
  @override
  List<Widget> scoreKeeper = [];
  int questionNumber = 0;
  int numberOfCorrectAnswers = 0;
  void evaluate(bool userAnswer) {
    setState(() {
      if (quizBrain.checkAnswer(userAnswer: userAnswer)) {
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
        numberOfCorrectAnswers++;
      } else {
        scoreKeeper.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
      quizBrain.nextQuestion()
          ? null
          : Alert(
              context: context,
              type: AlertType.success,
              title: "DONE",
              desc:
                  "You have Scored $numberOfCorrectAnswers out of ${quizBrain.getTotalNumberOfQuestions()}",
              buttons: [
                DialogButton(
                  child: Text(
                    "Restart",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    setState(() {
                      quizBrain.restart();
                      numberOfCorrectAnswers = 0;
                      scoreKeeper = [];
                    });
                    print("Done");
                    Navigator.pop(context);
                  },
                  width: 120,
                )
              ],
            ).show();
    });
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
                quizBrain.getQuestionText(),
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
