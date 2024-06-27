import 'package:flutter/material.dart';
import 'package:graduation/features/create_tour.dart/presentation/views/widgets/pages_response.dart'; // Ensure this import is correct

class TourDetailsPage extends StatefulWidget {
  @override
  _TourDetailsPageState createState() => _TourDetailsPageState();
}

class _TourDetailsPageState extends State<TourDetailsPage> {
  final TextEditingController destinationController = TextEditingController(text: 'Paris');
  final TextEditingController peopleController = TextEditingController(text: '5-10');
  DateTime selectedDate = DateTime(2024, 6, 21);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Let's check the details"),
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
                      'Paris',
                      style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
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
                            style: TextStyle(fontSize: screenWidth * 0.04),
                          ),
                          Spacer(),
                          Text(
                            'Edit',
                            style: TextStyle(color: Colors.blue, fontSize: screenWidth * 0.04),
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
                'Your landmarks',
                Row(
                  children: [
                    Image.asset(
                      'assets/Property 1=Frame 6.png',
                      width: screenWidth * 0.2,
                      height: screenWidth * 0.2,
                    ),
                    SizedBox(width: screenWidth * 0.04),
                    Expanded(
                      child: Text(
                        'Place de la Bastille',
                        style: TextStyle(fontSize: screenWidth * 0.04),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Edit',
                      style: TextStyle(color: Colors.blue, fontSize: screenWidth * 0.04),
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
                    _buildRowWithEdit(context, 'Tour languages', 'Afrikaans', screenWidth),
                    SizedBox(height: screenWidth * 0.02),
                    Text('How many people will be on the tour?'),
                    _buildRowWithEdit(context, 'n5-10', '', screenWidth),
                  ],
                ),
              ),
              SizedBox(height: screenWidth * 0.08),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _beginGuideSearch,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    padding: EdgeInsets.symmetric(vertical: screenWidth * 0.04),
                  ),
                  child: Text('Begin guide search', style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white)),
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
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenWidth * 0.02),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildRowWithEdit(BuildContext context, String title, String value, double screenWidth) {
    return Row(
      children: [
        Text(title, style: TextStyle(fontSize: screenWidth * 0.04)),
        Spacer(),
        Text(
          value,
          style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.black54),
        ),
        SizedBox(width: screenWidth * 0.02),
        Text(
          'Edit',
          style: TextStyle(color: Colors.blue, fontSize: screenWidth * 0.04),
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

  void _beginGuideSearch() {
    // Implement the search functionality
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResponseScreen()), // Ensure this is the correct page to navigate to
    );
    print('Search for guides');
  }
}
