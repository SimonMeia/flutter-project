import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SendDogPage extends StatefulWidget {
  const SendDogPage({super.key});

  @override
  State<SendDogPage> createState() => _SendDogPageState();
}

class _SendDogPageState extends State<SendDogPage> {
  int? selectedIndex;
  List imageUrls = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/dogs');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        print('Response data: $jsonResponse');
        setState(() {
          imageUrls.clear(); // Clear existing URLs
          for (var url in jsonResponse) {
            imageUrls.add(url);
          }
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> send(int index) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/send');

    try {
      final response = await http.post(url, body: {'index': index.toString()});
      if (response.statusCode == 200) {
        print('Response body: ${response.body}');
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Choose an item',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: List.generate(imageUrls.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: selectedIndex == index
                        ? Border.all(color: Colors.blue, width: 3)
                        : Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      imageUrls[index],
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade200,
                          child: const Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 50,
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: selectedIndex != null
                ? () {
                    // Handle button press
                    send(selectedIndex!);
                  }
                : null,
            child: const Text('Send Selected'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              getData();
            },
            child: const Text('Refresh data'),
          ),
        ),
      ],
    );
  }
}
