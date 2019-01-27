/* eslint-disable no-shadow, no-param-reassign, import/prefer-default-export */
import { web3 } from '../services/web3Adapter';

const state = {
  network: {
    id: '',
    name: '',
    correct: '',
  },
  currentBlock: '',
};

const getters = {
  network: state => state.network,
  currentBlock: state => state.currentBlock,
};

const actions = {
  async setData({ commit }) {
    let netId = await web3.eth.net.getId();
    // Make sure it's a string
    netId += '';
    let name;
    let correct = false;
    switch (netId) {
      case '1':
        name = 'Mainnet';
        break;
      case '2':
        name = ' Morden';
        break;
      case '3':
        name = 'Ropsten';
        break;
      case '4':
        name = 'Rinkeby';
        correct = true;
        break;
      case '42':
        name = 'Kovan';
        break;
      default:
        name = 'Unknown';
    }
    const newData = {
      id: netId,
      name,
      correct,
    };
    commit('changeData', newData);
  },
  async updateLatestBlock({ commit }) {
    const latest = await web3.eth.getBlock('latest');
    commit('setCurrentBlock', latest.number);
  },
};

const mutations = {
  changeData(state, data) {
    state.network = data;
  },
  setCurrentBlock(state, number) {
    state.currentBlock = number;
  },
};

export const web3Data = {
  namespaced: true,
  state,
  getters,
  actions,
  mutations,
};
