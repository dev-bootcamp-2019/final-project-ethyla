<template>
<v-layout column>
  <v-flex>Welcome to the GasGame. You can play by sending transactions to the game contract. All transactions have a fixed total size of 0.1 ETH. The higher the remaining value (after you payed for gas) the more points you earn. if you are the first
    in a block you get double the points!</v-flex>
  <v-flex xs12>
    <v-form v-model="valid">
      <v-layout align-center>
        <v-flex xs10>
          <v-text-field v-model="currentValues.gasPrice" :readonly="locked.gasPrice" :rules="[rules.required, rules.number]" label="GasPrice" box color="black">
          </v-text-field>
        </v-flex>
        <v-flex xs2>
          <v-tooltip open-delay="10000000" top v-model="toolTipGasPrice" open-on-hover="false">
            <v-btn slot="activator" @click="lockGasPriceAction(locked.gasPrice)">{{gasPriceLocked}}</v-btn>
            <span>Unlock something else first.</span>
          </v-tooltip>
        </v-flex>
      </v-layout>
      <v-layout align-center>
        <v-flex xs10>
          <v-text-field v-model="currentValues.gasLimit" :readonly="locked.gasLimit" :rules="[rules.required, rules.number]" label="GasLimit" box color="black"></v-text-field>
        </v-flex>
        <v-flex xs2>
          <v-tooltip open-delay="10000000" top v-model="toolTipGasLimit">
            <v-btn slot="activator" @click="lockGasLimitAction(locked.gasLimit)">{{gasLimitLocked}}</v-btn>
            <span>Unlock something else first.</span>
          </v-tooltip>
        </v-flex>
      </v-layout>
      <v-layout align-center>
        <v-flex xs10>
          <v-text-field v-model="currentValues.value" :readonly="locked.value" :rules="[rules.required, rules.number]" label="Value" box color="black"></v-text-field>
        </v-flex>
        <v-flex xs2>
          <v-tooltip open-delay="10000000" top v-model="toolTipValue">
            <v-btn slot="activator" @click="lockValueAction(locked.value)">{{valueLocked}}</v-btn>
            <span>Unlock something else first.</span>
          </v-tooltip>
        </v-flex>
      </v-layout>
    </v-form>
  </v-flex>
  <v-flex>
    <v-layout align-center>
      <v-btn :disabled="!valid">Send Tx</v-btn>
      <v-btn>Reset All</v-btn>
    </v-layout>
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
      toolTipGasPrice: false,
      toolTipGasLimit: false,
      toolTipValue: false,
    };
  },
  methods: {
    calculatePrice(limit, value) {

    },
    calculateLimit(limit, value) {

    },
    calculateValue(limit, value) {

    },
    lockGasPriceAction() {
      if (this.locked.gasPrice) {
        this.locked.gasPrice = false;
      } else if (!this.locked.gasLimit && !this.locked.value) {
        this.locked.gasPrice = true;
      } else {
        this.toolTipGasPrice = true;
      }
    },
    lockGasLimitAction() {
      if (this.locked.gasLimit) {
        this.locked.gasLimit = false;
      } else if (!this.locked.gasPrice && !this.locked.value) {
        this.locked.gasLimit = true;
      } else {
        this.toolTipGasLimit = true;
      }
    },
    lockValueAction() {
      if (this.locked.value) {
        this.locked.value = false;
      } else if (!this.locked.gasPrice && !this.locked.gasLimit) {
        this.locked.value = true;
      } else {
        this.toolTipValue = true;
      }
    },
  },
  computed: {
    gasPriceLocked() {
      if (this.locked.gasPrice) {
        return 'Locked';
      }
      return 'Lock';
    },
    gasLimitLocked() {
      if (this.locked.gasLimit) {
        return 'Locked';
      }
      return 'Lock';
    },
    valueLocked() {
      if (this.locked.value) {
        return 'Locked';
      }
      return 'Lock';
    },
  },
};
</script>

<style>

</style>
