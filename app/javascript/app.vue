<template>
  <div id="app">
    <v-app id="inspire" dark>
      <baseLayout></baseLayout>
      <v-content>
        <router-view></router-view>
      </v-content>
    </v-app>
  </div>
</template>

<script>
import BaseLayout from './layouts/BaseLayout'

export default {
  name: 'app',
  components: {
    BaseLayout
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
