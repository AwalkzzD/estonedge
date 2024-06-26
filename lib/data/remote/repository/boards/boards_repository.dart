import 'package:dio/dio.dart';
import 'package:estonedge/base/constants/app_constants.dart';
import 'package:estonedge/data/remote/model/board_types/board_types_response.dart';
import 'package:estonedge/data/remote/model/boards/add_board_response.dart';
import 'package:estonedge/data/remote/utils/dio_manager.dart';
import 'package:estonedge/utils/shared_pref.dart';

/// GET - ALL BOARD TYPES AND SWITCH TYPES
void apiGetBoardTypes(Function(List<BoardTypesResponse>) onSuccess,
    Function(String) onError) async {
  try {
    final response = boardTypesResponseFromJson(
        (await (await DioManager.getInstance())!.get(boardTypes,
                options: Options(responseType: ResponseType.plain)))
            .data);

    onSuccess(response);
  } on DioException catch (ex) {
    onError(ex.message ?? "Something went wrong");
  }
}

/// POST - BOARD DATA AND SWITCH DATA
void apiAddBoardData({
  required String roomId,
  required String addBoardRequestParams,
  required Function(AddBoardResponse) onSuccess,
  required Function(String) onError,
}) async {
  try {
    final response = addBoardResponseFromJson(
        (await (await DioManager.getInstance())!
                .post('$users/${getUserId()}/$rooms/$roomId/$boards',
                    options: Options(
                      responseType: ResponseType.plain,
                      validateStatus: (status) => true,
                    ),
                    data: addBoardRequestParams))
            .data);
    onSuccess(response);
  } on DioException catch (ex) {
    onError(ex.message ?? "Something went wrong");
  }
}
