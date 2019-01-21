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
});
