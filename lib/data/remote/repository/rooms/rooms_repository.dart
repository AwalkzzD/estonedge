import 'package:dio/dio.dart';

import '../../../../base/constants/app_constants.dart';
import '../../model/rooms/rooms_response.dart';
import '../../utils/dio_manager.dart';

void apiGetRoomsData(
    Function(List<RoomsResponse>) onSuccess, Function(String) onError) async {
  try {
    print('Room API called');
    final response = roomsResponseFromJson(
        (await (await DioManager.getInstance())!.get('$getUsers/2/$getRooms',
                options: Options(responseType: ResponseType.plain)))
            .data);

    onSuccess(response);
  } on DioException catch (ex) {
    onError(ex.message ?? "Something went wrong");
  }
}
