import 'package:dio/dio.dart';
import 'package:graduation/core/utils/api_service.dart';

import '../../../../auth/core_login/errors/excpetion.dart';

class Revwrepoimp {
  final ApiService apiService;

  Revwrepoimp(this.apiService);


  Future<void> addReview({
    required double rating,
    required String comment,
    required String landmark,
    required String reviewType,
  }) async {
    try {
      var data = await apiService.post(
        endpoint: 'reviews',
        Headers: Options(
          headers: <String, String>{
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4ZmI4MTRiNTZmYTE4NCIsImlhdCI6MTcxNTU1NTA4MCwiZXhwIjoxNzIzMzMxMDgwfQ.7KcMqIu-UNoV5qBqm71cyWH8ZBzpKBMjSXq-hmgjxWg',
            'Content-Type': 'application/json',
          },
        ),
        body: {
          'rating': rating,
          'comment': comment,
          'landmark': landmark,
          'reviewType': reviewType,
        },
      );
      print(data);
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.toString()}');
        throw ServerFailure.fromDiorError(e);
      } else {
        print('ServerFailure: ${e.toString()}');
        throw ServerFailure(e.toString());
      }
    }
  }
}
