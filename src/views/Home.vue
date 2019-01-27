<template>
<v-layout row fill-height>
  <v-flex xs6 pr-3>
    <v-layout fill-height column>
      <v-flex style="min-height:50%; display: flex;">
        <TxConfigurator></TxConfigurator>
      </v-flex>
      <v-flex style="min-height:50%; max-height:50%;">
        <LastBlock></LastBlock>
      </v-flex>
    </v-layout>
  </v-flex>
  <v-flex xs6 pl-3 align-self-start>
    <Highscore></Highscore>
  </v-flex>
</v-layout>
</template>

<script>
import TxConfigurator from '../components/TxConfigurator.vue';
import Highscore from '../components/Highscore.vue';
import LastBlock from '../components/LastBlock.vue';

export default {
  name: 'home',
  components: {
    TxConfigurator,
    Highscore,
    LastBlock,
  },
  data() {
    return {
      nowPlaying: false,
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
