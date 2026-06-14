import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RouteErrorScreen extends StatelessWidget {
  final String message;

  const RouteErrorScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('خطأ في المسار')),
      body: Center(
        child: Text(
          message.isNotEmpty ? message : 'عذراً، هذه الشاشة غير موجودة!',
          // 'عذراً، هذه الشاشة غير موجودة!',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}