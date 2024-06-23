import 'package:estonedge/base/constants/app_styles.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/base/widgets/drop_down_list.dart';
import 'package:estonedge/ui/home/room/board/board_details_screen.dart';
import 'package:flutter/material.dart';

class AddBoardScreen extends StatelessWidget {
  const AddBoardScreen({super.key});

  static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => const AddBoardScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Add Board',
            style: fs24BlackSemibold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text(
              'Board',
              style: fs14BlackSemibold,
            ),
            const SizedBox(height: 10),
            GenericDropdown(
              items: ['2 M', '3 M', '4 M', '12 M'],
              hint: 'Select Board Type',
              onChanged: (String? value) {
                // Handle the selected value
                print('Selected gender: $value');
              },
            ),
            const SizedBox(height: 30),
            Text(
              'Switch',
              style: fs14BlackSemibold,
            ),
            const SizedBox(height: 10),
            GenericDropdown(
              items: ['2 S', '3 S', '4 S', '12 S'],
              hint: 'Select Switch Type',
              onChanged: (String? value) {
                // Handle the selected value
                print('Selected gender: $value');
              },
            ),
            const SizedBox(height: 80),
            Center(
              child: CustomButton(
                  btnText: 'Submit',
                  color: Colors.blue,
                  onPressed: () {
                    // Navigator.pushNamed(context, '/boardDetails');
                    Navigator.push(
                        context,
                        BoardDetailsScreen.route(
                            isFromRoomDetailsScreen: false));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
