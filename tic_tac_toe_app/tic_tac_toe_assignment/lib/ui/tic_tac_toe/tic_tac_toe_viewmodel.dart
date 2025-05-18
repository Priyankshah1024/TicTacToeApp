import 'package:confetti/confetti.dart';
import 'package:stacked/stacked.dart';
import 'package:tic_tac_toe_assignment/app/app.locator.dart';
import 'package:tic_tac_toe_assignment/services/snackbar_service.dart';

class TicTacToeViewModel extends BaseViewModel {
  //this is a board with 9 empty cells
  List<String> _board = List.filled(9, '');
  String _currentPlayer = 'X';
  String _winner = '';

  List<String> get board => _board;
  String get currentPlayer => _currentPlayer;
  String get winner => _winner;

  ConfettiController confettiController = ConfettiController();
  final _customSnackBarService = locator<CustomSnackbarService>();

  void startupLogic() {
    confettiController = ConfettiController(duration: Duration(seconds: 3));
  }

  //this when a cell is tapped
  void onCellClick(int index) {
    //if a cell used or game over
    if (_board[index] != '' || _winner != '') return;

    //set current player's as mark
    _board[index] = _currentPlayer;

    //check for winner
    checkForWinner();

    if (_winner == '') {
      _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
    }
    notifyListeners();
  }

  //check for winner or draw the game
  void checkForWinner() {
    final List<List<int>> winningCombo = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], //for the row
      [0, 3, 6], [1, 4, 7], [2, 5, 8], //for cols
      [0, 4, 8], [2, 4, 6] //for the diagonals
    ];

    for (var combo in winningCombo) {
      if (_board[combo[0]] != '' &&
          _board[combo[0]] == _board[combo[1]] &&
          _board[combo[1]] == _board[combo[2]]) {
        _winner = _board[combo[0]];
        _customSnackBarService.showCustomSnackbar(
            message: "Congratulations! you're the winner", success: true);
        confettiController.play();
        return;
      }
    }
    //if board is full which is no empty cells and no winner
    if (!_board.contains('')) {
      _winner = 'Draw';
      _customSnackBarService.showCustomSnackbar(
          message: 'Oops!. The Game has been Draw', success: false);
    }
  }

  //reset the game to initial state
  void resetGame() {
    _board = List.filled(9, '');
    _currentPlayer = 'X';
    _winner = '';
    confettiController.stop();
    _customSnackBarService.showCustomSnackbar(
        message: 'Game Reset Successfully', success: true);
    notifyListeners();
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }
}
