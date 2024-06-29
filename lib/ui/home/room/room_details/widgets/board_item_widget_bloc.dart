import 'package:estonedge/data/remote/model/boards/delete_board_response.dart';
import 'package:estonedge/data/remote/model/boards/update_board_response.dart';
import 'package:estonedge/data/remote/repository/boards/boards_repository.dart';
import 'package:estonedge/data/remote/requests/boards/update_board_request.dart';

import '../../../../../base/src_bloc.dart';

class BoardItemWidgetBloc extends BasePageBloc {
  void updateBoard(String roomId, String boardId, String boardName,
      Function(UpdateBoardResponse) onSuccess, Function(String) onError) {
    showLoading();

    final updateBoardRequestParams =
        UpdateBoardRequestParameters(boardName: boardName).toRequestParams();

    apiUpdateBoardDetails(
        roomId: roomId,
        boardId: boardId,
        updateBoardRequestParams: updateBoardRequestParams,
        onSuccess: (response) {
          hideLoading();
          onSuccess(response);
        },
        onError: (errorMsg) {
          hideLoading();
          onError(errorMsg);
        });
  }

  void deleteBoard(String roomId, String boardId,
      Function(DeleteBoardResponse) onSuccess, Function(String) onError) {
    showLoading();

    apiDeleteBoardDetails(
        roomId: roomId,
        boardId: boardId,
        onSuccess: (response) {
          hideLoading();
          onSuccess(response);
        },
        onError: (errorMsg) {
          hideLoading();
          onError(errorMsg);
        });
  }
}
