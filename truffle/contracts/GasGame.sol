pragma solidity ^0.5;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

// Interface for calling the permanent storage
contract Scoreboard {
    function addScore(address, uint256) public;
    function isPlayer(address) public view returns (bool);
    function addPlayer(address) public;
    function playerCount() public view returns (uint256);
    function getPlayerById(uint256) public view returns (address);
    function getScore(address) public view returns (uint256);
}

/// @title A Contract that enforces same total value for all tx
contract GasGame is Ownable {

    // Permanent Scoreboard
    Scoreboard scoreboard;

    // Enforced exact total value a tx must have
    uint256 txValue;

    // Last block this game was played at
    uint256 lastBlock;

    // Player played the game and got points, score is points of current round
    event ScoreAdded(address player, uint256 score);

    constructor(address _scoreboard) public {
        // Sets the address of the highscore
        scoreboard = Scoreboard(_scoreboard);
        // Sets the lastBlock to a round number, so that the game takes place every tenth block (Only to make the number nice :))
        lastBlock = block.number;
        // Sets the enforced total value of a tx
        txValue = 100000000000000000;
    }

    // Only allows calls on blocknumbers ending with 0
    // Doesn't work good enough, UX is really bad, so disabled for now
    /* modifier onlyTenthBlock() {
        require(block.number % 10 == 0, "This is not a tenth block.");
        _;
    } */

    // Enforces the exact total amount of a tx, by computing total gaslimit and used wei for purchasing gas plus remaining wei value of the tx
    // Weakness to this aproach: The use can set a huge gaslimit which never gets consumed and so doesn't lose as much money, but they would get lower points
    modifier onlyCorrectValue() {
        uint256 leftover = gasleft();
        // Gas used up to this point is always 21437 if called from an externally owned account, so no contract calls for now
        uint256 used = 21437;
        uint256 totalGas = leftover + used;
        uint256 weiPayed = tx.gasprice * totalGas;
        uint256 totalWei = weiPayed + msg.value;
        require(totalWei == txValue, "Total tx value does not match expected value.");
        _;
    }

    /// @dev Function that calculates total points for a player and saves them to the scoreboard
    function play() public payable onlyCorrectValue{
        uint256 score = gasleft();
        // If last block is still the block of the last game the caller is the first one this block
        if (lastBlock != block.number) {
            //Set a new lastBlock so that following tx know that they aren't the first
            lastBlock = block.number;
            // Double the score as a reward for being the first
            score = score * 2;
        }
        // Check if user is already on scoreboard
        if (!scoreboard.isPlayer(msg.sender)) {
            scoreboard.addPlayer(msg.sender);
        }
        // Add score to scoreboard
        scoreboard.addScore(msg.sender, score);
        emit ScoreAdded(msg.sender, score);
    }

    /// @param _newValue of the total allowed value of a single tx
    /// @dev Sets a new value that tx must use
    function setTxValue(uint256 _newValue) public onlyOwner {
        txValue = _newValue;
    }

    /// @dev Convenience function to return all addresses of all players
    /// @return an array containing all registered players
    function getAllPlayers() public view returns (address[] memory) {
        uint256 highestIndex = scoreboard.playerCount();
        address[] memory allPlayers = new address[](highestIndex);
        // Loop through the "array"
        for (uint256 i = 1; i <= highestIndex; i++) {
            address player = scoreboard.getPlayerById(i);
            if (scoreboard.isPlayer(player)) {
                allPlayers[i-1] = player;
            }
        }
        return allPlayers;
    }

    /// @param _player address of the player
    /// @dev Convenience function to return the total score of a single player
    /// @return the total number of points of the player
    function getScore(address _player) public view returns (uint256) {
        return scoreboard.getScore(_player);
    }
}
