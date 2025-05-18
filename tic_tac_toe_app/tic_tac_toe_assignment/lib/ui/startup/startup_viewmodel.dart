import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tic_tac_toe_assignment/app/app.locator.dart';
import 'package:tic_tac_toe_assignment/app/app.router.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  Future<void> startupLogic() async {
    Future.delayed(
      Duration(seconds: 3),
      () => _navigationService.navigateToTicTacToeView(),
    );
  }
}
