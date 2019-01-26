# Scoreboard for all addresses
scoreboard: map(address, uint256)
"""
@notice Total points per player
@dev Players are saved in a custom array below
"""

players: uint256
"""
@notice Total number of players
@dev Used as the current MAX_INDEX in the array
"""

playerMap: map(uint256, address)
"""
@notice Maps user index to user address
@dev The array content, access by checking all indexes lower than players(MAX_INDEX)
"""

playerExists: map(address, bool)
"""
@notice Mapping to keep track of existing players, used to remove players
@dev It's easier to remove a player here to remove them from the arry, than to change playerMap
"""

owner: address
"""
@notice Owner of the contract
@dev Used for restricting access
"""

callers: map(address, bool)
"""
@notice Addresses that are allowed to change the playerlist and the highscores
@dev Used for restricting access
"""

@public
def __init__():
    """
    @notice Constructor
    @dev Sets the owner of the contract
    """
    self.owner = msg.sender

@public
def setOwner(new_owner: address):
    """
    @notice Changes the owner
    @dev Only callable by the current owner
    @param new_owner the new owner of the contract
    """
    assert msg.sender == self.owner, "Not the owner."
    self.owner = new_owner

# Adds an address to the list of allowed scoreboard updaters
@public
def setCaller(new_caller: address):
    """
    @notice Adds an address to the allowed callers
    @dev Only callable by the owner
    @param new_caller the address of the new caller
    """
    assert msg.sender == self.owner, "Not the owner."
    self.callers[new_caller] = True

@public
def removeCaller(remove_caller: address):
    """
    @notice Removes an address from the allowed callers
    @dev Only callable by the owner
    @param remove_caller the address of the caller to be removed
    """
    assert msg.sender == self.owner, "Not the owner."
    self.callers[remove_caller] = False

# Adds a player to the 'array' and updates its index
@public
def addPlayer(player : address):
    """
    @notice Adds a player
    @dev Only callable by an allowed caller, only adds a user if they don't exist
    @param player the address to be added
    """
    assert self.callers[msg.sender], "Not an allowed caller."
    if self.playerExists[player] == False:
        self.playerExists[player] = True
        self.players = self.players + 1
        self.playerMap[self.players] = player

# Invalidates a player, so that frontends can exclude them
@public
def removePlayer(player : address):
    """
    @notice Removes a player
    @dev Only callable by an allowed caller
    @param player the address to be removed
    """
    assert self.callers[msg.sender], "Not an allowed caller."
    self.playerExists[player] = False

# Count of all players ever added
@public
@constant
def playerCount() -> uint256:
    """
    @notice Returns number of all players ever added
    @dev Number is also MAX_INDEX of the player array
    @return Number of all players ever added
    """
    return self.players

# Check to see if an address is a registered player
@public
@constant
def isPlayer(player : address) -> bool:
    """
    @notice Check if player exists
    @dev Check the playerExists mapping, because we don't realign the playerMap
    @param player the address that should be checked
    @return true if player exists and false if not, or they were removed
    """
    return self.playerExists[player]

# Returns a player address by id, useful for frontends to display all players
@public
@constant
def getPlayerById(playerId : uint256) -> address:
    """
    @notice Returns the player by their id
    @dev Returns the player at the specific index of the array
    @param playerId the id or index of the player
    @return the address of the player at the index/id
    """
    return self.playerMap[playerId]

# Adds points to a specific player
@public
def addScore(player : address, add_value : uint256):
    """
    @notice Adds points to the current player score
    @dev Only callable by an allowed caller
    @param player the address of the player
    @param add_value the points to be added to the score
    """
    assert self.callers[msg.sender], "Not an allowed caller."
    self.scoreboard[player] = self.scoreboard[player] + add_value

# Removes points from a specific player
@public
def subScore(player : address, sub_value : uint256):
    """
    @notice Removes points from the current player score
    @dev Only callable by an allowed caller
    @param player the address of the player
    @param sub_value the points to be removed from the score
    """
    assert self.callers[msg.sender], "Not an allowed caller."
    self.scoreboard[player] = self.scoreboard[player] - sub_value

# Sets the score of a specific player to a specific amount
@public
def setScore(player : address, new_score : uint256):
    """
    @notice Sets a specific score for a player
    @dev Only callable by an allowed caller, overrides existing score
    @param player the address of the player
    @param new_score the new total score
    """
    assert self.callers[msg.sender], "Not an allowed caller."
    self.scoreboard[player] = new_score

# Returns the score of a specific player
@public
@constant
def getScore(player : address) -> uint256:
    """
    @notice Returns the score of a specific player
    @dev The current total score of a player
    @param player the address of the player
    @return Total score of the player
    """
    return self.scoreboard[player]
