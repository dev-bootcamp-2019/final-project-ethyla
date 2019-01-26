pragma solidity ^0.5;

import 'openzeppelin-solidity/contracts/ownership/Ownable.sol';

contract Scoreboard {
    function addScore(address, uint256) public;
    function isPlayer(address) public view returns (bool);
    function addPlayer(address) public;
    function playerCount() public view returns (uint256);
    function getPlayerById(uint256) public view returns (address);
    function getScore(address) public view returns (uint256);
}

contract GasGame is Ownable {

    Scoreboard scoreboard;

    uint256 txValue;

    uint256 lastBlock;

    constructor(address _scoreboard) public {
        // Sets the address of the highscore
        scoreboard = Scoreboard(_scoreboard);
        // Sets the lastBlock to a round number, so that the game takes place every thousandth block
        lastBlock = block.number - (block.number % 1000);
        txValue = 3000000;
    }

    event scoreAdded(address player, uint256 score);

    modifier onlyThousandthBlock(){
      require(block.number % 1000 == 0, 'This is not a thousandth block.');
      _;
    }

    modifier onlyCorrectValue(){
        uint256 leftover = gasleft();
        uint256 used = 21430;
        uint256 totalGas = leftover + used;
        uint256 weiPayed = tx.gasprice * totalGas;
        uint256 totalWei = weiPayed + msg.value;
        require(totalWei == txValue);
        _;
    }

    function play() public payable onlyThousandthBlock {
        uint256 score = gasleft();
        if(lastBlock != block.number){
            //You are the first in the block
            lastBlock = block.number;
            score = score * 2;
        }
        if(!scoreboard.isPlayer(msg.sender)){
            scoreboard.addPlayer(msg.sender);
        }
        scoreboard.addScore(msg.sender, score);
        emit scoreAdded(msg.sender, score);
    }

    function getAllPlayers() public view returns (address[]) {
        uint256 highestIndex = scoreboard.playerCount();
        address[] allPlayers;
        for(uint256 i = 0; i <= highestIndex; i++){
            address player = scoreboard.getPlayerById(i);
            if(scoreboard.isPlayer(player)) {
                allPlayers.push(player);
            }
        }
    }

    function getScore(address _player) public view returns (uint256) {
        return scoreboard.getScore(_player);
    }

    function setTxValue(uint256 _newValue) public onlyOwner {
        txValue = _newValue;
    }
}
