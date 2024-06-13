import 'package:estonedge/base/constants/app_images.dart';
import 'package:estonedge/base/screens/base_widget.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class SelectRoomImageScreen extends BaseWidget {
  const SelectRoomImageScreen({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() => _SelectRoomImageScreenState();
}

class _SelectRoomImageScreenState
    extends BaseWidgetState<SelectRoomImageScreen> {
  List<bool> selectedImages = List.generate(
      6, (index) => false); // List to keep track of selected images

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
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Flexible(
              child: GridView.builder(
                itemCount: 6, // Total number of containers
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 containers per row
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 0,
                  childAspectRatio: 1.3, // Adjust the aspect ratio if needed
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedImages[index] =
                            !selectedImages[index]; // Toggle selection state
                      });
                    },
                    child: Stack(
                      children: [
                        Image.asset(
                            'assets/images/room.png'), // Display the image
                        if (selectedImages[
                            index]) // Display tick icon if selected
                          Positioned(
                            bottom: 8,
                            right: 8,
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 24,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            CustomButton(
              btnText: 'Continue',
              width: double.infinity,
              color: Colors.blueAccent,
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Icon(Icons.add_task),
                  content: const Text('Room Added Successfully'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
