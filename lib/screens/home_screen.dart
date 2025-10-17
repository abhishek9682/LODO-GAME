import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/common_button.dart';


class HomeScreen extends StatelessWidget {
  final double paddingH = 20;
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Challenge & Connect', style: TextStyle(color: Colors.black87)),
        actions: [Padding(padding: EdgeInsets.only(right: 12), child: CircleAvatar(backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/12.jpg')))],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text('Play Ludo with friends', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            SizedBox(height: 18),
            Expanded(
              child: ListView(
                children: [
                  _promoCard(context, 'Khelo Aur Jeeto!', 'Win coins & unlock 1:1 audio', 50),
                  SizedBox(height: 14),
                  _promoCard(context, 'Fast Match', 'Quick 1v1 challenge', 20),
                  SizedBox(height: 14),
                  _promoCard(context, 'Tournament', 'Weekly leaderboard', 100),
                ],
              ),
            ),
            Center(child: Text('Designed for demo • Flutter UI', style: TextStyle(color: Colors.black45))),
            SizedBox(height: 16)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.accent,
        onPressed: () => Navigator.pushNamed(context, '/loading'),
        child: Icon(Icons.play_arrow, color: Colors.black87),
      ),
    );
  }


  Widget _promoCard(BuildContext ctx, String title, String subtitle, int coins) {
    return GestureDetector(
        onTap: () => Navigator.pushNamed(ctx, '/loading'),
        child: Container(
            decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0,6))]),
            padding: EdgeInsets.all(14),
            child: Row(children: [
              Container(width: 64, height: 64, decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF6AD3FF), Color(0xFF3E92FF)]), borderRadius: BorderRadius.circular(12)), child: Icon(Icons.games, color: Colors.white, size: 30)),
              SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: TextStyle(fontWeight: FontWeight.bold)), SizedBox(height: 6), Text(subtitle, style: TextStyle(color: Colors.black54))])),
              Column(children: [Container(padding: EdgeInsets.symmetric(horizontal:8, vertical:6), decoration: BoxDecoration(color: Color(0xFFFFF3D6), borderRadius: BorderRadius.circular(8)), child: Row(children: [Icon(Icons.monetization_on, size: 14), SizedBox(width:6), Text('$coins')])) , SizedBox(height:8), CommonButton(label: 'Play', onPressed: () => Navigator.pushNamed(ctx, '/loading'))])
            ]
            ),
        )
        );
            }
}