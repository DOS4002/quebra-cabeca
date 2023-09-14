import 'dart:io';
import 'dart:math';

void main() {
  final int boardSize = 3;
  final List<List<int>> board = List.generate(boardSize, (_) => List.generate(boardSize, (_) => 0));
  int emptyRow = boardSize - 1;
  int emptyCol = boardSize - 1;

  void printBoard() {
    for (var i = 0; i < boardSize; i++) {
      for (var j = 0; j < boardSize; j++) {
        final cell = board[i][j];
        stdout.write(cell == 0 ? '   ' : '${cell.toString().padLeft(2)} ');
      }
      print('');
    }
  }

  bool isWinning() {
    int value = 1;
    for (var i = 0; i < boardSize; i++) {
      for (var j = 0; j < boardSize; j++) {
        if (board[i][j] != value) {
          return false;
        }
        value = (value % (boardSize * boardSize - 1)) + 1;
      }
    }
    return true;
  }

  void shuffleBoard() {
    final random = Random();
    for (var i = 0; i < 100; i++) {
      final directions = [
        if (emptyCol > 0) 'left',
        if (emptyCol < boardSize - 1) 'right',
        if (emptyRow > 0) 'up',
        if (emptyRow < boardSize - 1) 'down',
      ];
      final randomDirection = directions[random.nextInt(directions.length)];

      switch (randomDirection) {
        case 'left':
          if (emptyCol < boardSize - 1) {
            board[emptyRow][emptyCol] = board[emptyRow][emptyCol + 1];
            board[emptyRow][emptyCol + 1] = 0;
            emptyCol++;
          }
          break;
        case 'right':
          if (emptyCol > 0) {
            board[emptyRow][emptyCol] = board[emptyRow][emptyCol - 1];
            board[emptyRow][emptyCol - 1] = 0;
            emptyCol--;
          }
          break;
        case 'up':
          if (emptyRow < boardSize - 1) {
            board[emptyRow][emptyCol] = board[emptyRow + 1][emptyCol];
            board[emptyRow + 1][emptyCol] = 0;
            emptyRow++;
          }
          break;
        case 'down':
          if (emptyRow > 0) {
            board[emptyRow][emptyCol] = board[emptyRow - 1][emptyCol];
            board[emptyRow - 1][emptyCol] = 0;
            emptyRow--;
          }
          break;
      }
    }
  }

  shuffleBoard();

  print('Bem-vindo ao Jogo de Quebra-Cabeça!');
  while (!isWinning()) {
    printBoard();
    stdout.write('Mova uma peça (use W/A/S/D): ');
    final move = stdin.readLineSync();
    if (move != null && move.isNotEmpty) {
      final direction = move.toLowerCase();

      switch (direction) {
        case 'w': // Move up
          if (emptyRow < boardSize - 1) {
            board[emptyRow][emptyCol] = board[emptyRow + 1][emptyCol];
            board[emptyRow + 1][emptyCol] = 0;
            emptyRow++;
          }
          break;
        case 's': // Move down
          if (emptyRow > 0) {
            board[emptyRow][emptyCol] = board[emptyRow - 1][emptyCol];
            board[emptyRow - 1][emptyCol] = 0;
            emptyRow--;
          }
          break;
        case 'a': // Move left
          if (emptyCol < boardSize - 1) {
            board[emptyRow][emptyCol] = board[emptyRow][emptyCol + 1];
            board[emptyRow][emptyCol + 1] = 0;
            emptyCol++;
          }
          break;
        case 'd': // Move right
          if (emptyCol > 0) {
            board[emptyRow][emptyCol] = board[emptyRow][emptyCol - 1];
            board[emptyRow][emptyCol - 1] = 0;
            emptyCol--;
          }
          break;
      }
    }
  }

  printBoard();
  print('Parabéns! Você venceu o jogo!');
}
