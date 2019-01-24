<template>
<v-app id="inspire">
  <v-toolbar color="primary" dark fixed app>
    <v-toolbar-title>GasGame</v-toolbar-title>
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
  web3,
  web3Adapter,
} from './services/web3Adapter';

export default {

  async created() {
    console.log(web3);
    await web3Adapter.init();
    // Doesn't work with metamask, could be implemented using infura
    // web3.eth.subscribe('pendingTransactions')
    //   .on('data', (transaction) => {
    //     console.log(transaction);
    //   });
    console.log(web3);
  },
};
</script>

<style lang="scss">

</style>
