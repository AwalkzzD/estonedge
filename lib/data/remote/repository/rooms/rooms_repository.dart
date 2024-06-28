import 'package:dio/dio.dart';
import 'package:estonedge/data/remote/model/rooms/add_room/add_room_response.dart';
import 'package:estonedge/data/remote/model/rooms/delete_room/delete_room_response.dart';
import 'package:estonedge/utils/shared_pref.dart';

import '../../../../base/constants/app_constants.dart';
import '../../model/rooms/get_rooms/rooms_response.dart';
import '../../utils/dio_manager.dart';

/// user [getUserId()] for getting userId stored in shared pref, for api calls

/// GET - ALL ROOMS OF USER
void apiGetRoomsData(
    Function(List<RoomsResponse>) onSuccess, Function(String) onError) async {
  try {
    final response = roomsResponseFromJson(
        (await (await DioManager.getInstance())!.get(
                '$users/${getUserId()}/$rooms',
                options: Options(responseType: ResponseType.plain)))
            .data);

    onSuccess(response);
  } on DioException catch (ex) {
    onError(ex.message ?? "Something went wrong");
  }
}

/// GET - ALL SINGLE ROOM OF USER
void apiGetRoomData(String roomId, Function(RoomsResponse) onSuccess,
    Function(String) onError) async {
  try {
    final response = roomResponseFromJson(
        (await (await DioManager.getInstance())!.get(
                '$users/${getUserId()}/$rooms/$roomId',
                options: Options(responseType: ResponseType.plain)))
            .data);

    onSuccess(response);
  } on DioException catch (ex) {
    onError(ex.message ?? "Something went wrong");
  }
}

/// POST - ROOM DATA
void apiAddRoomData(String addRoomRequestParams,
    Function(AddRoomResponse) onSuccess, Function(String) onError) async {
  try {
    final response = addRoomResponseFromJson(
        (await (await DioManager.getInstance())!
                .post('$users/${getUserId()}/$rooms',
                    options: Options(
                      responseType: ResponseType.plain,
                      validateStatus: (status) => true,
                    ),
                    data: addRoomRequestParams))
            .data);
    onSuccess(response);
  } on DioException catch (ex) {
    onError(ex.message ?? "Something went wrong");
  }
}

/// DELETE - ROOM OF USER
void apiDeleteRoom(String roomId, Function(DeleteRoomResponse) onSuccess,
    Function(String) onError) async {
  try {
    final response = deleteRoomResponseFromJson(
        (await (await DioManager.getInstance())!.delete(
                '$users/${getUserId()}/$rooms/$roomId',
                options: Options(responseType: ResponseType.plain)))
            .data);
    onSuccess(response);
  } on DioException catch (ex) {
    onError(ex.message ?? "Something went wrong");
  }
}
