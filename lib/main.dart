import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'screens/game_over_screen.dart';
import 'utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const SnakeGame(),
    );
  }
}

class SnakeGame extends StatefulWidget {
  const SnakeGame({Key? key}) : super(key: key);

  @override
  State<SnakeGame> createState() => _SnakeGameState();
}

class _SnakeGameState extends State<SnakeGame> {
  static List<int> snakePosition = [45, 65, 85, 105, 125];
  int numberOfSquares = 680;
  static var randomNumber = Random();
  int foodPosition = randomNumber.nextInt(680);

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void getNewFood() {
    setState(() {
      foodPosition = randomNumber.nextInt(680);
    });
  }

  void startGame() {
    snakePosition = [45, 65, 85, 105, 125];
    const duration = Duration(milliseconds: 300);
    Timer.periodic(duration, (Timer timer) {
      updateSnake();
      if (gameOver()) {
        timer.cancel();
        _showGameOverScreen();
      }
    });
  }

  void _showGameOverScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (builder) => GameOver()));
  }

  var direction = 'right';
  void updateSnake() {
    setState(() {
      switch (direction) {
        case 'down':
          if (snakePosition.last > 680) {
            snakePosition.add(snakePosition.last + 20 - 680);
          } else {
            snakePosition.add(snakePosition.last + 20);
          }
          break;
        case 'up':
          if (snakePosition.last < 20) {
            snakePosition.add(snakePosition.last - 20 + 680);
          } else {
            snakePosition.add(snakePosition.last - 20);
          }
          break;
        case 'right':
          if ((snakePosition.last + 1) % 20 == 0) {
            snakePosition.add(snakePosition.last + 1 - 20);
          } else {
            snakePosition.add(snakePosition.last + 1);
          }
          break;
        case 'left':
          if (snakePosition.last % 20 == 0) {
            snakePosition.add(snakePosition.last - 1 + 20);
          } else {
            snakePosition.add(snakePosition.last - 1);
          }
          break;

        default:
      }

      if (snakePosition.last == foodPosition) {
        getNewFood();
      } else {
        snakePosition.removeAt(0);
      }
    });
  }

  bool gameOver() {
    Map map = {};
    for (var i in snakePosition) {
      if (map.containsKey(i)) {
        return true;
      } else {
        map[i] = 0;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: background,
        body: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  if (direction != 'up' && details.delta.dy > 0) {
                    direction = 'down';
                  } else if (direction != 'down' && details.delta.dy < 0) {
                    direction = 'up';
                  }
                },
                onHorizontalDragUpdate: (details) {
                  if (direction != 'left' && details.delta.dx > 0) {
                    direction = 'right';
                  } else if (direction != 'right' && details.delta.dx < 0) {
                    direction = 'left';
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: numberOfSquares,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 20),
                    itemBuilder: (context, index) {
                      if (snakePosition.contains(index)) {
                        return Container(
                          margin: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: snake,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        );
                      }
                      if (index == foodPosition) {
                        return Container(
                          margin: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: food,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        );
                      }
                      return Container(
                        margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: grid,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
