import 'package:flutter/material.dart';

class StarRatingReadOnly extends StatelessWidget {
  final double initialRating;
  final double starSize;

  const StarRatingReadOnly({
    Key? key,
    this.initialRating = 0,
    this.starSize = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _buildStarRating(),
    );
  }

  List<Widget> _buildStarRating() {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      double fractionalRating = initialRating - i + 1;
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
        Icon(
          starIcon,
          color: starColor,
          size: starSize,
        ),
      );
    }
    return stars;
  }
}
