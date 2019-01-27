<template>
<v-card>
  <v-card-title>
    <div class="headline">Last Round</div>
    <v-spacer></v-spacer>
    <v-text-field v-model="search" label="Search" single-line hide-details></v-text-field>
  </v-card-title>
  <v-data-table hide-actions :pagination.sync="pagination" :headers="headers" :items="tx" :search="search" class="elevation-1 scroll" style="height:33vh;">
    <template slot="headerCell" slot-scope="props">
        <v-tooltip bottom>
          <span slot="activator">
            {{ props.header.text }}
          </span>
          <span>
            {{ props.header.tooltip }}
          </span>
        </v-tooltip>
      </template>
    <template slot="items" slot-scope="props">
          <td class="text-xs-left ">{{ props.item.points }}</td>
          <td class="text-xs-left">{{ props.item.gasPrice }}</td>
          <td class="text-xs-left">{{ props.item.gasLimit }}</td>
          <td class="text-xs-left">{{ props.item.address }}</td>
        </template>
    <v-alert slot="no-results" :value="true" color="error">
      Your search for "{{ search }}" found no results.
    </v-alert>

  </v-data-table>
</v-card>
</template>

<script>
import {
  mapGetters,
} from 'vuex';
import {
  gasGameContract,
  web3,
} from '../services/web3Adapter';

export default {
  data() {
    return {
      search: '',
      pagination: {
        sortBy: 'points',
        descending: true,
        rowsPerPage: -1,
      },
      headers: [{
        text: 'Total Points',
        tooltip: 'Gathered points since the beginning.',
        align: 'left',
        sortable: true,
        value: 'points',
      }, {
        text: 'GasPrice',
        tooltip: 'GasPrice of the transaction.',
        align: 'left',
        sortable: true,
        value: 'gasPrice',
      }, {
        text: 'GasLimit',
        tooltip: 'GasLimit of the transaction.',
        align: 'left',
        sortable: true,
        value: 'gasLimit',
      }, {
        text: 'Address',
        tooltip: 'Address of the player.',
        align: 'left',
        sortable: false,
        value: 'address',
      }],
      tx: [],
    };
  },
  watch: {
    init(to) {
      if (to === true) {
        this.fetchAllLastTx();
      }
    },
    currentBlock() {
      this.players = [];
      this.fetchAllLastTx();
    },
  },
  methods: {
    async fetchAllLastTx() {
      const allLastEvents = await gasGameContract.getPastEvents('ScoreAdded', {
        fromBlock: this.currentBlock,
        toBlock: this.currentBlock,
      });
      const promiseArray = [];
      // eslint-disable-next-line
      for (const element in allLastEvents) {
        const txHash = allLastEvents[element].transactionHash;
        const points = allLastEvents[element].returnValues.score;
        promiseArray.push(this.fetchData(txHash, points));
      }
      Promise.all(promiseArray);
    },
    async fetchData(txhash, points) {
      const txData = await web3.eth.getTransaction(txhash);
      const txObj = {
        value: false,
        points,
        address: txData.from,
        gasLimit: txData.gas,
        gasPrice: txData.gasPrice,
      };
      this.tx.push(txObj);
    },
  },
  computed: {
    ...mapGetters('web3Data', ['init', 'currentBlock']),
  },
};
</script>

<style>
</style>
