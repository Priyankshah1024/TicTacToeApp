import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tic_tac_toe_assignment/services/snackbar_service.dart';
import 'package:tic_tac_toe_assignment/ui/startup/startup_view.dart';
import 'package:tic_tac_toe_assignment/ui/tic_tac_toe/tic_tac_toe_view.dart';

@StackedApp(routes: [
  MaterialRoute(
    page: StartupView,
    initial: true,
  ),
  MaterialRoute(
    page: TicTacToeView,
  ),
], dependencies: [
  LazySingleton(classType: NavigationService),
  LazySingleton(classType: SnackbarService),
  LazySingleton(classType: CustomSnackbarService),
])
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
