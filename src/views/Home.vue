<template>
<v-layout row fill-height>
  <v-flex xs6 pr-3>
    <v-layout fill-height column>
      <v-flex style="min-height:50%; display: flex;">
        <TxConfigurator></TxConfigurator>
      </v-flex>
      <v-flex style="min-height:50%; max-height:50%;">
        <!-- Current Block to see pending tx -->
        <v-card v-if="nowPlaying">
          <v-card-title>
            Current Block
            <v-spacer></v-spacer>
            <v-text-field v-model="search" label="Search" single-line hide-details></v-text-field>
          </v-card-title>
          <v-data-table hide-actions :pagination.sync="pagination" :headers="headers" :items="transactions" :search="search" class="elevation-1 scroll" style="max-height:33vh;">
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
            <template slot="items" slot-scope="props" >
              <td class="text-xs-left ">{{ props.item.points }}</td>
              <td class="text-xs-left">{{ props.item.address }}</td>
            </template>
            <v-alert slot="no-results" :value="true" color="error">
              Your search for "{{ search }}" found no results.
            </v-alert>
          </v-data-table>
        </v-card>

        <!-- Most recent Block wherer a game happend -->
        <v-card v-else>
          <v-card-title>
            Current Block
            <v-spacer></v-spacer>
            <v-text-field v-model="search" label="Search" single-line hide-details></v-text-field>
          </v-card-title>
          <v-data-table hide-actions :pagination.sync="pagination" :headers="headers" :items="players" :search="search" class="elevation-1 scroll" style="height:33vh;">
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
      </v-flex>
    </v-layout>
  </v-flex>
  <v-flex xs6 pl-3 align-self-start>
    <v-card>
      <v-card-title>
        Highscore
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
  </v-flex>
</v-layout>
</template>

<script>
import TxConfigurator from '../components/TxConfigurator.vue';

export default {
  name: 'home',
  components: {
    TxConfigurator,
  },
  data() {
    return {
      search: '',
      nowPlaying: false,
      transactions: [{
        value: false,
        points: 101,
        address: '0x98765678...',
      }, {
        value: false,
        points: 100,
        address: '0x98765678...',
      }, {
        value: false,
        points: 100,
        address: '0x98765678...',
      }, {
        value: false,
        points: 100,
        address: '0x98765678...',
      }, {
        value: false,
        points: 100,
        address: '0x98765678...',
      }, {
        value: false,
        points: 20,
        address: '0x98765678...',
      }, {
        value: false,
        points: 100,
        address: '0x98765678...',
      }, {
        value: false,
        points: 200,
        address: '0x98765678...',
      }],
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
      players: [{
        value: false,
        points: 101,
        address: '0x98765678...',
      }, {
        value: false,
        points: 100,
        address: '0x98765678...',
      }, {
        value: false,
        points: 100,
        address: '0x98765678...',
      }, {
        value: false,
        points: 100,
        address: '0x98765678...',
      }, {
        value: false,
        points: 100,
        address: '0x98765678...',
      }, {
        value: false,
        points: 20,
        address: '0x98765678...',
      }, {
        value: false,
        points: 100,
        address: '0x98765678...',
      }, {
        value: false,
        points: 200,
        address: '0x98765678...',
      }, {
        value: false,
        points: 200,
        address: '0x98765678...',
      }, {
        value: false,
        points: 200,
        address: '0x98765678...',
      }, {
        value: false,
        points: 200,
        address: '0x98765678...',
      }, {
        value: false,
        points: 200,
        address: '0x98765678...',
      }, {
        value: false,
        points: 200,
        address: '0x98765678...',
      }, {
        value: false,
        points: 200,
        address: '0x98765678...',
      }, {
        value: false,
        points: 200,
        address: '0x98765678...',
      }, {
        value: false,
        points: 200,
        address: '0x98765678...',
      }, {
        value: false,
        points: 200,
        address: '0x98765678...',
      }, {
        value: false,
        points: 200,
        address: '0x98765678...',
      }, {
        value: false,
        points: 200,
        address: '0x98765678...',
      }, {
        value: false,
        points: 200,
        address: '0x98765678...',
      }, {
        value: false,
        points: 200,
        address: '0x98765678...',
      }, {
        value: false,
        points: 200,
        address: '0x98765678...',
      }, {
        value: false,
        points: 200,
        address: '0x98765678...',
      }, {
        value: false,
        points: 200,
        address: '0x98765678...',
      }, {
        value: false,
        points: 200,
        address: '0x98765678...',
      }, {
        value: false,
        points: 200,
        address: '0x98765678...',
      }, {
        value: false,
        points: 200,
        address: '0x98765678...',
      }, {
        value: false,
        points: 200,
        address: '0x98765678...',
      }, {
        value: false,
        points: 200,
        address: '0x98765678...',
      }],
    };
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
