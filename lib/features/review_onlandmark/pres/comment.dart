import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final TextEditingController _commentController = TextEditingController();
  double _rating = 0;
  List<Review> _reviews = [];

  void _submitReview() {
    if (_commentController.text.isNotEmpty && _rating > 0) {
      setState(() {
        _reviews.add(Review(
          name: "User Name", // Replace with actual user name
          date: DateTime.now(),
          rating: _rating,
          comment: _commentController.text,
        ));
        _commentController.clear();
        _rating = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Review Page")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: "Enter your comment",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 10),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating;
                });
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _submitReview,
              child: Text("Submit Review"),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _reviews.length,
                itemBuilder: (context, index) {
                  return ReviewWidget(review: _reviews[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Review {
  final String name;
  final DateTime date;
  final double rating;
  final String comment;

  Review({
    required this.name,
    required this.date,
    required this.rating,
    required this.comment,
  });
}

class ReviewWidget extends StatelessWidget {
  final Review review;

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
                  backgroundImage: AssetImage('assets/default_avatar.png'), // Replace with actual image if available
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${review.date.toLocal()}".split(' ')[0],
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
