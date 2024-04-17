import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final double initialRating;
  final double starSize;
  final ValueChanged<double>? onChanged;

  const StarRating({
    Key? key,
    this.initialRating = 0,
    this.starSize = 20.0,
    this.onChanged,
  }) : super(key: key);

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  late double starRating;

  @override
  void initState() {
    super.initState();
    starRating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _buildStarRating(),
    );
  }

  List<Widget> _buildStarRating() {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      stars.add(
        GestureDetector(
          onTap: () {
            setState(() {
              starRating = i.toDouble();
              if (widget.onChanged != null) {
                widget.onChanged!(starRating);
              }
            });
          },
          child: Icon(
            Icons.star,
            color: i <= (starRating) ? Colors.amber : Colors.grey,
            size: widget.starSize,
          ),
        ),
      );
    }
    return stars;
  }
}
