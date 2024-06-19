import 'package:estonedge/base/constants/app_images.dart';
import 'package:estonedge/base/screens/base_widget.dart';
import 'package:estonedge/base/utils/extension_functions.dart';
import 'package:estonedge/base/utils/widgets/custom_appbar.dart';
import 'package:estonedge/data/remote/repository/auth/auth_repository_provider.dart';
import 'package:estonedge/ui/home/dashboard/dashboard_screen.dart';
import 'package:estonedge/ui/home/home_screen_provider.dart';
import 'package:estonedge/ui/home/room/room_screen.dart';
import 'package:estonedge/ui/home/scheduler/schedule_details_screen.dart';
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
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  label: 'Profile',
                ),
              ],
            );
          }),
    );
  }

  @override
  Widget? getDrawer() {
    return Drawer(
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
                          onClick: () => navigateToLogin()),
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
    );
  }

  @override
  Widget? getAppBar() {
    return AppBar(
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: Image.asset(AppImages.drawerIcon),
            onPressed: () {
              openDrawer();
            },
          );
        },
      ),
      title: StreamBuilder<int>(
          stream: getBloc().currentPageIndexStream,
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              /// Dashboard Screen
              if (snapshot.data == 0) {
                return StreamBuilder<String>(
                    stream: getBloc().userNameStream,
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        userName = snapshot.data!;
                      }
                      return Builder(builder: (context) {
                        return SafeArea(
                          child: Column(
                            children: <Widget>[
                              CustomAppbar(
                                context,
                                title: 'Hi $userName',
                                appBarImage: AppImages.homeProfileIcon,
                                trailingIconAction: () {
                                  getBloc().updateCurrentIndex(2);
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        );
                      });
                    });
              }
              /// Rooms Screen
              else if (snapshot.data == 1) {
                return StreamBuilder<String>(
                    stream: getBloc().userNameStream,
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        userName = snapshot.data!;
                      }
                      return Builder(builder: (context) {
                        return SafeArea(
                          child: Column(
                            children: <Widget>[
                              CustomAppbar(
                                context,
                                title: 'My Rooms',
                                appBarImage: AppImages.appBarPlusIcon,
                                trailingIconAction: () {
                                  navigateToAddRoom();
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        );
                      });
                    });
              }
              /// Profile Screen
              else if (snapshot.data == 2) {
                return StreamBuilder<String>(
                    stream: getBloc().userNameStream,
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        userName = snapshot.data!;
                      }
                      return Builder(builder: (context) {
                        return SafeArea(
                          child: Column(
                            children: <Widget>[
                              CustomAppbar(
                                context,
                                title: 'Your Profile',
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        );
                      });
                    });
              } else {
                return Builder(builder: (context) {
                  return SafeArea(
                    child: Column(
                      children: <Widget>[
                        CustomAppbar(
                          context,
                          title: 'Hi $userName',
                          appBarImage: AppImages.homeProfileIcon,
                          trailingIconAction: () {
                            getBloc().updateCurrentIndex(2);
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
                });
              }
            } else {
              return const SizedBox();
            }
          }),
    );
  }

  @override
  void initState() {
    getInitData();
    super.initState();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return StreamBuilder<int>(
        stream: getBloc().currentPageIndexStream,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return _pages[snapshot.data!];
          } else {
            return getBaseLoadingWidget();
          }
        });
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
  HomeScreenBloc getBloc() => _bloc;

  void getInitData() {
    getBloc().getUserAttributes((value) {
      print(value);
    });
  }

  void navigateToAddRoom() {
    Navigator.of(context).pushNamed('/addRoom');
  }
}
