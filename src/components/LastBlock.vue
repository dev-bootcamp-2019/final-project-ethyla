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
          <td class="text-xs-left">{{ props.item.address }}</td>
          <td class="text-xs-left">{{ props.item.gasPrice }}</td>
          <td class="text-xs-left">{{ props.item.gasLimit }}</td>

        </template>
    <v-alert slot="no-results" :value="true" color="error">
      Your search for "{{ search }}" found no results.
    </v-alert>

  </v-data-table>
</v-card>
</template>

<script>
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
      }],
      tx: [{
        value: false,
        points: 101,
        address: '0x98765678...',
        gasLimit: '1230000',
        gasPrice: '1000000000',
      }, {
        value: false,
        points: 101,
        address: '0x98765678...',
        gasLimit: '1230000',
        gasPrice: '100000000',
      }, {
        value: false,
        points: 101,
        address: '0x98765678...',
        gasLimit: '1230000',
        gasPrice: '10000000',
      }, {
        value: false,
        points: 101,
        address: '0x98765678...',
        gasLimit: '1230000',
        gasPrice: '2000000000',
      }, {
        value: false,
        points: 101,
        address: '0x98765678...',
        gasLimit: '1230000',
        gasPrice: '1000000000',
      }, {
        value: false,
        points: 101,
        address: '0x98765678...',
        gasLimit: '1230000',
        gasPrice: '1000000000',
      }, {
        value: false,
        points: 101,
        address: '0x98765678...',
        gasLimit: '1230000',
        gasPrice: '1000000000',
      }, {
        value: false,
        points: 101,
        address: '0x98765678...',
        gasLimit: '1230000',
        gasPrice: '1000000000',
      }],
    };
  },
};
</script>

<style>
</style>
