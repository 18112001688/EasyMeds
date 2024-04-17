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
      double fractionalRating = starRating - i + 1;
      IconData starIcon;
      Color starColor;

      // Determine the icon and color based on the fractional part of the rating
      if (fractionalRating >= 0.75) {
        starIcon = Icons.star;
        starColor = Colors.amber;
      } else if (fractionalRating >= 0.25) {
        starIcon = Icons.star_half;
        starColor = Colors.amber;
      } else {
        starIcon = Icons.star_border;
        starColor = Colors.grey;
      }

      stars.add(
        GestureDetector(
          onTap: () {
            setState(() {
              // Calculate the new rating
              starRating = i.toDouble();
              if (widget.onChanged != null) {
                widget.onChanged!(starRating);
              }
            });
          },
          child: Icon(
            starIcon,
            color: starColor,
            size: widget.starSize,
          ),
        ),
      );
    }
    return stars;
  }
}
