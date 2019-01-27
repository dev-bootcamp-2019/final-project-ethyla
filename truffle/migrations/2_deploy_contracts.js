const VyperStorage = artifacts.require('VyperStorage');
const GasGame = artifacts.require('GasGame');

module.exports = async function (deployer) {
  await deployer.deploy(VyperStorage);

  await deployer.deploy(GasGame, VyperStorage.address);
};
