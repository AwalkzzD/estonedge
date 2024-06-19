import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/base/base_page.dart';
import 'package:estonedge/base/widgets/keep_alive_widget.dart';
import 'package:estonedge/ui/home/home_screen_bloc.dart';
import 'package:estonedge/ui/home/room/room_screen.dart';
import 'package:estonedge/ui/home/scheduler/schedule_details_screen.dart';
import 'package:estonedge/ui/home/scheduler/schedule_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../base/src_components.dart';
import '../../base/src_constants.dart';
import '../../base/utils/widgets/custom_appbar.dart';
import 'dashboard/dashboard_screen.dart';

class HomeScreen extends BasePage {
  const HomeScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _HomeScreenState();
}

class _HomeScreenState extends BasePageState<HomeScreen, HomeScreenBloc> {
  final HomeScreenBloc _bloc = HomeScreenBloc();

  /// Get user name from the database
  String userName = 'User';
  List<Widget> _pages = [];

  void _onItemTapped(int index) {
    getBloc().updateCurrentIndex(index);
  }

  @override
  Widget? getBottomNavigationBar() {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
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
    _pages = [
      const KeepAlivePage(child: DashboardScreen()),
      const KeepAlivePage(child: RoomScreen()),
      const KeepAlivePage(child: ScheduleHomeScreen()),
      const KeepAlivePage(child: ScheduleDetailsScreen()),
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
    return StreamBuilder<int>(
      stream: getBloc().currentPageIndexStream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return _pages[snapshot.data!];
        } else {
          return getBaseLoadingWidget();
        }
      },
    );
  }

  @override
  bool customBackPressed() => true;

  @override
  void onBackPressed(bool didPop, BuildContext context) {
    print('step 1');
    if (!didPop) {
      print('step 2');
      if (isDrawerOpen()) {
        print('step 3');
        closeDrawer();
      } else {
        print('step 4');
        if (getBloc().currentPageIndex.value != 0) {
          print('step 5');
          getBloc().currentPageIndex.add(0);
        } else if (getBloc().currentPageIndex.value == 0) {
          print('step 6');
          SystemNavigator.pop();
        } else {
          print('step 7');
          final navigator = Navigator.of(context);
          bool value = isOTSLoading();
          if (!value) {
            print('step 8');
            navigator.pop();
          }
        }
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
    getBloc().logout();
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
