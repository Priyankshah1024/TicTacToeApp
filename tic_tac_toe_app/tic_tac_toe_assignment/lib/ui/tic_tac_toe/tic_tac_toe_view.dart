import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tic_tac_toe_assignment/ui/shared/styles.dart';
import 'package:tic_tac_toe_assignment/ui/shared/ui_helpers.dart';
import 'package:tic_tac_toe_assignment/ui/tic_tac_toe/tic_tac_toe_viewmodel.dart';

class TicTacToeView extends StatefulWidget {
  const TicTacToeView({super.key});

  @override
  State<TicTacToeView> createState() => _TicTacToeViewState();
}

class _TicTacToeViewState extends State<TicTacToeView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => TicTacToeViewModel(),
        onViewModelReady: (model) => model.startupLogic(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text("Let's Play"),
            ),
            body: _ticTacToeBoardWidget(model: model),
          );
        });
  }

  //game board widget
  Widget _ticTacToeBoardWidget({required TicTacToeViewModel model}) {
    return Stack(
      children: [
        //background gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                kcPurpleColor,
                kcIndigoColor,
              ],
            ),
          ),
        ),
        //show confetti when current player is winner
        if (model.winner.isNotEmpty && model.winner != 'Draw') ...[
          _showConfettiWidget(model: model),
        ],
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Tic Tac Toe Game',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: kcWhiteColor,
                      letterSpacing: 1.5,
                    ),
                  ),
                  verticalSpaceMedium,
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: kcWhiteColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      model.winner.isNotEmpty
                          ? (model.winner == 'Draw'
                              ? 'Game Draw!'
                              : '${model.winner} Wins!')
                          : '${model.currentPlayer}\'s Turn',
                      style: TextStyle(
                        fontSize: 20,
                        color: kcWhiteColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  verticalSpaceSmall,
                ],
              ),
              //board which is GridView
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      margin: EdgeInsets.all(14),
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          itemCount: 9,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => model.onCellClick(index),
                              child: AnimatedContainer(
                                alignment: Alignment.center,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeOutBack,
                                decoration: BoxDecoration(
                                  color: _getCellColor(model.board[index]),
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: kcWhiteColor.withOpacity(0.1),
                                      blurRadius: 6,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: AnimatedSwitcher(
                                  duration: Duration(milliseconds: 300),
                                  child: Text(
                                    model.board[index],
                                    key: ValueKey(model.board[index]),
                                    style: TextStyle(
                                      fontSize: 40,
                                      color:
                                          _getSymbolColor(model.board[index]),
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ),

              verticalSpaceRegular,

              //reset btn
              Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: ElevatedButton(
                  onPressed: () => model.resetGame(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber.shade600,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    shadowColor: Colors.amber.shade800,
                  ),
                  child: Text(
                    'New Game',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: kcWhiteColor,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
              verticalSpaceSmall,
            ],
          ),
        ),
      ],
    );
  }

  //when current player wins show confetti
  Widget _showConfettiWidget({required TicTacToeViewModel model}) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConfettiWidget(
        confettiController: model.confettiController,
        blastDirection: pi / 3,
        maxBlastForce: 10,
        minBlastForce: 5,
        emissionFrequency: 0.03,
        numberOfParticles: 50,
        gravity: 0,
        blastDirectionality: BlastDirectionality.explosive,
        shouldLoop: false,
      ),
    );
  }

  Color _getCellColor(String value) {
    if (value == 'X') return Colors.blue.shade600;
    if (value == 'O') return Colors.red.shade600;
    return Colors.white.withOpacity(0.1);
  }

  Color _getSymbolColor(String value) {
    if (value == 'X') return Colors.blue.shade100;
    if (value == 'O') return Colors.red.shade100;
    return Colors.transparent;
  }
}
