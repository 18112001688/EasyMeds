import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:medcs/core/constent/colors.dart';
import 'package:medcs/core/utlity/start_rating_read_only.dart';
import 'package:medcs/core/utlity/styles.dart';
import 'package:medcs/features/home/data/models/review_mode.dart';
import 'package:medcs/features/splash/prsentation/widgets/primary_button.dart';

class ReviewsView extends StatefulWidget {
  const ReviewsView({super.key, required this.productId});
  final String productId;

  @override
  State<ReviewsView> createState() => _ReviewsViewState();
}

class _ReviewsViewState extends State<ReviewsView> {
  double? starRating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Reviews',
          style: StylesLight.bodyLarge17,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('UsersReview')
              .where('ProductID', isEqualTo: widget.productId)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child:
                      Text('An error occurred! ${snapshot.error.toString()}'));
            } else {
              final reviews = snapshot.data!.docs
                  .map((doc) => ReviewModel.fromFireStore(doc))
                  .toList();

              // Calculate average star rating
              final totalRatings = reviews.fold<double>(0,
                  (previousValue, element) => previousValue + (element.rating));
              starRating = totalRatings / reviews.length;

              // if (reviews.isEmpty) {
              //   // Display message when there are no reviews
              //   return const Center(
              //     child: Text('No reviews for this product.'),
              //   );
              // }

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                '${reviews.length} Reviews',
                                style: StylesLight.bodyMeduim15,
                              ),
                              Row(
                                children: [
                                  Text(starRating.toString()),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Row(
                                    children: [
                                      StarRatingReadOnly(
                                        initialRating: starRating ?? 0,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          CustomPrimaryButton(
                              label: 'Add Review',
                              onPressed: () {
                                GoRouter.of(context).push('/AddReviewView',
                                    extra: widget.productId);
                              },
                              color: AppColors.secondryOrange,
                              borderRadius: 5,
                              height: 35,
                              width: 125,
                              borderColor: AppColors.secondryOrange,
                              labelColor: Colors.white,
                              fontSize: 13)
                        ],
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ListView.builder(
                        itemCount: reviews.length,
                        shrinkWrap: true,
                        itemBuilder: ((context, index) {
                          final review = reviews[index];
                          final reviewDateTime = review.reviewDate.toDate();
                          final formattedDate =
                              DateFormat('dd MMMM yyyy').format(reviewDateTime);

                          return Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: CustomUserReview(
                              userName: review.userName,
                              date: formattedDate,
                              starRating: review.rating,
                              comment: review.review,
                              image: review.userImage,
                              reviewID: review.reviewId,
                              onLongPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Delete Review'),
                                    content: const Text(
                                        'Are you sure you want to delete this review?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(
                                            context), // Cancel deletion
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          try {
                                            // Get a reference to the review document in Firestore using reviewId
                                            final reviewRef = FirebaseFirestore
                                                .instance
                                                .collection('UsersReview')
                                                .doc(review.reviewId);

                                            // Delete the review document
                                            await reviewRef.delete();

                                            setState(() {});

                                            // Show success message
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Review deleted successfully'),
                                              ),
                                            );
                                          } catch (e) {
                                            // Show error message if deletion fails
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Failed to delete review: $e'),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}

class CustomUserReview extends StatelessWidget {
  const CustomUserReview({
    Key? key,
    required this.userName,
    required this.date,
    required this.starRating,
    required this.comment,
    required this.image,
    required this.onLongPressed,
    required this.reviewID,
  }) : super(key: key);

  final String userName;
  final String date;
  final double starRating;
  final String comment;
  final String image;
  final VoidCallback onLongPressed;
  final String reviewID;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(image),
                radius: 25,
              ),
              const SizedBox(width: 7),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: const TextStyle(fontSize: 14),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 45),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.watch_later_outlined,
                          size: 15,
                          color: AppColors.secondryLight,
                        ),
                        const SizedBox(width: 7),
                        Text(
                          date,
                          style: StylesLight.bodyExtraSmallGrey11,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(starRating.toString()),
                        const Text(
                          ' rating',
                          style: StylesDark.bodyExtraSmallGrey11,
                        )
                      ],
                    ),
                    Row(children: [
                      StarRatingReadOnly(
                        starSize: 15,
                        initialRating: starRating,
                      )
                    ]),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            comment,
            style: const TextStyle(color: AppColors.secondryLight),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey[200],
          )
        ],
      ),
    );
  }
}
