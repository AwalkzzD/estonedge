import 'package:dio/dio.dart';
import 'package:estonedge/data/remote/model/rooms/add_room_response.dart';
import 'package:estonedge/utils/shared_pref.dart';

import '../../../../base/constants/app_constants.dart';
import '../../model/rooms/rooms_response.dart';
import '../../utils/dio_manager.dart';

/// user [getUserId()] for getting userId stored in shared pref, for api calls

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
