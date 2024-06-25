import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graduation/core/utils/api_service.dart';
import 'package:graduation/features/landmarks/data/model/landmark_on_cat_model/landmark_on_cat_model.dart';
import 'package:graduation/features/review_onlandmark/data/model/getreviewmodel.dart';
import 'package:graduation/features/review_onlandmark/data/repo/revwrepoimp.dart';
import 'package:graduation/features/review_onlandmark/pres/cubit/reviewcubit.dart';
import 'package:graduation/features/review_onlandmark/pres/cubit/reviewstate.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key, required this.landmarkmodel}) : super(key: key);

  final LandmarkOnCatModel landmarkmodel;

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final TextEditingController _commentController = TextEditingController();
  double _rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReviewCubit(Revwrepoimp(ApiService(Dio())))..getallReviewsonlandmark(
                        id: widget.landmarkmodel.id!,
                      ),
      child: Scaffold(
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
                  context.read<ReviewCubit>().getallReviewsonlandmark(
                        id: widget.landmarkmodel.id!,
                      );
                  context.read<ReviewCubit>().addReviewonlandmark(
                        landmarkid: widget.landmarkmodel.id!,
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
                      return Text(state.toString());
                      // return ListView.builder(
                      //   itemCount: state.reviews.first.data.length,
                      //   itemBuilder: (context, index) {
                      //     return ReviewWidget(review: state.reviews.first.data[index]);
                      //   },
                      // );
                    } else if (state is AddReviewFailure) {
                      log('AddReviewFailure state: ${state.errorMessage}');
                      return Center(
                          child: Text(
                              'Error submitting review: ${state.errorMessage}'));
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
      ),
    );
  }
}

class ReviewWidget extends StatelessWidget {
  final ReviewData review;

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
                      review.user.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${DateTime.parse(review.createdAt).toLocal()}"
                          .split(' ')[0],
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            RatingBarIndicator(
              rating: review.rating,
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 20.0,
              direction: Axis.horizontal,
            ),
            SizedBox(height: 10),
            Text(review.comment),
          ],
        ),
      ),
    );
  }
}
