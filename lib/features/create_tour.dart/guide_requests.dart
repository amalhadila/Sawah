import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graduation/core/utils/api_service.dart';
import 'presentation/model/get_all_custom_tours_model.dart';
import 'presentation/model/get_all_governs_model.dart';
import 'presentation/model/get_all_landmarks_by_govern_model.dart';
import 'presentation/model/get_avaiabled_guides_model.dart';
import 'presentation/model/get_cancelled_tours_model.dart';
import 'presentation/model/get_custom_tour_by_id_model.dart';
import 'presentation/model/get_my_requests_model.dart';
import 'presentation/model/get_my_tour_request_by_id_model.dart';

class GuideRequests {
  final ApiService apiService = ApiService(Dio());
  Future getAllGoverns(BuildContext context) async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.get(
          options: Options(
            headers: {
              'Authorization':
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4ZmI4MTRiNTZmYTE4NCIsImlhdCI6MTcxOTM2NzE5MCwiZXhwIjoxNzI3MTQzMTkwfQ.tS7RqEwaramU40EOYYOmXhfvRmNGuYrKq9DD21RK7_E',
            },
          ),
          'http://192.168.1.6:8000/api/v1/customizedTour/governorates');
      GetAllGovernsModel getAllGovernsModel =
          GetAllGovernsModel.fromJson(response.data);
      return getAllGovernsModel;
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened $e, please try again"),
        ),
      );
    }
  }

  Future getAllLandMarksByGovern(
      BuildContext context, String governorate) async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.get(
          options: Options(
            headers: {
              'Authorization':
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4ZmI4MTRiNTZmYTE4NCIsImlhdCI6MTcxOTM2NzE5MCwiZXhwIjoxNzI3MTQzMTkwfQ.tS7RqEwaramU40EOYYOmXhfvRmNGuYrKq9DD21RK7_E',
            },
          ),
          'http://192.168.1.6:8000/api/v1/customizedTour/landmarks/:$governorate');
      GetAllLandmarksByGovernModel getAllGovernsModel =
          GetAllLandmarksByGovernModel.fromJson(response.data);
      return getAllGovernsModel;
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened $e, please try again"),
        ),
      );
    }
  }

  Future getAllCustomTours(BuildContext context, String governorate) async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.get(
          options: Options(
            headers: {
              'Authorization':
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4ZmI4MTRiNTZmYTE4NCIsImlhdCI6MTcxOTM2NzE5MCwiZXhwIjoxNzI3MTQzMTkwfQ.tS7RqEwaramU40EOYYOmXhfvRmNGuYrKq9DD21RK7_E',
            },
          ),
          'http://192.168.1.6:8000/api/v1/customizedTour');
      GetAllCustomToursModel getAllCustomToursModel =
          GetAllCustomToursModel.fromJson(response.data);
      return getAllCustomToursModel;
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened $e, please try again"),
        ),
      );
    }
  }

  Future getCustomTourById(BuildContext context, String tourId) async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.get(
          options: Options(
            headers: {
              'Authorization':
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4ZmI4MTRiNTZmYTE4NCIsImlhdCI6MTcxOTM2NzE5MCwiZXhwIjoxNzI3MTQzMTkwfQ.tS7RqEwaramU40EOYYOmXhfvRmNGuYrKq9DD21RK7_E',
            },
          ),
          'http://192.168.1.6:8000/api/v1/customizedTour/$tourId');
      GetCustomTourByIdModel getCustomTourByIdModel =
          GetCustomTourByIdModel.fromJson(response.data);
      return getCustomTourByIdModel;
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened $e, please try again"),
        ),
      );
    }
  }

  Future getMyReqeusts(BuildContext context) async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.get(
          options: Options(
            headers: {
              'Authorization':
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4ZmI4MTRiNTZmYTE4NCIsImlhdCI6MTcxOTM2NzE5MCwiZXhwIjoxNzI3MTQzMTkwfQ.tS7RqEwaramU40EOYYOmXhfvRmNGuYrKq9DD21RK7_E',
            },
          ),
          'http://192.168.1.6:8000/api/v1/customizedTour/my-requests');
      GetMyRequestsModel getMyRequestsModel =
          GetMyRequestsModel.fromJson(response.data);
      return getMyRequestsModel;
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened $e, please try again"),
        ),
      );
    }
  }

  Future getMyRequestTourById(BuildContext context, String tourId) async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.get(
          options: Options(
            headers: {
              'Authorization':
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4ZmI4MTRiNTZmYTE4NCIsImlhdCI6MTcxOTM2NzE5MCwiZXhwIjoxNzI3MTQzMTkwfQ.tS7RqEwaramU40EOYYOmXhfvRmNGuYrKq9DD21RK7_E',
            },
          ),
          'http://192.168.1.6:8000/api/v1/customizedTour/my-requests/$tourId');
      GetMyRequestTourByIdModel getMyRequestTourByIdModel =
          GetMyRequestTourByIdModel.fromJson(response.data);
      return getMyRequestTourByIdModel;
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened $e, please try again"),
        ),
      );
    }
  }

  Future getCancelledTours(BuildContext context) async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.get(
          options: Options(
            headers: {
              'Authorization':
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4ZmI4MTRiNTZmYTE4NCIsImlhdCI6MTcxOTM2NzE5MCwiZXhwIjoxNzI3MTQzMTkwfQ.tS7RqEwaramU40EOYYOmXhfvRmNGuYrKq9DD21RK7_E',
            },
          ),
          'http://192.168.1.6:8000/api/v1/customizedTour/canceled');
      GetCancelledToursModel getCancelledToursModel =
          GetCancelledToursModel.fromJson(response.data);
      return getCancelledToursModel;
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened $e, please try again"),
        ),
      );
    }
  }

  Future getAvailableGuides(BuildContext context, String tourId) async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.get(
          options: Options(
            headers: {
              'Authorization':
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4ZmI4MTRiNTZmYTE4NCIsImlhdCI6MTcxOTM2NzE5MCwiZXhwIjoxNzI3MTQzMTkwfQ.tS7RqEwaramU40EOYYOmXhfvRmNGuYrKq9DD21RK7_E',
            },
          ),
          'http://192.168.1.6:8000/api/v1/customizedTour/$tourId/browse-guides');
      GetAvailableGuidesModel getAvailableGuidesModel =
          GetAvailableGuidesModel.fromJson(response.data);
      return getAvailableGuidesModel;
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened $e, please try again"),
        ),
      );
    }
  }

  Future createTour(BuildContext context, String tourId,
      {String? governorate,
      List<String>? spokenLanguages,
      String? groupSize,
      List<String>? landmarks,
      String? startDate,
      String? endDate,
      String? commentForGuide}) async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.post(
          options: Options(
            headers: {
              'Authorization':
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4ZmI4MTRiNTZmYTE4NCIsImlhdCI6MTcxOTM2NzE5MCwiZXhwIjoxNzI3MTQzMTkwfQ.tS7RqEwaramU40EOYYOmXhfvRmNGuYrKq9DD21RK7_E',
            },
          ),
          'http://192.168.1.6:8000/api/v1/customizedTour',
          data: {
            "governorate": governorate,
            "spokenLanguages": spokenLanguages,
            "groupSize": groupSize,
            "landmarks": landmarks,
            "startDate": startDate,
            "endDate": endDate,
            "commentForGuide": commentForGuide
          });
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened $e, please try again"),
        ),
      );
    }
  }

  Future updateTour(BuildContext context, String tourId, String status) async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.patch(
          options: Options(
            headers: {
              'Authorization':
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4ZmI4MTRiNTZmYTE4NCIsImlhdCI6MTcxOTM2NzE5MCwiZXhwIjoxNzI3MTQzMTkwfQ.tS7RqEwaramU40EOYYOmXhfvRmNGuYrKq9DD21RK7_E',
            },
          ),
          'http://192.168.1.6:8000/api/v1/customizedTour/$tourId',
          data: {"status": status});
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened $e, please try again"),
        ),
      );
    }
  }

  Future cancelTour(BuildContext context, String tourId) async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.patch(
          options: Options(
            headers: {
              'Authorization':
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4ZmI4MTRiNTZmYTE4NCIsImlhdCI6MTcxOTM2NzE5MCwiZXhwIjoxNzI3MTQzMTkwfQ.tS7RqEwaramU40EOYYOmXhfvRmNGuYrKq9DD21RK7_E',
            },
          ),
          'http://192.168.1.6:8000/api/v1/customizedTour/$tourId/cancel');
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened $e, please try again"),
        ),
      );
    }
  }

  Future respondToTourRequest(
      BuildContext context, String tourId, String price) async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.patch(
          options: Options(
            headers: {
              'Authorization':
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4ZmI4MTRiNTZmYTE4NCIsImlhdCI6MTcxOTM2NzE5MCwiZXhwIjoxNzI3MTQzMTkwfQ.tS7RqEwaramU40EOYYOmXhfvRmNGuYrKq9DD21RK7_E',
            },
          ),
          'http://192.168.1.6:8000/api/v1/customizedTour/respond/$tourId',
          data: {"price": price});
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened $e, please try again"),
        ),
      );
    }
  }

  Future respondToTourGuide(
      BuildContext context, String tourId, String guideId) async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.patch(
          options: Options(
            headers: {
              'Authorization':
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4ZmI4MTRiNTZmYTE4NCIsImlhdCI6MTcxOTM2NzE5MCwiZXhwIjoxNzI3MTQzMTkwfQ.tS7RqEwaramU40EOYYOmXhfvRmNGuYrKq9DD21RK7_E',
            },
          ),
          'http://192.168.1.6:8000/api/v1/customizedTour/:$tourId/respond/guide/:$guideId',
          data: {"response": "accept"});
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened $e, please try again"),
        ),
      );
    }
  }

  Future sendRequestToGuide(
      BuildContext context, String tourId, String guideId) async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.patch(
        options: Options(
          headers: {
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4ZmI4MTRiNTZmYTE4NCIsImlhdCI6MTcxOTM2NzE5MCwiZXhwIjoxNzI3MTQzMTkwfQ.tS7RqEwaramU40EOYYOmXhfvRmNGuYrKq9DD21RK7_E',
          },
        ),
        'http://192.168.1.6:8000/api/v1/customizedTour/tour/$tourId/guide/$guideId/send-request',
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened $e, please try again"),
        ),
      );
    }
  }

  Future cancelDataSourceRefreshResponse(
      BuildContext context, String tourId, String guideId) async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.patch(
        options: Options(
          headers: {
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4ZmI4MTRiNTZmYTE4NCIsImlhdCI6MTcxOTM2NzE5MCwiZXhwIjoxNzI3MTQzMTkwfQ.tS7RqEwaramU40EOYYOmXhfvRmNGuYrKq9DD21RK7_E',
          },
        ),
        'http://192.168.1.6:8000/api/v1/customizedTour/tour/$tourId/guide/$guideId/cancel-request',
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened $e, please try again"),
        ),
      );
    }
  }

  Future deleteCustomTour(BuildContext context, String tourId) async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.delete(
        options: Options(
          headers: {
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4ZmI4MTRiNTZmYTE4NCIsImlhdCI6MTcxOTM2NzE5MCwiZXhwIjoxNzI3MTQzMTkwfQ.tS7RqEwaramU40EOYYOmXhfvRmNGuYrKq9DD21RK7_E',
          },
        ),
        'http://192.168.1.6:8000/api/v1/customizedTour/$tourId',
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened $e, please try again"),
        ),
      );
    }
  }
}
