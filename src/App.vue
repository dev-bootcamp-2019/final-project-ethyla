<template>
<v-app id="inspire">
  <v-toolbar color="primary" dark fixed app>
    <v-toolbar-title>GasGame</v-toolbar-title>
    <v-spacer></v-spacer>
    <v-btn :color="networkColor">{{network.name}}</v-btn>
  </v-toolbar>
  <v-content>
    <v-container fluid fill-height class="secondary">
      <v-layout fill-height justify-center>
        <v-flex grow text-xs-center>
          <router-view />
        </v-flex>
      </v-layout>
    </v-container>
  </v-content>
</v-app>
</template>
<script>
import {
  mapActions,
  mapGetters,
} from 'vuex';
import {
  web3,
  web3Adapter,
} from './services/web3Adapter';

export default {

  async created() {
    await web3Adapter.init();
    // Doesn't work with metamask, could be implemented using infura
    // web3.eth.subscribe('pendingTransactions')
    //   .on('data', (transaction) => {
    //     console.log(transaction);
    //   });
    await this.setData();
    this.pollLatestBlock();
  },
  methods: {
    ...mapActions('web3Data', [
      'setData',
      'updateLatestBlock',
    ]),
    pollLatestBlock() {
      setTimeout(() => {
        this.updateLatestBlock();
        this.pollLatestBlock();
      }, 1000);
    },
  },
  computed: {
    ...mapGetters('web3Data',
      ['network']),
    networkColor() {
      if (this.network.correct) {
        return 'accent';
      }
      return 'error';
    },
  },
};
</script>

<style lang="scss">

</style>
