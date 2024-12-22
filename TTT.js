const debug = true;

function db(input) {
    if (debug) console.log(input);
}



//Player logic
function createPlayer(name, screenOrder){
    const symbol = screenOrder === 1?"X":"O";

    return{name,symbol,screenOrder}
}

//Board logic
function createBoard(){
    const board =  ["1","2","3",
                    "4","5","6",
                    "7","8","9"];
    
                    
    function playMove(input,symbol){
        board[input] = symbol
    }

    const winningPatterns = [
        [0, 1, 2], // Top row
        [3, 4, 5], // Middle row
        [6, 7, 8], // Bottom row
        [0, 3, 6], // Left column
        [1, 4, 7], // Middle column
        [2, 5, 8], // Right column
        [0, 4, 8], // Top-left to bottom-right diagonal
        [2, 4, 6]  // Top-right to bottom-left diagonal
    ];

    function checkForWin(symbol){   
        return winningPatterns.some(array=> {
            if (array.every(value => board[value] === symbol)){
                db("Winner!")
                return true
            }
            return false;
            });
    }


    return {board,playMove,checkForWin}
}

//GAME logic
function gameStart(){
    const {name1,name2} = (function(){
        const name1 = prompt("Player 1's name?").trim();
        const name2 = prompt("Player 2's name?").trim();
        return {name1,name2}
    })();

    let turn = 0
    const startGame = () =>turn;

    function playTurn(event,player){
        let result = "";
        turn++;
        if (turn == 10){
            result = "Draw!"
            return result
        }

        playMove(event,player)

        if (turn >= 5){
            result = checkForWin(player1.symbol) === true?player1.name + " wins!":"";
            db(result)
            return result;
        }
        else{
            return "";
        }
    }


    const player1 = createPlayer(name1,1);
    const player2 = createPlayer(name2,2);
    const {board,playMove,checkForWin} = createBoard();
    startGame();
    db(turn);


    playTurn(0,player1.symbol);
    db(turn);
    playTurn(4,player2.symbol);
    db(turn);
    playTurn(1,player1.symbol);
    db(turn);
    playTurn(8,player2.symbol);
    db(turn);
    playTurn(2,player1.symbol);
    db(turn);
}


gameStart();