import Web3 from 'web3';

/* global ethereum */

let web3;

const web3Adapter = {
  async init() {
    if (window.ethereum) {
      web3 = new Web3(ethereum);
      try {
        await ethereum.enable();
      } catch (error) {
        // User denied account access...
      }
    // Non-dapp browsers
    } else {
      console.log('Non-Ethereum browser detected. You should consider trying MetaMask!');
    }
  },

};

export { web3, web3Adapter };
