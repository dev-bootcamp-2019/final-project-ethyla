### Reentrancy

A Reentrancy is currently not possible, because only a single external contract call happens (in GasGame), and that contract is known. The second contract never calls any outside functions. (VyperStorage)  
The called address in the first contract can be changed, but changing it is restricted to the owner of the contract. To make a Reentrancy possible an attacker first hast to become owner of GasGame, then change the called address to one which he can exploit.  
Additionally the function that calls the other contract is structured in such a way that a Reentrancy would be useless. Namely the call is at the very end, after any state changes.


### Transaction Ordering

The contract is intentionally vulnerable to this. Otherwise the game mechanic of finding a winner wouldn't work, or make much sense.

### Timestamp or Blockhash dependency

The contracts never rely on either.

### Integer Overflow and Underflow

These are theoretically possible. The only place where it could happen is the Scoreboard. The arithmetic in the play function of GasGame can never reach high enough numbers to overflow (because of the limited ether supply, although maybe the rinkeby faucet could do it :)) Currently this is 'solved' via only allowing trusted contracts to modify the score.

### Denial of Service

A theoretic approach to this would be somehow changing the lastBlock state variable of GasGame. While this is pretty much impossible (no client would accept a block with a forged number), the exact same number as the last block would make earning double points impossible for this round of play.

### Force Sending Ether

Is no problem (neither sending before deployment, nor after), because while the contract accepts ether and does calculations on the send amount, the total value the contract owns is never used.
