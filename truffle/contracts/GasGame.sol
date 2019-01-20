pragma solidity ^0.5;

contract Scoreboard {
    function addScore(address, uint256) public;
}

contract GasGame {

    Scoreboard scoreboard;

    uint256 txValue = 3000000;

    uint256 lastBlock;

    constructor(address _scoreboard) public {
        scoreboard = Scoreboard(_scoreboard);
    }

    event scoreAdded(address player, uint256 score);

    function play() public payable {
        uint256 leftover = gasleft();
        uint256 used = 21374;
        uint256 totalGas = leftover + used;
        uint256 weiPayed = tx.gasprice * totalGas;
        uint256 totalWei = weiPayed + msg.value;
        require(totalWei == txValue);
        uint256 score = leftover;
        if(lastBlock != block.number){
            //You are the first in the block
            lastBlock = block.number;
            score = score * 2;
        }
        scoreboard.addScore(msg.sender, score);
        emit scoreAdded(msg.sender, score);
    }

}
