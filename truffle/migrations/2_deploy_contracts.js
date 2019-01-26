const VyperStorage = artifacts.require('VyperStorage');
const GasGame = artifacts.require('GasGame');

module.exports = function (deployer) {
  deployer.deploy(VyperStorage);
  then(() => deployer.deploy(GasGame, VyperStorage.address));
};
