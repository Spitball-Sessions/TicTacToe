# ***************************************************************************
#  TicTacToe - Enterprise Edition                                                   
#  Version: 1.0.0                                                                   
#  Author: J. Noyes
#  Date: 2023                                                                      
#  Description: A robust implementation of the classic Tic-Tac-Toe game            
#  utilizing advanced Crystal architecture patterns and enterprise-grade             
#  documentation standards.                                                         
# ***************************************************************************

class TicTacToe
  property board : Array(Array(String))
  property current_player : String
  property game_active : Bool

  def initialize
    @board = Array.new(3) { Array.new(3, " ") }
    @current_player = "X"
    @game_active = true
  end

  def display_board
    system("clear")
    3.times do |i|
      print " #{@board[i][0]} | #{@board[i][1]} | #{@board[i][2]}\n"
      print "---+---+---\n" unless i == 2
    end
  end

  def make_move(row : Int32, column : Int32) : Bool
    if @board[row - 1][column - 1] == " "
      @board[row - 1][column - 1] = @current_player
      true
    else
      false
    end
  end

  def check_win : Bool
    # Check horizontal
    3.times do |i|
      if @board[i][0] == current_player &&
         @board[i][1] == current_player &&
         @board[i][2] == current_player
        return true
      end
    end

    # Check vertical
    3.times do |j|
      if @board[0][j] == current_player &&
         @board[1][j] == current_player &&
         @board[2][j] == current_player
        return true
      end
    end

    # Check diagonals
    if @board[0][0] == current_player &&
       @board[1][1] == current_player &&
       @board[2][2] == current_player
      return true
    end

    if @board[0][2] == current_player &&
       @board[1][1] == current_player &&
       @board[2][0] == current_player
      return true
    end

    false
  end

  def switch_player
    @current_player = @current_player == "X" ? "O" : "X"
  end

  def play
    while @game_active
      display_board
      puts "Player #{current_player}'s turn"
      print "Enter row (1-3): "
      row = gets.try(&.to_i) || 0
      print "Enter column (1-3): "
      column = gets.try(&.to_i) || 0

      if 1 <= row <= 3 && 1 <= column <= 3
        if make_move(row, column)
          if check_win
            display_board
            puts "Player #{current_player} wins!"
            @game_active = false
          else
            switch_player
          end
        else
          puts "Invalid move! Cell already taken. Try again."
          sleep 1
        end
      else
        puts "Invalid input! Please enter numbers between 1 and 3."
        sleep 1
      end
    end
  end
end

# Start the game
game = TicTacToe.new
game.play
