import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/base/src_constants.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/data/remote/model/user/user_response.dart'
    as user_model;
import 'package:estonedge/ui/home/room/switch/switch_details_screen_bloc.dart';
import 'package:estonedge/ui/home/room/switch/widget/switch_item_widget.dart';
import 'package:flutter/material.dart';

class SwitchDetailsScreen extends BasePage {
  final user_model.Board board;

  const SwitchDetailsScreen({super.key, required this.board});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _SwitchDetailsScreenState();

  static Route<dynamic> route(user_model.Board board) {
    return CustomPageRoute(
        builder: (context) => SwitchDetailsScreen(board: board));
  }
}

class _SwitchDetailsScreenState
    extends BasePageState<SwitchDetailsScreen, SwitchDetailsScreenBloc> {
  final SwitchDetailsScreenBloc _bloc = SwitchDetailsScreenBloc();

  @override
  SwitchDetailsScreenBloc getBloc() => _bloc;

  @override
  Widget? getAppBar() {
    return AppBar(
      backgroundColor: white,
      centerTitle: true,
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: Image.asset(AppImages.appBarBackIcon),
            onPressed: () {
              Navigator.pop(context);
            },
          );
        },
      ),
      title: const Text(
        'Switch Details',
        style: fs24BlackBold,
      ),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return buildSwitchList();
  }

  Widget buildSwitchList() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('Switch Details', style: fs20BlackSemibold),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: widget.board.switches.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.3,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child:
                      SwitchItemWidget(switch1: widget.board.switches[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
