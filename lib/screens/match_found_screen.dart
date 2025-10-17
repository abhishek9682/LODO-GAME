import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class MatchFoundScreen extends StatefulWidget {
  @override
  _MatchFoundScreenState createState() => _MatchFoundScreenState();
}

class _MatchFoundScreenState extends State<MatchFoundScreen>
    with SingleTickerProviderStateMixin {
  final Random _rnd = Random();
  int dice = 6;
  int countdown = 10;
  Timer? _timer;
  late AnimationController _diceController;
  late Animation<double> _diceAnimation;

  @override
  void initState() {
    super.initState();

    // Dice rotation animation
    _diceController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 800))
      ..repeat(reverse: true);
    _diceAnimation =
        Tween<double>(begin: 0, end: pi * 2).animate(_diceController);

    // Countdown Timer
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (countdown > 0) {
        setState(() {
          countdown--;
          dice = _rnd.nextInt(6) + 1; // Random dice value
        });
      } else {
        t.cancel();
        _diceController.stop();
        // Navigate automatically after countdown
        Future.delayed(Duration(milliseconds: 500), () {
          Navigator.pushReplacementNamed(context, '/game');
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _diceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4FC3F7), Color(0xFF0288D1)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Foreground content
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Title
                Column(
                  children: const [
                    Text(
                      "MATCH FOUND!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Get ready to roll the dice!",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),

                // Player avatars
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildPlayerCard("Rocky", "https://i.pravatar.cc/150?img=3"),
                    Column(
                      children: [
                        RotationTransition(
                          turns: _diceAnimation,
                          child: Image.network(
                            "https://upload.wikimedia.org/wikipedia/commons/1/14/Dice-6-b.svg",
                            height: size.width * 0.2,
                            width: size.width * 0.2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Dice: $dice",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    _buildPlayerCard("Julie", "https://i.pravatar.cc/150?img=5"),
                  ],
                ),

                // Countdown timer display
                Column(
                  children: [
                    Text(
                      "Starting in",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    Text(
                      "$countdown s",
                      style: TextStyle(
                        fontSize: 42,
                        color: Colors.yellowAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                // Cancel button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding:
                    EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    _timer?.cancel();
                    _diceController.stop();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerCard(String name, String imgUrl) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(imgUrl),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
