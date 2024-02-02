import 'package:flutter/material.dart';

class CustomOrWidget extends StatelessWidget {
  const CustomOrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, left: 12),
      child: Row(
        children: [
          Container(
            color: const Color(0xffE5E7EB),
            width: 140,
            height: 1.0,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "OR",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xffA1A8B0)),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            color: const Color(0xffE5E7EB),
            width: 140,
            height: 1.0,
          ),
        ],
      ),
    );
  }
}
