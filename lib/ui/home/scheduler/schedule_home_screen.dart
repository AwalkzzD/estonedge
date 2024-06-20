import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/base/base_page.dart';
import 'package:estonedge/base/constants/app_styles.dart';
import 'package:estonedge/base/src_widgets.dart';
import 'package:estonedge/ui/home/scheduler/schedule_home_screen_bloc.dart';
import 'package:flutter/material.dart';

class ScheduleHomeScreen extends BasePage {
  const ScheduleHomeScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _ScheduleHomeScreenState();

  static Route<dynamic> route() {
    print('IN SchduleScreen');
    return CustomPageRoute(builder: (context) => const ScheduleHomeScreen());
  }
}

class _ScheduleHomeScreenState
    extends BasePageState<ScheduleHomeScreen, ScheduleHomeScreenBloc> {
  List<String> days = ['S', 'M', 'T', 'W', 'T', 'F', 'S', 'S'];
  Set<int> selectedIndices = Set<int>();
  
  ScheduleHomeScreenBloc _bloc = ScheduleHomeScreenBloc();

  @override
  ScheduleHomeScreenBloc getBloc() => _bloc;

  @override
  Widget buildWidget(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {        
        return SafeArea(
          child: Card(
              elevation: 4,
              margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.lightbulb),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hall Tube',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      Text(
                        '08:45 AM',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        'ON',
                        style: fs14BlackSemibold,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 35),
                    height: 50,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: days.length,
                      itemExtent: 40, // Adjust the size of each item
                      itemBuilder: (context, index) {
                        return IconButton(
                          onPressed: () {
                            setState(() {
                              if (selectedIndices.contains(index)) {
                                selectedIndices.remove(index);
                              } else {
                                selectedIndices.add(index);
                              }
                            });
                          },
                          icon: CircleAvatar(
                            backgroundColor: selectedIndices.contains(index)
                                ? Colors.blue
                                : Colors.grey.shade400,
                            child: Text(days[index]),
                          ),
                        );
                      },
                    ),
                  )
                ],
              )),
        );
      },
    );
  }
}
