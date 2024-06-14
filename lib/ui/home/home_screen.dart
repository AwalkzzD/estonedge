import 'package:estonedge/base/constants/app_images.dart';
import 'package:estonedge/base/screens/base_widget.dart';
import 'package:estonedge/base/utils/extension_functions.dart';
import 'package:estonedge/base/utils/widgets/custom_appbar.dart';
import 'package:estonedge/data/remote/repository/auth/auth_repository_provider.dart';
import 'package:estonedge/ui/home/dashboard/dashboard_screen.dart';
import 'package:estonedge/ui/home/home_screen_provider.dart';
import 'package:estonedge/ui/home/room/room_screen.dart';
import 'package:estonedge/ui/home/scheduler/schedule_details_screen.dart';
import 'package:estonedge/ui/home/scheduler/schedule_home_screen.dart';
import 'package:estonedge/ui/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends BaseWidget {
  const HomeScreen({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() => _HomeScreenState();
}

class _HomeScreenState extends BaseWidgetState<HomeScreen> {

  /// Get user name from the database
  String userName = 'User';
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardScreen(),
    const RoomScreen(),
    const ProfileScreen(),
    const ScheduleDetailsScreen(),
  ];

  get getTitles => [
        'Hi $userName',
        'My Rooms',
        'Account',
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
  Widget build(BuildContext context) {
    final _userName = ref.watch(userNameProvider);

    getLoadingView();

    _userName.when(
        data: (authUserAttributesList) {
          setState(() {
            userName = authUserAttributesList.getUsername();
          });
        },
        error: (Object error, StackTrace stackTrace) {},
        loading: () {});
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Image.asset(
                  AppImages.drawerIcon), // You can use the built-in menu icon
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        //automaticallyImplyLeading: false,
        title: Builder(builder: (context) {
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
                    ref.read(authRepositoryProvider).logout();
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
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
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
}
