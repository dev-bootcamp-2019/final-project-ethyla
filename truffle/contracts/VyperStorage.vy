scoreboard: map(address, uint256)
players: uint256
playerMap: map(uint256, address)
playerExists: map(address, bool)
owner: address
callers: map(address, bool)

@public
def __init__():
    self.owner = msg.sender

@public
def setCaller(new_caller: address):
    assert msg.sender == self.owner
    self.callers[new_caller] = True

@public
def removeCaller(remove_caller: address):
    assert msg.sender == self.owner
    self.callers[remove_caller] = False

@public
def addPlayer(player : address):
    assert self.callers[msg.sender]
    if self.playerExists[player] == False:
        self.playerExists[player] = True
        self.players = self.players + 1
        self.playerMap[self.players] = player

@public
def removePlayer(player : address):
    assert self.callers[msg.sender]
    self.playerExists[player] = False

@public
@constant
def playerCount() -> uint256:
    return self.players

@public
@constant
def getPlayer(player : address) -> bool:
    return self.playerExists[player]

@public
@constant
def getPlayerById(playerId : uint256) -> address:
    return self.playerMap[playerId]

@public
def addScore(player : address, add_value : uint256):
    assert self.callers[msg.sender]
    self.scoreboard[player] = self.scoreboard[player] + add_value

@public
def subScore(player : address, sub_value : uint256):
    assert self.callers[msg.sender]
    self.scoreboard[player] = self.scoreboard[player] - sub_value

@public
def setScore(player : address, new_score : uint256):
    assert self.callers[msg.sender]
    self.scoreboard[player] = new_score

@public
@constant
def getScore(player : address) -> uint256:
    return self.scoreboard[player]
