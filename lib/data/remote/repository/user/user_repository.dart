import 'package:dio/dio.dart';
import 'package:estonedge/base/constants/app_constants.dart';
import 'package:estonedge/data/remote/model/user/user_response.dart';

import '../../utils/dio_manager.dart';

void apiGetUserData(
    Function(UserResponse) onSuccess, Function(String) onError) async {
  try {
    final response = userResponseFromJson(
        (await (await DioManager.getInstance())!.get(
                '${getUsers}/2',
                options: Options(responseType: ResponseType.plain)))
            .data);

    if(response.userId.isNotEmpty) {
      onSuccess(response);
    }
  } on DioException catch (ex) {
    onError(ex.message ?? "Something went wrong");
  }
}
