import 'package:estonedge/base/screens/base_widget.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class AddRoomScreen extends BaseWidget {
  const AddRoomScreen({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends BaseWidgetState<AddRoomScreen> {
  var roomName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add Room',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Room Name',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
                controller: roomName,
                hintText: 'Room Name',
                icon: const Icon(Icons.house),
                isPassword: false),
            SizedBox(height: 50),
            CustomButton(
                btnText: 'Continue',
                width: double.infinity,
                color: Colors.blueAccent,
                onPressed: () {
                  Navigator.pushNamed(context, '/selectRoomImage');
                })
          ],
        ),
      ),
    );
  }
}
