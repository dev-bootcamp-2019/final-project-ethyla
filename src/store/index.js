import Vue from 'vue';
import Vuex from 'vuex';
import { web3Data } from './web3Data';

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    web3Data,
  },
});
