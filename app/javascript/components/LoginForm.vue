<template>
  <v-container
    fluid
    fill-height>
    <v-layout
      align-center
      justify-center>
      <v-flex xs10 sm8 md4>
        <v-card class="elevation-12">
          <v-toolbar dark color="primary">
            <v-toolbar-title>Login form</v-toolbar-title>
          </v-toolbar>
          <v-card-text>
            <v-form>
              <v-text-field
                prepend-icon="person"
                name="login" 
                label="Username"
                type="text"
                v-model="username">
              </v-text-field>
              <v-text-field
                prepend-icon="lock"
                name="password"
                label="Password"
                id="password"
                type="password"
                v-model="password">
              </v-text-field>
            </v-form>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn
              color="primary"
              v-on:click="logIn()">
              Login
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
export default {
  data () {
    return {
      drawer: null,
      username: '',
      password: ''
    }
  },
  methods: {
    logIn() {
      const loginData = {
        username: this.username,
        password: this.password
      }
      this.$store.dispatch('logIn', loginData)
    }
  }
}
</script>

<style>

</style>
