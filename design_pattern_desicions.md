## Design patterns

### Separation of storage and logic

The reason for this is so that different versions of the game can all interact with one scoreboard. This enables players to choose the version they like most.   
Additionally it allows 'banning' of broken or unfair contracts while keeping all scores without user or developer action (migration).

### Contract Owners

Both contracts have owner that manage specific parts of the contracts. They mainly allow access to maintenance functions. GasGame uses the OpenZeppelin Ownable contract and VyperStorage uses a self written version.

###### Most other decisions are written more broadly in the README.md.
