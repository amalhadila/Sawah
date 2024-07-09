import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sawah/auth/cach/cach_helper.dart';
import 'package:sawah/auth/core_login/api/end_point.dart';
import 'package:sawah/constants.dart';
import 'package:sawah/core/utils/style.dart';
import 'package:sawah/features/create_tour.dart/presentation/model/get_avaiabled_guides_model.dart';
import 'package:sawah/firebase/firedatabase.dart';
import 'package:sawah/features/store/presentation/views/widgets/payment_response.dart'
as ps;
import '../../../../store/presentation/views/widgets/payment_web_view.dart';
import '../../model/getallrespondingguide.dart';
import 'cardofguideresponse.dart';

class ResponseScreen extends StatefulWidget {
  final String tourId;
  final String tourname;

  const ResponseScreen(
      {super.key, required this.tourId, required this.tourname});

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

  Future<List<GetAvailableGuidesModel>> getAvailableGuides(
      String tourId) async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.get(
        'https://sawahonline.com/api/v1/customizedTour/$tourId/browse-guides',
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${CacheHelper().getData(key: apikey.token)}',
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

  Future<List<RespondingGuide>> getRespondingGuides(String tourId) async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.get(
        'https://sawahonline.com/api/v1/customizedTour/$tourId/responding-guides',
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${CacheHelper().getData(key: apikey.token)}',
          },
        ),
      );

      List<dynamic> responseData = response.data['data']['respondingGuides'];
      print(responseData);

      List<RespondingGuide> guides =
          responseData.map((json) => RespondingGuide.fromJson(json)).toList();

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
          title: Text(
            widget.tourname,
            style: TextStyle(
                color: kmaincolor, fontSize: 19, fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TabBar(
                  labelStyle: Textstyle.textStyle15,
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: kmaincolor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: kbackgroundcolor,
                  labelPadding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                  tabs: [
                    Tab(text: 'Responses'),
                    Tab(text: 'All guides'),
                  ],
                  labelColor: kbackgroundcolor,
                  unselectedLabelColor: kmaincolor,
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildResponsesTab(),
            _buildAllGuidesTab(),
          ],
        ));
  }

  Widget _buildResponsesTab() {
    return FutureBuilder<List<RespondingGuide>>(
      future: getRespondingGuides(widget.tourId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final guides = snapshot.data ?? [];
          if (guides.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chat_bubble_outline,
                        size: 100, color: Colors.grey),
                    SizedBox(height: 10),
                    Text(
                      'Wait for responses from specialists',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                        backgroundColor: kmaincolor,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
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
          } else {
            return ListView.builder(
              itemCount: guides.length,
              itemBuilder: (context, index) {
                final guide = guides[index];
                return GuideCardrespond(
                  imageUrl: guide.guide?.photo ?? '',
                  username: guide.guide?.name ?? 'Unknown Name',
                  price: guide.price?.toString() ?? 'Unknown Price',
                  tourId: widget.tourId,
                  guideId: guide.guide?.id ?? '',
                );
              },
            );
          }
        }
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
                  trailing: IconButton(
                    onPressed: () async {
                      final roomId =
                          await FireData().creatRoom(guide.id!, guide.name!,
                        guide.photo!);
                      GoRouter.of(context)
                          .push('/ChatScreen', extra: [roomId, guide.name!]);
                    },
                    icon: const Icon(Icons.chat_rounded, color: kmaincolor),
                  ),
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(guide.photo ?? '')),
                  title: Text(guide.name ?? 'Unknown Name',
                      style: TextStyle(
                          color: kmaincolor, fontWeight: FontWeight.w700)),
                  subtitle: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Kind: ${guide.kind ?? 'Unknown Kind'} ',
                            style: TextStyle(
                                color: ksecondcolor,
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            const Icon(
                              FontAwesomeIcons.solidStar,
                              size: 16,
                              color: accentColor1,
                            ),
                            Text(' ${guide.rating?.toString() ?? 'No rating'} ',
                                style: TextStyle(
                                    color: ksecondcolor,
                                    fontWeight: FontWeight.w600)),
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

class GuideCardrespond extends StatelessWidget {
  final String imageUrl;
  final String username;
  final String price;
  final String tourId;
  final String guideId;

  const GuideCardrespond({
    Key? key,
    required this.imageUrl,
    required this.username,
    required this.price,
    required this.tourId,
    required this.guideId,
  }) : super(key: key);

  Future<void> acceptPrice(
      BuildContext context, String tourId, String guideId) async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.patch(
        'http://192.168.100.71:8000/api/v1/customizedTour/$tourId/respond/guide/$guideId',
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${CacheHelper().getData(key: apikey.token)}',
          },
        ),
        data: {"response": "accept"},
      );
      await payCustomTour(context, tourId);
      print('Response: ${response.data}');

    } catch (e) {
      print(e.toString());
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened $e, please try again"),
        ),
      );
    }
  }
  Future<void> payCustomTour(BuildContext context, tourId) async {
    final Dio _dio = Dio();

    try {
      var response = await _dio.post(
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${Token}',
          },
        ),
        'http://192.168.1.4:8000/api/v1/bookings/custom-checkout-session/:$tourId',
        data: {"firstName": "Amr", "lastName": "Kfr", "phone": 1010101001},
      );
      ps.PaymentResponse paymentResponse =
      ps.PaymentResponse.fromJson(response.data);
      Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => PaymentWebView(paymentResponse: paymentResponse),
      ));
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
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardHeight = screenWidth * 0.48; // Adjusted card height

    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Card(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 2,
        child: Container(
          height: cardHeight,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: secondaryColor1,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                  SizedBox(width: 10),
                  Text(
                    username,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: kmaincolor),
                  ),
                ],
              ),
              SizedBox(height: 10), // Adjusted height
              Text(
                'Price: \$$price',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kmaincolor,
                    fontSize: 18),
              ),
              // Adds space to push the button to the bottom
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () async {
                    await acceptPrice(context, tourId, guideId);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kmaincolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Accept',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
