import 'package:estonedge/base/basePage.dart';
import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/ui/home_test/home_screen_test_bloc.dart';
import 'package:flutter/material.dart';

import '../../base/constants/app_images.dart';
import '../../base/utils/widgets/custom_appbar.dart';
import '../home/dashboard/dashboard_screen.dart';
import '../home/room/room_screen.dart';
import '../home/scheduler/schedule_details_screen.dart';
import '../home/scheduler/schedule_home_screen.dart';

class HomeScreenTest extends BasePage {
  const HomeScreenTest({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _HomeScreenTestState();
}

class _HomeScreenTestState
    extends BasePageState<HomeScreenTest, HomeScreenTestBloc> {
  final HomeScreenTestBloc _bloc = HomeScreenTestBloc();

  /// Get user name from the database
  String userName = 'User';
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardScreen(),
    const RoomScreen(),
    const ScheduleHomeScreen(),
    const ScheduleDetailsScreen(),
  ];

  get getTitles => [
        'Hi $userName',
        'My Rooms',
        'New Screen',
        'Scheduler',
      ];

  get getImages => [
        AppImages.homeProfileIcon,
        AppImages.appBarPlusIcon,
        AppImages.appBarPlusIcon,
        AppImages.appBarPlusIcon,
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    getInitData();
    super.initState();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Image.asset(
                  AppImages.drawerIcon), // You can use the built-in menu icon
              onPressed: () {
                openDrawer();
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        //automaticallyImplyLeading: false,
        title: StreamBuilder<String>(
            stream: getBloc().userNameStream,
            builder: (context, snapshot) {
              if(snapshot.data != null) {
                userName = snapshot.data!;
              }
              return Builder(builder: (context) {
                return SafeArea(
                  child: Column(
                    children: <Widget>[
                      CustomAppbar(
                        context,
                        title: getTitles[_selectedIndex],
                        appBarImage: getImages[_selectedIndex],
                        trailingIconAction: () {},
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                );
              });
            }),
      ),
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
                            text: 'Home',
                            iconData: Icons.home_outlined,
                            onClick: () => _onItemTapped(0)),
                        buildCustomDrawerItem(
                            text: 'Room',
                            iconData: Icons.bed_outlined,
                            onClick: () => _onItemTapped(1)),
                        buildCustomDrawerItem(
                            text: 'Account',
                            iconData: Icons.people_outline_outlined,
                            onClick: () => _onItemTapped(2)),
                        buildCustomDrawerItem(
                            text: 'Schedule',
                            iconData: Icons.schedule_outlined,
                            onClick: () => _onItemTapped(3)),
                      ],
                    ),
                  ],
                ),
              ),
              buildCustomDrawerItem(
                  text: 'Logout',
                  iconData: Icons.login_outlined,
                  onClick: () {
                    navigateToLogin();
                  }),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: 20.0), // Equal spacing from both sides
        child: BottomNavigationBar(
          showSelectedLabels: true,
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.5),
          //currentIndex: _selectedIndex,
          //onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          // Hide labels by default
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bed_outlined),
              label: 'Rooms',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCustomDrawerItem({
    required String text,
    required IconData iconData,
    required Function() onClick,
  }) {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            onClick();
            Navigator.pop(context);
          },
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

  void navigateToLogin() {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context, rootNavigator: true).pushReplacementNamed('/login');
    });
  }

  @override
  HomeScreenTestBloc getBloc() => _bloc;

  void getInitData() {
    getBloc().getUserAttributes((value) {
      print(value);
    });
  }
}
