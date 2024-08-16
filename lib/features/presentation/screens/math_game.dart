import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math';

import 'package:intership_test_studyoio/features/presentation/styles/color_style.dart';

class MathGamePage extends StatefulWidget {
  @override
  _MathGamePageState createState() => _MathGamePageState();
}

class _MathGamePageState extends State<MathGamePage> {
  int firstNumber = 0;
  int secondNumber = 0;
  int answer = 0;
  int selectedNumber = -1;
  int attempts = 2;
  int wrongAttempts = 0;
  bool isCorrect = false;
  bool isAnswered = false;
  bool isGameOver = false;

  Offset? startPosition;
  Offset? endPosition;

  final GlobalKey _answerKey = GlobalKey();
  final List<GlobalKey> _numberKeys = List.generate(10, (index) => GlobalKey());

  @override
  void initState() {
    super.initState();
    _generateNewProblem();
  }

  void _generateNewProblem() {
    final random = Random();
    firstNumber = random.nextInt(10);
    secondNumber = random.nextInt(10);
    answer = firstNumber + secondNumber;

    if (answer >= 10) {
      _generateNewProblem();
      return;
    }

    isCorrect = false;
    selectedNumber = -1;
    wrongAttempts = 0;
    attempts = 2;
    isAnswered = false;
    isGameOver = false;
    startPosition = null;
    endPosition = null;

    setState(() {});
  }

  void _updatePositions() {
    RenderBox renderBoxAnswer =
        _answerKey.currentContext?.findRenderObject() as RenderBox;
    Offset answerPosition = renderBoxAnswer.localToGlobal(Offset.zero) +
        Offset(
            renderBoxAnswer.size.width / 10, renderBoxAnswer.size.height / 10);

    setState(() {
      endPosition = answerPosition;

      if (selectedNumber >= 0) {
        RenderBox renderBoxNumber = _numberKeys[selectedNumber]
            .currentContext
            ?.findRenderObject() as RenderBox;
        Offset numberPosition = renderBoxNumber.localToGlobal(Offset.zero) +
            Offset(renderBoxNumber.size.width / 10,
                renderBoxNumber.size.height / 10);

        startPosition = numberPosition;
      }
    });
  }

  void _checkAnswer() {
    _updatePositions();
    if (isGameOver) return;

    setState(() {
      isAnswered = true;
      if (selectedNumber == answer) {
        isCorrect = true;
        _showCorrectAnswerDialog();
      } else {
        isCorrect = false;
        wrongAttempts++;
        attempts--;

        if (wrongAttempts >= 2) {
          isGameOver = true;
          _showGameOverDialog();
        } else {
          _showIncorrectAnswerDialog();
        }
      }
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
                _generateNewProblem();
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
          onPressed: _generateNewProblem,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            2,
            (index) => Icon(
              index < wrongAttempts ? Icons.star_border : Icons.star,
              color: index < wrongAttempts ? Colors.red : Colors.green,
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
                  "$firstNumber + $secondNumber",
                  style: const TextStyle(fontSize: 40, color: Colors.blue),
                ),
                SizedBox(height: 20),
                DragTarget<int>(
                  key: _answerKey,
                  onAccept: (data) {
                    setState(() {
                      if (!isGameOver) selectedNumber = data;
                      _updatePositions();
                      startPosition = null;
                      endPosition = null;
                    });
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isAnswered
                              ? (isCorrect ? Colors.green : Colors.red)
                              : Colors.grey,
                          width: 2,
                        ),
                      ),
                      child: Text(
                        selectedNumber == -1 ? "?" : "$selectedNumber",
                        style: TextStyle(
                          fontSize: 40,
                          color: isAnswered
                              ? (isCorrect ? Colors.green : Colors.red)
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
                            startPosition = null;
                            endPosition = null;
                          });
                        },
                        onDragUpdate: (details) {
                          setState(() {
                            if (startPosition == null) {
                              _updatePositions();
                            }
                            startPosition = details.globalPosition;
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
                            startPosition = null;
                            endPosition = null;
                          });
                        },
                        onDragUpdate: (details) {
                          setState(() {
                            if (startPosition == null) {
                              _updatePositions();
                            }
                            startPosition = details.globalPosition;
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
                  onPressed: () {
                    _checkAnswer();
                  },
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
            painter: LinePainter(startPosition, endPosition),
          ),
        ],
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final Offset? startPosition;
  final Offset? endPosition;

  LinePainter(this.startPosition, this.endPosition);

  @override
  void paint(Canvas canvas, Size size) {
    if (startPosition != null && endPosition != null) {
      final paint = Paint()
        ..color = Colors.cyan
        ..strokeWidth = 4.0
        ..strokeCap = StrokeCap.round;

      // Draw line
      canvas.drawLine(startPosition!, endPosition!, paint);

      // Draw arrowhead
      final arrowHeadPaint = Paint()
        ..color = Colors.cyan
        ..style = PaintingStyle.fill;

      // Calculate the angle of the line
      final dx = endPosition!.dx - startPosition!.dx;
      final dy = endPosition!.dy - startPosition!.dy;
      final angle = atan2(dy, dx);

      final arrowSize = 20.0;

      final arrowHeadPath = Path()
        ..moveTo(endPosition!.dx, endPosition!.dy)
        ..lineTo(
          endPosition!.dx - arrowSize * cos(angle - pi / 6),
          endPosition!.dy - arrowSize * sin(angle - pi / 6),
        )
        ..lineTo(
          endPosition!.dx - arrowSize * cos(angle + pi / 6),
          endPosition!.dy - arrowSize * sin(angle + pi / 6),
        )
        ..close();

      canvas.drawPath(arrowHeadPath, arrowHeadPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
