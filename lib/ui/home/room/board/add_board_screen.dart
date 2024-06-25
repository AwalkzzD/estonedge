import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_dropdown.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/base/widgets/drop_down_list.dart';
import 'package:estonedge/ui/home/room/board/board_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../../base/src_constants.dart';

class AddBoardScreen extends StatelessWidget {
  const AddBoardScreen({super.key});

  static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => const AddBoardScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Image.asset(AppImages.appBarBackIcon),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          },
        ),
        centerTitle: true,
        title: const Text(
          'Add Board',
          style: fs24BlackBold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text(
              'Board',
              style: fs14BlackSemibold,
            ),
            const SizedBox(height: 10),
            CustomDropdown(
                hint: 'Select Board Type',
                items: const ['2 M', '3 M', '4 M', '12 M'],
                onClick: (value) {}),
            const SizedBox(height: 30),
            Text(
              'Switch',
              style: fs14BlackSemibold,
            ),
            const SizedBox(height: 10),
            CustomDropdown(
                hint: 'Select Switch Type',
                items: const ['2 S', '3 S', '4 S', '12 S'],
                onClick: (value) {}),
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
