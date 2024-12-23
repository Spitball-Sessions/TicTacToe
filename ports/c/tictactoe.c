/***************************************************************************
 * TicTacToe - Enterprise Edition                                                    
 * Version: 1.0.0                                                                    
 * Date: 2023                                                                       
 * Description: A robust implementation of the classic Tic-Tac-Toe game             
 * utilizing advanced C architecture patterns and enterprise-grade                    
 * documentation standards.                                                          
 ***************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>

#define BOARD_SIZE 3

typedef struct {
    char board[BOARD_SIZE][BOARD_SIZE];
    char current_player;
    bool game_active;
} Game;

void initialize_game(Game* game) {
    for (int i = 0; i < BOARD_SIZE; i++) {
        for (int j = 0; j < BOARD_SIZE; j++) {
            game->board[i][j] = ' ';
        }
    }
    game->current_player = 'X';
    game->game_active = true;
}

void display_board(const Game* game) {
    system("clear");
    for (int i = 0; i < BOARD_SIZE; i++) {
        printf(" %c | %c | %c\n", game->board[i][0], game->board[i][1], game->board[i][2]);
        if (i < BOARD_SIZE - 1) {
            printf("---+---+---\n");
        }
    }
}

bool make_move(Game* game, int row, int col) {
    if (row < 0 || row >= BOARD_SIZE || col < 0 || col >= BOARD_SIZE) {
        return false;
    }
    
    if (game->board[row][col] == ' ') {
        game->board[row][col] = game->current_player;
        return true;
    }
    return false;
}

bool check_win(const Game* game) {
    // Check rows
    for (int i = 0; i < BOARD_SIZE; i++) {
        if (game->board[i][0] == game->current_player &&
            game->board[i][1] == game->current_player &&
            game->board[i][2] == game->current_player) {
            return true;
        }
    }
    
    // Check columns
    for (int i = 0; i < BOARD_SIZE; i++) {
        if (game->board[0][i] == game->current_player &&
            game->board[1][i] == game->current_player &&
            game->board[2][i] == game->current_player) {
            return true;
        }
    }
    
    // Check diagonals
    if (game->board[0][0] == game->current_player &&
        game->board[1][1] == game->current_player &&
        game->board[2][2] == game->current_player) {
        return true;
    }
    
    if (game->board[0][2] == game->current_player &&
        game->board[1][1] == game->current_player &&
        game->board[2][0] == game->current_player) {
        return true;
    }
    
    return false;
}

void switch_player(Game* game) {
    game->current_player = (game->current_player == 'X') ? 'O' : 'X';
}

bool process_turn(Game* game) {
    int row, col;
    printf("Player %c's turn\n", game->current_player);
    printf("Enter row (1-3): ");
    if (scanf("%d", &row) != 1) {
        while (getchar() != '\n');
        return false;
    }
    printf("Enter column (1-3): ");
    if (scanf("%d", &col) != 1) {
        while (getchar() != '\n');
        return false;
    }
    
    row--; // Convert to 0-based indexing
    col--;
    
    if (!make_move(game, row, col)) {
        printf("Invalid move! Try again.\n");
        sleep(1);
        return false;
    }
    
    if (check_win(game)) {
        display_board(game);
        printf("Player %c wins!\n", game->current_player);
        game->game_active = false;
        return true;
    }
    
    switch_player(game);
    return true;
}

int main() {
    Game game;
    initialize_game(&game);
    
    while (game.game_active) {
        display_board(&game);
        if (!process_turn(&game)) {
            printf("Invalid input! Please enter numbers between 1 and 3.\n");
            sleep(1);
        }
    }
    
    return 0;
}
