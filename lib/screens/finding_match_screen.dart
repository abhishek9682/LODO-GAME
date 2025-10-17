import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../utils/app_colors.dart'; // create this file for colors if not exist

class FindingMatchScreen extends StatefulWidget {
  const FindingMatchScreen({super.key});

  @override
  State<FindingMatchScreen> createState() => _FindingMatchScreenState();
}

class _FindingMatchScreenState extends State<FindingMatchScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctr;
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    _ctr = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
      setState(() {
        progress = _ctr.value;
      });
    });
    _ctr.forward();

    Timer(const Duration(milliseconds: 2600), () {
      Navigator.pushReplacementNamed(context, '/match');
    });
  }

  @override
  void dispose() {
    _ctr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFEBF6FF), Color(0xFFF9FBFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Finding Match...',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              SizedBox(width: w * 0.6, height: w * 0.6, child: _avatarRing(w * 0.6)),
              const SizedBox(height: 24),
              const Text('Preparing your table', style: TextStyle(color: Colors.black54)),
              const SizedBox(height: 12),
              Container(
                width: w * 0.8,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: FractionallySizedBox(
                  widthFactor: progress,
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              TextButton(
                onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
                child: const Text('Cancel', style: TextStyle(color: Colors.black54)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _avatarRing(double size) {
    return Stack(
      children: [
        Center(
          child: Container(
            width: size * 0.45,
            height: size * 0.45,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFBEE6FF),
            ),
            child: Icon(Icons.videogame_asset,
                size: size * 0.15, color: AppColors.primary),
          ),
        ),
        Positioned(left: 12, top: 8, child: _smallAvatar('https://randomuser.me/api/portraits/men/32.jpg')),
        Positioned(right: 12, top: 8, child: _smallAvatar('https://randomuser.me/api/portraits/women/44.jpg')),
        Positioned(left: 12, bottom: 8, child: _smallAvatar('https://randomuser.me/api/portraits/women/68.jpg')),
        Positioned(right: 12, bottom: 8, child: _smallAvatar('https://randomuser.me/api/portraits/men/76.jpg')),
      ],
    );
  }

  Widget _smallAvatar(String url) {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: ClipOval(child: Image.network(url, fit: BoxFit.cover)),
    );
  }
}
