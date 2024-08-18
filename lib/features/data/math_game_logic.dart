import 'dart:math';
import 'package:flutter/material.dart';

class MathGameLogic {
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

  final VoidCallback onProblemGenerated;

  MathGameLogic({required this.onProblemGenerated});

  void generateNewProblem() {
    final random = Random();
    firstNumber = random.nextInt(10);
    secondNumber = random.nextInt(10);
    answer = firstNumber + secondNumber;

    if (answer >= 10) {
      generateNewProblem();
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

    onProblemGenerated();
  }

  void updatePositions(GlobalKey answerKey, List<GlobalKey> numberKeys) {
    RenderBox renderBoxAnswer =
        answerKey.currentContext?.findRenderObject() as RenderBox;
    Offset answerPosition = renderBoxAnswer.localToGlobal(Offset.zero) +
        Offset(renderBoxAnswer.size.width / 10, renderBoxAnswer.size.height / 10);

    endPosition = answerPosition;

    if (selectedNumber >= 0) {
      RenderBox renderBoxNumber = numberKeys[selectedNumber]
          .currentContext
          ?.findRenderObject() as RenderBox;
      Offset numberPosition = renderBoxNumber.localToGlobal(Offset.zero) +
          Offset(renderBoxNumber.size.width / 10,
              renderBoxNumber.size.height / 10);

      startPosition = numberPosition;
    }
  }

  void checkAnswer(VoidCallback onCorrect, VoidCallback onIncorrect, VoidCallback onGameOver) {
    isAnswered = true;
    if (selectedNumber == answer) {
      isCorrect = true;
      onCorrect();
    } else {
      isCorrect = false;
      wrongAttempts++;
      attempts--;

      if (wrongAttempts >= 2) {
        isGameOver = true;
        onGameOver();
      } else {
        onIncorrect();
      }
    }
  }

  void resetPositions() {
    startPosition = null;
    endPosition = null;
  }
}
