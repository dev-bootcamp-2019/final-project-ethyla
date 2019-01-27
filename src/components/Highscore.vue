<template>
<v-card>
  <v-card-title>
    <div class="headline">Highscore</div>
    <v-spacer></v-spacer>
    <v-text-field v-model="search" label="Search" single-line hide-details></v-text-field>
  </v-card-title>
  <v-data-table hide-actions :pagination.sync="pagination" :headers="headers" :items="players" :search="search" class="elevation-1 scroll" style="max-height:77vh;">
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
        text: 'Address',
        tooltip: 'Address of the player.',
        align: 'left',
        sortable: false,
        value: 'address',
      }],
      players: [],
    };
  },
  created() {

    // this.fetchAllPlayers();
  },
  watch: {
    init(to) {
      if (to === true) {
        this.fetchAllPlayers();
      }
    },
    currentBlock() {
      this.players = [];
      this.fetchAllPlayers();
    },
  },
  methods: {
    async fetchAllPlayers() {
      const playerArray = await gasGameContract.methods.getAllPlayers().call();
      const promiseArray = [];
      // eslint-disable-next-line
      for (const element in playerArray) {
        const address = playerArray[element];
        promiseArray.push(this.fetchPlayer(address));
      }
      Promise.all(promiseArray);
    },
    async fetchPlayer(address) {
      const points = await gasGameContract.methods.getScore(address).call();
      const playerObj = {
        value: false,
        points,
        address,
      };
      this.players.push(playerObj);
    },
  },
  computed: {
    ...mapGetters('web3Data', ['init', 'currentBlock']),
  },
};
</script>

<style>
.scroll {
  overflow-y: auto;
}

::-webkit-scrollbar {
  display: none;
}
</style>
