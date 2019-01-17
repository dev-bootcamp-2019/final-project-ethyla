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

<style lang="scss">

</style>
