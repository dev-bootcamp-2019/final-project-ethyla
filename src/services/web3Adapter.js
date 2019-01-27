import Web3 from 'web3';
import GasGame from '../../truffle/build/contracts/GasGame.json';
import store from '../store';
/* global ethereum */

let web3;
let gasGameContract;

const web3Adapter = {
  async init() {
    if (window.ethereum) {
      web3 = new Web3(ethereum);
      try {
        const accounts = await ethereum.enable();
        const userAccount = accounts[0];

        store.dispatch('web3Data/setUserAccount', userAccount);


        gasGameContract = new web3.eth.Contract(GasGame.abi, GasGame.networks[4].address);
      } catch (error) {
        // User denied account access...
      }
    // Non-dapp browsers
    } else {
      console.log('Non-Ethereum browser detected. You should consider trying MetaMask!');
    }
    store.dispatch('web3Data/setInit');
    ethereum.on('accountsChanged', (accounts) => {
      const userAccount = accounts[0];
      store.dispatch('web3Data/setUserAccount', userAccount);
    });
  },

};

export {
  web3, web3Adapter, gasGameContract,
};
