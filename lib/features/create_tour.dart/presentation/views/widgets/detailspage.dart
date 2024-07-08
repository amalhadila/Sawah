import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/core/utils/style.dart';
import 'package:graduation/features/create_tour.dart/presentation/model/get_all_landmarks_by_govern_model.dart';
import 'package:graduation/features/create_tour.dart/presentation/views/widgets/my%20orders.dart';
import 'package:shimmer/shimmer.dart'; 

class TourDetailsPage extends StatefulWidget {
  final String selectedGovernorate;
  final List<String> selectedLanguages;
  final List<Landmark> selectedLandmarks;
  final DateTime startDate;
  final DateTime endDate;
  final int groupSize;
  final String comment;

  TourDetailsPage({
    required this.selectedGovernorate,
    required this.selectedLanguages,
    required this.selectedLandmarks,
    required this.startDate,
    required this.endDate,
    required this.groupSize,
    required this.comment,
  });

  @override
  _TourDetailsPageState createState() => _TourDetailsPageState();
}

class _TourDetailsPageState extends State<TourDetailsPage> {
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController peopleController = TextEditingController();
  DateTime selectedDate = DateTime(2024, 6, 21);

  @override
  void initState() {
    super.initState();
    destinationController.text = 'Paris'; 
    peopleController.text = '5-10'; 
    selectedDate = widget.startDate;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title:const Text("Let's check the details",style: Textstyle.textStyle21,),
        backgroundColor: kbackgroundcolor,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildCard(
                context,
                'Your destination',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destinationController.text,
                      style: Textstyle.textStyle16.copyWith(color: neutralColor3),
                    ),
                    SizedBox(height: screenWidth * 0.02),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, size: screenWidth * 0.05),
                          SizedBox(width: screenWidth * 0.02),
                          Text(
                            "${selectedDate.toLocal()}".split(' ')[0],
                            style: Textstyle.textStyle16.copyWith(color: neutralColor3),
                          ),                          
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenWidth * 0.04),
              _buildCard(
                context,
                'Your landmark',
                Row(
                  children: [
                    CachedNetworkImage(
      imageUrl: widget.selectedLandmarks.first.images[0] ,
      width: screenWidth * 0.25,
      height:  screenWidth * 0.21,
      fit: BoxFit.fill,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: screenWidth * 0.25,
          height:  screenWidth * 0.21,
          color: Colors.white,
        ),
      ),errorWidget: (context, url, error) => Icon(Icons.error),
    ),
                 
                    SizedBox(width: screenWidth * 0.04),
                    Expanded(
                      child: Text(
                        widget.selectedLandmarks.isNotEmpty
                            ? widget.selectedLandmarks.first.name
                            : '',
                        style:Textstyle.textStyle16.copyWith(color: neutralColor3),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                 
                  ],
                ),
              ),
              SizedBox(height: screenWidth * 0.04),
              _buildCard(
                context,
                'Tour details',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRowWithEdit(
                        context,
                        'Tour languages',
                        widget.selectedLanguages.isNotEmpty
                            ? widget.selectedLanguages.join(', ')
                            : '',
                        screenWidth),
                    SizedBox(height: screenWidth * 0.02),
                    Text('How many people will be on the tour?',style:Textstyle.textStyle16.copyWith(color: neutralColor3),),
                    _buildRowWithEdit(
                        context,
                        widget.groupSize == 1
                            ? '1-4'
                            : widget.groupSize == 2
                                ? '5-10'
                                : 'More than 10',
                        '',
                        screenWidth),
                  ],
                ),
              ),
              SizedBox(height: screenWidth * 0.08),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 80),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyOrdersPage()),
                      );
                    },
                   style: ElevatedButton.styleFrom(
                  backgroundColor: kmaincolor,
                  minimumSize: Size.fromHeight(48),
                ),
                    child: Text('create',
                        style:Textstyle.textStyle16.copyWith( color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, Widget child) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      elevation: 4,
      color: ksecondcolor2,
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenWidth * 0.02),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildRowWithEdit(
      BuildContext context, String title, String value, double screenWidth) {
    return Row(
      children: [
        Text(title, style: TextStyle(fontSize: screenWidth * 0.04)),
        Spacer(),
        Text(
          value,
          style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.black54),
        ),
       
      ],
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
