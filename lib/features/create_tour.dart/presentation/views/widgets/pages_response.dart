import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:graduation/features/create_tour.dart/presentation/model/get_avaiabled_guides_model.dart';
import 'package:graduation/features/create_tour.dart/presentation/model/get_my_requests_model.dart';
import 'package:graduation/features/create_tour.dart/presentation/views/widgets/AvailableGuidesScreen.dart';
import 'package:graduation/features/create_tour.dart/presentation/views/widgets/yourTourDetailsPage.dart';

class ResponseScreen extends StatefulWidget {
  @override
  _ResponseScreenState createState() => _ResponseScreenState();
}

class _ResponseScreenState extends State<ResponseScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<GetMyRequestsModel>> _myRequestsFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _myRequestsFuture = getMyRequests();
  }
  Future<List<GetAvailableGuidesModel>> getAllGuides(String tourId) async {
  final Dio _dio = Dio();
  try {
    var response = await _dio.get(
      'http://192.168.1.6:8000/api/v1/customizedTour/$tourId/browse-guides',
      options: Options(
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4ZmI4MTRiNTZmYTE4NCIsImlhdCI6MTcxOTM2NzE5MCwiZXhwIjoxNzI3MTQzMTkwfQ.tS7RqEwaramU40EOYYOmXhfvRmNGuYrKq9DD21RK7_E',
        },
      ),
    );

    dynamic responseData = response.data;
    print(responseData);

    List<GetAvailableGuidesModel> guides = (responseData as List)
        .map((json) => GetAvailableGuidesModel.fromJson(json))
        .toList();

    return guides;
  } catch (e) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Operation Failed"),
        content: Text("An error happened $e, please try again"),
      ),
    );
    throw e; // rethrowing the exception to handle it further if needed
  }
}

  Future<List<GetMyRequestsModel>> getMyRequests() async {
  final Dio _dio = Dio();
  try {
    var response = await _dio.get(
      'http://192.168.1.6:8000/api/v1/customizedTour/my-requests',
      options: Options(
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4ZmI4MTRiNTZmYTE4NCIsImlhdCI6MTcxOTM2NzE5MCwiZXhwIjoxNzI3MTQzMTkwfQ.tS7RqEwaramU40EOYYOmXhfvRmNGuYrKq9DD21RK7_E',
        },
      ),
    );

    dynamic responseData = response.data;
    print(responseData);

    List<GetMyRequestsModel> requests = (responseData['data']['requests'] as List)
        .map((json) => GetMyRequestsModel.fromJson(json))
        .toList();

    return requests;
  } catch (e) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Operation Failed"),
        content: Text("An error happened $e, please try again"),
      ),
    );
    throw e; // rethrowing the exception to handle it further if needed
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          children: [
            Text('Paris', style: TextStyle(color: Colors.black)),
            Text('2024-06-21',
                style: TextStyle(color: Colors.black54, fontSize: 14)),
          ],
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicator: RoundedRectangleTabIndicator(
                color: Colors.white,
                weight: 2,
                width: 100,
                radius: 30,
              ),
              tabs: [
                Tab(text: 'Your Requests'),
                Tab(text: 'All guides'),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<GetMyRequestsModel>>(
        future: _myRequestsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _buildNoRequestsTab();
          } else {
            return TabBarView(
              controller: _tabController,
              children: [
                _buildResponsesTab(snapshot.data!),
                _buildAllGuidesTab(),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildNoRequestsTab() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline, size: 100, color: Colors.grey),
            SizedBox(height: 10),
            Text(
              'Wait for responsesfrom specialists',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "You don't have any responses yet. You can wait or contact a guide by yourself",
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text(
                'Contact a guide',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsesTab(List<GetMyRequestsModel> requests) {
  return ListView.builder(
    itemCount: requests.length,
    itemBuilder: (context, index) {
      return Card(
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                requests[index].landmarks?[0].name ?? '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                requests[index].governorate ?? 'No governorate',
                style: TextStyle(fontSize: 12),
              ),
              SizedBox(height: 4),
              Text(
                requests[index].groupSize ?? '',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Text(
                  requests[index].status ?? '',
                  style: TextStyle(fontSize: 12),
                ),
              
              
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AvailableGuidesScreen(tourId: requests[index].id!),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'View Guides',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

    },
  );
}

  Widget _buildAllGuidesTab() {
    return Center(
      child: Text('All guides tab content here'),
    );
  }
}

class RoundedRectangleTabIndicator extends Decoration {
  final BoxPainter _painter;

  RoundedRectangleTabIndicator({
    required Color color,
    required double weight,
    required double width,
    required double radius,
  }) : _painter = _RoundedRectanglePainter(color, weight, width, radius);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _RoundedRectanglePainter extends BoxPainter {
  final Paint _paint;
  final double weight;
  final double width;
  final double radius;

  _RoundedRectanglePainter(
      Color color, this.weight, this.width, this.radius)
      : _paint = Paint()
         ..color = color
         ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2 - width / 2, cfg.size!.height - weight);
    final Rect rect = Rect.fromLTWH(
        circleOffset.dx, circleOffset.dy - weight, width, weight * 2);
    final RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    canvas.drawRRect(rRect, _paint);
  }
}