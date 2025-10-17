import 'package:flutter/material.dart';
import '../utils/app_colors.dart';


class CommonButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color;
  CommonButton({required this.label, required this.onPressed, this.color});


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? AppColors.accent,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(label, style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700)),
    );
  }
}