import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation/auth/cach/cach_helper.dart';
import 'package:graduation/auth/core_login/api/end_point.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/core/utils/style.dart';
import 'package:graduation/features/create_tour.dart/presentation/model/get_avaiabled_guides_model.dart';
import 'package:graduation/features/create_tour.dart/presentation/model/get_my_requests_model.dart';

class ResponseScreen extends StatefulWidget {
          final String tourId;
          final String tourname;

  const ResponseScreen({super.key, required this.tourId, required this.tourname});

  @override
  _ResponseScreenState createState() => _ResponseScreenState();
}

class _ResponseScreenState extends State<ResponseScreen>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
Future<List<GetAvailableGuidesModel>> getAvailableGuides(String tourId) async {
  final Dio _dio = Dio();
  try {
    var response = await _dio.get(
      'http://192.168.1.4:8000/api/v1/customizedTour/$tourId/browse-guides',
      options: Options(
        headers: {
          'Authorization':
              'Bearer ${Token}',
        },
      ),
    );

    List<dynamic> responseData = response.data['availableGuides'];
    print(responseData);

    List<GetAvailableGuidesModel> guides = responseData
        .map((json) => GetAvailableGuidesModel.fromJson(json))
        .toList();

    return guides;
  } catch (e) {
    throw e;
  }
}

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kbackgroundcolor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kmaincolor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:
            Text(widget.tourname, style: TextStyle(color: kmaincolor,fontSize: 19,fontWeight: FontWeight.w700),),
            
        
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:20.0),
            child: TabBar(
              labelStyle:       Textstyle.textStyle15,
              controller: _tabController,
              indicator: BoxDecoration(
                color: kmaincolor,
                borderRadius: BorderRadius.circular(10),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: kbackgroundcolor,
              labelPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
             
              tabs: [
                Tab(text: 'Your Requests'),
                Tab(text: 'All guides'),
              ],
               labelColor: kbackgroundcolor,
              unselectedLabelColor: kmaincolor,
            ),
          ),
        ),
      ),),
      body: 
             TabBarView(
              
              controller: _tabController,
              children: [
                _buildNoRequestsTab(),
                _buildAllGuidesTab(),
              ],));
            
          
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
              'Wait for responses from specialists',
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
  return FutureBuilder<List<GetAvailableGuidesModel>>(
    future: getAvailableGuides(widget.tourId),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else {
        final guides = snapshot.data ?? [];
        if (guides.isEmpty) {
          return const Center(child: Text('No guides available'));
        } else {
          return ListView.builder(
            itemCount: guides.length,
            itemBuilder: (context, index) {
              final guide = guides[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(guide.photo??'')
                    
                ),
                title: Text(guide.name ?? 'Unknown Name',style: TextStyle(color: kmaincolor,fontWeight: FontWeight.w700)),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical:3.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Text(
                        'Kind: ${guide.kind ?? 'Unknown Kind'} ',style: TextStyle(color: ksecondcolor,fontWeight: FontWeight.w600)
                      ),
                      SizedBox(height: 3,),
                       Row(
                         children: [
                          const Icon(
                                      FontAwesomeIcons.solidStar,
                                      size: 16,
                                      color: accentColor1,
                                    ),
                           Text(
                            ' ${guide.rating?.toString() ?? 'No rating'} ',style: TextStyle(color: ksecondcolor,fontWeight: FontWeight.w600)
                                               ),
                         ],
                       ),
                    ],
                  ),
                ),
             
              );
            },
          );
        }
      }
    },
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
