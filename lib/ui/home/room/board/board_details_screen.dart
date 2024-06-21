import 'package:estonedge/base/constants/app_styles.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/ui/home/room/switch/switch_details_screen.dart';
import 'package:flutter/material.dart';

class BoardDetailsScreen extends StatelessWidget {
  BoardDetailsScreen({super.key});

  static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => BoardDetailsScreen());
  }

  final List<String> boards = ['Board 1', 'Board 2', 'Board 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Board Details',
          style: fs24BlackSemibold,
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Board', style: fs16BlackSemibold),
                TextButton(
                  onPressed: () {
                    // Handle add board action
                  },
                  child: TextButton(
                      onPressed: () {},
                      child: const Text('+ Add Board',
                          style: TextStyle(fontSize: 16, color: Colors.blue))),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: boards.length,
                itemBuilder: (context, index) {
                  return BoardCard(boardName: boards[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BoardCard extends StatelessWidget {
  final String boardName;

  BoardCard({required this.boardName});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(boardName),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PopupMenuButton<String>(
              onSelected: (value) {
                // Handle menu item selection
                if (value == 'Edit') {
                  // Handle edit action
                } else if (value == 'Delete') {
                  // Handle delete action
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'Edit',
                  child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Edit'),
                  ),
                ),
                const PopupMenuItem(
                  value: 'Delete',
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Delete'),
                  ),
                ),
              ],
              icon: const Icon(Icons.more_vert),
            ),
            TextButton(
              onPressed: () {
                // Navigator.pushNamed(context, '/switchDetails');
                Navigator.push(context, SwitchDetailsScreen.route());
              },
              child: const Text(
                'Configure board',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
