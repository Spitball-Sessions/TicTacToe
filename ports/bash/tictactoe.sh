#!/bin/bash

# TicTacToe - Enterprise Edition
# Version: 1.0.0
# Date: 2023
# Description: A robust implementation of the classic Tic-Tac-Toe game
# utilizing advanced Bash architecture patterns and enterprise-grade
# documentation standards.

declare -A board
current_player="X"
game_active=true

initialize_game() {
    for ((i=0; i<3; i++)); do
        for ((j=0; j<3; j++)); do
            board[$i,$j]=" "
        done
    done
}

display_board() {
    clear
    echo
    for ((i=0; i<3; i++)); do
        echo " ${board[$i,0]} | ${board[$i,1]} | ${board[$i,2]} "
        if [ $i -lt 2 ]; then
            echo "---+---+---"
        fi
    done
    echo
}

make_move() {
    local row=$1
    local col=$2
    
    if [ "${board[$row,$col]}" = " " ]; then
        board[$row,$col]=$current_player
        return 0
    fi
    return 1
}

check_win() {
    # Check rows
    for ((i=0; i<3; i++)); do
        if [ "${board[$i,0]}" = "$current_player" ] && \
           [ "${board[$i,1]}" = "$current_player" ] && \
           [ "${board[$i,2]}" = "$current_player" ]; then
            return 0
        fi
    done
    
    # Check columns
    for ((i=0; i<3; i++)); do
        if [ "${board[0,$i]}" = "$current_player" ] && \
           [ "${board[1,$i]}" = "$current_player" ] && \
           [ "${board[2,$i]}" = "$current_player" ]; then
            return 0
        fi
    done
    
    # Check diagonals
    if [ "${board[0,0]}" = "$current_player" ] && \
       [ "${board[1,1]}" = "$current_player" ] && \
       [ "${board[2,2]}" = "$current_player" ]; then
        return 0
    fi
    
    if [ "${board[0,2]}" = "$current_player" ] && \
       [ "${board[1,1]}" = "$current_player" ] && \
       [ "${board[2,0]}" = "$current_player" ]; then
        return 0
    fi
    
    return 1
}

switch_player() {
    if [ "$current_player" = "X" ]; then
        current_player="O"
    else
        current_player="X"
    fi
}

process_turn() {
    echo "Player $current_player's turn"
    
    read -p "Enter row (1-3): " row
    read -p "Enter column (1-3): " col
    
    if ! [[ "$row" =~ ^[1-3]$ ]] || ! [[ "$col" =~ ^[1-3]$ ]]; then
        echo "Invalid input! Please enter numbers between 1 and 3."
        sleep 1
        return 1
    fi
    
    # Convert to 0-based indexing
    ((row--))
    ((col--))
    
    if ! make_move $row $col; then
        echo "Invalid move! Try again."
        sleep 1
        return 1
    fi
    
    if check_win; then
        display_board
        echo "Player $current_player wins!"
        game_active=false
        return 0
    fi
    
    switch_player
    return 0
}

main() {
    initialize_game
    
    while [ "$game_active" = true ]; do
        display_board
        if ! process_turn; then
            continue
        fi
    done
}

main
