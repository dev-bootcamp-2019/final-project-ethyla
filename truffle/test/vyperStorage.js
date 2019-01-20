/* eslint-env  mocha */
/* global artifacts, contract, assert */


const VyperStorage = artifacts.require('VyperStorage');

contract('VyperStorage', (accounts) => {
  it('...should only allow calling by set accounts.', async () => {
    const storage = await VyperStorage.deployed();

    await storage.setCaller(accounts[0]);

    // Get stored value
    await storage.addPlayer(accounts[0]);
    const account1 = await storage.getPlayer(accounts[0]);
    const account2 = await storage.getPlayer(accounts[1]);

    assert.equal(true, account1, "Account 1 wasn't allowed to add a player.");
    assert.equal(false, account2, 'Account 2 was allowed to add a player.');
  });
});
