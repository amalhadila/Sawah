import 'package:flutter/material.dart';

void main() {
  runApp(tour_guide());
}

class tour_guide extends StatelessWidget {
  const tour_guide({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandmarkSelectionScreen(),
    );
  }
}

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
          child: Text('What do you want to see?'),
        ),
        backgroundColor: Color(0xffFFFFFF), // Background color of the app bar
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              // Implement the close action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.map,
                      color: Color.fromRGBO(
                          219, 113, 0, 1)), // Color of the map icon
                  onPressed: () {
                    // Implement the map action
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    // Implement the "I don't know. Pick for me!" action
                  },
                  child: Text("I don't know. Pick for me!"),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: landmarks.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.grey[200],
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectedLandmarksScreen(),
                  ),
                );
              },
              child: Text('Next 1'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(
                        219, 113, 0, 1)), // Color of the "Next 1" button
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                minimumSize:
                    MaterialStateProperty.all<Size>(Size(double.infinity, 50)),
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
        title: Center(
          child: Text('This is what you chose'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              // Implement the close action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
                  child: Icon(Icons.location_on, color: Colors.white),
                ),
                title: Text('Place de la Bastille'),
                trailing: TextButton(
                  onPressed: () {
                    // Implement the delete action
                  },
                  child: Text('delete'),
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
            ElevatedButton(
              onPressed: () {
                // Implement the next action
              },
              child: Text('Next 1'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(
                        219, 113, 0, 1)), // Color of the "Next 1" button
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                minimumSize:
                    MaterialStateProperty.all<Size>(Size(double.infinity, 50)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
