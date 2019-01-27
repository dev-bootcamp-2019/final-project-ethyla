import Web3 from 'web3';
import GasGame from '../../truffle/build/contracts/GasGame.json';
import store from '../store';
/* global ethereum */

let web3;
let gasGameContract;
let userAccount;

const web3Adapter = {
  async init() {
    if (window.ethereum) {
      web3 = new Web3(ethereum);
      try {
        const accounts = await ethereum.enable();
        userAccount = accounts[0];
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
      userAccount = accounts[0];
    });
  },

};

export {
  web3, web3Adapter, gasGameContract, userAccount,
};
