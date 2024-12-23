DECLARE SUB db (input$)
DECLARE FUNCTION createPlayer () STATIC
DECLARE FUNCTION createBoard () STATIC
DECLARE FUNCTION checkForWin (board$(), symbol$) STATIC
DECLARE SUB playMove (board$(), input$, symbol$)

' Enable debug
CONST debug = -1 ' Set to 0 to disable debug

' Start Game
SUB gameStart
    DIM player1Name AS STRING
    DIM player1Symbol AS STRING
    DIM player2Name AS STRING
    DIM player2Symbol AS STRING
    DIM board$(9)
    DIM turn AS INTEGER
    DIM result AS STRING
    DIM playerSymbol AS STRING
    DIM playerName AS STRING
    
    RANDOMIZE TIMER
    PRINT "Game Start!"
    CALL createPlayer(player1Name, player1Symbol, player2Name, player2Symbol)

    DIM player1(1) AS STRING
    DIM player2(1) AS STRING

    IF RND <= 0.5 THEN
        player1(0) = player1Name
        player1(1) = player1Symbol
        player2(0) = player2Name
        player2(1) = player2Symbol
    ELSE
        player1(0) = player2Name
        player1(1) = player2Symbol
        player2(0) = player1Name
        player2(1) = player1Symbol
    END IF

    db "First Player: " + player1(0) + " Symbol: " + player1(1)
    db "Second Player: " + player2(0) + " Symbol: " + player2(1)

    CALL createBoard(board$())
    turn = 1
    result = ""

    DO WHILE result = ""
        IF turn MOD 2 = 0 THEN
            playerName = player2(0)
            playerSymbol = player2(1)
        ELSE
            playerName = player1(0)
            playerSymbol = player1(1)
        END IF

        PRINT playerName + ", enter a square (1-9):"
        DIM move AS STRING
        INPUT move

        CALL playMove(board$(), move, playerSymbol)
        turn = turn + 1

        IF turn > 9 THEN
            result = "Draw!"
        END IF

        IF turn >= 5 THEN
            IF checkForWin(board$(), playerSymbol) THEN
                result = playerName + " wins!"
            END IF
        END IF
    LOOP

    PRINT result
END SUB

' Display debug information
SUB db (input$)
    IF debug THEN
        PRINT "[DEBUG]: "; input$
    END IF
END SUB

' Create Players
SUB createPlayer (player1Name, player1Symbol, player2Name, player2Symbol)
    PRINT "Enter first player's name:"
    INPUT player1Name
    PRINT "Enter first player's symbol:"
    INPUT player1Symbol
    PRINT "Enter second player's name:"
    INPUT player2Name
    PRINT "Enter second player's symbol:"
    INPUT player2Symbol

    player1Symbol = UCASE$(player1Symbol)
    player2Symbol = UCASE$(player2Symbol)
END SUB

' Initialize Board
SUB createBoard (board$())
    board$(1) = "1"
    board$(2) = "2"
    board$(3) = "3"
    board$(4) = "4"
    board$(5) = "5"
    board$(6) = "6"
    board$(7) = "7"
    board$(8) = "8"
    board$(9) = "9"
END SUB

' Make a move
SUB playMove (board$(), input$, symbol$)
    DIM pos AS INTEGER
    pos = VAL(input$)

    IF pos >= 1 AND pos <= 9 THEN
        board$(pos) = symbol$
        CALL db("Updated Board: " + board$(1) + " " + board$(2) + " " + board$(3))
    ELSE
        PRINT "Invalid move. Try again."
    END IF
END SUB

' Check for a win
FUNCTION checkForWin (board$(), symbol$)
    DIM patterns(8, 2) AS INTEGER
    DIM i AS INTEGER

    ' Winning patterns
    DATA 1, 2, 3
    DATA 4, 5, 6
    DATA 7, 8, 9
    DATA 1, 4, 7
    DATA 2, 5, 8
    DATA 3, 6, 9
    DATA 1, 5, 9
    DATA 3, 5, 7

    FOR i = 0 TO 7
        READ patterns(i, 0), patterns(i, 1), patterns(i, 2)
    NEXT

    FOR i = 0 TO 7
        IF board$(patterns(i, 0)) = symbol$ AND board$(patterns(i, 1)) = symbol$ AND board$(patterns(i, 2)) = symbol$ THEN
            checkForWin = -1
            EXIT FUNCTION
        END IF
    NEXT

    checkForWin = 0
END FUNCTION

' Game Start
CALL gameStart
