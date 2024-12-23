const debug = true;

function db(input) {
    if (debug) console.log(input);
}


//Player logic
function createPlayer(){
    //Immediately Invoked Function - starts immediately, no need to call.
    const {name1,name2,symbol1,symbol2} = (function (){
        const name1 = prompt("First name?").trim();
        const symbol1 = prompt("First Symbol?").trim().toUpperCase();
        const name2 = prompt("Second name?").trim();
        const symbol2 = prompt("Second Symbol?").trim().toUpperCase();
        return {name1,name2,symbol1,symbol2}
    })();

    const {firstPlayer,secondPlayer} = (function(){
        if (Math.random() <= 0.5){
            const firstPlayer = {name:name1,symbol:symbol1};
            const secondPlayer = {name:name2,symbol:symbol2};
            db(firstPlayer)
            return {firstPlayer,secondPlayer}
        }
        else{
            const firstPlayer = {name:name2,symbol:symbol2};
            const secondPlayer = {name:name1,symbol:symbol1};
            db(firstPlayer)
            return {firstPlayer,secondPlayer}
        }
    })();

    return{firstPlayer,secondPlayer}
}

//Board logic
function createBoard(){
    const board =  ["1","2","3",
                    "4","5","6",
                    "7","8","9"];
    
                    
    function playMove(input,symbol){
        const move = board.indexOf(input)
        board[move] = symbol
        db(board)
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
    const {firstPlayer,secondPlayer} = createPlayer();
    let result = "";

    function playTurn(event){
        let player = turn%2 == 0?secondPlayer:firstPlayer;
        db(player);

        turn++;
        if (turn == 10){
            result = "Draw!"
            return result
        }

        playMove(event,player.symbol)

        if (turn >= 5){
            result = checkForWin(player.symbol) === true?player.name + " wins!":"";
            db(result)
            return result;
        }
        else{
            return result = "";
        }
    }

    let turn = 1
    const startGame = () =>turn;

    const {board,playMove,checkForWin} = createBoard();
    startGame();
    
    while (result == ""){
        playTurn(prompt("${player.name}, What square?")) 
    }
}


gameStart();