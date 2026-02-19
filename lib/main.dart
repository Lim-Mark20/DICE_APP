import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
void main() {
  runApp(const DiceApp());
}

class DiceApp extends StatelessWidget {
  const DiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice App',
      debugShowCheckedModeBanner: false,
      home: const DiceHomePage(),
    );
  }
}

class DiceHomePage extends StatefulWidget {
  const DiceHomePage({super.key});

  @override
  State<DiceHomePage> createState() => _DiceHomePageState();
}

class _DiceHomePageState extends State<DiceHomePage> {
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void rollDice() {
    setState(() {
      leftDiceNumber = Random().nextInt(6) + 1;
      rightDiceNumber = Random().nextInt(6) + 1;
      if (leftDiceNumber + rightDiceNumber == 7) {
        _confettiController.play();
      }
    });
  }

  Color getColorForTotal(int total) {
    if (total < 6) {
      return Colors.red;
    } else if (total == 6) {
      return Colors.yellow;
    } else {
      return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Dice App'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/dice$leftDiceNumber.png', width: 140, height: 100),
                    const SizedBox(width: 20),
                    Image.asset('assets/images/dice$rightDiceNumber.png', width: 140, height: 100),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Total: ${leftDiceNumber + rightDiceNumber}',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: getColorForTotal(leftDiceNumber + rightDiceNumber),
                      ),
                    ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: rollDice,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: const Text('Roll Dice', style: TextStyle(fontSize: 20)),
                ),
                const SizedBox(height: 20),
                if (leftDiceNumber + rightDiceNumber == 7)
                  const Text(
                    'Congrats you win the jackpot',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                  ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              particleDrag: 0.05,
              emissionFrequency: 0.05,
              numberOfParticles: 50,
              gravity: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}
