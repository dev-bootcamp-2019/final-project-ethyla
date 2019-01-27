# Please do not grade this yet.
## I will be working on in through Sunday, I will remove this text when I'm finished.
### Thank you :)

# GasGame

## Motivation

The goal of this DApp is to teach an average or new user some of the finer details how Gas and transaction ordering works. This is important, because a firm understanding how Gas works is important for many applications.  
This project aims to do this by creating a game where points will be awarded for specific things, all related to gas. And displaying information about other transactions in the same block.  

## Implemented features

Currently the game consists of a contract that restricts the total value (gas + value) to 0.1 ETH. A transaction builder allows the player to manipulate gaslimit, gasprice and send value. The goal is to have the first transaction in a given block, that reaches the contract. Being the first awards double the points. Points are awarded equal to the amount of value send to the contract in wei.  
All earned points are collected in a different contract that acts as a highscore.

## Further ideas




## Running the dev setup

```
npm install
```

```
npm run serve
```

For interacting with the contract you will need Metamask.
For testing you won't need to deploy the contracts, the DApp uses the rinkeby contracts in this repo.
### Truffle

Because there seems to be a bug in relation to using vyper with truffle, please first delete the truffle/build folder.  
Everything here is done using truffle develop. But using ganache should be fine.

#### Vyper
Also you will need vyper for almost everything contract related.  
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

## Tests

Gasgame.sol has 0 tests.
VyperStorage.vy has 5 tests.
The tests check the most basic functionality, such as:
- Only allowed addresses can manipulate the state
- The state updates correctly
- The state is readable


## Stretch Requirements

One of the contracts is written in vyper. (VyperStorage.vy)
