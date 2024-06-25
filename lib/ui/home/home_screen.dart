import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/base/base_page.dart';
import 'package:estonedge/base/utils/widgets/custom_appbar.dart';
import 'package:estonedge/base/widgets/bottom_bar/lazy_load_indexed_stack.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/ui/auth/login/login_screen.dart';
import 'package:estonedge/ui/home/dashboard/dashboard_screen.dart';
import 'package:estonedge/ui/home/home_screen_bloc.dart';
import 'package:estonedge/ui/home/room/add_room/add_room_screen.dart';
import 'package:estonedge/ui/home/room/board/add_board/add_board_screen.dart';
import 'package:estonedge/ui/home/room/room_screen.dart';
import 'package:estonedge/ui/home/scheduler/schedule_home_screen.dart';
import 'package:estonedge/ui/profile/profile_screen.dart';
import 'package:estonedge/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../base/src_constants.dart';
import '../../base/widgets/keep_alive_widget.dart';

class HomeScreen extends BasePage {
  const HomeScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _HomeScreenState();

  static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => const HomeScreen());
  }
}

class _HomeScreenState extends BasePageState<HomeScreen, HomeScreenBloc> {
  final HomeScreenBloc _bloc = HomeScreenBloc();

  /// Get user name from the database
  String userName = getUserName();
  List<Widget> _pages = [];

  void _onItemTapped(int index) {
    getBloc().updateCurrentIndex(index);
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
                          onClick: () => navigateToScheduleRoom()),
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
      backgroundColor: Colors.white,
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
                                appBarTrailingImage: AppImages.homeProfileIcon,
                                trailingIconAction: () {
                                  getBloc().updateCurrentIndex(2);
                                },
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
                                appBarTrailingImage: AppImages.appBarPlusIcon,
                                trailingIconAction: () {
                                  closeDrawer();
                                  navigateToAddRoom();
                                },
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
                                appBarTrailingImage: AppImages.blankIcon,
                                title: 'Your Profile',
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
                          appBarTrailingImage: AppImages.homeProfileIcon,
                          trailingIconAction: () {
                            getBloc().updateCurrentIndex(2);
                          },
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
    _pages = [
      const KeepAlivePage(child: DashboardScreen()),
      const KeepAlivePage(child: RoomScreen()),
      const KeepAlivePage(child: ProfileScreen()),
      const KeepAlivePage(child: ScheduleHomeScreen()),
    ];
    super.initState();
  }

  @override
  void onReady() {
    getInitData();
    super.onReady();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Stack(
      children: [
        buildBodyPages(),
        buildBottomNavBar(),
      ],
    );
  }

  Widget buildBodyPages() {
    return StreamBuilder<int>(
      stream: getBloc().currentPageIndexStream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return LazyLoadIndexedStack(
            index: snapshot.data ?? 0,
            preloadIndexes: const [],
            children: _pages,
          );
        } else {
          return getBaseLoadingWidget();
        }
      },
    );
  }

  Widget buildBottomNavBar() {
    return Positioned(
      left: 10,
      right: 10,
      bottom: 15,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: StreamBuilder<int>(
              stream: getBloc().currentPageIndexStream,
              builder: (context, snapshot) {
                return BottomNavigationBar(
                  currentIndex: (snapshot.data != null &&
                          (snapshot.data! >= 0 && snapshot.data! <= 2))
                      ? snapshot.data!
                      : 0,
                  showSelectedLabels: true,
                  backgroundColor: Colors.transparent,
                  selectedItemColor: Colors.white,
                  unselectedItemColor: Colors.white.withOpacity(0.5),
                  type: BottomNavigationBarType.fixed,
                  onTap: (index) {
                    _onItemTapped(index);
                  },
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
                );
              }),
        ),
      ),
    );
  }

  @override
  bool customBackPressed() => true;

  @override
  void onBackPressed(bool didPop, BuildContext context) {
    if (!didPop) {
      if (isDrawerOpen()) {
        closeDrawer();
      } else {
        SystemNavigator.pop();
      }
    }
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
            Navigator.pop(context);
            onClick();
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
    getBloc().logout();
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context, rootNavigator: true)
          .pushReplacement(LoginScreen.route());
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
    Navigator.of(globalContext, rootNavigator: true)
        .push(AddRoomScreen.route());
  }

  void navigateToScheduleRoom() =>
      Navigator.of(context).push(ScheduleHomeScreen.route());
}
