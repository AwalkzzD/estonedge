import 'package:estonedge/base/constants/app_images.dart';
import 'package:estonedge/base/screens/base_widget.dart';
import 'package:estonedge/base/utils/widgets/custom_appBar.dart';
import 'package:estonedge/ui/home/add_room_screen.dart';
import 'package:estonedge/ui/home/frequently_used_screen.dart';
import 'package:estonedge/ui/room/room_screen.dart';
import 'package:estonedge/ui/scheduler/schedule_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends BaseWidget {
  const HomeScreen({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() => _HomeScreenState();
}

class _HomeScreenState extends BaseWidgetState<HomeScreen> {
  /// Get user name from the database
  String userName = 'Drax';
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    AddRoomScreen(),
    FrequentlyUsedScreen(),
    ScheduleScreen(),
    RoomScreen(),
  ];

  List<String> getTitles() {
    return [
      'Hi $userName',
      'Frequently',
      'Device Screen',
      'Room',
    ];
  }

  List<String> getImages() {
    return [
      AppImages.homeProfileIcon,
      AppImages.addRoomPlusIcon,
      AppImages.addRoomPlusIcon,
      AppImages.addRoomPlusIcon,
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final titles = getTitles();
    final imgs = getImages();
    return Scaffold(
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
                CustomAppbar(context,
                    title: titles[_selectedIndex],
                    appBarImage: imgs[_selectedIndex]),
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
                        buildCustomDrawerItem('Home', Icons.home_outlined,
                            () => _onItemTapped(0)),
                        buildCustomDrawerItem(
                            'Room', Icons.bed_outlined, () => _onItemTapped(3)),
                        buildCustomDrawerItem(
                            'People',
                            Icons.people_outline_outlined,
                            () => _onItemTapped(1)),
                        buildCustomDrawerItem('Schedule', Icons.calendar_month,
                            () => _onItemTapped(2)),
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
      body: _pages[_selectedIndex],
      floatingActionButton: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      margin: const EdgeInsets.only(left: 28),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      padding: const EdgeInsets.symmetric(
          horizontal: 20.0), // Equal spacing from both sides
      child: BottomNavigationBar(
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
          onPressed: () {
            onClick();
            Navigator.pop(context); // Close the drawer after clicking an item
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
}
