import 'package:flutter/material.dart';
import 'package:quizapp/answer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Icon> _scoreTracker = [];
  int _questionIndex = 0;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool endofQuiz = false;
  bool correctAnswerWasSelected = false;
  void _questionsAnswered(answerScore) {
    setState(() {
      //answer was selected
      answerWasSelected = true;
      //check if answer was correct
      if (answerScore) {
        _totalScore++;
        correctAnswerWasSelected = true;
      }
      //adding to the score tracker on top
      _scoreTracker.add(
        answerScore
            ? Icon(Icons.check_circle, color: Colors.green)
            : Icon(
                Icons.cancel_rounded,
                color: Colors.red,
              ),
      );
      // when the quiz ends
      if (_questionIndex + 1 == _questions.length) {
        endofQuiz = true;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex++;
      answerWasSelected = false;
      correctAnswerWasSelected = false;
    });
    //what happens at the end of the quiz
    if (_questionIndex >= _questions.length) {
      _resetQuiz();
    }
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _scoreTracker = [];
      endofQuiz = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Quiz'),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                if (_scoreTracker.length == 0)
                  SizedBox(
                    height: 25,
                  ),
                if (_scoreTracker.length > 0) ..._scoreTracker
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 130.0,
              margin: EdgeInsets.only(bottom: 10, left: 30, right: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                //deepOrange,
              ),
              child: Center(
                child: Text(
                  _questions[_questionIndex]['question'].toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    //white
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ...(_questions[_questionIndex]['answer']
                    as List<Map<String, Object>>)
                .map((answer) => Answer(
                      answerText: answer['answerText'].toString(),
                      answerColor: answerWasSelected
                          ? (answer['score'] == true
                              ? Colors.green
                              : Colors.red)
                          : Colors.transparent,
                      answerTap: () {
                        //if answer was alredy selected then notthing happen on the ontap
                        if (answerWasSelected) {
                          return;
                        }
                        _questionsAnswered(answer['score']);
                        //
                      },
                    )),
            SizedBox(height: 20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(80, 40.0),
                ),
                onPressed: () {
                  if (!answerWasSelected) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'Please select the answer before going to the next question')));
                    return;
                  }
                  _nextQuestion();
                },
                child: Text(endofQuiz ? 'Restart Quiz' : 'Next question')),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                '${_totalScore.toString()}/${_questions.length}',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            if (answerWasSelected)
              Container(
                height: 50,
                width: double.infinity,
                color: correctAnswerWasSelected ? Colors.green : Colors.red,
                child: Center(
                  child: Text(
                    correctAnswerWasSelected
                        ? 'Well done, you got right!'
                        : 'wrong',
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

final _questions = [
  {
    'question': '1.What is Flutter?',
    'answer': [
      {'answerText': 'A:Flutter is an open-source UI toolkit', 'score': true},
      {'answerText': 'B:Flutter is an opne-source DBMS', 'score': false},
      {
        'answerText': 'C:Flutter is an opne-source backend toolkit ',
        'score': false
      }
    ],
  },
  {
    'question': '2.The first alpha version of flutter was released in ?',
    'answer': [
      {'answerText': 'A:May 2016', 'score': false},
      {'answerText': 'B:May 2017', 'score': true},
      {'answerText': 'C:May 2018', 'score': false}
    ],
  },
  {
    'question': '3.Flutter is developed by ?',
    'answer': [
      {'answerText': 'A:Microsoft', 'score': false},
      {'answerText': 'B:Facebook', 'score': false},
      {'answerText': 'C:Google', 'score': true}
    ],
  },
  {
    'question': '4.Is Flutter a SDK ?',
    'answer': [
      {'answerText': 'A:No', 'score': false},
      {'answerText': 'B:Can not say', 'score': false},
      {'answerText': 'C:Yes', 'score': true}
    ],
  },
  {
    'question': '5.What is Dart ?',
    'answer': [
      {
        'answerText': 'A:Dart is a object-oriented programming languege.',
        'score': false
      },
      {
        'answerText': 'B:Dart is used to create frontend user intefaces.',
        'score': false,
      },
      {'answerText': 'C:Both are correct', 'score': true}
    ],
  },
  {
    'question': '6.How many types of widgets are there in Flutter ?',
    'answer': [
      {'answerText': 'A:4', 'score': false},
      {'answerText': 'B:2', 'score': true},
      {'answerText': 'C:6', 'score': false}
    ],
  },
  {
    'question': '7.WidgetsApp is used for basic navigation?',
    'answer': [
      {'answerText': 'A:Yes', 'score': true},
      {'answerText': 'B:No', 'score': false},
      {'answerText': 'C:Can not say', 'score': false}
    ],
  },
  {
    'question': '8.A Widget that allows to refresh the screen is called a ?',
    'answer': [
      {'answerText': 'A:Statebuild widgets', 'score': false},
      {'answerText': 'B:Stateless widget', 'score': false},
      {'answerText': 'C:Stateful widget', 'score': true}
    ],
  },
  {
    'question':
        '9.How many child widgets can be added to the Container Widgets?',
    'answer': [
      {'answerText': 'A:Unlimitted', 'score': false},
      {'answerText': 'B:1', 'score': true},
      {'answerText': 'C:3', 'score': false}
    ],
  }
];
