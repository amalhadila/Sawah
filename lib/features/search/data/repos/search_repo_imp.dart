import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:graduation/core/errors/failures.dart';
import 'package:graduation/core/utils/api_service.dart';
import 'package:graduation/features/landmarks/data/model/landmark_on_cat_model/landmark_on_cat_model.dart';
import 'package:graduation/features/search/data/repos/search_repo.dart';
import 'package:dio/dio.dart';

class SearchRepoImp implements SearchRepo {
  final ApiService apiService;

  SearchRepoImp(this.apiService);

  @override
  Future<Either<Failure, List<LandmarkOnCatModel>>> fetchSearchResults(
      {required String name}) async {
    try {
      var data = await apiService.get(endpoint: 'landmarks', search: name);
      log('test');
      print(data);
      List<LandmarkOnCatModel> landmark = [];
      for (var match in data['data']['docs']) {
        landmark.add(LandmarkOnCatModel.fromJson(match));
      }
      return right(landmark);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
