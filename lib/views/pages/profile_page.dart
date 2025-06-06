import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Container(
        padding: EdgeInsets.all(24),
        width: double.infinity,
        // color: Colors.amber,
        child: Column(
          spacing: 24,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name'),
                TextField(
                  controller: name,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  onEditingComplete: () {
                    setState(() {});
                  },
                ),
                Text(name.text),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('UUID'),
                TextField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                  readOnly: true,
                ),
              ],
            ),

            ElevatedButton(onPressed: () {}, child: Text('Save')),
          ],
        ),
      ),
    );
  }
}
