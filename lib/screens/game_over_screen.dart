import 'package:flutter/material.dart';
import 'package:snake_game/main.dart';
import 'package:snake_game/utils/colors.dart';

class GameOver extends StatelessWidget {
  const GameOver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Game-Over',
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.red,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red)),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => const SnakeGame()));
                },
                child: const Text(
                  'Re-start',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
