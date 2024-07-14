import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sawah/features/review_onlandmark/data/model/get_review_model/get_review_model.dart';
import 'package:sawah/features/review_onlandmark/pres/cubit/reviewcubit.dart';
import 'package:sawah/features/review_onlandmark/pres/cubit/reviewstate.dart';
import 'package:sawah/features/store/data/product/product.dart';

class Rviewpagefortour extends StatefulWidget {
  const Rviewpagefortour({Key? key, required this.products}) : super(key: key);

  final Product products;

  @override
  _RviewpagefortourState createState() => _RviewpagefortourState();
}

class _RviewpagefortourState extends State<Rviewpagefortour> {
  final TextEditingController _commentController = TextEditingController();
  double _rating = 0.0;

  @override
  void initState() {
    super.initState();
    context.read<ReviewCubit>().getallReviewsonlandmark(
          id: widget.products.id!,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: 80,
                child: TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    labelText: "Enter your comment",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 40,
                child: RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 20,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                    context.read<ReviewCubit>().updateRating(rating);
                  },
                ),
              ),
              const SizedBox(height: 10),
              BlocConsumer<ReviewCubit, ReviewState>(
                listener: (context, state) {
                  if (state is AddReviewFailure) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('done'),
                          content: Text('add review scuess'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state is! AddReviewLoading
                        ? () {
                            context.read<ReviewCubit>().addReviewonTour(
                                  landmarkid: widget.products.id!,
                                  reviewType: 'Tour',
                                  comment: _commentController.text,
                                );
                          }
                        : null,
                    child: state is AddReviewLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text("Submit Review"),
                  );
                },
              ),
              SizedBox(height: 20),
              BlocBuilder<ReviewCubit, ReviewState>(
                builder: (context, state) {
                  if (state is GetReviewSuccess) {
                    log('GetReviewSuccess state');
                    return SizedBox(
                      height: 400, // Adjust the height as needed
                      child: ListView.builder(
                        itemCount: state.reviews.length,
                        itemBuilder: (context, index) {
                          return ReviewWidget(review: state.reviews[index]);
                        },
                      ),
                    );
                  } else if (state is GetReviewFailure) {
                    return Text(
                        'Error fetching reviews: ${state.errorMessage}');
                  } else {
                    return Text('Enter your review and rating above');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewWidget extends StatelessWidget {
  final GetReviewModel review;

  ReviewWidget({required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/default_avatar.png'),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.user?.name ?? 'Unknown',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${review.createdAt?.toLocal()}".split(' ')[0],
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            RatingBarIndicator(
              rating: review.rating ?? 0,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 20.0,
              direction: Axis.horizontal,
            ),
            SizedBox(height: 10),
            Text(review.comment ?? ''),
          ],
        ),
      ),
    );
  }
}
