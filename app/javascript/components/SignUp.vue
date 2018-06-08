<template>
  <v-container
    fluid
    fill-height>
    <v-layout
      align-center
      justify-center>
      <v-flex xs10 sm8 md 8>
        <v-form ref="form">
          <v-text-field
            v-model="username"
            label="Name"
            v-bind:rules="nameRules"
            required>
          </v-text-field>
          <v-text-field
            v-model="password"
            label="Password"
            v-bind:append-icon="visible ? 'visibility_off' : 'visibility'"
            v-bind:append-icon-cb="() => (visible = !visible)"
            v-bind:type="visible ? 'text' : 'password'"
            v-bind:rules="passwordRules"
            required>
          </v-text-field>
          <v-select
            v-bind:items="departments"
            item-text="name"
            item-value="id"
            label="Department"
            v-model="department"
            v-bind:rules="deptRules"
            required>
          </v-select>
          <v-text-field
            v-model="email"
            label="Email Address"
            v-bind:rules="emailRules"
            required>
          </v-text-field>
          <v-btn
            color="light-blue lighten-1"
            right
            v-on:click="signUp">
            submit
          </v-btn>
        </v-form>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import axios from 'axios'

export default {
  data() {
    return {
      username: '',
      nameRules: [
          v => !!v || 'Username is required'
      ],
      password: '',
      passwordRules: [
          v => !!v || 'Password is required'
      ],
      department: '',
      deptRules: [
          v => !!v || 'Department is required'
      ],
      email: '',
      emailRules: [
          v => !!v || 'E-Mail Address is required'
      ],

      visible: false,

      // for select box
      departments: []
    }
  },
  methods: {
    signUp() {
      if (this.$refs.form.validate()) {
        const signUpInfo = {
          name: this.username,
          password: this.password,
          department: this.department,
          email: this.email
        }
        axios.get('/auth/sign_up', signUpInfo).then(response => {
          this.$store.commit('SET_CURRENT_USER', response.data)
        }).catch(response => {
          console.log(response)
          throw response
        })
      }
    }
  },
  mounted: function() {
    axios.get('/departments').then(response => {
      for(let i = 0, l = response.data.length; i < l; i++) {
        this.$set(this.departments, i, response.data[i])
        console.log(response.data[i].name)
      }
    }).catch(response => {
      console.log(response)
      throw response
    })
  }
}
</script>

<style>

</style>
