/* eslint-env  mocha */
/* global artifacts, contract, assert */


const VyperStorage = artifacts.require('VyperStorage');

contract('VyperStorage', (accounts) => {
  it('...should disallow calling by unset accounts.', async () => {
    const storage = await VyperStorage.deployed();
    let correctError;
    try {
      await storage.addPlayer(accounts[0]);
    } catch (error) {
      correctError = error.message.search('Not an allowed caller') >= 0;
    }

    assert.equal(true, correctError, 'Account 1 was allowed to add a player.');
  });

  it('...should allow calling by set accounts.', async () => {
    const storage = await VyperStorage.deployed();

    await storage.setCaller(accounts[0]);

    await storage.addPlayer(accounts[0]);
    const account = await storage.isPlayer(accounts[0]);

    assert.equal(true, account, "Account 1 wasn't allowed to add a player.");
  });

  it('...should add a player.', async () => {
    const storage = await VyperStorage.deployed();

    await storage.addPlayer(accounts[1]);
    const playerCount = await storage.playerCount();

    assert.equal(2, playerCount, "Didn't have correct amount of players.");
  });

  it('...should be able to retrieve a player.', async () => {
    const storage = await VyperStorage.deployed();

    await storage.addPlayer(accounts[2]);
    const playerAddress = await storage.getPlayerById(3);

    assert.equal(accounts[2], playerAddress, "Didn't have correct amount of players.");
  });

  it('...should add score points to a player.', async () => {
    const storage = await VyperStorage.deployed();

    await storage.addPlayer(accounts[3]);
    await storage.addScore(accounts[3], 10);

    const playerScore = await storage.getScore(accounts[3]);

    assert.equal(10, playerScore, "Didn't have correct amount of players.");
  });
});
