import 'package:dio/dio.dart';
import 'package:estonedge/base/constants/app_constants.dart';
import 'package:estonedge/data/remote/model/user/user_additional_info_response.dart';
import 'package:estonedge/data/remote/model/user/user_response.dart';
import 'package:estonedge/utils/shared_pref.dart';

import '../../model/user/create_user_response.dart';
import '../../utils/dio_manager.dart';

/// api to create a user record in DB
void apiCreateUserRecord(String createUserRequestParams,
    Function(CreateUserResponse) onSuccess, Function(String) onError) async {
  try {
    print('User ID --> ${getUserId()}');
    final response = createUserResponseFromJson(
        (await (await DioManager.getInstance())!.post('$users/${getUserId()}',
                options: Options(
                  responseType: ResponseType.plain,
                  validateStatus: (status) => true,
                ),
                data: createUserRequestParams))
            .data);

    if (response.userId != null) {
      print('User Id not null --> ${response.userId}');
      onSuccess(response);
    } else {
      print('User Id null --> ${response.userId}');
    }
  } on DioException catch (ex) {
    onError(ex.message ?? "Something went wrong");
  }
}

/// api to get user data
void apiGetUserData(
    Function(UserResponse) onSuccess, Function(String) onError) async {
  try {
    final response = userResponseFromJson(
        (await (await DioManager.getInstance())!.get('$users/${getUserId()}',
                options: Options(
                    responseType: ResponseType.plain,
                    validateStatus: (status) => true)))
            .data);
    if (response.userId.isNotEmpty) {
      onSuccess(response);
    }
  } on DioException catch (ex) {
    onError(ex.message ?? "Something went wrong");
  }
}

/// api to put user additional info
void apiPutAdditionalInfo(
    String addAdditionalInfoRequestParameters,
    Function(AdditionalInfoResponse) onSuccess,
    Function(String) onError) async {
  try {
    final response = additionalInfoResponseFromJson(
        (await (await DioManager.getInstance())!.put('$users/${getUserId()}',
                options: Options(
                    responseType: ResponseType.plain,
                    validateStatus: (status) => true),
                data: addAdditionalInfoRequestParameters))
            .data);
    onSuccess(response);
  } on DioException catch (ex) {
    onError(ex.message ?? "Something went wrong");
  }
}
