import 'package:estonedge/base/constants/app_styles.dart';
import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/base/constants/app_images.dart';
import 'package:estonedge/ui/home/room/switch/widget/switch_item_widget_bloc.dart';
import 'package:flutter/material.dart';

class SwitchItemWidget extends BasePage {
  final String deviceImage;
  final String deviceName;
  final int totalDevices;
  final bool isSwitched;
  final Function(bool) onToggle;

  const SwitchItemWidget(this.deviceImage, this.deviceName, this.totalDevices,
      this.isSwitched, this.onToggle,
      {super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _SwitchItemWidgetState();
}

class _SwitchItemWidgetState
    extends BasePageState<SwitchItemWidget, SwitchItemBloc> {
  final SwitchItemBloc _bloc = SwitchItemBloc();

  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Adjust to fit content
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 38, child: Image.asset(widget.deviceImage)),
              Switch(
                activeThumbImage:
                    const AssetImage(AppImages.switchActiveThumbImage),
                inactiveThumbImage:
                    const AssetImage(AppImages.switchInactiveThumbImage),
                activeTrackColor: Colors.blueAccent,
                inactiveTrackColor: Colors.black,
                value: widget.isSwitched,
                onChanged: widget.onToggle,
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  widget.deviceName,
                  style: fs16BlackBold,
                  overflow: TextOverflow.ellipsis, // Handle overflow
                ),
              ),
              // const Spacer(),
              PopupMenuButton<String>(
                onSelected: (value) {
                  // Handle menu item selection
                  if (value == 'Edit') {
                    // Handle edit action
                  } else if (value == 'Favorite') {
                    // Handle delete action
                  } else if (value == 'Delete') {
                    // Handle delete action
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'Edit',
                    child: ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('Edit'),
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'Favorite',
                    child: ListTile(
                      leading: Icon(Icons.favorite),
                      title: Text('Favorite'),
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'Delete',
                    child: ListTile(
                      leading: Icon(Icons.delete),
                      title: Text('Delete'),
                    ),
                  ),
                ],
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  SwitchItemBloc getBloc() => _bloc;
}
