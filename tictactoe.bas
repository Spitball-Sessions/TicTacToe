REM ***************************************************************************
REM *  TicTacToe - Enterprise Edition                                                   *
REM *  Version: 1.0.0                                                                   *
REM *  Author: Enterprise Development Team                                              *
REM *  Date: 2023                                                                      *
REM *  Description: A robust implementation of the classic Tic-Tac-Toe game            *
REM *  utilizing advanced QBasic architecture patterns and enterprise-grade             *
REM *  documentation standards.                                                         *
REM ***************************************************************************

REM Module-level variable declarations
DIM SHARED Board(1 TO 3, 1 TO 3) AS STRING
DIM SHARED CurrentPlayer AS STRING
DIM SHARED GameActive AS INTEGER

REM ***************************************************************************
REM * Function: InitializeGame
REM * Purpose: Initializes the game state and board configuration
REM * Parameters: None
REM * Returns: None
REM * Side Effects: Modifies global Board array and CurrentPlayer
REM ***************************************************************************
SUB InitializeGame
    REM Iterate through each row of the game board matrix
    REM This ensures proper initialization of all cell values
    REM Critical for maintaining game state integrity
    FOR i = 1 TO 3
        REM Iterate through each column of the game board matrix
        REM This completes the second dimension of initialization
        REM Ensures comprehensive coverage of the game grid
        FOR j = 1 TO 3
            REM Assignment of empty string represents an unoccupied cell
            REM This is the standard notation for available moves
            REM Critical for move validation and game state evaluation
            Board(i, j) = " "
        NEXT j
    NEXT i
    
    REM Initialize the starting player to "X"
    REM X is traditionally the first player in Tic-Tac-Toe
    REM This sets up the turn-based gameplay loop
    CurrentPlayer = "X"
    
    REM Set game state to active
    REM This boolean flag controls the main game loop
    REM Essential for proper game flow management
    GameActive = 1
END SUB

REM ***************************************************************************
REM * Function: DisplayBoard
REM * Purpose: Renders the current game state to the display
REM * Parameters: None
REM * Returns: None
REM * Side Effects: Outputs to console
REM ***************************************************************************
SUB DisplayBoard
    CLS
    REM Display the current state of the game board
    REM Utilizes ASCII characters for board visualization
    REM Ensures user-friendly interface presentation
    PRINT " " + Board(1, 1) + " | " + Board(1, 2) + " | " + Board(1, 3)
    PRINT "---+---+---"
    PRINT " " + Board(2, 1) + " | " + Board(2, 2) + " | " + Board(2, 3)
    PRINT "---+---+---"
    PRINT " " + Board(3, 1) + " | " + Board(3, 2) + " | " + Board(3, 3)
END SUB

REM ***************************************************************************
REM * Function: MakeMove
REM * Purpose: Processes player input and updates game state
REM * Parameters: Row, Column - INTEGER
REM * Returns: Success - INTEGER
REM ***************************************************************************
FUNCTION MakeMove(Row AS INTEGER, Column AS INTEGER)
    REM Validate if selected cell is empty
    REM This prevents illegal move attempts
    REM Critical for maintaining game rule integrity
    IF Board(Row, Column) = " " THEN
        REM Update board state with current player's marker
        REM This represents a successful move execution
        REM Essential for game progression
        Board(Row, Column) = CurrentPlayer
        MakeMove = 1
    ELSE
        REM Return false if move is invalid
        REM This indicates move validation failure
        REM Necessary for proper error handling
        MakeMove = 0
    END IF
END FUNCTION

REM ***************************************************************************
REM * Function: CheckWin
REM * Purpose: Evaluates game state for win conditions
REM * Parameters: None
REM * Returns: HasWon - INTEGER
REM ***************************************************************************
FUNCTION CheckWin
    REM Check horizontal win conditions
    REM Evaluates all three possible horizontal lines
    REM Critical for game win state detection
    FOR i = 1 TO 3
        IF Board(i, 1) = CurrentPlayer AND Board(i, 2) = CurrentPlayer AND Board(i, 3) = CurrentPlayer THEN
            CheckWin = 1
            EXIT FUNCTION
        END IF
    NEXT i

    REM Check vertical win conditions
    REM Evaluates all three possible vertical lines
    REM Essential for comprehensive win detection
    FOR j = 1 TO 3
        IF Board(1, j) = CurrentPlayer AND Board(2, j) = CurrentPlayer AND Board(3, j) = CurrentPlayer THEN
            CheckWin = 1
            EXIT FUNCTION
        END IF
    NEXT j

    REM Check diagonal win conditions
    REM Evaluates both possible diagonal lines
    REM Completes win condition verification
    IF Board(1, 1) = CurrentPlayer AND Board(2, 2) = CurrentPlayer AND Board(3, 3) = CurrentPlayer THEN
        CheckWin = 1
        EXIT FUNCTION
    END IF
    IF Board(1, 3) = CurrentPlayer AND Board(2, 2) = CurrentPlayer AND Board(3, 1) = CurrentPlayer THEN
        CheckWin = 1
        EXIT FUNCTION
    END IF

    CheckWin = 0
END FUNCTION

REM ***************************************************************************
REM * Function: Main
REM * Purpose: Primary game loop and control flow
REM * Parameters: None
REM * Returns: None
REM ***************************************************************************
InitializeGame
DO WHILE GameActive
    DIM Row AS INTEGER, Column AS INTEGER
    DisplayBoard
    
    REM Prompt current player for move
    REM Ensures clear user interaction
    REM Maintains game flow control
    PRINT "Player "; CurrentPlayer; "'s turn"
    PRINT "Enter row (1-3): ";
    INPUT Row
    PRINT "Enter column (1-3): ";
    INPUT Column

    REM Execute player move and validate
    REM This ensures proper game state updates
    REM Critical for game progression
    IF MakeMove(Row, Column) THEN
        IF CheckWin THEN
            DisplayBoard
            PRINT "Player "; CurrentPlayer; " wins!"
            GameActive = 0
        ELSE
            REM Switch active player
            REM This maintains turn-based gameplay
            REM Essential for game flow
            IF CurrentPlayer = "X" THEN
                CurrentPlayer = "O"
            ELSE
                CurrentPlayer = "X"
            END IF
        END IF
    ELSE
        PRINT "Invalid move! Try again."
    END IF
LOOP

END
