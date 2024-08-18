import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intership_test_studyoio/features/data/math_game_logic.dart';
import 'package:intership_test_studyoio/features/presentation/styles/color_style.dart';
import 'package:intership_test_studyoio/features/presentation/widgets/line_painter.dart';


class MathGamePage extends StatefulWidget {
  @override
  _MathGamePageState createState() => _MathGamePageState();
}

class _MathGamePageState extends State<MathGamePage> {
  late MathGameLogic _gameLogic;

  final GlobalKey _answerKey = GlobalKey();
  final List<GlobalKey> _numberKeys = List.generate(10, (index) => GlobalKey());
  bool isDragged = false; // Tambahkan flag isDragged

  @override
  void initState() {
    super.initState();
    _gameLogic = MathGameLogic(onProblemGenerated: _updateUI);
    _gameLogic.generateNewProblem();
  }

  void _updateUI() {
    setState(() {
      isDragged = false; // Reset flag saat soal baru di-generate
    });
  }

  void _updatePositions() {
    _gameLogic.updatePositions(_answerKey, _numberKeys);
    setState(() {});
  }

  void _checkAnswer() {
    _updatePositions();
    if (_gameLogic.isGameOver) return;

    setState(() {
      _gameLogic.checkAnswer(_showCorrectAnswerDialog, _showIncorrectAnswerDialog, _showGameOverDialog);
    });
  }

  void _showCorrectAnswerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Correct!"),
          content: Text("Great job! The answer is correct."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                _gameLogic.generateNewProblem();
              },
            ),
          ],
        );
      },
    );
  }

  void _showIncorrectAnswerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Incorrect"),
          content: Text("Oops! That's not correct. Try again."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Game Over"),
          content: Text(
              "You've made 2 incorrect attempts. Please refresh to try again."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.backgroundMathgame,
      appBar: AppBar(
        backgroundColor: ColorStyle.appbarMathgame,
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.refresh),
          onPressed: _gameLogic.generateNewProblem,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            2,
            (index) => Icon(
              index < _gameLogic.wrongAttempts ? Icons.star_border : Icons.star,
              color: index < _gameLogic.wrongAttempts ? Colors.red : Colors.green,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${_gameLogic.firstNumber} + ${_gameLogic.secondNumber}",
                  style: const TextStyle(fontSize: 40, color: Colors.blue),
                ),
                SizedBox(height: 20),
                DragTarget<int>(
                  key: _answerKey,
                  onAccept: (data) {
                    setState(() {
                      if (!_gameLogic.isGameOver) {
                        _gameLogic.selectedNumber = data;
                        isDragged = true; // Set flag setelah angka di-drag
                        _updatePositions();
                      }
                    });
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _gameLogic.isAnswered
                              ? (_gameLogic.isCorrect ? Colors.green : Colors.red)
                              : Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        _gameLogic.selectedNumber == -1 ? "?" : "${_gameLogic.selectedNumber}",
                        style: TextStyle(
                          fontSize: 40,
                          color: _gameLogic.isAnswered
                              ? (_gameLogic.isCorrect ? Colors.green : Colors.red)
                              : Colors.white,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 60.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Draggable<int>(
                        key: _numberKeys[index],
                        data: index,
                        onDragStarted: () {
                          setState(() {
                            isDragged = false; // Reset flag saat drag dimulai
                            _gameLogic.resetPositions();
                          });
                        },
                        onDragUpdate: (details) {
                          setState(() {
                            if (_gameLogic.startPosition == null) {
                              _updatePositions();
                            }
                            _gameLogic.startPosition = details.globalPosition;
                          });
                        },
                        feedback: Material(
                          color: Colors.transparent,
                          child: Text(
                            "$index",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                        childWhenDragging: Container(),
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: ColorStyle.buttonMathgame,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "$index",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Draggable<int>(
                        key: _numberKeys[index + 5],
                        data: index + 5,
                        onDragStarted: () {
                          setState(() {
                            isDragged = false; // Reset flag saat drag dimulai
                            _gameLogic.resetPositions();
                          });
                        },
                        onDragUpdate: (details) {
                          setState(() {
                            if (_gameLogic.startPosition == null) {
                              _updatePositions();
                            }
                            _gameLogic.startPosition = details.globalPosition;
                          });
                        },
                        feedback: Material(
                          color: Colors.transparent,
                          child: Text(
                            "${index + 5}",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                        childWhenDragging: Container(),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: ColorStyle.buttonMathgame,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "${index + 5}",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _checkAnswer,
                  child: Icon(Icons.check, size: 30.sp, color: Colors.red),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorStyle.buttonMathgame,
                    minimumSize: Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                )
              ],
            ),
          ),
          CustomPaint(
            painter: LinePainter(_gameLogic.startPosition, _gameLogic.endPosition, isDragged: isDragged),
          ),
        ],
      ),
    );
  }
}

