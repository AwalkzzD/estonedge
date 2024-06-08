import 'package:flutter/material.dart';

class ScheduleDetailsScreen extends StatefulWidget {
  const ScheduleDetailsScreen({super.key});

  @override
  State<ScheduleDetailsScreen> createState() => _ScheduleDetailsScreenState();
}

class _ScheduleDetailsScreenState extends State<ScheduleDetailsScreen> {
  List<String> roomList = <String>['room1', 'room2', 'room3', 'room4'];
  List<String> boardList = <String>['board1', 'board2', 'board3', 'board4'];
  List<String> switchList = <String>[
    'switch1',
    'switch2',
    'switch3',
    'switch4'
  ];

  String? selectedRoom;
  String? selectedBoard;
  String? selectedSwitch;

  @override
  void initState() {
    super.initState();
    selectedRoom = roomList.first;
    selectedBoard = boardList.first;
    selectedSwitch = switchList.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 50, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ddl('Room', roomList, selectedRoom, (newValue) {
              setState(() {
                selectedRoom = newValue;
              });
            }),
            const SizedBox(
              height: 20,
            ),
            _ddl('Board', boardList, selectedBoard, (newValue) {
              setState(() {
                selectedBoard = newValue;
              });
            }),
            const SizedBox(
              height: 20,
            ),
            _ddl('Switch', switchList, selectedSwitch, (newValue) {
              setState(() {
                selectedSwitch = newValue;
              });
            }),
            SizedBox(
              height: 180,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blue,
                    side: BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Less rounded border
                    ),
                    minimumSize: Size(100, 40), // More width
                  ),
                  child: Text('Select'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.grey,
                    side: BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Less rounded border
                    ),
                    minimumSize: Size(100, 40), // More width
                  ),
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _ddl(String ddlName, List<String> items, String? selectedValue,
      ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ddlName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.grey,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            value: selectedValue,
            onChanged: onChanged,
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            decoration: InputDecoration.collapsed(hintText: ''),
          ),
        ),
      ],
    );
  }
}
