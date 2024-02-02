import 'package:flutter/material.dart';

class QuantityBottomSheet extends StatelessWidget {
  const QuantityBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 6,
            width: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: Colors.grey),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              // physics: const NeverScrollableScrollPhysics(),
              itemCount: 20,
              // shrinkWrap: true,
              itemBuilder: (context, index) => InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "${index + 1}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
