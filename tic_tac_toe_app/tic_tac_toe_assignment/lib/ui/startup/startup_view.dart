import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tic_tac_toe_assignment/ui/startup/startup_viewmodel.dart';

class StartupView extends StatelessWidget {
  const StartupView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        onViewModelReady: (model) => model.startupLogic(),
        viewModelBuilder: () => StartupViewModel(),
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/tic_tac_toe.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
