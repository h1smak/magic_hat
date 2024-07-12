import 'package:flutter/material.dart';

class StatBox extends StatelessWidget {
  final String title;
  final int value;

  const StatBox({
    required this.title,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value.toString(), style: const TextStyle(fontSize: 24)),
          Text(title, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
