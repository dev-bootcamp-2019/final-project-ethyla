# Scoreboard for all addresses
scoreboard: map(address, uint256)

# The following is basically a dynamic array, beacuse vyper doesn't have one
# The length of the array, also the current max index
players: uint256
# The data of the array, keeps track of all the addresses coresponding to the indexes above
playerMap: map(uint256, address)
# Aditional mapping, to remove players from the game, this was used because it is simple than reordering the index
playerExists: map(address, bool)
# Used for restricting access
owner: address
# Limits access to altering the scoreboard
callers: map(address, bool)

# Constructor sets the owner
@public
def __init__():
    self.owner = msg.sender

@public
def setOwner(new_owner: address):
    assert msg.sender == self.owner, "Not the owner."
    self.owner = new_owner

# Adds an address to the list of allowed scoreboard updaters
@public
def setCaller(new_caller: address):
    assert msg.sender == self.owner, "Not the owner."
    self.callers[new_caller] = True

# Removes an address from the list of allowed scoreboard updaters
@public
def removeCaller(remove_caller: address):
    assert msg.sender == self.owner, "Not the owner."
    self.callers[remove_caller] = False

# Adds a player to the 'array' and updates its index
@public
def addPlayer(player : address):
    assert self.callers[msg.sender], "Not an allowed caller."
    if self.playerExists[player] == False:
        self.playerExists[player] = True
        self.players = self.players + 1
        self.playerMap[self.players] = player

# Invalidates a player, so that frontends can exclude them
@public
def removePlayer(player : address):
    assert self.callers[msg.sender], "Not an allowed caller."
    self.playerExists[player] = False

# Count of all players ever added
@public
@constant
def playerCount() -> uint256:
    return self.players

# Check to see if an address is a registered player
@public
@constant
def isPlayer(player : address) -> bool:
    return self.playerExists[player]

# Returns a player address by id, useful for frontends to display all players
@public
@constant
def getPlayerById(playerId : uint256) -> address:
    return self.playerMap[playerId]

# Adds points to a specific player
@public
def addScore(player : address, add_value : uint256):
    assert self.callers[msg.sender], "Not an allowed caller."
    self.scoreboard[player] = self.scoreboard[player] + add_value

# Removes points from a specific player
@public
def subScore(player : address, sub_value : uint256):
    assert self.callers[msg.sender], "Not an allowed caller."
    self.scoreboard[player] = self.scoreboard[player] - sub_value

# Sets the score of a specific player to a specific amount
@public
def setScore(player : address, new_score : uint256):
    assert self.callers[msg.sender], "Not an allowed caller."
    self.scoreboard[player] = new_score

# Returns the score of a specific player
@public
@constant
def getScore(player : address) -> uint256:
    return self.scoreboard[player]
