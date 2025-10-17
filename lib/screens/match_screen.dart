import 'dart:math';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class MatchScreen extends StatefulWidget {
  const MatchScreen({super.key});

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  int diceValue = 1;
  final Random _random = Random();

  void rollDice() {
    setState(() {
      diceValue = _random.nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double boardSize = MediaQuery.of(context).size.width * 0.9;
    final double cellSize = boardSize / 3;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F8FF),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text("Ludo Board", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🎲 Ludo Board
            Container(
              width: boardSize,
              height: boardSize,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        _buildHomeCell(Colors.red),
                        _buildPathCell(),
                        _buildHomeCell(Colors.green),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        _buildPathCell(),
                        _buildCenterCell(),
                        _buildPathCell(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        _buildHomeCell(Colors.yellow),
                        _buildPathCell(),
                        _buildHomeCell(Colors.blue),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // 🎲 Dice display
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    '🎲 Dice: $diceValue',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: rollDice,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      'ROLL DICE',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeCell(Color color) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.8),
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: const Center(
          child: Icon(Icons.home, color: Colors.white, size: 32),
        ),
      ),
    );
  }

  Widget _buildPathCell() {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: const Center(
          child: Icon(Icons.circle, color: Colors.grey, size: 14),
        ),
      ),
    );
  }

  Widget _buildCenterCell() {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: const Center(
          child: Text('★',
              style: TextStyle(fontSize: 30, color: Colors.black54)),
        ),
      ),
    );
  }
}
