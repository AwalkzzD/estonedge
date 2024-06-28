import 'package:dio/dio.dart';
import 'package:estonedge/base/constants/app_constants.dart';
import 'package:estonedge/data/remote/model/board_types/board_types_response.dart';
import 'package:estonedge/data/remote/model/boards/add_board_response.dart';
import 'package:estonedge/data/remote/model/boards/delete_board_response.dart';
import 'package:estonedge/data/remote/model/boards/update_board_response.dart';
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

/// PUT - BOARD DATA [BOARD NAME & MAC ID]
void apiUpdateBoardDetails({
  required String roomId,
  required String boardId,
  required String updateBoardRequestParams,
  required Function(UpdateBoardResponse) onSuccess,
  required Function(String) onError,
}) async {
  try {
    final response = updateBoardResponseFromJson(
        (await (await DioManager.getInstance())!
                .put('$users/${getUserId()}/$rooms/$roomId/$boards/$boardId',
                    options: Options(
                      responseType: ResponseType.plain,
                      validateStatus: (status) => true,
                    ),
                    data: updateBoardRequestParams))
            .data);
    onSuccess(response);
  } on DioException catch (ex) {
    onError(ex.message ?? "Something went wrong");
  }
}

/// DELETE - DELETE BOARD DATA
void apiDeleteBoardDetails({
  required String roomId,
  required String boardId,
  required Function(DeleteBoardResponse) onSuccess,
  required Function(String) onError,
}) async {
  try {
    final response = deleteBoardResponseFromJson(
        (await (await DioManager.getInstance())!
                .delete('$users/${getUserId()}/$rooms/$roomId/$boards/$boardId',
                    options: Options(
                      responseType: ResponseType.plain,
                      validateStatus: (status) => true,
                    )))
            .data);
    onSuccess(response);
  } on DioException catch (ex) {
    onError(ex.message ?? "Something went wrong");
  }
}
