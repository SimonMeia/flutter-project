import 'package:flutter/material.dart';
import 'package:flutter_project/views/pages/home_page.dart';
import 'package:flutter_project/views/pages/profile_page.dart';

List<Widget> pages = [HomePage(), ProfilePage()];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Tree'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ProfilePage();
                  },
                ),
              );
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: pages.elementAt(0),
    );
  }
}
