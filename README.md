# GasGame

## Motivation

The goal of this DApp is to teach an average or new user some of the finer details how Gas and transaction ordering works. This is important, because a firm understanding how Gas works is important for many applications.  
This project aims to do this by creating a game where points will be awarded for specific things, all related to gas. And displaying information about other transactions in the same block.  

## Implemented features

Currently the game consists of a contract that restricts the total value (gas + value) to 0.1 ETH. A transaction builder allows the player to manipulate gaslimit, gasprice and send value. The goal is to have the first transaction in a given block, that reaches the contract. Being the first awards double the points. Points are awarded equal to the amount of value send to the contract in wei.  
All earned points are collected in a different contract that acts as a highscore.

## Further ideas

- Implement a "winner", the player with the most points during a round will get all send ether as a reward
- Implement various common functions (such as ERC-20 transfer or kitty breeding) that give various amounts of points. This could be done to teach players how different transactions and their required gas require different strategies to get early into a block. (Very useful for example during ICOs).

## Problems

- Not all miners order just by gasprice, there are different strategies, this needs to be shown to users
- Running the game every block probably leads to a low player density per round. Restricting rounds to specific blocks was already implemented, but it has a horrible UX, because it is difficult to know when exactly a new block is created, and impossible to know if your tx will be included in the chosen block.


## Running the dev setup

```
npm install
```

```
npm run serve
```

Visit http://localhost:8080

For interacting with the contract you will need Metamask.
For testing you won't need to deploy the contracts, the DApp uses the rinkeby contracts in this repo.

### Truffle

Because there seems to be a bug in relation to using vyper with truffle, please first delete the truffle/build folder.  
Everything here is done using truffle develop. But using ganache should be fine.
This project uses truffle 5.0.2

#### Vyper
Also you will need vyper for almost everything contract related.  
This project uses version: 0.1.0b6
Follow the instructions on [https://vyper.readthedocs.io/en/latest/installing-vyper.html](https://vyper.readthedocs.io/en/latest/installing-vyper.html)

#### Test

```
truffle develop
```

```
test
```

#### Dev

```
truffle develop
```

```
compile
```

```
deploy
```

#### Deploying to rinkeby

Please first add your infura token to truffle-config.js or use a different provider.  
Make sure truffle/build is deleted (see above).

```
truffle develop
```

```
compile
```

```
deploy --network=rinkeby
```


## Building for production
```
npm run build
```

### Lints and fix JS files
```
npm run lint
```


## Additional Requirements

### Library/Extend Contract

Used the Ownable Contract of OpenZepplin in GasGame.sol

### Tests

#### Gasgame.sol has 2 tests.
- Check only owner has access to maintenance function
- Unsure how to test contracts depending on others

#### VyperStorage.vy has 5 tests.
The tests check the most basic functionality, such as:
- Only allowed addresses can manipulate the state
- The state updates correctly
- The state is readable

### Emergency Stop

While there is no circuit breaker it is still possible to stop the DApp in two ways.
- While still in control  (being owner) of VyperStorage it is possible to disallow the current GasGame from modifying the scoreboard via the removeCaller function.
- While still in control (being owner) of GasGame it is possible to change the allowed value for example to 1 via the setTxValue function. This will disallow any calls to the contracts play function that have a different total value than 1 (a transactions is at least 21000 gas, with a gasprice of 1 the total value will still be at least 21000).  
It is also theoretically possible (especially for miners) to have a gasprice of 0, so the better way would be to set the allowed value to MAX_INT for uint256 which is bigger than all ether combined, making an attack impossible

###  Updating the UI

The UI is updated every new block, by polling new blocks.

### User account
The currently selected Metamask account is always display in the top right corner along with the network. It updates on changes.

## Stretch Requirements

### Vyper

One of the contracts is written in vyper. (VyperStorage.vy)

### Upgradeable contract

The storage is separated from the game logic, this makes it possible to make changes to the game, deploying a new contract, but keeping the old highscore.
Of course proper balancing is important, but all players can keep (without the need to do anything) playing the game with their score.  
Additionally the storage contract restricts the contracts that are allowed to call it while also allowing multiple contracts to change its state. This makes it possible to keep old versions of the game active, so that players can play which ever version they like best, while still competing on a single leaderboard.  
The disallowing of calls makes it possible to keep the storage even if one game version has breaking bugs.  

### IPFS

The app is hosted on ipfs. You can access it on one of the gateways:

https://gateway.ipfs.io/ipfs/QmVy53SyMyAmvZb6i5vA1jyc2VT18aVkNbN4rBFJpE2sz8/

Or on your own local gateway:

##### IPNS (I might update this later, the ipfs link is the project submitted at the deadline)  
http://localhost:8080/ipns/QmRTaWxw9yTvFRxPNm3ZCD22raTrbN2PgZvTiKWYuroYN8/

##### IPFS  
http://localhost:8080/ipfs/QmVy53SyMyAmvZb6i5vA1jyc2VT18aVkNbN4rBFJpE2sz8/

###### Important, because I only host it on my laptop and the gateways only cache so long (I also pined it on infura) it might not be reachable, send me a mail and I will start my local node.
