import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:graduation/core/utils/api_service.dart';
import 'package:graduation/features/landmarks/data/model/landmark_on_cat_model/landmark_on_cat_model.dart';
import 'package:graduation/features/review_onlandmark/data/model/reviewmodel.dart';
import 'package:graduation/features/review_onlandmark/data/repo/revwrepoimp.dart';
import 'package:graduation/features/review_onlandmark/pres/cubit/reviewcubit.dart';
import 'package:graduation/features/review_onlandmark/pres/cubit/reviewstate.dart';
import 'package:graduation/features/store/data/product/product.dart';

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
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReviewCubit(Revwrepoimp(ApiService(Dio()))),
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
                  context.read<ReviewCubit>().postReviewsontour(
                        tourid: widget.products.id!,
                        reviewType: 'Tour',
                        comment: _commentController
                            .text, // Ensure comment is passed here
                      );
                },
                child: Text("Submit Review"),
              ),
              SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<ReviewCubit, ReviewState>(
                  builder: (context, state) {
                    if (state is AddReviewSuccess) {
                      return Text('gbggg');
                      //                   return Card(
                      //   margin: EdgeInsets.symmetric(vertical: 8),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(16.0),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Row(
                      //           children: [
                      //             CircleAvatar(
                      //               backgroundImage: AssetImage('assets/default_avatar.png'), // Replace with actual image if available
                      //             ),
                      //             SizedBox(width: 10),
                      //             Column(
                      //               crossAxisAlignment: CrossAxisAlignment.start,
                      //               children: [
                      //                 Text(
                      //                   ReviewModel.,
                      //                   style: TextStyle(fontWeight: FontWeight.bold),
                      //                 ),
                      //                 Text(
                      //                   "{review.date.toLocal()}".split(' ')[0],
                      //                   style: TextStyle(color: Colors.grey),
                      //                 ),
                      //               ],
                      //             ),
                      //           ],
                      //         ),
                      //         SizedBox(height: 10),
                      //         RatingBarIndicator(
                      //           rating: ReviewModel.fromJson(jsonData).rating,
                      //           itemBuilder: (context, index) => Icon(
                      //             Icons.star,
                      //             color: Colors.amber,
                      //           ),
                      //           itemCount: 5,
                      //           itemSize: 20.0,
                      //           direction: Axis.horizontal,
                      //         ),
                      //         SizedBox(height: 10),
                      //         Text(review.comment),
                      //       ],
                      //     ),
                      //   ),
                      // );
                    } else if (state is AddReviewFailure) {
                      return Text(
                          'Error submitting review: ${state.errorMessage}');
                    } else if (state is AddReviewLoading) {
                      return CircularProgressIndicator();
                    } else {
                      return Text('Enter your review and rating above');
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
