import 'package:estonedge/base/screens/base_widget.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_textfield.dart';
import 'package:estonedge/ui/auth/validators.dart';
import 'package:estonedge/ui/home/room/add_room/add_room_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddRoomScreen extends BaseWidget {
  const AddRoomScreen({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends BaseWidgetState<AddRoomScreen> {
  var roomNameController = TextEditingController();
  String? nameError;

  @override
  void dispose() {
    roomNameController.dispose();
    super.dispose();
  }

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
              controller: roomNameController,
              hintText: 'Room Name',
              icon: const Icon(Icons.house),
              isPassword: false,
              errorText: nameError,
              onChanged: (text) {
                setState(() {
                  nameError = validateName(text);
                });
              },
            ),
            SizedBox(height: 50),
            Consumer(
              builder: (context, ref, _) {
                return CustomButton(
                  btnText: 'Continue',
                  width: double.infinity,
                  color: Colors.blueAccent,
                  onPressed: () {
                    setState(() {
                      nameError = validateName(roomNameController.text);
                    });

                    if (nameError == null) {
                      ref.read(roomNameProvider.notifier).state =
                          roomNameController.text;
                      Navigator.pushNamed(context, '/selectRoomImage');
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
