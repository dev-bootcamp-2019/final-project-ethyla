/* eslint-env  mocha */
/* global artifacts, contract, assert */


const GasGame = artifacts.require('GasGame');

contract('GasGame', (accounts) => {
  it('...should throw on setting txvalue by not owner.', async () => {
    const game = await GasGame.deployed();
    const setValue = 1;
    let errorThrow;

    try {
      await game.setTxValue(setValue).send({ from: accounts[1] });
      errorThrow = false;
    } catch (error) {
      errorThrow = true;
    }
    assert.equal(true, errorThrow, 'Not owner was allowed to add a player.');
  });

  it('...should allow setting txvalue by owner.', async () => {
    const game = await GasGame.deployed();
    const setValue = 1;
    let errorThrow;

    try {
      await game.setTxValue(setValue);
      errorThrow = false;
    } catch (error) {
      errorThrow = true;
    }

    assert.equal(false, errorThrow, "Owner wasn't allowed to add a player.");
  });
});
