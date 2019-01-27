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
              <span>You are missing {{missingAmount}} worth of wei.</span>
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
// TODO: calculate missing value, don't try to calculate on the fly

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
        gasPrice: 20000000000,
        gasLimit: 1000000,
        value: 80000000000000000,
      },
      currentValues: {
        gasPrice: 20000000000,
        gasLimit: 1000000,
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
    sendTx() {

    },
    resetAll() {
      this.currentValues = this.defaultValues;
    },
  },
  computed: {
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
  },
};
</script>

<style>

</style>
