import 'package:estonedge/base/constants/app_images.dart';
import 'package:estonedge/base/screens/base_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends BaseWidget {
  const HomeScreen({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() => _HomeScreenState();
}

class _HomeScreenState extends BaseWidgetState<HomeScreen> {
  /// get user name from database
  String userName = 'Drax';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*drawer: Drawer(
        backgroundColor: Colors.blueAccent,
        width: MediaQuery.of(context).size.width / 3,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                spacing: 30,
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  buildCustomDrawerItem('Home', Icons.home_outlined, () {}),
                  buildCustomDrawerItem('Room', Icons.bed_outlined, () {}),
                  buildCustomDrawerItem(
                      'People', Icons.people_outline_outlined, () {}),
                  buildCustomDrawerItem('Device', Icons.router_outlined, () {}),
                  Spacer(),
                  buildCustomDrawerItem('Logout', Icons.login_outlined, () {}),
                ],
              ),
            ],
          ),
        ),
      ),*/
      drawer: Drawer(
        backgroundColor: Colors.blueAccent,
        width: MediaQuery.of(context).size.width / 3,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      spacing: 30,
                      direction: Axis.vertical,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        buildCustomDrawerItem(
                            'Home', Icons.home_outlined, () {}),
                        buildCustomDrawerItem(
                            'Room', Icons.bed_outlined, () {}),
                        buildCustomDrawerItem(
                            'People', Icons.people_outline_outlined, () {}),
                        buildCustomDrawerItem(
                            'Device', Icons.router_outlined, () {}),
                      ],
                    ),
                  ],
                ),
              ),
              buildCustomDrawerItem('Logout', Icons.login_outlined, () {}),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
      body: Builder(builder: (context) {
        return SafeArea(
          child: Column(
            children: <Widget>[
              buildCustomAppBar(context),
              const SizedBox(
                height: 50,
              ),
              buildAddRoomButton(),
            ],
          ),
        );
      }),
    );
  }

  Widget buildCustomAppBar(BuildContext context) {
    /// Row widget to create a custom appbar
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shadowColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                ),
                onPressed: () {
                  print("Open Drawer");
                  Scaffold.of(context).openDrawer();
                },
                child: Image.asset(AppImages.drawerIcon),
              ),
              Text(
                'Hi, ${userName}',
                style: const TextStyle(
                    fontSize: 32,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Image.asset(AppImages.homeProfileIcon),
        ],
      ),
    );
  }

  Widget buildAddRoomButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 15),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          style: BorderStyle.solid,
          color: const Color.fromRGBO(192, 192, 192, 1),
        )),
        child: MaterialButton(
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(AppImages.addRoomPlusIcon),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  'Add New Room',
                  style: TextStyle(
                    fontFamily: 'Lexend',
                    fontSize: 14,
                    color: Color.fromRGBO(192, 192, 192, 1),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCustomDrawerItem(
      String text, IconData iconData, Function() onClick) {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: onClick,
          icon: Icon(
            iconData,
            color: Colors.white,
            size: 50,
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            fontFamily: 'Lexend',
            fontSize: 13,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
