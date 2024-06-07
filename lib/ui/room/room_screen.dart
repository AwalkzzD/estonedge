import 'package:flutter/material.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(color: Colors.blue),
              Stack(
                children: [
                  Container(
                      //height: 300,
                      margin:
                          const EdgeInsets.only(left: 30, right: 30, top: 30),
                      child: Image.asset('assets/images/Room.png')),
                  Container(
                    height: 40,
                    margin: const EdgeInsets.only(left: 48, top: 40),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Living Room',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '3/3',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                margin: const EdgeInsets.only(left: 30, right: 30),
                child: const Row(
                  children: [
                    SizedBox(
                      width: 10,
                      height: 60,
                    ),
                    CircleAvatar(
                        backgroundColor: Colors.white, child: Icon(Icons.air)),
                    SizedBox(width: 10),
                    CircleAvatar(
                        backgroundColor: Colors.white, child: Icon(Icons.tv)),
                    SizedBox(width: 10),
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.lightbulb_outline)),
                  ],
                ),
              ),
            ],
          );
        },
        itemCount: 5,
      ),
    );
  }
}
