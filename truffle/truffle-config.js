const privKeyrinkeby = 'd9b4fd1876c2a41eeddde58109ee76551454a3d9a1e9a9db227eefb62a632b86';
const HDWalletProvider = require('truffle-hdwallet-provider');

module.exports = {
  networks: {
    development: {
      host: 'localhost',
      port: 8545,
      network_id: '*', // Match any network id
    },
    rinkeby: {
      provider: () => new HDWalletProvider(privKeyrinkeby, 'https://rinkeby.infura.io/v3/'),
      // from: '0x3feAC4ECfBfcB441cf91552e00445d1c807D9D62',
      network_id: 4,
      gas: 4000000, // Gas limit used for deploys
    },
  },
};
