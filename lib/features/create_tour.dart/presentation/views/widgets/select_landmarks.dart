import 'package:flutter/material.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/features/create_tour.dart/presentation/views/widgets/user_lang.dart';




class LandmarkSelectionScreen extends StatelessWidget {
  final List<Map<String, String>> landmarks = [
    {
      "name": "Panthéon",
      "description": "The Panthéon was the first major monument in Paris."
    },
    {
      "name": "Rodin Museum",
      "description": "Created in 1916 by Auguste Rodin’s own initiative."
    },
    {
      "name": "Centre Pompidou",
      "description":
          "Home to Europe's largest collection of modern and contemporary art."
    },
    {
      "name": "Hotel National des Invalides",
      "description": "One of the most important monuments in Paris."
    },
    {
      "name": "Catacombs of Paris",
      "description": "A maze of limestone quarries under the streets of Paris."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('What do you want to see?',style: TextStyle(fontWeight: FontWeight.w600),),
        ),
        backgroundColor: kbackgroundcolor, // Background color of the app bar
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kmaincolor,
            size: 22,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter the landmark's name",
                      prefixIcon: Icon(Icons.search,
                          color: Color.fromRGBO(219, 113, 0,
                              1)), // Color of the icon beside search bar
                      hintStyle: TextStyle(fontSize: 16),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Color.fromARGB(255, 255, 248, 241),
                    ),
                  ),
                ),
                
              ],
            ),
            SizedBox(height: 16.0),

            Expanded(
              child: ListView.builder(
                itemCount: landmarks.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: kCardColor,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.location_on, color: Colors.white),
                      ),
                      title: Text(landmarks[index]['name']!),
                      subtitle: Text(landmarks[index]['description']!),
                      trailing: IconButton(
                        icon: Icon(Icons.add,
                            color: Color.fromRGBO(
                                219, 113, 0, 1)), // Color of the '+' button
                        onPressed: () {
                          // Implement the add action
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 60),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectedLandmarksScreen(),
                    ),
                  );
                },
                
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kmaincolor, 
                    minimumSize: Size.fromHeight(50), 
                  ),
              
                  child: const Text('Next', style: TextStyle(color: kbackgroundcolor, fontWeight: FontWeight.bold, fontSize: 17)),
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectedLandmarksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kmaincolor,
            size: 22,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: kbackgroundcolor,
        title: Center(
          child: Text('This is what you chose',style: TextStyle(fontWeight: FontWeight.w600),),
        ),
        
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:16.0),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: kCardColor,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.location_on, color: Colors.white),
                ),
                title: Text('Place de la Bastille'),
                trailing: TextButton(
                  onPressed: () {
                    // Implement the delete action
                  },
                  child: Text('delete',style: TextStyle(color: kmaincolor,fontWeight: FontWeight.w700),),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[200],
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.add, color: Colors.white),
                ),
                title: Text('Add a new landmark'),
                onTap: () {
                  // Implement the add new landmark action
                },
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 60),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LanguageSelectionScreen(),
                    ),
                  );
                },
                
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kmaincolor, 
                    minimumSize: Size.fromHeight(50), 
                  ),
              
                  child: const Text('Next', style: TextStyle(color: kbackgroundcolor, fontWeight: FontWeight.bold, fontSize: 17)),
                
                      ),
            )],
        ),
      ),
    );
  }
}