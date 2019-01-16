import Vue from 'vue';
import Vuetify from 'vuetify';
import 'vuetify/dist/vuetify.min.css';

Vue.use(Vuetify, {
  theme: {
    primary: '#ff5722',
    secondary: '#ffc107',
    accent: '#8bc34a',
    error: '#e91e63',
    warning: '#9c27b0',
    info: '#03a9f4',
    success: '#4caf50',
  },
  customProperties: true,
  iconfont: 'mdi',
});
