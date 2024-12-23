! ***************************************************************************
!  TicTacToe - Enterprise Edition                                                   
!  Version: 1.0.0                                                                   
!  Date: 2027                                                                      
!  Description: A robust implementation of the classic Tic-Tac-Toe game            
!  utilizing advanced Fortran architecture patterns and enterprise-grade             
!  documentation standards.                                                         
! ***************************************************************************

program TicTacToe
    implicit none
    
    character(len=1), dimension(3,3) :: board
    character(len=1) :: current_player
    logical :: game_active
    integer :: row, col, io_status
    
    call initialize_game()
    
    do while (game_active)
        call display_board()
        call process_turn()
    end do
    
contains

    subroutine initialize_game()
        integer :: i, j
        do i = 1, 3
            do j = 1, 3
                board(i,j) = ' '
            end do
        end do
        current_player = 'X'
        game_active = .true.
    end subroutine initialize_game
    
    subroutine display_board()
        call system('clear')
        print *, ' ', board(1,1), ' | ', board(1,2), ' | ', board(1,3)
        print *, '---+---+---'
        print *, ' ', board(2,1), ' | ', board(2,2), ' | ', board(2,3)
        print *, '---+---+---'
        print *, ' ', board(3,1), ' | ', board(3,2), ' | ', board(3,3)
    end subroutine display_board
    
    logical function make_move(r, c)
        integer, intent(in) :: r, c
        make_move = .false.
        if (board(r,c) == ' ') then
            board(r,c) = current_player
            make_move = .true.
        end if
    end function make_move
    
    logical function check_win()
        integer :: i
        check_win = .false.
        
        ! Check horizontal
        do i = 1, 3
            if (board(i,1) == current_player .and. &
                board(i,2) == current_player .and. &
                board(i,3) == current_player) then
                check_win = .true.
                return
            end if
        end do
        
        ! Check vertical
        do i = 1, 3
            if (board(1,i) == current_player .and. &
                board(2,i) == current_player .and. &
                board(3,i) == current_player) then
                check_win = .true.
                return
            end if
        end do
        
        ! Check diagonals
        if (board(1,1) == current_player .and. &
            board(2,2) == current_player .and. &
            board(3,3) == current_player) then
            check_win = .true.
            return
        end if
        
        if (board(1,3) == current_player .and. &
            board(2,2) == current_player .and. &
            board(3,1) == current_player) then
            check_win = .true.
            return
        end if
    end function check_win
    
    subroutine switch_player()
        if (current_player == 'X') then
            current_player = 'O'
        else
            current_player = 'X'
        end if
    end subroutine switch_player
    
    subroutine process_turn()
        print *, "Player ", current_player, "'s turn"
        print *, "Enter row (1-3): "
        read(*,*, iostat=io_status) row
        print *, "Enter column (1-3): "
        read(*,*, iostat=io_status) col
        
        if (io_status == 0 .and. row >= 1 .and. row <= 3 .and. &
            col >= 1 .and. col <= 3) then
            if (make_move(row, col)) then
                if (check_win()) then
                    call display_board()
                    print *, "Player ", current_player, " wins!"
                    game_active = .false.
                else
                    call switch_player()
                end if
            else
                print *, "Invalid move! Cell already taken."
                call sleep(1)
            end if
        else
            print *, "Invalid input! Please enter numbers between 1 and 3."
            call sleep(1)
        end if
    end subroutine process_turn
    
end program TicTacToe
