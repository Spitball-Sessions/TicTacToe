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
    const board =  {b1:"1",b2:"2",b3:"3",
                    b4:"4",b5:"5",b6:"6",
                    b7:"7",b8:"8",b9:"9"};
    
    return board

}



//GAME logic
function gameStart(){
    const {name1,name2} = (function(){
        const name1 = prompt("Player 1's name?").trim();
        const name2 = prompt("Player 2's name?").trim();
        return {name1,name2}
    })();

    const player1 = createPlayer(name1,1);
    const player2 = createPlayer(name2,2);
    const board = createBoard();
    db(board);

    board.b5 = player1.symbol;
    board.b7 = player2.symbol;
    db(board);

    
}


gameStart();