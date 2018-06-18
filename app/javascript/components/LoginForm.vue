<template>
  <v-container
    fluid
    fill-height>
    <v-layout
      align-center
      justify-center>
      <v-flex xs10 sm8 md4>
        <v-card class="elevation-12">
          <v-toolbar dark color="info">
            <v-toolbar-title>Login form</v-toolbar-title>
          </v-toolbar>
          <v-card-text>
            <v-form ref="form" lazy-validation>
              <v-text-field
                prepend-icon="mail"
                name="login" 
                label="Email Address"
                type="text"
                v-model="email"
                v-bind:rules="emailRules">
              </v-text-field>
              <v-text-field
                prepend-icon="lock"
                name="password"
                label="Password"
                id="password"
                type="password"
                v-model="password"
                v-bind:rules="passwordRules">
              </v-text-field>
            </v-form>
          </v-card-text>
          <v-card-actions>
            <v-spacer></v-spacer>
            <v-btn
              color="info"
              v-on:click="logIn">
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
      email: '',
      emailRules: [
        v => !!v || 'E-Mail Address is required',
        v => /^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/.test(v) || 'E-mail Address is invalid'
      ],
      password: '',
      passwordRules: [
        v => !!v || 'Password is required',
        v => /^(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,100}$/i.test(v) || 'Passwords must contain at least one half-width alphanumeric character'
      ]
    }
  },
  methods: {
    logIn() {
      if (this.$refs.form.validate()) {
        const loginData = {
          email: this.email,
          password: this.password
        }
        this.$store.dispatch('logIn', loginData)
            .catch(thrown => {
              console.log(thrown)
              throw thrown
            })
      }
    }
  }
}
</script>

<style>

</style>
