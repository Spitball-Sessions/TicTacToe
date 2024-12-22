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

    return {board, playMove}
}

//GAME logic
function gameStart(){
    const {name1,name2} = (function(){
        const name1 = prompt("Player 1's name?").trim();
        const name2 = prompt("Player 2's name?").trim();
        return {name1,name2}
    })();

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

    const player1 = createPlayer(name1,1);
    const player2 = createPlayer(name2,2);
    const {board,playMove} = createBoard();
    db(board);


    function checkForWin(symbol){   
        winningPatterns.some(array=> {
            if (array.every(value => board[value] === symbol)){
                if (symbol == player1.symbol){
                    db(player1.name)
                    return player1.name
                }
                else{
                    db(player2.name)
                    return player2.name
                }
            }
            else{
                return
            }
        });}

    playMove(0,player1.symbol);
    playMove(4,player2.symbol);
    playMove(1,player1.symbol);
    playMove(8,player2.symbol);
    playMove(2,player1.symbol);
    checkForWin(player1.symbol)
    console.table(board);
}


gameStart();