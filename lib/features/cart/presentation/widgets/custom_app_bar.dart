import 'package:flutter/material.dart';
import 'package:medcs/core/utlity/styles.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final VoidCallback onDeletePressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight, // Use the same height as AppBar
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      color: Colors.white, // Customize the background color
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 120),
            child: Text(
              title,
              style: StylesLight.bodyLarge17,
            ),
          ),
          IconButton(
            onPressed: onDeletePressed,
            icon: const Icon(Icons.delete),
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
