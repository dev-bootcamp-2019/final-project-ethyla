<template>
<v-layout column>
  <v-flex>
    <div class="text-xs-left">
      <div class="headline">Welcome to the GasGame.</div>
      <p> You can play by sending transactions to the game contract. All transactions have a fixed total size of 0.1 ETH. The higher the remaining value (after you payed for gas) the more points you earn. if you are the first
        in a block you get double the points!</p>
    </div>
  </v-flex>
  <v-flex xs12>
    <v-form v-model="valid">

      <v-layout align-center>
        <v-flex xs6 pr-2>
          <v-text-field v-model="currentValues.gasPrice" :rules="[rules.required, rules.number]" label="GasPrice" box color="black">
          </v-text-field>
        </v-flex>
        <v-flex xs6 pl-2>
          <v-text-field v-model="currentValues.gasLimit" :rules="[rules.required, rules.number, rules.minGasLimit]" label="GasLimit" box color="black"></v-text-field>
        </v-flex>
      </v-layout>

      <v-layout align-center>
        <v-flex xs10>
          <v-text-field v-model="currentValues.value" :rules="[rules.required, rules.number]" label="Value" box color="black"></v-text-field>
        </v-flex>

        <v-flex>
          <v-layout align-top pb-4>
            <v-tooltip :open-delay="openTime" top open-on-hover="false">
              <v-btn :disabled="!valid || !correctAmount" slot="activator" @click="sendTx" color="primary">Send Tx</v-btn>
              <span v-if="!correctAmount">You are missing {{missingAmount}} worth of wei.</span>
              <!-- <span v-else-if="!correctBlock">Game is only active every 10th block.</span> -->
            </v-tooltip>
            <v-btn @click="resetAll" color="primary">Reset All</v-btn>
          </v-layout>
        </v-flex>

      </v-layout>
    </v-form>
  </v-flex>
</v-layout>
</template>

<script>
import {
  mapGetters,
} from 'vuex';

import {
  gasGameContract,
  userAccount,
} from '../services/web3Adapter';

export default {
  data() {
    return {
      rules: {
        required: value => !!value || 'Required.',
        number: value => !isNaN(value) || 'Must be a number.',
        minGasLimit: value => value >= 100000 || 'Must be atleast 100000 or tx will fail.',
      },
      valid: true,
      defaultValues: {
        gasPrice: 10000000000,
        gasLimit: 2000000,
        value: 80000000000000000,
      },
      currentValues: {
        gasPrice: 10000000000,
        gasLimit: 2000000,
        value: 80000000000000000,
      },
      totalTxValue: 100000000000000000,
      locked: {
        gasPrice: false,
        gasLimit: true,
        value: false,
      },
      toolTipSendTx: false,
    };
  },
  methods: {
    async sendTx() {
      gasGameContract.methods.play().send({
        gas: this.currentValues.gasLimit,
        gasPrice: this.currentValues.gasPrice,
        value: this.currentValues.value,
        from: userAccount,
      });
    },
    resetAll() {
      this.currentValues = this.defaultValues;
    },
  },
  computed: {
    ...mapGetters('web3Data',
      ['currentBlock']),
    missingAmount() {
      const gasValue = parseInt(this.currentValues.gasPrice, 10) * parseInt(this.currentValues.gasLimit, 10);
      const totalValue = parseInt(gasValue, 10) + parseInt(this.currentValues.value, 10);
      return this.totalTxValue - totalValue;
    },
    correctAmount() {
      const gasValue = parseInt(this.currentValues.gasPrice, 10) * parseInt(this.currentValues.gasLimit, 10);
      const totalValue = parseInt(gasValue, 10) + parseInt(this.currentValues.value, 10);
      return totalValue === this.totalTxValue;
    },
    openTime() {
      if (this.correctAmount) {
        return 1000000;
      }
      return 200;
    },
    correctBlock() {
      const nextBlock = parseInt(this.currentBlock, 10) + 1;
      return nextBlock % 10 === 0;
    },
  },
};
</script>

<style>

</style>
