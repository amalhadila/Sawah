import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graduation/core/utils/api_service.dart';
import 'package:graduation/features/home/data/models/most_visited_model/most_visited_model.dart';

import 'package:graduation/features/landmarks/data/model/landmark_on_cat_model/landmark_on_cat_model.dart';

import 'package:graduation/features/review_onlandmark/data/model/get_review_model/get_review_model.dart';
import 'package:graduation/features/review_onlandmark/data/model/getreviewmodel.dart';
import 'package:graduation/features/review_onlandmark/data/repo/revwrepoimp.dart';
import 'package:graduation/features/review_onlandmark/pres/cubit/reviewcubit.dart';
import 'package:graduation/features/review_onlandmark/pres/cubit/reviewstate.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key, this.landmarkmodel, this.mostvistedkmodel})
      : super(key: key);

  final LandmarkOnCatModel? landmarkmodel;
  final MostVisitedModel? mostvistedkmodel;

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final TextEditingController _commentController = TextEditingController();
  double _rating = 0.0;

  @override
  void initState() {
    super.initState();
    context.read<ReviewCubit>().getallReviewsonlandmark(
          id: (widget.landmarkmodel?.id ?? widget.mostvistedkmodel?.id)!,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 80,
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
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
                itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                itemBuilder: (context, _) => Icon(
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
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                context.read<ReviewCubit>().addReviewonlandmark(
                      landmarkid: (widget.landmarkmodel?.id ??
                          widget.mostvistedkmodel?.id)!,
                      reviewType: 'Landmark',
                      comment: _commentController.text,
                    );
              },
              child: Text("Submit Review"),
            ),
            SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<ReviewCubit, ReviewState>(
                builder: (context, state) {
                  if (state is GetReviewSuccess) {
                    log('GetReviewSuccess state');
                    return ListView.builder(
                      itemCount: state.reviews.length,
                      itemBuilder: (context, index) {
                        return ReviewWidget(review: state.reviews[index]);
                      },
                    );
                  } else if (state is GetReviewFailure) {
                    log('GetReviewFailure state: ${state.errorMessage}');
                    return Center(
                        child: Text(
                            'Error fetching reviews: ${state.errorMessage}'));
                  } else {
                    log('Loading state');
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
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
                  backgroundImage: AssetImage(
                      'assets/default_avatar.png'), // Replace with actual image if available
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
